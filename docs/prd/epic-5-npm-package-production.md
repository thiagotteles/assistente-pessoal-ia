# Epic 5: NPM Package e Produção User-First

**Status**: 🔄 Em Progresso
**Prioridade**: Alta
**Objetivo**: Completar transformação para produto NPM user-first pronto para produção

---

## 🎯 Visão Geral

Transformar o Assistente Pessoal IA de projeto de desenvolvimento em **produto NPM production-ready**, com instalação trivial (`npx assistente-pessoal install`), documentação user-first, e estrutura limpa.

---

## 📊 Progresso Atual

| Componente | Status | Progresso |
|-----------|--------|-----------|
| Estrutura NPM | ✅ Completo | 100% |
| CLI Commands | ✅ Completo | 100% |
| Agent Registry | ✅ Completo | 100% |
| Instalador Interativo | ✅ Completo | 100% |
| README User-First | ✅ Completo | 100% |
| Reorganização Arquivos | ✅ Completo | 100% |
| **Migração de Agentes** | ❌ Pendente | 0% |
| **Templates Base** | ❌ Pendente | 0% |
| **Testes End-to-End** | ❌ Pendente | 0% |
| **CI/CD** | ❌ Pendente | 0% |
| **Publicação NPM** | ❌ Pendente | 0% |

**Overall**: 60% completo

---

## 📋 Stories do Epic

**NOTA**: Story 5.0 (anteriormente 3.5) é o container deste Epic. Veja `docs/stories/5.0.story.md` para contexto completo e user stories originais.

### Story 5.0: NPM Package e Instalador User-First (Container) 🔄

**Status**: In Progress
**Arquivo**: [5.0.story.md](../stories/5.0.story.md)
**Estimativa Total**: 20 horas (~2.5 dias úteis)

Esta é a story guarda-chuva que contém todas as sub-stories abaixo (5.1 a 5.8).

---

### Story 5.1: Migração de Agentes para src/agents/ ⏳

**Objetivo**: Mover todos os 5 agentes de `.assistant-core/agents/` para `src/agents/` no formato correto.

**Tarefas**:
1. ✅ Criar estrutura `src/agents/core/organizador/`
2. ✅ Criar estrutura `src/agents/official/{secretaria,arquiteto,psicologo,mentor}/`
3. ⏳ Copiar agente Organizador (Sofia)
4. ⏳ Copiar agente Secretária
5. ⏳ Copiar agente Arquiteto (Marcus)
6. ⏳ Copiar agente Psicólogo (Dr. Helena)
7. ⏳ Copiar agente Mentor (Leonardo)
8. ⏳ Validar estrutura de cada agente
9. ⏳ Atualizar `agents.json` com paths corretos

**Acceptance Criteria**:
- ✅ Todos os 5 agentes em `src/agents/`
- ✅ Estrutura: `agent.yaml`, `memory-template.yaml`, `tasks/`
- ✅ Registry validado: `npm run validate-agents`
- ✅ `.assistant-core/agents/` deprecated

**Estimativa**: 2 horas

---

### Story 5.2: Criação de Templates Base ⏳

**Objetivo**: Criar `templates/` com estrutura base para instalação limpa.

**Tarefas**:
1. ⏳ Criar `templates/` directory
2. ⏳ Criar templates de diretórios básicos
3. ⏳ Criar `templates/.assistant/config/` base
4. ⏳ Criar template de `daily-dump.md`
5. ⏳ Criar template de `BEM-VINDO.md`
6. ⏳ Criar `.gitignore` template
7. ⏳ Criar Obsidian config template

**Acceptance Criteria**:
- ✅ `templates/` contém estrutura mínima
- ✅ Setup.js copia de `templates/` corretamente
- ✅ Instalação cria estrutura completa

**Estimativa**: 1 hora

---

### Story 5.3: Testes End-to-End da Instalação 🔴

**Objetivo**: Validar que `npx assistente-pessoal install` funciona perfeitamente.

**Tarefas**:
1. ⏳ Instalar dependencies: `npm install`
2. ⏳ Link local: `npm link`
3. ⏳ Teste 1: Instalação mínima (apenas Organizador)
4. ⏳ Teste 2: Instalação completa (todos os 5 agentes)
5. ⏳ Teste 3: Instalação customizada (3 agentes)
6. ⏳ Validar Git init funciona
7. ⏳ Validar Obsidian config funciona
8. ⏳ Validar slash commands funcionam
9. ⏳ Testar em Windows
10. ⏳ Testar em Mac/Linux

**Acceptance Criteria**:
- ✅ `npx assistente-pessoal install` completa sem erros
- ✅ Apenas agentes selecionados são instalados
- ✅ Slash commands funcionam: `/organizador`, `/secretaria`, etc.
- ✅ Git repository criado se solicitado
- ✅ Funciona em Win/Mac/Linux

**Estimativa**: 3 horas

---

### Story 5.4: Comandos CLI Pós-Instalação 🔴

**Objetivo**: Validar que `list`, `add`, `remove`, `available`, `info` funcionam.

