const inquirer = require('inquirer');
const path = require('path');
const os = require('os');
const fs = require('fs-extra');
const chalk = require('chalk');

/**
 * Interactive Installation Prompts
 * Collects user preferences for installation
 */
class InstallationPrompts {
  /**
   * Run all installation prompts
   * @returns {Promise<Object>} User preferences
   */
  async collectPreferences() {
    console.log(chalk.blue.bold('🤖 Assistente Pessoal IA - Instalador Interativo\n'));
    console.log(chalk.white('Bem-vindo! Vamos configurar seu assistente pessoal.\n'));

    const preferences = {};

    // 1. Installation path
    preferences.installPath = await this.promptInstallPath();

    // 2. User name
    preferences.userName = await this.promptUserName();

    // 3. User profile (for agent recommendations)
    preferences.userProfile = await this.promptUserProfile();

    // 4. Obsidian integration
    preferences.setupObsidian = await this.promptObsidianIntegration();

    // Git backup removido - usuário é responsável por seu próprio backup
    preferences.setupGit = false;

    return preferences;
  }

  /**
   * Prompt for installation path
   */
  async promptInstallPath() {
    const defaultPath = path.join(os.homedir(), 'assistente-ia');

    const { installPath } = await inquirer.prompt([
      {
        type: 'input',
        name: 'installPath',
        message: '📂 Onde deseja instalar o Assistente?',
        default: defaultPath,
        validate: (input) => {
          const expandedPath = input.replace(/^~/, os.homedir());
          const absolutePath = path.resolve(expandedPath);

          // Check if path already exists
          if (fs.existsSync(absolutePath)) {
            return chalk.yellow(`Pasta já existe: ${absolutePath}. Deseja continuar mesmo assim? (arquivos podem ser sobrescritos)`);
          }

          return true;
        },
        filter: (input) => {
          // Expand ~ to home directory
          const expandedPath = input.replace(/^~/, os.homedir());
          return path.resolve(expandedPath);
        }
      }
    ]);

    return installPath;
  }

  /**
   * Prompt for user name
   */
  async promptUserName() {
    const { userName } = await inquirer.prompt([
      {
        type: 'input',
        name: 'userName',
        message: '👤 Como devemos te chamar?',
        default: os.userInfo().username,
        validate: (input) => {
          if (!input || input.trim().length === 0) {
            return 'Por favor, insira seu nome.';
          }
          return true;
        },
        filter: (input) => input.trim()
      }
    ]);

    return userName;
  }

  /**
   * Prompt for user profile
   */
  async promptUserProfile() {
    const { userProfile } = await inquirer.prompt([
      {
        type: 'list',
        name: 'userProfile',
        message: '🎯 Qual seu perfil principal? (para recomendações de agentes)',
        choices: [
          { name: '💻 Desenvolvedor/a', value: 'developers' },
          { name: '🎨 Designer', value: 'designers' },
          { name: '✍️  Escritor/a', value: 'writers' },
          { name: '📚 Estudante', value: 'students' },
          { name: '🧠 Pessoa com TDAH', value: 'adhd' },
          { name: '🌟 Outro', value: 'all' }
        ],
        default: 'all'
      }
    ]);

    return userProfile;
  }

  /**
   * Prompt for Obsidian integration
   */
  async promptObsidianIntegration() {
    const { setupObsidian } = await inquirer.prompt([
      {
        type: 'confirm',
        name: 'setupObsidian',
        message: '📝 Configurar integração com Obsidian?',
        default: true
      }
    ]);

    return setupObsidian;
  }

  /**
   * Show installation summary and confirm
   */
  async confirmInstallation(preferences, selectedAgents) {
    console.log(chalk.yellow('\n📦 Resumo da Instalação:\n'));
    console.log(`  ${chalk.white('Local:')} ${chalk.green(preferences.installPath)}`);
    console.log(`  ${chalk.white('Nome:')} ${chalk.green(preferences.userName)}`);
    console.log(`  ${chalk.white('Perfil:')} ${chalk.green(preferences.userProfile)}`);
    console.log(`  ${chalk.white('Agentes:')} ${chalk.green(selectedAgents.length)} selecionados`);
    console.log(`  ${chalk.white('Obsidian:')} ${preferences.setupObsidian ? chalk.green('Sim') : chalk.gray('Não')}`);

    const { confirm } = await inquirer.prompt([
      {
        type: 'confirm',
        name: 'confirm',
        message: '\n✅ Confirmar instalação?',
        default: true
      }
    ]);

    return confirm;
  }
}

module.exports = InstallationPrompts;
