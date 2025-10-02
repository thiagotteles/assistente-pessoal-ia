# Roadmap: Story 3.5 - NPM Package e Instalador Interativo

**Story**: 3.5 - NPM Package e Instalador Interativo User-First
**Status**: 🔄 In Progress
**Start Date**: 2025-10-02
**Estimated Duration**: 6-7 dias

---

## 📋 Visão Geral

Transformar o Assistente Pessoal IA em produto user-first com instalação NPM interativa e seleção de agentes.

**Objetivo Principal**: `npx assistente-pessoal install` com interface similar ao BMAD method.

---

## 🗺️ Fases de Implementação

### ✅ Fase 0: Planejamento e Arquitetura (CONCLUÍDO)

**Duração**: 1 dia
**Status**: ✅ Completo

**Deliverables**:
- ✅ `docs/architecture/agent-selector-monorepo.md` - Arquitetura completa
- ✅ `docs/UX-BRIEF-user-first.md` - Brief para UX
- ✅ `docs/stories/3.5.story.md` - Story formal
- ✅ Roadmap de implementação

**Decisões Arquiteturais**:
- Monorepo approach (não NPM packages separados)
- Agent registry em JSON (`src/agents/agents.json`)
- Seleção interativa com inquirer.js
- Community via fork + PR workflow

---

### 🔄 Fase 1: Core Installer (ATUAL)

**Duração**: 2-3 dias
**Status**: 🔄 In Progress
**Prioridade**: Alta

#### Tarefas

##### 1.1 Setup NPM Package Structure
- [ ] Criar `package.json` com configuração NPM
  - `name: "assistente-pessoal-ia"`
  - `bin: { "assistente-pessoal": "./bin/cli.js" }`
  - `version: "1.0.0"`
- [ ] Adicionar dependencies:
  - `commander` - CLI framework
  - `inquirer` - Interactive prompts
  - `chalk` - Terminal colors
  - `ora` - Spinners
  - `fs-extra` - File operations
  - `yaml` - YAML parsing
- [ ] Configurar `.npmignore`
- [ ] Testar local install: `npm link`

**Acceptance**: `npx assistente-pessoal --version` funciona localmente

---

##### 1.2 Criar CLI Entry Point
- [ ] Criar `bin/cli.js`
  - Shebang: `#!/usr/bin/env node`
  - Setup commander.js
  - Comando `install`
  - Comando `--version`
  - Comando `--help`
- [ ] Adicionar error handling básico
- [ ] Testar execução: `node bin/cli.js --help`

**Acceptance**: CLI mostra help e versão corretamente

---

##### 1.3 Implementar Installer Base
- [ ] Criar `src/installer/prompts.js`
  - Prompt: Local de instalação (default: `~/assistente-ia`)
  - Prompt: Nome do usuário
  - Prompt: Configurar Git backup? (Sim/Não)
  - Validações básicas
- [ ] Criar `src/installer/setup.js`
  - Criar estrutura de diretórios
  - Copiar `templates/` para local de instalação
  - Feedback visual com `ora` spinners
  - Mensagem de sucesso final
- [ ] Integrar prompts com CLI

**Acceptance**:
```bash
npx assistente-pessoal install
# Pergunta local, nome, git
# Cria estrutura base
# Mostra mensagem de sucesso
```

---

##### 1.4 Criar Agent Registry
- [ ] Criar `src/agents/agents.json`
  - Schema com: id, name, title, icon, description, required, category, path
  - Registrar Organizador (core)
  - Registrar 4 agentes oficiais (secretaria, arquiteto, psicologo, mentor)
- [ ] Criar validador de schema
  - Validar campos obrigatórios
  - Validar paths existem
  - Validar IDs únicos
- [ ] Criar script de validação: `npm run validate-agents`

**Acceptance**: `agents.json` valida com todos os 5 agentes atuais

---

##### 1.5 Implementar Agent Selector
- [ ] Criar `src/installer/agent-selector.js`
  - Classe `AgentSelector`
  - Método `selectAgents(userProfile)`
  - Construir choices com separadores
  - Formatar com ícones e descrições
  - Marcar Organizador como obrigatório (disabled)
  - Marcar recomendados como checked
- [ ] Criar lógica de recomendações
  - Based on user profile (developer, designer, etc.)
  - Agents com `recommended: true`
  - Agents com `recommended_for: ["profile"]`
- [ ] Integrar com installer flow
- [ ] Adicionar summary de seleção

**Acceptance**: Interface checkbox mostra todos agentes, Organizador obrigatório, recomendados marcados

---

