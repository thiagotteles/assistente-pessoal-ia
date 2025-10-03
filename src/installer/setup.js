const fs = require('fs-extra');
const path = require('path');
const chalk = require('chalk');
const ora = require('ora');
const { execSync } = require('child_process');
const agentRegistry = require('../utils/agent-registry');

/**
 * Installation Setup
 * Handles the actual installation process
 */
class AssistenteSetup {
  constructor(preferences) {
    this.preferences = preferences;
    this.installPath = preferences.installPath;
    this.selectedAgents = preferences.selectedAgents || [];
  }

  /**
   * Run complete installation
   */
  async run() {
    console.log(chalk.blue.bold('\n🚀 Instalando Assistente Pessoal IA...\n'));

    try {
      await this.createDirectoryStructure();
      await this.copyBaseFiles();
      await this.installSelectedAgents();

      if (this.preferences.setupGit) {
        await this.setupGitRepository();
      }

      if (this.preferences.setupObsidian) {
        await this.setupObsidianConfig();
      }

      await this.createWelcomeFiles();
      await this.saveConfiguration();

      this.printSuccessMessage();
    } catch (error) {
      console.error(chalk.red('\n❌ Erro durante instalação:'), error.message);
      throw error;
    }
  }

  /**
   * Create directory structure
   */
  async createDirectoryStructure() {
    const spinner = ora('Criando estrutura de diretórios...').start();

    try {
      // Main directory
      await fs.ensureDir(this.installPath);

      // Core directories
      const directories = [
        'despejo',
        'knowledge-base',
        'knowledge-base/projetos',
        'knowledge-base/pessoas',
        'knowledge-base/reunioes',
        'knowledge-base/decisoes',
        'knowledge-base/aprendizados',
        'todos',
        'diario',
        '.claude',
        '.assistant',
        '.assistant/memory',
        '.assistant/config'
      ];

      for (const dir of directories) {
        await fs.ensureDir(path.join(this.installPath, dir));
      }

      spinner.succeed('Estrutura de diretórios criada');
    } catch (error) {
      spinner.fail('Erro ao criar estrutura de diretórios');
      throw error;
    }
  }

  /**
   * Copy base template files
   */
  async copyBaseFiles() {
    const spinner = ora('Copiando arquivos base...').start();

    try {
      const templatesPath = path.join(__dirname, '../../templates');

      // Check if templates directory exists
      if (await fs.pathExists(templatesPath)) {
        // Copy template files (excluding agents)
        const items = await fs.readdir(templatesPath);

        for (const item of items) {
          const sourcePath = path.join(templatesPath, item);
          const targetPath = path.join(this.installPath, item);

          // Skip .assistant/agents (we'll populate separately)
          if (item !== '.assistant') {
            await fs.copy(sourcePath, targetPath, { overwrite: false });
          }
        }
      }

      // Create daily-dump.md
      const dailyDumpPath = path.join(this.installPath, 'despejo', 'daily-dump.md');
      if (!await fs.pathExists(dailyDumpPath)) {
        const dailyDumpContent = `# Despejo Diário\n\n${this.getCurrentDate()}\n\n---\n\nEscreva aqui tudo que vem à mente. Sem filtros, sem organização.\nO Organizador vai processar isso depois.\n\n`;
        await fs.writeFile(dailyDumpPath, dailyDumpContent);
      }

      spinner.succeed('Arquivos base copiados');
    } catch (error) {
      spinner.fail('Erro ao copiar arquivos base');
      throw error;
    }
  }

  /**
   * Install selected agents
   */
  async installSelectedAgents() {
    const spinner = ora('Instalando agentes selecionados...').start();

    try {
      for (const agentId of this.selectedAgents) {
        const agent = agentRegistry.getAgent(agentId);

        if (!agent) {
          spinner.warn(`Agente ${agentId} não encontrado no registry`);
          continue;
        }

        // Get source path from registry
        const sourcePath = agentRegistry.getAgentSourcePath(agentId);

        // CORREÇÃO: Instalar em .claude/ para slash commands funcionarem
        const targetPath = path.join(this.installPath, '.claude', agentId);

        // Check if source exists
        if (!await fs.pathExists(sourcePath)) {
          spinner.warn(`Pasta do agente ${agent.name} não encontrada: ${sourcePath}`);
          continue;
        }

        // Copy agent
        await fs.copy(sourcePath, targetPath, { overwrite: true });

        spinner.text = `Instalando agentes... ✓ ${agent.name}`;
      }

      spinner.succeed(`Agentes instalados (${this.selectedAgents.length})`);
    } catch (error) {
      spinner.fail('Erro ao instalar agentes');
      throw error;
    }
  }

