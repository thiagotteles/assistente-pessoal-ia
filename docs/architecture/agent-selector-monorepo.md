# Agent Selector Architecture: Instalação Seletiva de Agentes (Monorepo)

**Autor**: Winston (Architect)
**Data**: 02/10/2025
**Status**: Proposta Arquitetural - Versão Corrigida

---

## 🎯 Conceito Correto

**O que você quer** (agora entendi!):
- ✅ Todos os agentes **dentro do repositório** (monorepo)
- ✅ Instalador **mostra lista** de agentes disponíveis
- ✅ Usuário **escolhe quais** quer instalar
- ✅ Comunidade **contribui agentes** via Pull Request
- ✅ Similar ao **BMAD installer** (npx bmad-method install)

**O que você NÃO quer**:
- ❌ Agentes como packages NPM separados
- ❌ Marketplace externo
- ❌ Download de agentes de fora

---

## 🏗️ Arquitetura Simplificada

### Estrutura do Repositório

```
assistente-pessoal-ia/  (Monorepo GitHub)
├── package.json
├── bin/
│   └── cli.js                      # npx assistente-pessoal install
│
├── src/
│   ├── installer/
│   │   ├── prompts.js              # Perguntas interativas
│   │   ├── agent-selector.js       # ← Selector de agentes
│   │   └── setup.js                # Copia apenas agentes escolhidos
│   └── agents/                     # ← TODOS os agentes aqui
│       ├── core/
│       │   └── organizador/        # Obrigatório
│       │       ├── agent.yaml
│       │       ├── memory-template.yaml
│       │       └── tasks/
│       │
│       ├── official/               # Agentes oficiais opcionais
│       │   ├── secretaria/
│       │   │   ├── agent.yaml
│       │   │   ├── memory-template.yaml
│       │   │   └── tasks/
│       │   ├── arquiteto/
│       │   ├── psicologo/
│       │   └── mentor/
│       │
│       └── community/              # Agentes da comunidade
│           ├── financeiro/         # Contributed by @joao
│           │   ├── agent.yaml
│           │   ├── memory-template.yaml
│           │   ├── tasks/
│           │   └── AUTHOR.md       # Credits
│           ├── designer/           # Contributed by @maria
│           └── README.md           # Como contribuir agente
│
├── templates/                      # Template base (sem agentes)
│   ├── despejo/
│   ├── knowledge-base/
│   ├── todos/
│   ├── diario/
│   └── .assistant/
│       ├── config.yaml
│       └── agents/                 # ← Vazio (agentes copiados na install)
│
└── docs/
    └── CONTRIBUTING-AGENTS.md      # Como contribuir agente
```

---

## 🎮 Fluxo de Instalação (Como BMAD)

### Passo 1: Comando Inicial

```bash
$ npx assistente-pessoal install

🤖 Assistente Pessoal IA - Instalador Interativo

Bem-vindo! Vamos configurar seu assistente pessoal.
```

### Passo 2: Escolher Local (Igual BMAD)

```bash
? Onde deseja instalar o Assistente?
  (Use as setas ↑↓ para navegar)

  > ~/assistente-ia
    ~/Documents/assistente
    ./assistente
    Outro local (digitar)

✓ Local escolhido: /Users/voce/assistente-ia
```

### Passo 3: Configurações Básicas

```bash
? Como devemos te chamar?
  > Marina

? Configurar backup automático (Git)?
  > Sim

✓ Configurações salvas
```

### Passo 4: ⭐ **NOVO - Seletor de Agentes**

```bash
🤖 Escolha seus Agentes Especializados

O Organizador (Sofia) é obrigatório e já está incluído.

Selecione agentes adicionais que deseja instalar:

┌─────────────────────────────────────────────────────────────┐
│ AGENTES OFICIAIS                                            │
└─────────────────────────────────────────────────────────────┘

  [X] 📊 Secretária
      Gestão executiva, agenda, status de projetos
      Recomendado para: Todos os perfis

  [ ] 🏗️  Arquiteto (Marcus)
      Consultoria técnica com confronto construtivo
      Recomendado para: Desenvolvedores, Tech Leads

  [X] 🧠 Psicólogo (Dr. Helena)
      Suporte emocional especializado para TDAH
      Recomendado para: Pessoas com TDAH

  [ ] 🎯 Mentor (Leonardo)
      Desenvolvimento de carreira e networking
      Recomendado para: Crescimento profissional

┌─────────────────────────────────────────────────────────────┐
│ AGENTES DA COMUNIDADE                                       │
└─────────────────────────────────────────────────────────────┘

  [ ] 💰 Consultor Financeiro
      Gestão de finanças pessoais e investimentos
      Por: @joao-dev

  [ ] 🎨 Designer Criativo
      Feedback de design e UI/UX
      Por: @maria-ux

  [ ] 📝 Editor de Conteúdo
      Revisão e melhoria de textos
      Por: @pedro-writer

(Use ESPAÇO para selecionar, ENTER para confirmar)

✓ Agentes selecionados: Organizador, Secretária, Psicólogo
```

