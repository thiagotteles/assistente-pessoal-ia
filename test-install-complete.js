const path = require('path');
const InstallCommand = require('./src/commands/install');

// Simular instalação completa
async function testInstall() {
  console.log('🧪 Testando instalação completa...\n');

  // Mock preferences
  const mockPreferences = {
    installPath: path.join(__dirname, 'test-install-output'),
    userName: 'TestUser',
    selectedAgents: ['organizador', 'secretaria'],
    setupGit: false,
    setupObsidian: false
  };

  // Criar instalador
  const Setup = require('./src/installer/setup');
  const installer = new Setup(mockPreferences);

  try {
    await installer.run();
    console.log('\n✅ Instalação completa!');

    // Verificar arquivos
    const fs = require('fs-extra');
    const agentsPath = path.join(mockPreferences.installPath, '.claude', 'commands', 'assistentes', 'agents');
    const tasksPath = path.join(mockPreferences.installPath, '.claude', 'commands', 'assistentes', 'tasks');

    const agents = await fs.readdir(agentsPath);
    const tasks = await fs.readdir(tasksPath);

    console.log('\n📁 Agentes instalados:', agents);
    console.log('📋 Tasks instaladas:', tasks.length, 'arquivos');

  } catch (error) {
    console.error('❌ Erro:', error);
  }
}

testInstall();