  /**
   * Setup Git repository
   */
  async setupGitRepository() {
    const spinner = ora('Configurando Git...').start();

    try {
      const originalCwd = process.cwd();
      process.chdir(this.installPath);

      // Check if git is available
      try {
        execSync('git --version', { stdio: 'ignore' });
      } catch (error) {
        spinner.warn('Git não encontrado - pulando configuração');
        process.chdir(originalCwd);
        return;
      }

      // Initialize git if not already
      if (!await fs.pathExists(path.join(this.installPath, '.git'))) {
        execSync('git init', { stdio: 'ignore' });
      }

      // Create .gitignore
      const gitignorePath = path.join(this.installPath, '.gitignore');
      const gitignoreContent = `# Arquivos temporários
.DS_Store
Thumbs.db
*.tmp
*.temp

# Logs
*.log

# Obsidian
.obsidian/workspace*
.obsidian/cache

# Privado (se necessário)
# privado/
`;
      await fs.writeFile(gitignorePath, gitignoreContent);

      // Initial commit
      execSync('git add .', { stdio: 'ignore' });
      execSync('git commit -m "Initial setup: Assistente Pessoal IA"', { stdio: 'ignore' });

      process.chdir(originalCwd);
      spinner.succeed('Git configurado com commit inicial');
    } catch (error) {
      spinner.warn('Erro ao configurar Git - continuando sem backup automático');
    }
  }

  /**
   * Setup Obsidian configuration
   */
  async setupObsidianConfig() {
    const spinner = ora('Configurando Obsidian...').start();

    try {
      const obsidianPath = path.join(this.installPath, '.obsidian');
      await fs.ensureDir(obsidianPath);

      // Create basic Obsidian config
      const obsidianConfig = {
        vimMode: false,
        showLineNumber: false,
        foldHeading: true,
        foldIndent: true,
        showFrontmatter: false
      };

      await fs.writeJson(path.join(obsidianPath, 'app.json'), obsidianConfig, { spaces: 2 });

      spinner.succeed('Obsidian configurado');
    } catch (error) {
      spinner.warn('Erro ao configurar Obsidian - configuração manual necessária');
    }
  }

  /**
   * Create welcome files
   */
  async createWelcomeFiles() {
    const spinner = ora('Criando arquivos de boas-vindas...').start();

    try {
      // BEM-VINDO.md
      const welcomePath = path.join(this.installPath, 'BEM-VINDO.md');
      const welcomeContent = this.generateWelcomeContent();
      await fs.writeFile(welcomePath, welcomeContent);

      // README.md
      const readmePath = path.join(this.installPath, 'README.md');
      const readmeContent = this.generateReadmeContent();
      await fs.writeFile(readmePath, readmeContent);

      spinner.succeed('Arquivos de boas-vindas criados');
    } catch (error) {
      spinner.warn('Erro ao criar arquivos de boas-vindas');
    }
  }

  /**
   * Save installation configuration
   */
  async saveConfiguration() {
    const configPath = path.join(this.installPath, '.assistant', 'config', 'installation.json');

    const config = {
      version: '1.0.0',
      installedAt: new Date().toISOString(),
      userName: this.preferences.userName,
      userProfile: this.preferences.userProfile,
      installedAgents: this.selectedAgents,
      features: {
        git: this.preferences.setupGit,
        obsidian: this.preferences.setupObsidian
      }
    };

    await fs.writeJson(configPath, config, { spaces: 2 });
  }