##### 1.6 Adaptar Setup para Copiar Apenas Selecionados
- [ ] Modificar `setup.js`:
  - Receber `selectedAgents` array
  - Loop por cada agente selecionado
  - Copiar de `src/agents/<category>/<id>/` para `.assistant/agents/<id>/`
  - Spinner individual por agente
- [ ] Validar agentes copiados
  - Check `agent.yaml` existe
  - Check `tasks/` existe
  - Log agentes instalados
- [ ] Atualizar mensagem de sucesso
  - Listar agentes instalados com ícones
  - Mostrar próximos passos

**Acceptance**: Apenas agentes selecionados são copiados, mensagem final mostra lista correta

---

#### 📊 Deliverables Fase 1

- ✅ `package.json` com bin entry point
- ✅ `bin/cli.js` funcional
- ✅ `src/installer/prompts.js`
- ✅ `src/installer/agent-selector.js`
- ✅ `src/installer/setup.js`
- ✅ `src/agents/agents.json`
- ✅ `npx assistente-pessoal install` completo e funcional

#### 🧪 Testing Fase 1

```bash
# Test 1: Basic install
npx assistente-pessoal install
# → Escolher local
# → Escolher agentes (Organizador + Secretária + Psicólogo)
# → Confirmar
# → Verificar apenas 3 agentes em .assistant/agents/

# Test 2: Minimal install
npx assistente-pessoal install
# → Escolher apenas Organizador
# → Verificar apenas Organizador instalado

# Test 3: Full install
npx assistente-pessoal install
# → Selecionar todos os 5 agentes
# → Verificar todos instalados
```

---

### ⏳ Fase 2: CLI Commands

**Duração**: 1-2 dias
**Status**: ⏳ Planejado
**Dependências**: Fase 1 completa

#### Tarefas

##### 2.1 Implementar `list` Command
- [ ] Criar `src/commands/list.js`
- [ ] Ler `.assistant/agents/` directory
- [ ] Buscar metadata de cada agente
- [ ] Formatar output com tabela
- [ ] Mostrar: ícone, nome, categoria, status

**Expected Output**:
```bash
$ npx assistente-pessoal list

🤖 Agentes Instalados:

  📋 Organizador (Sofia)        [Core]
  📊 Secretária                 [Produtividade]
  🧠 Psicólogo (Dr. Helena)     [Bem-estar]

Total: 3 agentes

💡 Adicione mais: npx assistente-pessoal add arquiteto
```

---

##### 2.2 Implementar `add` Command
- [ ] Criar `src/commands/add.js`
- [ ] Validar agente existe no registry
- [ ] Verificar se já instalado
- [ ] Copiar agente para `.assistant/agents/`
- [ ] Atualizar configuração se necessário
- [ ] Feedback de sucesso

**Expected Flow**:
```bash
$ npx assistente-pessoal add arquiteto

📦 Adicionando agente: Arquiteto (Marcus)
⠋ Copiando arquivos...
✅ Arquiteto instalado com sucesso!

🚀 Use: /arquiteto no Claude Code
```

---

##### 2.3 Implementar `remove` Command
- [ ] Criar `src/commands/remove.js`
- [ ] Validar agente está instalado
- [ ] Bloquear remoção de core agents (Organizador)
- [ ] Prompt de confirmação
- [ ] Remover directory `.assistant/agents/<id>/`
- [ ] Feedback de sucesso

**Expected Flow**:
```bash
$ npx assistente-pessoal remove secretaria

⚠️  Tem certeza que deseja remover Secretária? (s/N) s
✅ Secretária removido
```

---

##### 2.4 Implementar `available` Command
- [ ] Criar `src/commands/available.js`
- [ ] Ler todos agentes do registry
- [ ] Marcar quais já estão instalados
- [ ] Separar por categorias (core, official, community)
- [ ] Mostrar descrições

**Expected Output**:
```bash
$ npx assistente-pessoal available

🤖 Agentes Disponíveis:

━━━ AGENTES OFICIAIS ━━━

  🏗️  Arquiteto (Marcus)
      Consultoria técnica com confronto construtivo
      Status: ✅ Instalado

  🎯 Mentor (Leonardo)
      Desenvolvimento de carreira
      Status: ⬜ Não instalado

━━━ AGENTES DA COMUNIDADE ━━━

  💰 Consultor Financeiro (por @joao-dev)
      Status: ⬜ Não instalado

Use: npx assistente-pessoal add <id>
```

---

##### 2.5 Implementar `info` Command
- [ ] Criar `src/commands/info.js`
- [ ] Buscar agente no registry
- [ ] Mostrar todos metadados
- [ ] Ler e exibir README do agente (se existir)
- [ ] Mostrar autor, categoria, dependências

