# 🎯 Plano de Execução: Epic 5 - NPM Package Production

**Data**: 2025-10-02
**Status**: Pronto para Executar
**Estimativa**: 16 horas (~2 dias úteis)

---

## 📊 Situação Atual

### ✅ O Que Já Está Pronto (60%)

**Infraestrutura NPM**:
- ✅ `package.json` configurado com bin entry point
- ✅ `bin/cli.js` com 6 comandos funcionais
- ✅ `src/commands/` - install, list, add, remove, available, info
- ✅ `src/installer/` - prompts, agent-selector, setup completo
- ✅ `src/utils/agent-registry.js` - Registry system
- ✅ `src/agents/agents.json` - Metadados dos 5 agentes

**Documentação User-First**:
- ✅ README.md reescrito (benefícios TDAH, instalação NPM)
- ✅ Arquivos reorganizados (raiz limpa com 2 arquivos)
- ✅ `docs/user-guide/` - USAGE, FAQ, TROUBLESHOOTING, BACKUP
- ✅ `docs/development/` - INSTALL-DEV, implementações
- ✅ `docs/development/REORGANIZACAO-USER-FIRST.md`

**Estrutura Limpa**:
```
✅ README.md (user-first!)
✅ package.json
✅ bin/ src/ docs/ scripts/ tests/
✅ despejo/ knowledge-base/ todos/ diario/
```

---

### ❌ O Que Falta (40%)

**Conteúdo Crítico**:
- ❌ Agentes ainda em `.assistant-core/agents/` (precisa mover para `src/agents/`)
- ❌ Pasta `templates/` não existe (precisa criar)
- ❌ Dependencies não instaladas (`node_modules/` vazio)
- ❌ Testes end-to-end não executados
- ❌ CI/CD não configurado

---

## 🗺️ Roadmap: 8 Stories

### 📅 Semana 1: Core Functionality (9h)

#### Story 5.1: Migração de Agentes ⏳ (2h)

**Objetivo**: Mover 5 agentes para `src/agents/`

**Comandos**:
```bash
# 1. Criar estrutura
mkdir -p src/agents/core/organizador
mkdir -p src/agents/official/secretaria
mkdir -p src/agents/official/arquiteto
mkdir -p src/agents/official/psicologo
mkdir -p src/agents/official/mentor

# 2. Copiar agentes
cp -r .assistant-core/agents/organizador/* src/agents/core/organizador/
cp -r .assistant-core/agents/secretaria/* src/agents/official/secretaria/
cp -r .assistant-core/agents/arquiteto/* src/agents/official/arquiteto/
cp -r .assistant-core/agents/psicologo/* src/agents/official/psicologo/
cp -r .assistant-core/agents/mentor/* src/agents/official/mentor/

# 3. Validar
npm run validate-agents
```

**Acceptance**:
- ✅ Todos os 5 agentes em `src/agents/`
- ✅ Estrutura: `agent.yaml`, `memory-template.yaml`, `tasks/`
- ✅ Validation script passa

---

#### Story 5.2: Templates Base ⏳ (1h)

**Objetivo**: Criar `templates/` para instalação limpa

**Estrutura**:
```
templates/
├── despejo/
│   └── daily-dump.md
├── knowledge-base/
│   ├── projetos/
│   ├── pessoas/
│   ├── decisoes/
│   └── aprendizados/
├── todos/
│   ├── por-projeto/
│   └── por-pessoa/
├── diario/
│   └── templates/
└── .assistant/
    ├── config/
    │   └── installation.json.template
    └── agents/  (vazio - populado durante install)
```

**Comandos**:
```bash
mkdir -p templates/{despejo,knowledge-base/{projetos,pessoas,decisoes,aprendizados},todos/{por-projeto,por-pessoa},diario/templates,.assistant/{config,agents}}

# Criar daily-dump template
cat > templates/despejo/daily-dump.md << 'EOF'
# Despejo Diário

[Data automática será inserida]

---

Escreva aqui tudo que vem à mente. Sem filtros, sem organização.
O Organizador vai processar isso depois.

EOF
```

