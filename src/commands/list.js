const chalk = require('chalk');
const fs = require('fs-extra');
const path = require('path');
const agentRegistry = require('../utils/agent-registry');

/**
 * List Command
 * Show installed agents
 */
async function listCommand() {
  console.log(chalk.blue.bold('\n🤖 Agentes Instalados:\n'));

  // Find installation directory (look for .assistant folder)
  const installPath = await findInstallPath();

  if (!installPath) {
    console.log(chalk.yellow('❌ Nenhuma instalação encontrada no diretório atual'));
    console.log(chalk.gray('\nExecute este comando dentro da pasta de instalação do assistente.'));
    console.log(chalk.gray('Ou execute: npx assistente-pessoal install\n'));
    return;
  }

  // Read installed agents from .claude/commands/assistentes/agents/ folder
  const agentsPath = path.join(installPath, '.claude', 'commands', 'assistentes', 'agents');

  if (!await fs.pathExists(agentsPath)) {
    console.log(chalk.yellow('❌ Pasta de agentes não encontrada'));
    console.log(chalk.gray('\nExecute a instalação primeiro: npx assistente-pessoal install\n'));
    return;
  }

  const agentFiles = await fs.readdir(agentsPath);
  const installedAgentIds = agentFiles
    .filter(f => f.endsWith('.md'))
    .map(f => f.replace('.md', ''));

  if (installedAgentIds.length === 0) {
    console.log(chalk.yellow('Nenhum agente instalado'));
    return;
  }

  // Display each agent
  for (const agentId of installedAgentIds) {
    const agent = agentRegistry.getAgent(agentId);

    if (agent) {
      const category = agent.category ? chalk.dim(`[${agent.category}]`) : '';
      console.log(chalk.white(`  ${agent.icon} ${chalk.bold(agent.name)} ${category}`));
      console.log(chalk.gray(`     ${agent.description}`));
    } else {
      console.log(chalk.white(`  ❓ ${agentId} ${chalk.dim('[desconhecido]')}`));
    }
  }

  console.log(chalk.white.bold(`\nTotal: ${installedAgentIds.length} agentes\n`));
  console.log(chalk.gray('💡 Adicione mais: npx assistente-pessoal add <agente>'));
  console.log(chalk.gray('📚 Ver disponíveis: npx assistente-pessoal available\n'));
}

/**
 * Find installation path
 */
async function findInstallPath() {
  const cwd = process.cwd();

  // Check current directory
  if (await fs.pathExists(path.join(cwd, '.assistant'))) {
    return cwd;
  }

  // Check if we're in a subdirectory of installation
  let currentPath = cwd;
  while (currentPath !== path.parse(currentPath).root) {
    if (await fs.pathExists(path.join(currentPath, '.assistant'))) {
      return currentPath;
    }
    currentPath = path.dirname(currentPath);
  }

  return null;
}

module.exports = listCommand;
