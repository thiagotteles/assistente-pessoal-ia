const chalk = require('chalk');
const fs = require('fs-extra');
const path = require('path');
const inquirer = require('inquirer');
const agentRegistry = require('../utils/agent-registry');

/**
 * Remove Command
 * Remove an agent from installation
 */
async function removeCommand(agentId) {
  console.log(chalk.blue.bold(`\n🗑️  Removendo agente: ${agentId}\n`));

  // Find installation path
  const installPath = await findInstallPath();

  if (!installPath) {
    console.log(chalk.red('❌ Nenhuma instalação encontrada no diretório atual'));
    console.log(chalk.gray('\nExecute este comando dentro da pasta de instalação do assistente.\n'));
    return;
  }

  // Get agent info
  const agent = agentRegistry.getAgent(agentId);
  const agentName = agent ? agent.name : agentId;

  // Check if agent is core (cannot be removed)
  if (agent && agent.required) {
    console.log(chalk.red(`❌ ${agentName} é um agente essencial e não pode ser removido\n`));
    return;
  }

  // Check if installed (in .claude/commands/assistentes/agents/)
  const targetPath = path.join(installPath, '.claude', 'commands', 'assistentes', 'agents', `${agentId}.md`);

  if (!await fs.pathExists(targetPath)) {
    console.log(chalk.yellow(`⚠️  Agente ${agentName} não está instalado\n`));
    return;
  }

  // Confirm removal
  const { confirm } = await inquirer.prompt([
    {
      type: 'confirm',
      name: 'confirm',
      message: `Tem certeza que deseja remover ${agentName}?`,
      default: false
    }
  ]);

  if (!confirm) {
    console.log(chalk.gray('\n❌ Remoção cancelada\n'));
    return;
  }

  // Remove agent
  try {
    await fs.remove(targetPath);
    console.log(chalk.green(`\n✅ ${agentName} removido com sucesso\n`));
  } catch (error) {
    console.log(chalk.red('\n❌ Erro ao remover agente:'), error.message, '\n');
  }
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

module.exports = removeCommand;
