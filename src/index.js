/**
 * Assistente Pessoal IA
 * Main module for programmatic usage
 */

const agentRegistry = require('./utils/agent-registry');
const InstallationPrompts = require('./installer/prompts');
const AgentSelector = require('./installer/agent-selector');
const AssistenteSetup = require('./installer/setup');

module.exports = {
  // Registry utilities
  agentRegistry,

  // Installer components
  InstallationPrompts,
  AgentSelector,
  AssistenteSetup,

  // Commands
  commands: {
    install: require('./commands/install'),
    list: require('./commands/list'),
    add: require('./commands/add'),
    remove: require('./commands/remove'),
    available: require('./commands/available'),
    info: require('./commands/info')
  }
};