### Passo 5: Instalação

```bash
📦 Instalando Assistente Pessoal IA...

⠋ Criando estrutura de diretórios...
✅ Estrutura criada

⠋ Copiando arquivos base...
✅ Arquivos base copiados

⠋ Instalando agentes selecionados...
  ✅ Organizador (Sofia)
  ✅ Secretária
  ✅ Psicólogo (Dr. Helena)

⠋ Configurando Git...
✅ Backup automático configurado

⠋ Criando arquivos de boas-vindas...
✅ Sistema pronto!

╔════════════════════════════════════════════════════════════╗
║  ✅ Instalação Concluída!                                  ║
╚════════════════════════════════════════════════════════════╝

📂 Local: /Users/voce/assistente-ia

🤖 Agentes instalados (3):
   • Organizador (Sofia) - Processa seu despejo diário
   • Secretária - Gestão executiva e reuniões
   • Psicólogo (Dr. Helena) - Suporte TDAH

🚀 Próximos passos:

   1. cd ~/assistente-ia
   2. Abra no Claude Code
   3. Execute: /organizador

💡 Adicionar mais agentes depois:
   npx assistente-pessoal add arquiteto
```

---

## 💻 Implementação Técnica

### 1. Agent Registry (agents.json)

**Arquivo**: `src/agents/agents.json`

```json
{
  "version": "1.0.0",
  "agents": {
    "core": [
      {
        "id": "organizador",
        "name": "Sofia",
        "title": "Organizador Inteligente",
        "icon": "📋",
        "description": "Processa despejo diário e organiza automaticamente",
        "required": true,
        "author": "oficial",
        "category": "essencial",
        "path": "src/agents/core/organizador"
      }
    ],
    "official": [
      {
        "id": "secretaria",
        "name": "Secretária",
        "title": "Assistente Executiva",
        "icon": "📊",
        "description": "Gestão executiva, agenda, status de projetos",
        "required": false,
        "recommended": true,
        "author": "oficial",
        "category": "produtividade",
        "path": "src/agents/official/secretaria"
      },
      {
        "id": "arquiteto",
        "name": "Marcus",
        "title": "Arquiteto Confrontador",
        "icon": "🏗️",
        "description": "Consultoria técnica com confronto construtivo",
        "required": false,
        "recommended_for": ["developers", "tech-leads"],
        "author": "oficial",
        "category": "tecnico",
        "path": "src/agents/official/arquiteto"
      },
      {
        "id": "psicologo",
        "name": "Dr. Helena",
        "title": "Psicólogo Supportivo",
        "icon": "🧠",
        "description": "Suporte emocional especializado para TDAH",
        "required": false,
        "recommended": true,
        "recommended_for": ["adhd"],
        "author": "oficial",
        "category": "bem-estar",
        "path": "src/agents/official/psicologo"
      },
      {
        "id": "mentor",
        "name": "Leonardo",
        "title": "Mentor de Carreira",
        "icon": "🎯",
        "description": "Desenvolvimento de carreira e networking",
        "required": false,
        "author": "oficial",
        "category": "carreira",
        "path": "src/agents/official/mentor"
      }
    ],
    "community": [
      {
        "id": "financeiro",
        "name": "Consultor Financeiro",
        "title": "Consultor Financeiro Pessoal",
        "icon": "💰",
        "description": "Gestão de finanças pessoais e investimentos",
        "required": false,
        "author": "joao-dev",
        "author_github": "https://github.com/joao-dev",
        "category": "financas",
        "path": "src/agents/community/financeiro",
        "contributed_at": "2025-10-01"
      },
      {
        "id": "designer",
        "name": "Designer Criativo",
        "title": "Feedback de Design",
        "icon": "🎨",
        "description": "Feedback de design e UI/UX",
        "required": false,
        "author": "maria-ux",
        "author_github": "https://github.com/maria-ux",
        "category": "criativo",
        "path": "src/agents/community/designer",
        "contributed_at": "2025-09-28"
      }
    ]
  }
}
```

