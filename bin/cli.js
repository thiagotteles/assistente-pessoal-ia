#!/usr/bin/env node

const { program } = require('commander');
const chalk = require('chalk');
const path = require('path');
const os = require('os');

const packageJson = require('../package.json');

// Commands
const installCommand = require('../src/commands/install');
const listCommand = require('../src/commands/list');
const addCommand = require('../src/commands/add');
const removeCommand = require('../src/commands/remove');
const availableCommand = require('../src/commands/available');
const infoCommand = require('../src/commands/info');

// Setup program
program
  .name('assistente-pessoal')
  .description('Assistente Pessoal IA - Seu segundo cérebro para TDAH')
  .version(packageJson.version);

// Install command
program
  .command('install')
  .description('Instalar o Assistente Pessoal IA de forma interativa')
  .action(async () => {
    try {
      await installCommand();
    } catch (error) {
      console.error(chalk.red('\n❌ Erro durante instalação:'), error.message);
      console.error(chalk.gray(error.stack));
      process.exit(1);
    }
  });

// List command
program
  .command('list')
  .description('Listar agentes instalados')
  .action(async () => {
    try {
      await listCommand();
    } catch (error) {
      console.error(chalk.red('\n❌ Erro ao listar agentes:'), error.message);
      process.exit(1);
    }
  });

// Add command
program
  .command('add <agent>')
  .description('Adicionar um agente à instalação existente')
  .action(async (agentId) => {
    try {
      await addCommand(agentId);
    } catch (error) {
      console.error(chalk.red('\n❌ Erro ao adicionar agente:'), error.message);
      process.exit(1);
    }
  });

// Remove command
program
  .command('remove <agent>')
  .description('Remover um agente da instalação')
  .action(async (agentId) => {
    try {
      await removeCommand(agentId);
    } catch (error) {
      console.error(chalk.red('\n❌ Erro ao remover agente:'), error.message);
      process.exit(1);
    }
  });

// Available command
program
  .command('available')
  .description('Ver todos os agentes disponíveis')
  .action(async () => {
    try {
      await availableCommand();
    } catch (error) {
      console.error(chalk.red('\n❌ Erro ao listar agentes disponíveis:'), error.message);
      process.exit(1);
    }
  });

// Info command
program
  .command('info <agent>')
  .description('Ver informações detalhadas de um agente')
  .action(async (agentId) => {
    try {
      await infoCommand(agentId);
    } catch (error) {
      console.error(chalk.red('\n❌ Erro ao obter informações:'), error.message);
      process.exit(1);
    }
  });

// Handle unknown commands
program.on('command:*', () => {
  console.error(chalk.red('\n❌ Comando inválido: %s'), program.args.join(' '));
  console.log(chalk.yellow('\nUse --help para ver comandos disponíveis\n'));
  process.exit(1);
});

// Parse arguments
program.parse(process.argv);

// Show help if no command
if (!process.argv.slice(2).length) {
  program.outputHelp();
}
