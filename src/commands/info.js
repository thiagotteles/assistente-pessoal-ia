const chalk = require('chalk');
const fs = require('fs-extra');
const path = require('path');
const agentRegistry = require('../utils/agent-registry');

/**
 * Info Command
 * Show detailed information about an agent
 */
async function infoCommand(agentId) {
  const agent = agentRegistry.getAgent(agentId);

  if (!agent) {
    console.log(chalk.red(`\n❌ Agente "${agentId}" não encontrado\n`));
    console.log(chalk.gray('💡 Ver agentes disponíveis: npx assistente-pessoal available\n'));
    return;
  }

  console.log(chalk.blue.bold(`\n${agent.icon} ${agent.name}\n`));

  // Basic info
  console.log(chalk.white.bold('Informações Básicas:'));
  console.log(chalk.white(`  Título: ${chalk.cyan(agent.title)}`));
  console.log(chalk.white(`  Categoria: ${chalk.cyan(agent.category)}`));
  console.log(chalk.white(`  Autor: ${chalk.cyan(agent.author)}`));
  console.log(chalk.white(`  Versão: ${chalk.cyan(agent.version || '1.0.0')}`));

  if (agent.required) {
    console.log(chalk.white(`  Status: ${chalk.red('Essencial (não pode ser removido)')}`));
  }

  // Description
  console.log(chalk.white.bold('\nDescrição:'));
  console.log(chalk.gray(`  ${agent.description}`));

  // Recommendations
  if (agent.recommended_for && agent.recommended_for.length > 0) {
    console.log(chalk.white.bold('\nRecomendado para:'));
    agent.recommended_for.forEach(profile => {
      const profileInfo = agentRegistry.getProfile(profile);
      const profileName = profileInfo ? profileInfo.name : profile;
      console.log(chalk.white(`  • ${profileName}`));
    });
  }

  // Tags
  if (agent.tags && agent.tags.length > 0) {
    console.log(chalk.white.bold('\nTags:'));
    console.log(chalk.gray(`  ${agent.tags.join(', ')}`));
  }

  // Check if installed
  const installPath = await findInstallPath();
  if (installPath) {
    const agentPath = path.join(installPath, '.assistant', 'agents', agentId);
    const isInstalled = await fs.pathExists(agentPath);

    console.log(chalk.white.bold('\nStatus de Instalação:'));
    if (isInstalled) {
      console.log(chalk.green('  ✅ Instalado'));

      // Try to read commands from agent.yaml
      const agentYamlPath = path.join(agentPath, 'agent.yaml');
      if (await fs.pathExists(agentYamlPath)) {
        const yaml = require('yaml');
        const agentYaml = yaml.parse(await fs.readFile(agentYamlPath, 'utf8'));

        if (agentYaml.commands && agentYaml.commands.length > 0) {
          console.log(chalk.white.bold('\nComandos disponíveis:'));
          agentYaml.commands.forEach(cmd => {
            console.log(chalk.cyan(`  • /${cmd}`));
          });
        }
      }
    } else {
      console.log(chalk.gray('  ⬜ Não instalado'));
      console.log(chalk.white.bold('\nPara instalar:'));
      console.log(chalk.cyan(`  npx assistente-pessoal add ${agentId}`));
    }
  }

  // Community agent specific info
  if (agent.author !== 'oficial' && agent.author_github) {
    console.log(chalk.white.bold('\nContribuidor:'));
    console.log(chalk.white(`  GitHub: ${chalk.cyan(agent.author_github)}`));
    if (agent.contributed_at) {
      console.log(chalk.white(`  Contribuído em: ${chalk.gray(agent.contributed_at)}`));
    }
  }

  console.log(); // Empty line at end
}

/**
 * Find installation path
 */
async function findInstallPath() {
  const cwd = process.cwd();

  if (await fs.pathExists(path.join(cwd, '.assistant'))) {
    return cwd;
  }

  let currentPath = cwd;
  while (currentPath !== path.parse(currentPath).root) {
    if (await fs.pathExists(path.join(currentPath, '.assistant'))) {
      return currentPath;
    }
    currentPath = path.dirname(currentPath);
  }

  return null;
}

module.exports = infoCommand;
