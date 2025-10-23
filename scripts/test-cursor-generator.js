#!/usr/bin/env node

/**
 * Test script for Cursor Command Generator
 */

const CursorCommandGenerator = require('../src/installer/cursor-command-generator');
const path = require('path');
const fs = require('fs-extra');
const chalk = require('chalk');

async function main() {
  console.log(chalk.blue.bold('\n🧪 Testando Gerador de Comandos Cursor\n'));

  const generator = new CursorCommandGenerator();

  try {
    // Load templates
    console.log(chalk.gray('📄 Carregando templates...'));
    await generator.loadTemplates();
    console.log(chalk.green('✓ Templates carregados\n'));

    // Test directory
    const testDir = path.join(__dirname, '../test-cursor-output');
    await fs.ensureDir(testDir);
    await fs.emptyDir(testDir);

    // Generate for organizador
    console.log(chalk.yellow('📋 Gerando comandos para: organizador'));
    const orgCommands = await generator.generateAgentCommands('organizador');

    console.log(chalk.gray(`   Comandos gerados: ${orgCommands.length}`));
    for (const cmd of orgCommands) {
      const filePath = path.join(testDir, cmd.filename);
      await fs.writeFile(filePath, cmd.content);
      console.log(chalk.green(`   ✓ ${cmd.filename}`));
    }

    // Generate for secretaria
    console.log(chalk.yellow('\n📊 Gerando comandos para: secretaria'));
    const secCommands = await generator.generateAgentCommands('secretaria');

    console.log(chalk.gray(`   Comandos gerados: ${secCommands.length}`));
    for (const cmd of secCommands) {
      const filePath = path.join(testDir, cmd.filename);
      await fs.writeFile(filePath, cmd.content);
      console.log(chalk.green(`   ✓ ${cmd.filename}`));
    }

    // Summary
    console.log(chalk.blue.bold('\n📊 Sumário:'));
    console.log(chalk.white(`   Total de comandos: ${orgCommands.length + secCommands.length}`));
    console.log(chalk.white(`   Diretório: ${testDir}`));

    // Validate content
    console.log(chalk.blue.bold('\n✅ Validando conteúdo:'));

    const orgBase = await fs.readFile(path.join(testDir, 'organizador.md'), 'utf-8');
    console.log(chalk.gray('   Verificando organizador.md...'));

    if (orgBase.includes('Sofia')) {
      console.log(chalk.green('   ✓ Nome do agente correto'));
    } else {
      console.log(chalk.red('   ✗ Nome do agente não encontrado'));
    }

    if (orgBase.includes('processa meu despejo')) {
      console.log(chalk.green('   ✓ Comandos mapeados corretamente'));
    } else {
      console.log(chalk.red('   ✗ Comandos não encontrados'));
    }

    if (orgBase.includes('.assistant-core/tasks/')) {
      console.log(chalk.green('   ✓ Referências a tasks corretas'));
    } else {
      console.log(chalk.red('   ✗ Referências a tasks incorretas'));
    }

    console.log(chalk.blue.bold('\n🎉 Teste completo!\n'));
    console.log(chalk.gray(`Arquivos gerados em: ${testDir}\n`));

  } catch (error) {
    console.error(chalk.red('\n❌ Erro:'), error.message);
    console.error(error.stack);
    process.exit(1);
  }
}

main();