**Expected Output**:
```bash
$ npx assistente-pessoal info arquiteto

🏗️  Arquiteto (Marcus)

Título: Arquiteto Confrontador
Categoria: Técnico
Autor: Oficial
Status: Instalado

Descrição:
Consultoria técnica com confronto construtivo para
decisões arquiteturais.

Recomendado para: Desenvolvedores, Tech Leads

Comandos disponíveis:
  - consultoria-tecnica
  - analise-projeto
  - confronto-tecnico
  - registrar-decisao
```

---

#### 📊 Deliverables Fase 2

- ✅ `src/commands/list.js`
- ✅ `src/commands/add.js`
- ✅ `src/commands/remove.js`
- ✅ `src/commands/available.js`
- ✅ `src/commands/info.js`
- ✅ CLI completo com 5 comandos funcionais

---

### ⏳ Fase 3: Community Workflow

**Duração**: 1 dia
**Status**: ⏳ Planejado
**Dependências**: Fase 1 completa

#### Tarefas

##### 3.1 Criar Documentação de Contribuição
- [ ] Criar `docs/CONTRIBUTING-AGENTS.md`
  - Explicar estrutura de um agente
  - Template de `agent.yaml`
  - Template de `memory-template.yaml`
  - Template de `AUTHOR.md`
  - Workflow: fork → branch → PR → review
  - Checklist de qualidade
  - Exemplos de bons agentes

---

##### 3.2 Criar Templates de Agente
- [ ] Criar `templates/community-agent/`
  - `agent.yaml.template`
  - `memory-template.yaml.template`
  - `AUTHOR.md.template`
  - `README.md.template`
  - `tasks/exemplo.md.template`

---

##### 3.3 Criar PR Template
- [ ] Criar `.github/PULL_REQUEST_TEMPLATE/agent.md`
  - Checklist de validação
  - Informações obrigatórias
  - Link para CONTRIBUTING-AGENTS.md

---

##### 3.4 Implementar CI Validation
- [ ] Criar `.github/workflows/validate-agents.yml`
  - Trigger on PR to `src/agents/`
  - Validar `agents.json` schema
  - Validar novo agente tem estrutura correta
  - Check for duplicate IDs
  - Validar paths existem
  - Comment on PR with results

---

#### 📊 Deliverables Fase 3

- ✅ `docs/CONTRIBUTING-AGENTS.md`
- ✅ `templates/community-agent/` completo
- ✅ `.github/PULL_REQUEST_TEMPLATE/agent.md`
- ✅ `.github/workflows/validate-agents.yml`
- ✅ CI validando PRs automaticamente

---

### ⏳ Fase 4: Migração de Agentes Existentes

**Duração**: 1 dia
**Status**: ⏳ Planejado
**Dependências**: Fase 1 completa

#### Tarefas

##### 4.1 Mover Estrutura de Agentes
- [ ] Criar `src/agents/core/organizador/`
  - Mover `.assistant-core/agents/organizador/`
  - Validar estrutura
- [ ] Criar `src/agents/official/secretaria/`
  - Mover `.assistant-core/agents/secretaria/`
- [ ] Criar `src/agents/official/arquiteto/`
  - Mover `.assistant-core/agents/arquiteto/`
- [ ] Criar `src/agents/official/psicologo/`
  - Mover `.assistant-core/agents/psicologo/`
- [ ] Criar `src/agents/official/mentor/`
  - Mover `.assistant-core/agents/mentor/`

---

##### 4.2 Registrar no agents.json
- [ ] Adicionar metadados completos
  - Ícones apropriados
  - Descrições user-friendly
  - Categorias corretas
  - Marcar recomendações

---

##### 4.3 Testar Instalação Seletiva
- [ ] Test: Instalar apenas Organizador
- [ ] Test: Instalar Organizador + Secretária
- [ ] Test: Instalar todos os 5
- [ ] Validar slash commands funcionam
- [ ] Validar memória de agentes funciona
- [ ] Validar tasks executam corretamente

---

##### 4.4 Deprecar setup.sh
- [ ] Adicionar deprecation notice no `setup.sh`
- [ ] Criar `setup-legacy.sh` (backup)
- [ ] Atualizar documentação
- [ ] Criar migration guide

---

#### 📊 Deliverables Fase 4

- ✅ Todos agentes em `src/agents/`
- ✅ `.assistant-core/agents/` vazio (deprecated)
- ✅ `agents.json` completo e validado
- ✅ Todos testes passando
- ✅ Migration guide criado