---

#### Story 5.3: Testes End-to-End ⏳ (3h)

**Objetivo**: Validar que instalação funciona

**Comandos**:
```bash
# 1. Instalar dependencies
npm install

# 2. Link local
npm link

# 3. Teste 1: Instalação mínima
cd ~/test-minimal
assistente-pessoal install
# Escolher apenas Organizador
# Validar

# 4. Teste 2: Instalação completa
cd ~/test-full
assistente-pessoal install
# Escolher todos os 5
# Validar

# 5. Teste 3: Comandos CLI
assistente-pessoal list
assistente-pessoal available
assistente-pessoal add arquiteto
assistente-pessoal info secretaria
```

**Acceptance**:
- ✅ `npx assistente-pessoal install` completa sem erros
- ✅ Apenas agentes selecionados são instalados
- ✅ Estrutura de diretórios correta
- ✅ Git init funciona (se solicitado)

---

#### Story 5.4: Comandos CLI ⏳ (2h)

**Objetivo**: Testar todos comandos pós-instalação

**Testes**:
```bash
# Dentro de uma instalação
cd ~/test-full

# Test list
assistente-pessoal list
# ✅ Mostra agentes instalados com ícones

# Test available
assistente-pessoal available
# ✅ Mostra todos, marca instalados

# Test add
assistente-pessoal add mentor
# ✅ Adiciona se não instalado

# Test remove
assistente-pessoal remove secretaria
# ✅ Remove após confirmação

# Test info
assistente-pessoal info arquiteto
# ✅ Mostra detalhes completos
```

**Acceptance**:
- ✅ Todos os 5 comandos funcionam
- ✅ Auto-detecção de instalação funciona
- ✅ Error messages são user-friendly

---

#### Story 5.5: Community Workflow ⏳ (3h)

**Objetivo**: Workflow para contribuir agentes

**Criar**:
1. `docs/CONTRIBUTING-AGENTS.md` - Guia completo
2. `templates/community-agent/` - Template de agente
3. `.github/PULL_REQUEST_TEMPLATE/agent.md` - PR template
4. `.github/workflows/validate-agents.yml` - CI validation

**Exemplo CI**:
```yaml
name: Validate Agents

on:
  pull_request:
    paths:
      - 'src/agents/**'
      - 'src/agents/agents.json'

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm install
      - run: npm run validate-agents
```

---

### 📅 Semana 2: Polish e Launch (7h)

#### Story 5.6: Documentação Final ⏳ (2h)

**Criar**:
1. Screenshots do instalador (3-4 imagens)
2. GIF do processo completo (30 segundos)
3. Atualizar README com assets visuais
4. Criar `QUICK-START.md` (5 minutos até valor)
5. Adicionar badges (npm, license, build status)

**Badges**:
```markdown
![npm version](https://img.shields.io/npm/v/assistente-pessoal-ia)
![license](https://img.shields.io/npm/l/assistente-pessoal-ia)
![downloads](https://img.shields.io/npm/dt/assistente-pessoal-ia)
```

---

#### Story 5.7: Preparação NPM ⏳ (2h)

**Checklist**:
```bash
# 1. Criar LICENSE
cat > LICENSE << 'EOF'
MIT License
...
EOF

# 2. Validar package.json
# - name, version, description
# - keywords
# - repository, bugs, homepage
# - files array

# 3. Testar npm pack
npm pack
# Gera assistente-pessoal-ia-1.0.0.tgz

# 4. Testar instalação do .tgz
cd ~/test-npm
npm install ~/path/to/assistente-pessoal-ia-1.0.0.tgz

# 5. Criar tag git
git tag v1.0.0
```

**Acceptance**:
- ✅ `npm pack` gera package válido
- ✅ Package tem todos arquivos necessários
- ✅ Package NÃO tem node_modules, .git, etc.

---

