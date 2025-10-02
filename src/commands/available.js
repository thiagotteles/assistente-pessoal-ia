const chalk = require('chalk');
const fs = require('fs-extra');
const path = require('path');
const agentRegistry = require('../utils/agent-registry');

/**
 * Available Command
 * Show all available agents
 */
async function availableCommand() {
  console.log(chalk.blue.bold('\n🤖 Agentes Disponíveis:\n'));

  // Get installed agents (if in installation directory)
  const installPath = await findInstallPath();
  let installedIds = [];

  if (installPath) {
    const agentsPath = path.join(installPath, '.assistant', 'agents');
    if (await fs.pathExists(agentsPath)) {
      installedIds = await fs.readdir(agentsPath);
    }
  }

  // Show core agents
  const coreAgents = agentRegistry.getCoreAgents();
  if (coreAgents.length > 0) {
    console.log(chalk.bold('━━━ AGENTES ESSENCIAIS ━━━\n'));

    coreAgents.forEach(agent => {
      const isInstalled = installedIds.includes(agent.id);
      const status = isInstalled ? chalk.green('✅ Instalado') : chalk.gray('⬜ Não instalado');

      console.log(chalk.white(`  ${agent.icon} ${chalk.bold(agent.name)} - ${status}`));
      console.log(chalk.gray(`     ${agent.description}`));
      console.log();
    });
  }

  // Show official agents
  const officialAgents = agentRegistry.getOfficialAgents();
  if (officialAgents.length > 0) {
    console.log(chalk.bold('━━━ AGENTES OFICIAIS ━━━\n'));

    officialAgents.forEach(agent => {
      const isInstalled = installedIds.includes(agent.id);
      const status = isInstalled ? chalk.green('✅ Instalado') : chalk.gray('⬜ Não instalado');
      const recommended = agent.recommended ? chalk.yellow(' ★ Recomendado') : '';

      console.log(chalk.white(`  ${agent.icon} ${chalk.bold(agent.name)} - ${status}${recommended}`));
      console.log(chalk.gray(`     ${agent.description}`));
      console.log();
    });
  }

  // Show community agents
  const communityAgents = agentRegistry.getCommunityAgents();
  if (communityAgents.length > 0) {
    console.log(chalk.bold('━━━ AGENTES DA COMUNIDADE ━━━\n'));

    communityAgents.forEach(agent => {
      const isInstalled = installedIds.includes(agent.id);
      const status = isInstalled ? chalk.green('✅ Instalado') : chalk.gray('⬜ Não instalado');
      const author = chalk.dim(`por @${agent.author}`);

      console.log(chalk.white(`  ${agent.icon} ${chalk.bold(agent.name)} ${author} - ${status}`));
      console.log(chalk.gray(`     ${agent.description}`));
      console.log();
    });
  } else {
    console.log(chalk.bold('━━━ AGENTES DA COMUNIDADE ━━━\n'));
    console.log(chalk.gray('  Nenhum agente da comunidade disponível ainda'));
    console.log(chalk.gray('  Seja o primeiro a contribuir! Veja CONTRIBUTING-AGENTS.md\n'));
  }

  // Usage instructions
  console.log(chalk.white.bold('💡 Como usar:\n'));
  console.log(chalk.white(`   Adicionar agente: ${chalk.cyan('npx assistente-pessoal add <id>')}`));
  console.log(chalk.white(`   Ver detalhes: ${chalk.cyan('npx assistente-pessoal info <id>')}`));
  console.log(chalk.white(`   Listar instalados: ${chalk.cyan('npx assistente-pessoal list')}\n`));
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

module.exports = availableCommand;
