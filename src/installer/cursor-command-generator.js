const fs = require('fs-extra');
const path = require('path');
const Handlebars = require('handlebars');
const agentRegistry = require('../utils/agent-registry');

/**
 * Cursor Command Generator
 * Generates Cursor IDE commands from agent definitions
 */
class CursorCommandGenerator {
  constructor() {
    this.templatesDir = path.join(__dirname, '../../templates');
    this.baseTemplate = null;
    this.taskTemplate = null;
  }

  /**
   * Load Handlebars templates
   */
  async loadTemplates() {
    const basePath = path.join(this.templatesDir, 'cursor-agent-base.template.md');
    const taskPath = path.join(this.templatesDir, 'cursor-task-specific.template.md');

    const baseContent = await fs.readFile(basePath, 'utf-8');
    const taskContent = await fs.readFile(taskPath, 'utf-8');

    this.baseTemplate = Handlebars.compile(baseContent);
    this.taskTemplate = Handlebars.compile(taskContent);
  }

  /**
   * Generate all commands for an agent
   * @param {string} agentId - Agent ID (e.g., 'organizador')
   * @returns {Array} Array of {filename, content} objects
   */
  async generateAgentCommands(agentId) {
    const agent = agentRegistry.getAgent(agentId);
    if (!agent) {
      throw new Error(`Agent ${agentId} not found in registry`);
    }

    const commands = [];

    // 1. Base command (conversational)
    commands.push({
      filename: `${agentId}.md`,
      content: await this.generateBaseCommand(agent)
    });

    // 2. Specific task commands
    const specificCommands = await this.generateTaskCommands(agent);
    commands.push(...specificCommands);

    return commands;
  }

  /**
   * Generate base conversational command
   */
  async generateBaseCommand(agent) {
    // Get command mappings for this agent
    const commands = this.getCommandsForAgent(agent.id);

    return this.baseTemplate({
      AGENT_NAME: agent.name,
      AGENT_ID: agent.id,
      AGENT_TITLE: agent.title || agent.name,
      AGENT_DESCRIPTION: agent.description,
      AGENT_PERSONA: this.getAgentPersona(agent),
      STYLE: this.getAgentStyle(agent),
      COMMANDS: commands,
      TASK_FILE: commands[0]?.taskFile || 'task.md',
      VERSION: require('../../package.json').version
    });
  }

  /**
   * Generate task-specific commands
   */
  async generateTaskCommands(agent) {
    const commands = [];
    const mainTasks = this.getCommandsForAgent(agent.id);

    for (const task of mainTasks) {
      const content = this.taskTemplate({
        AGENT_NAME: agent.name,
        AGENT_ID: agent.id,
        AGENT_DESCRIPTION: agent.description,
        STYLE: this.getAgentStyle(agent),
        TASK_TITLE: task.trigger,
        TASK_FILE: task.taskFile,
        TASK_DESCRIPTION: task.description || `Execute ${task.taskFile}`
      });

      commands.push({
        filename: `${agent.id}-${task.id}.md`,
        content
      });
    }

    return commands;
  }

  /**
   * Get commands mapping for an agent
   */
  getCommandsForAgent(agentId) {
    const mapping = {
      'organizador': [
        {
          id: 'processar',
          trigger: 'processa meu despejo',
          taskFile: 'processar-despejo.md',
          description: 'Processa daily-dump.md e organiza em tarefas, projetos e anotações'
        },
        {
          id: 'organizar',
          trigger: 'organiza por projeto',
          taskFile: 'organizar-por-projeto.md',
          description: 'Visualiza informações organizadas por projeto'
        },
        {
          id: 'revisar',
          trigger: 'revisa pendências',
          taskFile: 'revisar-pendencias.md',
          description: 'Analisa central-todos.md e identifica ações necessárias'
        }
      ],
      'secretaria': [
        {
          id: 'agenda',
          trigger: 'agenda do dia',
          taskFile: 'agenda-do-dia.md',
          description: 'Prepara agenda do dia com tarefas e compromissos'
        },
        {
          id: 'reuniao',
          trigger: 'registra reunião',
          taskFile: 'registro-reuniao.md',
          description: 'Registra notas de reunião com participantes e ações'
        },
        {
          id: 'status',
          trigger: 'status dos projetos',
          taskFile: 'status-projetos.md',
          description: 'Gera relatório de status de todos os projetos'
        }
      ],
      'arquiteto': [
        {
          id: 'consulta',
          trigger: 'consultoria técnica',
          taskFile: 'consultoria-tecnica.md',
          description: 'Oferece consultoria técnica e arquitetural'
        },
        {
          id: 'analise',
          trigger: 'analisa projeto',
          taskFile: 'analise-projeto.md',
          description: 'Analisa código e arquitetura do projeto'
        },
        {
          id: 'decisao',
          trigger: 'registra decisão',
          taskFile: 'registrar-decisao.md',
          description: 'Registra decisão técnica com contexto e rationale'
        }
      ],
      'psicologo': [
        {
          id: 'suporte',
          trigger: 'suporte emocional',
          taskFile: 'suporte-emocional.md',
          description: 'Oferece suporte emocional e mindfulness'
        },
        {
          id: 'procrastinacao',
          trigger: 'detecta procrastinação',
          taskFile: 'detectar-procrastinacao.md',
          description: 'Detecta padrões de procrastinação e sugere ações'
        },
        {
          id: 'tecnicas',
          trigger: 'sugere técnicas',
          taskFile: 'sugerir-tecnicas.md',
          description: 'Sugere técnicas específicas para TDAH'
        }
      ],
      'mentor': [
        {
          id: 'oportunidades',
          trigger: 'identifica oportunidades',
          taskFile: 'identificar-oportunidades.md',
          description: 'Mapeia oportunidades de crescimento profissional'
        },
        {
          id: 'conversa',
          trigger: 'prepara conversa',
          taskFile: 'preparar-conversa.md',
          description: 'Prepara para conversas difíceis (1:1, negociação)'
        },
        {
          id: 'metas',
          trigger: 'tracking de metas',
          taskFile: 'tracking-metas.md',
          description: 'Acompanha progresso de metas de carreira'
        }
      ]
    };

    return mapping[agentId] || [];
  }

  /**
   * Get agent persona description
   */
  getAgentPersona(agent) {
    const personas = {
      'organizador': 'Organizadora de Informações Pessoais Especialista em TDAH, empática e eficiente',
      'secretaria': 'Assistente Executiva profissional que gerencia agenda e projetos',
      'arquiteto': 'Arquiteto de Software experiente em design holístico de sistemas',
      'psicologo': 'Psicólogo especializado em TDAH, focado em bem-estar e produtividade',
      'mentor': 'Mentor de Carreira experiente em crescimento profissional'
    };

    return personas[agent.id] || agent.description;
  }

  /**
   * Get agent communication style
   */
  getAgentStyle(agent) {
    const styles = {
      'organizador': 'empática, eficiente e estruturada',
      'secretaria': 'profissional, organizada e proativa',
      'arquiteto': 'técnico, pragmático e questionador',
      'psicologo': 'acolhedor, não-julgador e encorajador',
      'mentor': 'inspirador, direto e estratégico'
    };

    return styles[agent.id] || 'profissional e prestativo';
  }
}

module.exports = CursorCommandGenerator;