---

### 2. Agent Selector (Interactive)

**Arquivo**: `src/installer/agent-selector.js`

```javascript
const inquirer = require('inquirer');
const chalk = require('chalk');
const agentRegistry = require('../agents/agents.json');

class AgentSelector {
  async selectAgents(userProfile = null) {
    console.log(chalk.blue.bold('\n🤖 Escolha seus Agentes Especializados\n'));

    // Organizador é obrigatório
    const coreAgents = agentRegistry.agents.core;
    console.log(chalk.cyan(`${coreAgents[0].icon} ${coreAgents[0].name} é obrigatório e já está incluído.\n`));

    // Construir lista de opções
    const choices = this.buildChoices(userProfile);

    const { selectedAgents } = await inquirer.prompt([
      {
        type: 'checkbox',
        name: 'selectedAgents',
        message: 'Selecione agentes adicionais:',
        choices: choices,
        pageSize: 15,
        loop: false
      }
    ]);

    // Sempre incluir organizador
    const finalSelection = ['organizador', ...selectedAgents];

    this.showSelectionSummary(finalSelection);

    return finalSelection;
  }

  buildChoices(userProfile) {
    const choices = [];

    // Separador: Agentes Oficiais
    choices.push(new inquirer.Separator(chalk.bold('━━━ AGENTES OFICIAIS ━━━')));

    // Adicionar agentes oficiais
    agentRegistry.agents.official.forEach(agent => {
      const isRecommended = this.isRecommended(agent, userProfile);

      choices.push({
        name: this.formatAgentChoice(agent, isRecommended),
        value: agent.id,
        checked: isRecommended,
        short: agent.name
      });
    });

    // Separador: Agentes da Comunidade
    if (agentRegistry.agents.community.length > 0) {
      choices.push(new inquirer.Separator());
      choices.push(new inquirer.Separator(chalk.bold('━━━ AGENTES DA COMUNIDADE ━━━')));

      agentRegistry.agents.community.forEach(agent => {
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

  formatAgentChoice(agent, isRecommended) {
    const icon = agent.icon;
    const name = chalk.white.bold(agent.name);
    const description = chalk.gray(agent.description);
    const badge = isRecommended ? chalk.green('★ Recomendado') : '';

    return `${icon} ${name} ${badge}\n    ${description}`;
  }

  formatCommunityAgentChoice(agent) {
    const icon = agent.icon;
    const name = chalk.white(agent.name);
    const description = chalk.gray(agent.description);
    const author = chalk.dim(`por @${agent.author}`);

    return `${icon} ${name} ${author}\n    ${description}`;
  }

  isRecommended(agent, userProfile) {
    // Se marcado como recomendado por padrão
    if (agent.recommended) return true;

    // Se recomendado para perfil específico
    if (userProfile && agent.recommended_for) {
      return agent.recommended_for.includes(userProfile);
    }

    return false;
  }

  showSelectionSummary(selectedAgents) {
    const agentNames = this.getAgentNames(selectedAgents);

    console.log(chalk.green('\n✓ Agentes selecionados:'));
    agentNames.forEach(name => {
      console.log(chalk.white(`   • ${name}`));
    });
    console.log();
  }

  getAgentNames(selectedIds) {
    const allAgents = [
      ...agentRegistry.agents.core,
      ...agentRegistry.agents.official,
      ...agentRegistry.agents.community
    ];

    return selectedIds.map(id => {
      const agent = allAgents.find(a => a.id === id);
      return agent ? `${agent.icon} ${agent.name}` : id;
    });
  }
}

module.exports = AgentSelector;
```

---

### 3. Setup Script (Copia Agentes Selecionados)

**Arquivo**: `src/installer/setup.js`

