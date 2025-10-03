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

  // Check if already installed (in .claude/commands/assistentes/agents/)
  const agentsDir = path.join(installPath, '.claude', 'commands', 'assistentes', 'agents');
  const tasksDir = path.join(installPath, '.claude', 'commands', 'assistentes', 'tasks');
  const targetAgentFile = path.join(agentsDir, `${agentId}.md`);

  if (await fs.pathExists(targetAgentFile)) {
    console.log(chalk.yellow(`⚠️  Agente ${agent.name} já está instalado`));
    console.log(chalk.gray('\nPara reinstalar, remova primeiro: npx assistente-pessoal remove ' + agentId + '\n'));
    return;
  }

  // Install agent
  const spinner = ora(`Copiando ${agent.name}...`).start();

  try {
    await fs.ensureDir(agentsDir);
    await fs.ensureDir(tasksDir);

    // Copiar arquivo .md do agente
    const agentMdSource = path.join(__dirname, '../..', '.assistant-core', 'agents', `${agentId}.md`);

    if (!await fs.pathExists(agentMdSource)) {
      spinner.fail(`Arquivo ${agentId}.md não encontrado`);
      return;
    }

    await fs.copy(agentMdSource, targetAgentFile);

    // Copiar TODAS as tasks (compartilhadas entre agentes)
    const tasksSource = path.join(__dirname, '../..', '.assistant-core', 'tasks');

    if (await fs.pathExists(tasksSource)) {
      const tasks = await fs.readdir(tasksSource);

      for (const task of tasks) {
        if (task.endsWith('.md')) {
          await fs.copy(
            path.join(tasksSource, task),
            path.join(tasksDir, task),
            { overwrite: true }
          );
        }
      }
    }

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