**Tarefas**:
1. ⏳ Testar `assistente-pessoal list`
2. ⏳ Testar `assistente-pessoal available`
3. ⏳ Testar `assistente-pessoal add arquiteto`
4. ⏳ Testar `assistente-pessoal remove secretaria`
5. ⏳ Testar `assistente-pessoal info psicologo`
6. ⏳ Validar detecção automática de instalação
7. ⏳ Validar error messages
8. ⏳ Validar que core agents não podem ser removidos

**Acceptance Criteria**:
- ✅ Todos os 5 comandos funcionam
- ✅ Error messages são user-friendly
- ✅ Auto-detecção de instalação funciona
- ✅ Feedback visual claro

**Estimativa**: 2 horas

---

### Story 5.5: Community Workflow e CI/CD 🔴

**Objetivo**: Workflow completo para contribuição de agentes.

**Tarefas**:
1. ⏳ Criar `CONTRIBUTING-AGENTS.md`
2. ⏳ Criar templates de agente community
3. ⏳ Criar PR template para agentes
4. ⏳ Configurar GitHub Actions para validar `agents.json`
5. ⏳ CI: Validar estrutura de novos agentes
6. ⏳ CI: Testes automáticos em PRs
7. ⏳ CI: Check duplicates e IDs únicos

**Acceptance Criteria**:
- ✅ `CONTRIBUTING-AGENTS.md` completo
- ✅ Template de agente funcional
- ✅ CI valida PRs automaticamente
- ✅ Processo documentado passo-a-passo

**Estimativa**: 3 horas

---

### Story 5.6: Documentação Final User-First ⏳

**Objetivo**: Completar toda documentação user-facing.

**Tarefas**:
1. ✅ README.md user-first (completo)
2. ⏳ Criar screenshots do instalador
3. ⏳ Criar GIF do processo de instalação
4. ⏳ Atualizar `docs/user-guide/USAGE.md`
5. ⏳ Atualizar `docs/user-guide/FAQ.md`
6. ⏳ Criar `QUICK-START.md` (5 minutos)
7. ⏳ Adicionar badges ao README (npm, license, etc.)

**Acceptance Criteria**:
- ✅ README tem screenshots/GIFs
- ✅ USAGE.md atualizado com NPM install
- ✅ FAQ responde top 10 perguntas
- ✅ QUICK-START é < 5 minutos

**Estimativa**: 2 horas

---

### Story 5.7: Preparação para Publicação NPM 🔴

**Objetivo**: Package pronto para `npm publish`.

**Tarefas**:
1. ⏳ Criar LICENSE (MIT)
2. ⏳ Atualizar `package.json` metadata
3. ⏳ Configurar `.npmignore` completo
4. ⏳ Validar `files` no package.json
5. ⏳ Criar CHANGELOG.md final
6. ⏳ Testar `npm pack` local
7. ⏳ Testar instalação do .tgz
8. ⏳ Definir semantic versioning (1.0.0)
9. ⏳ Criar tags git para releases

**Acceptance Criteria**:
- ✅ `npm pack` gera .tgz válido
- ✅ Package tem todos arquivos necessários
- ✅ Package NÃO tem arquivos dev
- ✅ LICENSE presente
- ✅ Metadata completo

**Estimativa**: 2 horas

---

### Story 5.8: Deprecação de Instalação Legacy 🔴

**Objetivo**: Marcar `setup.sh` como deprecated, promover NPM install.

**Tarefas**:
1. ⏳ Adicionar warning em `setup.sh`
2. ⏳ Criar `setup-legacy.sh` (backup)
3. ⏳ Atualizar docs para mostrar NPM como primário
4. ⏳ Criar migration guide: setup.sh → npx
5. ⏳ Manter compatibilidade para dev

**Acceptance Criteria**:
- ✅ `setup.sh` mostra deprecation warning
- ✅ Docs promovem NPM install
- ✅ Migration guide disponível
- ✅ Dev workflow ainda funciona

**Estimativa**: 1 hora

---

## 📅 Timeline Proposto

### Semana 1: Core Functionality

**Dia 1-2** (4h):
- ✅ Story 5.1: Migração de Agentes
- ✅ Story 5.2: Templates Base

**Dia 3** (3h):
- ✅ Story 5.3: Testes End-to-End

**Dia 4** (2h):
- ✅ Story 5.4: Comandos CLI

---

### Semana 2: Polish e Launch

**Dia 5** (3h):
- ✅ Story 5.5: Community Workflow

**Dia 6** (2h):
- ✅ Story 5.6: Documentação Final

**Dia 7** (3h):
- ✅ Story 5.7: Preparação NPM
- ✅ Story 5.8: Deprecação Legacy

---

**Total Estimado**: 19 horas (~2.5 dias úteis)

---

## ✅ Definition of Done (Epic 5)

### Funcional

- ✅ `npx assistente-pessoal install` funciona em Win/Mac/Linux
- ✅ Todos os 5 agentes funcionam após instalação
- ✅ Comandos CLI funcionam (list, add, remove, available, info)
- ✅ Git init e Obsidian config funcionam
- ✅ Seleção de agentes funciona corretamente