```javascript
const fs = require('fs-extra');
const path = require('path');
const chalk = require('chalk');
const ora = require('ora');
const agentRegistry = require('../agents/agents.json');

class AssistenteSetup {
  constructor(preferences) {
    this.preferences = preferences;
    this.installPath = preferences.installPath;
    this.selectedAgents = preferences.selectedAgents;
  }

  async run() {
    console.log(chalk.blue.bold('\n🚀 Instalando Assistente Pessoal IA...\n'));

    await this.createDirectoryStructure();
    await this.copyBaseFiles();
    await this.installSelectedAgents();  // ← Copia apenas selecionados
    await this.setupGitIfEnabled();
    await this.createWelcomeFiles();

    this.printSuccessMessage();
  }

  async installSelectedAgents() {
    const spinner = ora('Instalando agentes selecionados...').start();

    const allAgents = [
      ...agentRegistry.agents.core,
      ...agentRegistry.agents.official,
      ...agentRegistry.agents.community
    ];

    for (const agentId of this.selectedAgents) {
      const agent = allAgents.find(a => a.id === agentId);

      if (!agent) {
        spinner.warn(`Agente ${agentId} não encontrado no registry`);
        continue;
      }

      // Copiar agente do repo para instalação
      const sourcePath = path.join(__dirname, '../../', agent.path);
      const targetPath = path.join(
        this.installPath,
        '.assistant',
        'agents',
        agentId
      );

      await fs.copy(sourcePath, targetPath);

      spinner.text = `Instalando agentes... ✓ ${agent.name}`;
    }

    spinner.succeed(`Agentes instalados (${this.selectedAgents.length})`);
  }

  // ... resto do setup
}

module.exports = AssistenteSetup;
```

---

### 4. CLI Principal

**Arquivo**: `bin/cli.js`

```javascript
#!/usr/bin/env node

const { program } = require('commander');
const chalk = require('chalk');
const inquirer = require('inquirer');
const AgentSelector = require('../src/installer/agent-selector');
const AssistenteSetup = require('../src/installer/setup');

program
  .name('assistente-pessoal')
  .version('1.0.0');

program
  .command('install')
  .description('Instalar o Assistente Pessoal IA')
  .action(async () => {
    console.log(chalk.blue.bold('\n🤖 Assistente Pessoal IA - Instalador Interativo\n'));

    // Passo 1: Local de instalação
    const { installPath } = await inquirer.prompt([
      {
        type: 'input',
        name: 'installPath',
        message: 'Onde deseja instalar o Assistente?',
        default: path.join(os.homedir(), 'assistente-ia')
      }
    ]);

    // Passo 2: Nome do usuário
    const { userName } = await inquirer.prompt([
      {
        type: 'input',
        name: 'userName',
        message: 'Como devemos te chamar?'
      }
    ]);

    // Passo 3: Perfil (opcional - ajuda recomendações)
    const { userProfile } = await inquirer.prompt([
      {
        type: 'list',
        name: 'userProfile',
        message: 'Qual seu perfil principal?',
        choices: [
          { name: 'Desenvolvedor/a', value: 'developer' },
          { name: 'Designer', value: 'designer' },
          { name: 'Escritor/a', value: 'writer' },
          { name: 'Estudante', value: 'student' },
          { name: 'Outro', value: 'other' }
        ]
      }
    ]);

    // Passo 4: ⭐ Seletor de Agentes
    const selector = new AgentSelector();
    const selectedAgents = await selector.selectAgents(userProfile);

    // Passo 5: Git backup
    const { setupGit } = await inquirer.prompt([
      {
        type: 'confirm',
        name: 'setupGit',
        message: 'Configurar backup automático (Git)?',
        default: true
      }
    ]);

    // Confirmar instalação
    console.log(chalk.yellow('\n📦 Resumo da Instalação:\n'));
    console.log(`  Local: ${chalk.green(installPath)}`);
    console.log(`  Nome: ${chalk.green(userName)}`);
    console.log(`  Perfil: ${chalk.green(userProfile)}`);
    console.log(`  Agentes: ${chalk.green(selectedAgents.length)} selecionados`);
    console.log(`  Backup: ${setupGit ? chalk.green('Sim') : chalk.gray('Não')}`);

    const { confirm } = await inquirer.prompt([
      {
        type: 'confirm',
        name: 'confirm',
        message: 'Confirmar instalação?',
        default: true
      }
    ]);

    if (!confirm) {
      console.log(chalk.yellow('\n❌ Instalação cancelada\n'));
      process.exit(0);
    }

    // Executar instalação
    const setup = new AssistenteSetup({
      installPath,
      userName,
      userProfile,
      selectedAgents,
      setupGit
    });

    await setup.run();
  });

program
  .command('add <agent>')
  .description('Adicionar um agente à instalação existente')
  .action(async (agentId) => {
    // TODO: Implementar
    console.log(`Adicionando agente: ${agentId}`);
  });

program.parse();
```