#### Story 5.8: Deprecação Legacy ⏳ (1h)

**Adicionar em `scripts/setup.sh`**:
```bash
#!/bin/bash

echo "⚠️  AVISO: setup.sh está deprecated"
echo ""
echo "Para instalação moderna, use:"
echo "  npx assistente-pessoal install"
echo ""
echo "Continuar com setup.sh legacy? (y/N)"
read -r response

if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  exit 0
fi

# ... resto do script
```

**Atualizar docs**:
- README.md: NPM como método primário
- INSTALL-DEV.md: setup.sh para dev only
- Criar `MIGRATION.md`: git clone → npx

---

## 🎯 Checklist de Conclusão

### Funcional
- [ ] `npx assistente-pessoal install` funciona
- [ ] Todos os 5 agentes funcionam após instalação
- [ ] Comandos CLI funcionam (list, add, remove, available, info)
- [ ] Git init funciona
- [ ] Obsidian config funciona

### Documentação
- [ ] README.md com screenshots
- [ ] docs/user-guide/ completo
- [ ] CONTRIBUTING-AGENTS.md funcional
- [ ] LICENSE presente
- [ ] QUICK-START.md criado

### Qualidade
- [ ] Todos testes passando
- [ ] CI/CD configurado
- [ ] Error messages user-friendly
- [ ] Package validado com `npm pack`

### Publicação
- [ ] Semantic versioning (1.0.0)
- [ ] Git tag criado
- [ ] CHANGELOG.md atualizado
- [ ] Pronto para `npm publish`

---

## 🚀 Como Começar AGORA

### Passo 1: Preparar Ambiente

```bash
# No diretório do projeto
npm install
npm link
```

### Passo 2: Story 5.1 - Migração (Fazer Primeiro)

```bash
# Criar estrutura
mkdir -p src/agents/core/organizador
mkdir -p src/agents/official/{secretaria,arquiteto,psicologo,mentor}

# Copiar agentes
cp -r .assistant-core/agents/organizador/* src/agents/core/organizador/
cp -r .assistant-core/agents/secretaria/* src/agents/official/secretaria/
cp -r .assistant-core/agents/arquiteto/* src/agents/official/arquiteto/
cp -r .assistant-core/agents/psicologo/* src/agents/official/psicologo/
cp -r .assistant-core/agents/mentor/* src/agents/official/mentor/

# Validar
ls -R src/agents/
```

### Passo 3: Story 5.2 - Templates (Fazer Segundo)

```bash
mkdir -p templates/{despejo,knowledge-base,todos,diario,.assistant}
# ... criar arquivos template
```

### Passo 4: Story 5.3 - Testar (Fazer Terceiro)

```bash
assistente-pessoal --version
assistente-pessoal --help
assistente-pessoal install
```

---

## 📊 Tracking de Progresso

Use este formato para reportar progresso:

```
✅ Story 5.1: Migração de Agentes - COMPLETO
   - Agentes movidos: 5/5
   - Validation: PASS
   - Tempo: 1.5h (0.5h economizado)

🔄 Story 5.2: Templates - EM PROGRESSO (50%)
   - Estrutura criada: ✅
   - Templates: 3/6
   - Tempo: 0.5h de 1h
```

---

## 🎓 Referências

- **Epic 5**: `docs/prd/epic-5-npm-package-production.md`
- **Story 3.5**: `docs/stories/3.5.story.md`
- **Roadmap**: `docs/implementation/ROADMAP-3.5-npm-installer.md`
- **Reorganização**: `docs/development/REORGANIZACAO-USER-FIRST.md`

---

## 💬 Suporte

Para dúvidas ou bloqueios:
1. Consultar documentação em `docs/`
2. Revisar código existente em `src/`
3. Perguntar no contexto do desenvolvimento

---

**Criado**: 2025-10-02
**Autor**: Winston (Architect)
**Status**: 📋 Pronto para Execução
**Próximo Passo**: Story 5.1 - Migração de Agentes
