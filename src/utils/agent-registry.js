const path = require('path');
const fs = require('fs-extra');

/**
 * Agent Registry Utility
 * Centralizes access to agents.json registry
 */
class AgentRegistry {
  constructor() {
    this.registryPath = path.join(__dirname, '../agents/agents.json');
    this.registry = null;
  }

  /**
   * Load registry from agents.json
   */
  load() {
    if (!this.registry) {
      this.registry = fs.readJsonSync(this.registryPath);
    }
    return this.registry;
  }

  /**
   * Get all agents (core + official + community)
   */
  getAllAgents() {
    const registry = this.load();
    return [
      ...registry.agents.core,
      ...registry.agents.official,
      ...registry.agents.community
    ];
  }

  /**
   * Get agent by ID
   */
  getAgent(agentId) {
    const allAgents = this.getAllAgents();
    return allAgents.find(agent => agent.id === agentId);
  }

  /**
   * Get agents by category
   */
  getAgentsByCategory(category) {
    const registry = this.load();
    return registry.agents[category] || [];
  }

  /**
   * Get core agents (required)
   */
  getCoreAgents() {
    return this.getAgentsByCategory('core');
  }

  /**
   * Get official agents (optional)
   */
  getOfficialAgents() {
    return this.getAgentsByCategory('official');
  }

  /**
   * Get community agents
   */
  getCommunityAgents() {
    return this.getAgentsByCategory('community');
  }

  /**
   * Get category metadata
   */
  getCategory(categoryId) {
    const registry = this.load();
    return registry.categories[categoryId];
  }

  /**
   * Get profile metadata
   */
  getProfile(profileId) {
    const registry = this.load();
    return registry.profiles[profileId];
  }

  /**
   * Get recommended agents for profile
   */
  getRecommendedForProfile(profileId) {
    const profile = this.getProfile(profileId);
    if (!profile) return [];

    return profile.recommended_agents.map(id => this.getAgent(id)).filter(Boolean);
  }

  /**
   * Check if agent is recommended for profile
   */
  isRecommendedForProfile(agentId, profileId) {
    const agent = this.getAgent(agentId);
    if (!agent) return false;

    // Always recommended
    if (agent.recommended) return true;

    // Recommended for specific profile
    if (agent.recommended_for && agent.recommended_for.includes(profileId)) {
      return true;
    }

    return false;
  }

  /**
   * Validate agent structure
   */
  validateAgent(agentId) {
    const agent = this.getAgent(agentId);
    if (!agent) {
      throw new Error(`Agent ${agentId} not found in registry`);
    }

    const requiredFields = ['id', 'name', 'title', 'icon', 'description', 'path'];
    for (const field of requiredFields) {
      if (!agent[field]) {
        throw new Error(`Agent ${agentId} missing required field: ${field}`);
      }
    }

    return true;
  }

  /**
   * Get agent absolute path from repository root
   */
  getAgentSourcePath(agentId) {
    const agent = this.getAgent(agentId);
    if (!agent) return null;

    // Path is relative to repository root
    return path.join(__dirname, '../../', agent.path);
  }
}

module.exports = new AgentRegistry();