---

## 📝 Contribuindo Agentes (Community)

### Arquivo: `docs/CONTRIBUTING-AGENTS.md`

```markdown
# Como Contribuir um Agente

Obrigado por querer criar um agente para a comunidade!

## 📋 Checklist Rápido

- [ ] Criar pasta em `src/agents/community/seu-agente/`
- [ ] Adicionar `agent.yaml` com configuração
- [ ] Criar `memory-template.yaml`
- [ ] Adicionar tasks em `tasks/`
- [ ] Criar `README.md` explicando o agente
- [ ] Adicionar `AUTHOR.md` com seus créditos
- [ ] Registrar em `src/agents/agents.json`
- [ ] Criar Pull Request

## 🏗️ Estrutura de um Agente

```
src/agents/community/seu-agente/
├── agent.yaml              # Configuração do agente
├── memory-template.yaml    # Template de memória
├── tasks/                  # Workflows do agente
│   ├── tarefa-1.md
│   └── tarefa-2.md
├── templates/              # Templates (opcional)
│   └── template-1.yaml
├── README.md              # Documentação
└── AUTHOR.md              # Seus créditos
```

## 📄 agent.yaml (Template)

```yaml
id: seu-agente
name: Nome do Agente
title: Título Descritivo
icon: 💰
version: 1.0.0

description: |
  Descrição clara do que o agente faz.
  Seja específico e direto.

author: seu-username-github
category: [financas|criativo|tecnico|bem-estar|produtividade|carreira]

persona:
  role: Papel do Agente
  style: Tom de voz
  personality: |
    Descrição da personalidade

commands:
  - comando-1
  - comando-2

dependencies:
  tasks:
    - tarefa-1.md
    - tarefa-2.md
```

## 📝 AUTHOR.md (Template)

```markdown
# Agente: Seu Agente

**Autor**: Seu Nome (@seu-github)
**Contato**: seu@email.com (opcional)
**Data**: 2025-10-02

## Por que criei este agente?

[Explique a motivação]

## Casos de uso

[Liste 3-5 casos de uso práticos]

## Créditos

Se baseou em trabalho de outros? Dê créditos!
```

## 🔄 Processo de Contribuição

1. **Fork** do repositório
2. **Clone** seu fork
3. **Crie branch**: `git checkout -b agent/seu-agente`
4. **Desenvolva** o agente
5. **Teste** localmente
6. **Commit**: `git commit -m "feat: Add Seu Agente agent"`
7. **Push**: `git push origin agent/seu-agente`
8. **Pull Request** com descrição detalhada

## ✅ Critérios de Aprovação

Seu agente será aceito se:

- ✅ Segue estrutura padrão
- ✅ Tem documentação clara
- ✅ Não duplica agente existente
- ✅ Código/prompts são de qualidade
- ✅ Respeita Code of Conduct
- ✅ Funciona sem erros

## 🚫 O Que Não Será Aceito

- ❌ Agentes maliciosos ou spam
- ❌ Código ofensivo ou inadequado
- ❌ Duplicatas de agentes existentes
- ❌ Agentes muito genéricos (sem valor claro)

## 💡 Ideias de Agentes

**Precisamos de ajuda em**:
- 📚 Agente Estudos (técnica Feynman)
- 🏋️ Agente Saúde e Fitness
- 🍳 Agente Culinária e Nutrição
- 🎮 Agente Hobbies e Projetos Pessoais
- 🌍 Agente Viagens

**Veja issues com label** `agent-request`

## 🆘 Ajuda

Dúvidas? Abra uma issue ou pergunte no Discord!
```

---

## 🔄 Comandos Pós-Instalação

