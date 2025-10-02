const chalk = require('chalk');
const fs = require('fs-extra');
const path = require('path');
const ora = require('ora');
const agentRegistry = require('../utils/agent-registry');

/**
 * Add Command
 * Add an agent to existing installation
 */
async function addCommand(agentId) {
  console.log(chalk.blue.bold(`\n📦 Adicionando agente: ${agentId}\n`));

  // Find installation path
  const installPath = await findInstallPath();

  if (!installPath) {
    console.log(chalk.red('❌ Nenhuma instalação encontrada no diretório atual'));
    console.log(chalk.gray('\nExecute este comando dentro da pasta de instalação do assistente.\n'));
    return;
  }

  // Check if agent exists in registry
  const agent = agentRegistry.getAgent(agentId);

  if (!agent) {
    console.log(chalk.red(`❌ Agente "${agentId}" não encontrado no registry`));
    console.log(chalk.gray('\n💡 Ver agentes disponíveis: npx assistente-pessoal available\n'));
    return;
  }

  // Check if already installed
  const targetPath = path.join(installPath, '.assistant', 'agents', agentId);

  if (await fs.pathExists(targetPath)) {
    console.log(chalk.yellow(`⚠️  Agente ${agent.name} já está instalado`));
    console.log(chalk.gray('\nPara reinstalar, remova primeiro: npx assistente-pessoal remove ' + agentId + '\n'));
    return;
  }

  // Install agent
  const spinner = ora(`Copiando ${agent.name}...`).start();

  try {
    const sourcePath = agentRegistry.getAgentSourcePath(agentId);

    if (!await fs.pathExists(sourcePath)) {
      spinner.fail(`Arquivos do agente ${agent.name} não encontrados`);
      return;
    }

    await fs.copy(sourcePath, targetPath);

    spinner.succeed(`${agent.icon} ${agent.name} instalado com sucesso!`);

    console.log(chalk.white.bold('\n🚀 Como usar:\n'));
    console.log(chalk.cyan(`   /${agentId}`), chalk.gray('no Claude Code\n'));

  } catch (error) {
    spinner.fail('Erro ao copiar agente');
    throw error;
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

module.exports = addCommand;