  /**
   * Generate welcome content
   */
  generateWelcomeContent() {
    const agentsList = this.selectedAgents
      .map(id => {
        const agent = agentRegistry.getAgent(id);
        return agent ? `- ${agent.icon} **${agent.name}**: ${agent.description}` : '';
      })
      .filter(Boolean)
      .join('\n');

    return `# Bem-vindo ao Assistente Pessoal IA! 🤖

Olá, **${this.preferences.userName}**! 👋

Seu assistente pessoal foi instalado com sucesso.

## 🎯 Seus Agentes

${agentsList}

## 🚀 Primeiros Passos

1. **Abra este projeto no Claude Code**
2. **Faça seu primeiro despejo**: Abra \`despejo/daily-dump.md\` e escreva o que vem à mente
3. **Chame o Organizador**: Digite \`/organizador\` no Claude Code
4. **Veja a mágica acontecer**: O Organizador vai processar e organizar tudo automaticamente

## 📝 Obsidian (Opcional)

${this.preferences.setupObsidian ?
  `Configurado! Abra a pasta \`knowledge-base\` como vault no Obsidian para visualizar suas anotações.` :
  `Para usar o Obsidian, abra a pasta \`knowledge-base\` como vault.`}

## 💾 Backup Automático

${this.preferences.setupGit ?
  `Git configurado! Seus dados serão versionados automaticamente.` :
  `Configure Git manualmente se quiser backup automático dos seus dados.`}

## 🆘 Ajuda

- **Documentação**: Veja \`README.md\`
- **Comandos disponíveis**: Digite \`npx assistente-pessoal --help\`
- **Adicionar agentes**: \`npx assistente-pessoal add <agente>\`

---

**Dica TDAH**: Não tente entender tudo de uma vez. Comece pelo despejo diário. O resto você aprende usando! 🧠

*Gerado em ${this.getCurrentDate()}*
`;
  }

  /**
   * Generate README content
   */
  generateReadmeContent() {
    return `# Assistente Pessoal IA - Instalação Local

Esta é sua instalação local do Assistente Pessoal IA.

## 📁 Estrutura

- \`despejo/\` - Captura rápida de pensamentos (daily-dump.md)
- \`knowledge-base/\` - Base de conhecimento organizada
- \`todos/\` - Tarefas e projetos
- \`diario/\` - Diário pessoal
- \`.assistant/\` - Configuração e agentes (não mexa!)

## 🤖 Comandos

\`\`\`bash
# Listar agentes instalados
npx assistente-pessoal list

# Ver agentes disponíveis
npx assistente-pessoal available

# Adicionar novo agente
npx assistente-pessoal add <agente>

# Ver informações de um agente
npx assistente-pessoal info <agente>
\`\`\`

## 🚀 Uso Diário

1. Escreva em \`despejo/daily-dump.md\`
2. Execute \`/organizador\` no Claude Code
3. Veja suas anotações organizadas em \`knowledge-base/\`

## 📝 Obsidian

Abra \`knowledge-base/\` como vault para visualização rica.

---

Instalado em: ${this.getCurrentDate()}
Versão: 1.0.0
`;
  }

  /**
   * Print success message
   */
  printSuccessMessage() {
    console.log(chalk.green.bold('\n╔════════════════════════════════════════════════════════════╗'));
    console.log(chalk.green.bold('║  ✅ Instalação Concluída!                                  ║'));
    console.log(chalk.green.bold('╚════════════════════════════════════════════════════════════╝\n'));

    console.log(chalk.white(`📂 ${chalk.bold('Local:')}`));
    console.log(chalk.cyan(`   ${this.installPath}\n`));

    console.log(chalk.white(`🤖 ${chalk.bold(`Agentes instalados (${this.selectedAgents.length}):`)} `));
    this.selectedAgents.forEach(id => {
      const agent = agentRegistry.getAgent(id);
      if (agent) {
        console.log(chalk.white(`   • ${agent.icon} ${agent.name} - ${chalk.gray(agent.title)}`));
      }
    });

    console.log(chalk.white.bold('\n🚀 Próximos passos:\n'));
    console.log(chalk.white(`   1. ${chalk.cyan(`cd ${this.installPath}`)}`));
    console.log(chalk.white(`   2. Abra no Claude Code`));
    console.log(chalk.white(`   3. Execute: ${chalk.cyan('/organizador')}\n`));

    console.log(chalk.white.bold('💡 Adicionar mais agentes depois:\n'));
    console.log(chalk.white(`   ${chalk.cyan('npx assistente-pessoal add <agente>')}\n`));

    console.log(chalk.white.bold('📚 Ver agentes disponíveis:\n'));
    console.log(chalk.white(`   ${chalk.cyan('npx assistente-pessoal available')}\n`));

    if (this.preferences.setupObsidian) {
      console.log(chalk.white.bold('📝 Obsidian:\n'));
      console.log(chalk.white(`   Abra ${chalk.cyan(path.join(this.installPath, 'knowledge-base'))} como vault\n`));
    }
  }

  /**
   * Get current date formatted
   */
  getCurrentDate() {
    return new Date().toISOString().split('T')[0];
  }
}

module.exports = AssistenteSetup;