```bash
# Listar agentes instalados
$ npx assistente-pessoal list

🤖 Agentes Instalados:

  📋 Organizador (Sofia)
  📊 Secretária
  🧠 Psicólogo (Dr. Helena)

Total: 3 agentes

💡 Adicione mais: npx assistente-pessoal add arquiteto


# Adicionar agente depois
$ npx assistente-pessoal add arquiteto

📦 Adicionando agente: Arquiteto (Marcus)

⠋ Copiando arquivos...
✅ Arquiteto instalado com sucesso!

🚀 Use: /arquiteto no Claude Code


# Ver agentes disponíveis
$ npx assistente-pessoal available

🤖 Agentes Disponíveis:

━━━ AGENTES OFICIAIS ━━━

  🏗️  Arquiteto (Marcus)
      Consultoria técnica com confronto construtivo
      Status: Não instalado

  🎯 Mentor (Leonardo)
      Desenvolvimento de carreira
      Status: Não instalado

━━━ AGENTES DA COMUNIDADE ━━━

  💰 Consultor Financeiro
      Por: @joao-dev
      Status: Não instalado

  🎨 Designer Criativo
      Por: @maria-ux
      Status: Não instalado

Use: npx assistente-pessoal add <id>


# Remover agente
$ npx assistente-pessoal remove arquiteto

⚠️  Tem certeza que deseja remover Arquiteto (Marcus)? (s/N) s

✅ Arquiteto removido
```

---

## 📊 Comparação: Antes vs Depois

| Aspecto | Antes | Depois (Proposta) |
|---------|-------|-------------------|
| **Instalação** | 5 agentes fixos | Seleção interativa |
| **Agentes** | Hardcoded | Registry JSON |
| **Tamanho** | ~50 MB | ~15 MB (depende seleção) |
| **Community** | Impossível | Pull Requests |
| **Flexibilidade** | Zero | Total |
| **Complexidade** | Baixa | Média |
| **Extensibilidade** | Não | Sim (monorepo) |

---

## 🎯 Vantagens Desta Abordagem

### Para Usuários
- ✅ **Instalação customizada** (só o que precisa)
- ✅ **Menor tamanho** (não copia agentes não usados)
- ✅ **Controle total** (adicionar/remover depois)
- ✅ **Descoberta** (vê todos disponíveis)

### Para o Projeto
- ✅ **Monorepo** (tudo em um lugar)
- ✅ **Community via PR** (controle de qualidade)
- ✅ **Versionamento único** (não precisa sync packages)
- ✅ **Simples de manter** (sem NPM publishing)

### Para Contribuidores
- ✅ **Fork + PR** (workflow familiar)
- ✅ **Créditos claros** (AUTHOR.md)
- ✅ **Review process** (garantia de qualidade)
- ✅ **Descoberta** (agente fica visível no installer)

---

## 🚀 Roadmap de Implementação

### Fase 1: Core Installer (2-3 dias)
- [ ] Criar `agents.json` registry
- [ ] Implementar `AgentSelector`
- [ ] Adaptar `setup.js` para copiar apenas selecionados
- [ ] Testar fluxo completo

### Fase 2: CLI Commands (1-2 dias)
- [ ] `list` - Listar instalados
- [ ] `available` - Ver disponíveis
- [ ] `add <agent>` - Adicionar depois
- [ ] `remove <agent>` - Remover
- [ ] `info <agent>` - Detalhes

### Fase 3: Community Workflow (1 dia)
- [ ] `CONTRIBUTING-AGENTS.md`
- [ ] Template de agente
- [ ] PR template para agentes
- [ ] CI checks (validar agent.yaml)

### Fase 4: Migrar Agentes Existentes (1 dia)
- [ ] Mover 5 agentes atuais para `src/agents/`
- [ ] Registrar em `agents.json`
- [ ] Testar instalação seletiva
- [ ] Update README

**Total**: ~6-7 dias

---

## ✅ Isso Resolve Tudo?

**Checklist do que você queria**:
- ✅ Agentes **dentro do repo** (não packages externos)
- ✅ **Instalador interativo** (igual BMAD)
- ✅ **Escolher agentes** na instalação
- ✅ **Community contribui** via PR
- ✅ **Adicionar/remover** agentes depois
- ✅ **Monorepo** simples de manter

**Ficou faltando algo?** Me diga!

---

**Winston (Architect)**
*"Simplicidade é a sofisticação suprema." - Leonardo da Vinci*
