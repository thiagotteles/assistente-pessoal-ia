const inquirer = require('inquirer');
const chalk = require('chalk');
const agentRegistry = require('../utils/agent-registry');

/**
 * Interactive Agent Selector
 * Allows users to choose which agents to install
 */
class AgentSelector {
  /**
   * Display agent selection interface
   * @param {string} userProfile - User profile for recommendations
   * @returns {Promise<string[]>} Array of selected agent IDs
   */
  async selectAgents(userProfile = 'all') {
    console.log(chalk.blue.bold('\n🤖 Escolha seus Agentes Especializados\n'));

    // Show core agents info
    const coreAgents = agentRegistry.getCoreAgents();
    if (coreAgents.length > 0) {
      const coreAgent = coreAgents[0];
      console.log(
        chalk.cyan(`${coreAgent.icon} ${coreAgent.name} é obrigatório e já está incluído.\n`)
      );
    }

    // Build choices for selection
    const choices = this.buildChoices(userProfile);

    // Prompt for selection
    const { selectedAgents } = await inquirer.prompt([
      {
        type: 'checkbox',
        name: 'selectedAgents',
        message: 'Selecione agentes adicionais que deseja instalar:',
        choices: choices,
        pageSize: 15,
        loop: false
      }
    ]);

    // Always include core agents
    const coreAgentIds = coreAgents.map(a => a.id);
    const finalSelection = [...coreAgentIds, ...selectedAgents];

    // Show summary
    this.showSelectionSummary(finalSelection);

    return finalSelection;
  }

  /**
   * Build inquirer choices with separators and formatting
   */
  buildChoices(userProfile) {
    const choices = [];

    // Official agents section
    const officialAgents = agentRegistry.getOfficialAgents();
    if (officialAgents.length > 0) {
      choices.push(new inquirer.Separator(chalk.bold('━━━ AGENTES OFICIAIS ━━━')));

      officialAgents.forEach(agent => {
        const isRecommended = agentRegistry.isRecommendedForProfile(agent.id, userProfile);

        choices.push({
          name: this.formatAgentChoice(agent, isRecommended),
          value: agent.id,
          checked: isRecommended,
          short: agent.name
        });
      });
    }

    // Community agents section
    const communityAgents = agentRegistry.getCommunityAgents();
    if (communityAgents.length > 0) {
      choices.push(new inquirer.Separator());
      choices.push(new inquirer.Separator(chalk.bold('━━━ AGENTES DA COMUNIDADE ━━━')));

      communityAgents.forEach(agent => {
        choices.push({
          name: this.formatCommunityAgentChoice(agent),
          value: agent.id,
          checked: false,
          short: agent.name
        });
      });
    }

    return choices;
  }

  /**
   * Format official agent choice for display
   */
  formatAgentChoice(agent, isRecommended) {
    const icon = agent.icon;
    const name = chalk.white.bold(agent.name);
    const description = chalk.gray(agent.description);
    const badge = isRecommended ? chalk.green('  ★ Recomendado') : '';
    const category = agent.category ? chalk.dim(` [${agent.category}]`) : '';

    return `${icon} ${name}${badge}${category}\n    ${description}`;
  }

  /**
   * Format community agent choice for display
   */
  formatCommunityAgentChoice(agent) {
    const icon = agent.icon;
    const name = chalk.white(agent.name);
    const description = chalk.gray(agent.description);
    const author = chalk.dim(`por @${agent.author}`);
    const category = agent.category ? chalk.dim(` [${agent.category}]`) : '';

    return `${icon} ${name} ${author}${category}\n    ${description}`;
  }

  /**
   * Show selection summary
   */
  showSelectionSummary(selectedAgentIds) {
    const agentNames = this.getAgentNames(selectedAgentIds);

    console.log(chalk.green('\n✓ Agentes selecionados:'));
    agentNames.forEach(name => {
      console.log(chalk.white(`   • ${name}`));
    });
    console.log();
  }

  /**
   * Get agent names from IDs
   */
  getAgentNames(agentIds) {
    return agentIds.map(id => {
      const agent = agentRegistry.getAgent(id);
      return agent ? `${agent.icon} ${agent.name}` : id;
    }).filter(Boolean);
  }
}

module.exports = AgentSelector;