---

### ⏳ Fase 5: UX Refinement e Documentação

**Duração**: 1 dia
**Status**: ⏳ Planejado
**Dependências**: Fases 1-4 completas

#### Tarefas

##### 5.1 Reescrever README (User-First)
- [ ] Hero section
  - Tagline impactante
  - GIF do instalador
  - Call-to-action: instalação em 1 comando
- [ ] "Por que usar?" (antes de "Como usar?")
  - Benefícios TDAH com empatia
  - Casos de uso reais
  - Depoimentos (se houver)
- [ ] "Como instalar?" (destaque)
  - `npx assistente-pessoal install`
  - Screenshot do agent selector
  - Tempo estimado: < 2 minutos
- [ ] "Como usar?" (progressivo)
  - Quick Start (5 minutos)
  - Link para USAGE.md
- [ ] Seções finais
  - Community (como contribuir)
  - Privacidade (100% local)
  - Suporte e ajuda

---

##### 5.2 Criar USAGE.md Progressivo
- [ ] Quick Start (5 min)
  - Instalação
  - Primeiro uso do Organizador
  - Quick win: processar despejo
- [ ] Guia Completo
  - Todos os agentes
  - Comandos disponíveis
  - Obsidian integration
  - Git backup
- [ ] FAQ
  - Instalação
  - Uso diário
  - Troubleshooting
  - Privacidade

---

##### 5.3 Criar Assets Visuais
- [ ] GIF: Processo de instalação completo
- [ ] Screenshot: Agent selector
- [ ] Screenshot: Success message
- [ ] Screenshot: CLI commands (list, add, available)
- [ ] Screenshot: Obsidian dashboard

---

##### 5.4 Refinar Mensagens UX
- [ ] Error messages amigáveis
  - Node.js não instalado
  - Pasta já existe
  - Git não configurado
  - Permissões insuficientes
- [ ] Success messages motivacionais
  - Instalação completa
  - Agente adicionado
  - Primeiro uso bem-sucedido
- [ ] Progress indicators claros
  - Spinners com mensagens descritivas
  - Estimativas de tempo quando aplicável

---

#### 📊 Deliverables Fase 5

- ✅ `README.md` user-first completo
- ✅ `docs/USAGE.md` progressivo
- ✅ `docs/FAQ.md`
- ✅ Assets visuais (GIFs + screenshots)
- ✅ Mensagens UX refinadas

---

## 📊 Progresso Geral

| Fase | Status | Progresso | Estimativa | Real |
|------|--------|-----------|------------|------|
| 0. Planejamento | ✅ Done | 100% | 1 dia | 1 dia |
| 1. Core Installer | 🔄 In Progress | 0% | 2-3 dias | - |
| 2. CLI Commands | ⏳ Planned | 0% | 1-2 dias | - |
| 3. Community Workflow | ⏳ Planned | 0% | 1 dia | - |
| 4. Migração Agentes | ⏳ Planned | 0% | 1 dia | - |
| 5. UX Refinement | ⏳ Planned | 0% | 1 dia | - |
| **TOTAL** | **17%** | - | **6-7 dias** | **1 dia** |

---

## ✅ Definition of Done (Story 3.5)

- [ ] `npx assistente-pessoal install` funciona em Win/Mac/Linux
- [ ] Agent selector interativo com todos os 5 agentes
- [ ] Apenas agentes selecionados são instalados
- [ ] Comandos `list`, `add`, `remove`, `available`, `info` funcionam
- [ ] `CONTRIBUTING-AGENTS.md` completo
- [ ] CI valida estrutura de agentes em PRs
- [ ] README é user-first e compelling
- [ ] Todos os 5 agentes migrados para `src/agents/`
- [ ] Testes de instalação passam (Win/Mac/Linux)
- [ ] Documentação completa (USAGE.md, FAQ.md)
- [ ] Assets visuais criados (GIFs, screenshots)
- [ ] Zero breaking changes para usuários existentes (via Story 3.0)

---

## 🔗 Links Importantes

- **Story**: [docs/stories/3.5.story.md](../stories/3.5.story.md)
- **Arquitetura**: [docs/architecture/agent-selector-monorepo.md](../architecture/agent-selector-monorepo.md)
- **UX Brief**: [docs/UX-BRIEF-user-first.md](../UX-BRIEF-user-first.md)
- **Epic Status**: [docs/prd/EPICOS-STATUS.md](../prd/EPICOS-STATUS.md)

---

**Created**: 2025-10-02
**Author**: Winston (Architect)
**Last Updated**: 2025-10-02
