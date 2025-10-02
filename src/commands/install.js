const chalk = require('chalk');
const InstallationPrompts = require('../installer/prompts');
const AgentSelector = require('../installer/agent-selector');
const AssistenteSetup = require('../installer/setup');

/**
 * Install Command
 * Main installation workflow
 */
async function installCommand() {
  try {
    // Step 1: Collect user preferences
    const prompts = new InstallationPrompts();
    const preferences = await prompts.collectPreferences();

    // Step 2: Agent selection
    const selector = new AgentSelector();
    const selectedAgents = await selector.selectAgents(preferences.userProfile);

    // Step 3: Confirmation
    const confirmed = await prompts.confirmInstallation(preferences, selectedAgents);

    if (!confirmed) {
      console.log(chalk.yellow('\n❌ Instalação cancelada pelo usuário\n'));
      process.exit(0);
    }

    // Step 4: Execute installation
    const setup = new AssistenteSetup({
      ...preferences,
      selectedAgents
    });

    await setup.run();

    console.log(chalk.green.bold('✅ Pronto para usar!\n'));
    process.exit(0);

  } catch (error) {
    console.error(chalk.red('\n❌ Erro durante instalação:'), error.message);
    console.error(chalk.gray(error.stack));
    process.exit(1);
  }
}

module.exports = installCommand;
