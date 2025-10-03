const path = require('path');
const fs = require('fs-extra');
const agentRegistry = require('./src/utils/agent-registry');

async function testStructure() {
  const testDir = path.join(__dirname, 'test-install-output');

  // Limpar
  await fs.remove(testDir);
  await fs.ensureDir(testDir);

  // Criar estrutura
  const agentsDir = path.join(testDir, '.claude', 'commands', 'assistentes', 'agents');
  const tasksDir = path.join(testDir, '.claude', 'commands', 'assistentes', 'tasks');

  await fs.ensureDir(agentsDir);
  await fs.ensureDir(tasksDir);

  // Copiar agentes
  const selectedAgents = ['organizador', 'secretaria'];

  for (const agentId of selectedAgents) {
    const agentMdSource = path.join(__dirname, '.assistant-core', 'agents', `${agentId}.md`);
    const agentMdTarget = path.join(agentsDir, `${agentId}.md`);

    if (await fs.pathExists(agentMdSource)) {
      await fs.copy(agentMdSource, agentMdTarget);
      console.log(`✅ Copiado: ${agentId}.md`);
    }
  }

  // Copiar tasks
  const tasksSource = path.join(__dirname, '.assistant-core', 'tasks');
  const allTasks = await fs.readdir(tasksSource);

  for (const taskFile of allTasks) {
    if (taskFile.endsWith('.md')) {
      await fs.copy(
        path.join(tasksSource, taskFile),
        path.join(tasksDir, taskFile)
      );
    }
  }

  console.log(`✅ Copiadas ${allTasks.length} tasks`);

  // Verificar estrutura
  console.log('\n📁 Estrutura criada:');
  console.log(await fs.readdir(agentsDir));
  console.log('\n📋 Tasks:');
  console.log((await fs.readdir(tasksDir)).length + ' tasks');
}

testStructure().catch(console.error);
