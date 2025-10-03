const path = require('path');

// Simular instalação sem prompts interativos
async function testInstall() {
  const AssistenteSetup = require('./src/installer/setup');
  
  const preferences = {
    installPath: path.join(__dirname, 'test-install-output'),
    userName: 'TestUser',
    selectedAgents: ['organizador', 'secretaria'],
    setupGit: false,
    setupObsidian: false
  };
  
  console.log('🧪 Teste de instalação iniciado...\n');
  
  const setup = new AssistenteSetup(preferences);
  await setup.run();
  
  console.log('\n✅ Teste concluído!');
  console.log('📁 Instalação em:', preferences.installPath);
}

testInstall().catch(err => {
  console.error('❌ Erro no teste:', err.message);
  console.error(err.stack);
  process.exit(1);
});