### Documentação

- ✅ README.md user-first com screenshots
- ✅ docs/user-guide/ completo
- ✅ docs/development/ completo
- ✅ CONTRIBUTING-AGENTS.md funcional
- ✅ LICENSE presente

### Qualidade

- ✅ Todos testes passando
- ✅ CI/CD configurado
- ✅ Zero breaking changes para usuários existentes
- ✅ Error messages user-friendly
- ✅ Performance aceitável (< 2min instalação)

### Publicação

- ✅ `npm pack` gera package válido
- ✅ Package testado localmente
- ✅ Semantic versioning definido (1.0.0)
- ✅ Pronto para `npm publish`

---

## 🎯 Success Metrics

**Instalação**:
- ⏱️ Tempo médio: < 2 minutos
- 📦 Tamanho do package: < 5MB
- ✅ Taxa de sucesso: > 95%

**Adoção**:
- 📈 Downloads NPM: Meta de 100 em 30 dias
- ⭐ GitHub stars: +50% após launch
- 💬 Issues abertos: < 10 bugs críticos

**Qualidade**:
- ✅ Zero critical bugs no primeiro mês
- ✅ Tempo médio de resposta issues: < 48h
- ✅ Documentação clarity score: > 90%

---

## 🔗 Dependências

### Bloqueado Por

- Nada (pode começar agora)

### Bloqueia

- Epic 6 (futuro): Features Avançadas
- Publicação oficial no NPM Registry
- Marketing e divulgação

---

## 📝 Notas Técnicas

### Arquitetura Atual

```
✅ package.json - Completo
✅ bin/cli.js - Completo
✅ src/commands/ - 6 comandos implementados
✅ src/installer/ - Completo
✅ src/utils/agent-registry.js - Completo
✅ src/agents/agents.json - Registry criado

⏳ src/agents/core/organizador/ - Precisa migrar
⏳ src/agents/official/{4 agentes}/ - Precisa migrar
⏳ templates/ - Precisa criar
```

### Breaking Changes

- ✅ **Instalação**: De `git clone` para `npx install` (sem impacto, novo método)
- ✅ **Estrutura**: De `.assistant-core/` para `src/agents/` (apenas dev)
- ✅ **Setup**: `setup.sh` deprecated mas funcional (backward compatible)

### Backward Compatibility

- ✅ Usuários existentes: Story 3.0 (Upgrade Path) já implementada
- ✅ Dev workflow: `setup.sh` continua funcionando
- ✅ Slash commands: Mesmos comandos `/organizador`, etc.

---

## 🚀 Quick Start para Começar

### Para Implementar Story 5.1 (Agora)

```bash
# 1. Criar estrutura
mkdir -p src/agents/core/organizador
mkdir -p src/agents/official/{secretaria,arquiteto,psicologo,mentor}

# 2. Copiar agentes
cp -r .assistant-core/agents/organizador/* src/agents/core/organizador/
cp -r .assistant-core/agents/secretaria/* src/agents/official/secretaria/
# ... etc

# 3. Validar
npm run validate-agents

# 4. Testar
npm link
assistente-pessoal install
```

---

## 📊 Progresso Stories

| Story | Nome | Status | Estimativa | Real |
|-------|------|--------|------------|------|
| 5.1 | Migração Agentes | ⏳ Todo | 2h | - |
| 5.2 | Templates Base | ⏳ Todo | 1h | - |
| 5.3 | Testes E2E | ⏳ Todo | 3h | - |
| 5.4 | CLI Commands | ⏳ Todo | 2h | - |
| 5.5 | Community/CI | ⏳ Todo | 3h | - |
| 5.6 | Docs Final | ⏳ Todo | 2h | - |
| 5.7 | NPM Prep | ⏳ Todo | 2h | - |
| 5.8 | Legacy Deprecation | ⏳ Todo | 1h | - |
| **Total** | - | **0%** | **16h** | **0h** |

---

## 🎓 Aprendizados do Epic 3 (Aplicar aqui)

- ✅ User-first funciona: Foco em benefícios, não features
- ✅ Limpeza agressiva: Raiz limpa = profissional
- ✅ Separação de audiências: User vs Dev docs
- ✅ NPM trivializa instalação: `npx` é mágico
- ✅ Registry JSON: Flexibilidade total

---

## 🔄 Relacionamento com Outros Epics

- **Epic 0**: Setup automático (agora via NPM)
- **Epic 1**: Captura ultra-rápida (mantida)
- **Epic 2**: 5 agentes (agora modulares/selecionáveis)
- **Epic 3**: Experiência usuário (complementado)
- **Epic 4**: QA (testes adaptados)
- **Epic 5**: **NPM Package** ← ESTE
- **Epic 6** (futuro): Features avançadas pós-launch

---

**Criado**: 2025-10-02
**Autor**: Winston (Architect)
**Status**: 🔄 Pronto para Execução
**Prioridade**: 🔥 Alta - Crítico para Launch
