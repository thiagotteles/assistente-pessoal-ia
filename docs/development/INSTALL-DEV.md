# Instalação para Desenvolvimento

**Guia completo para desenvolvedores que querem contribuir com o projeto**

---

## 📋 Pré-requisitos

- **Node.js 14+** e **npm 6+**
- **Git**
- **Claude Code** ou qualquer editor Markdown
- **Bash** (Git Bash no Windows)

---

## 🔧 Setup Completo

### 1. Clone do Repositório

```bash
git clone https://github.com/yourusername/assistente-pessoal-ia.git
cd assistente-pessoal-ia
```

### 2. Instalar Dependências

```bash
npm install
```

### 3. Link Local (para testar CLI)

```bash
npm link
```

Agora você pode usar `assistente-pessoal` globalmente para testar.

### 4. Executar Setup de Desenvolvimento

```bash
bash scripts/setup.sh
```

Isso cria a estrutura de diretórios necessária para desenvolvimento.

---

## 📁 Estrutura do Projeto (Dev)

```
assistente-pessoal-ia/
├── bin/                        # CLI entry point
│   └── cli.js
├── src/                        # Source code
│   ├── agents/
│   │   └── agents.json         # Agent registry
│   ├── commands/               # CLI commands
│   ├── installer/              # Installation logic
│   └── utils/                  # Utilities
├── .assistant-core/            # Current agents (legacy)
│   └── agents/                 # Will be migrated to src/agents/
├── docs/
│   ├── architecture/           # Architecture docs
│   ├── stories/                # User stories
│   ├── development/            # Dev docs (this file)
│   └── user-guide/             # User documentation
├── scripts/                    # Build and utility scripts
├── tests/                      # Test files
├── despejo/                    # Capture directory
├── knowledge-base/             # Knowledge base
├── todos/                      # Tasks
└── diario/                     # Diary
```

---

## 🧪 Testes

### Executar Todos os Testes

```bash
npm test
```

### Executar Testes Específicos

```bash
# Test básico do sistema
bash tests/test-basic.sh

# Tests de uma story específica
bash tests/test-story-2.1.sh
```

### Validar Agent Registry

```bash
npm run validate-agents
```

---

## 🔨 Comandos de Desenvolvimento

### Testar CLI Localmente

```bash
# Testar install command
assistente-pessoal install

# Testar list command
assistente-pessoal list

# Testar add command
assistente-pessoal add arquiteto
```

### Debug

```bash
# Executar com debug output
DEBUG=* assistente-pessoal install

# Ou executar diretamente com node
node bin/cli.js install
```

---

## 📝 Workflow de Contribuição

### 1. Criar Branch

```bash
git checkout -b feature/minha-feature
```

### 2. Desenvolver

Faça suas alterações seguindo:
- **[Guia de Arquitetura](../architecture/agent-selector-monorepo.md)**
- **[Guia de Stories](../stories/)**

### 3. Testar

```bash
npm test
npm run validate-agents
```

### 4. Commit

```bash
git add .
git commit -m "feat: Descrição da feature"
```

### 5. Push e PR

```bash
git push origin feature/minha-feature
```

Abra Pull Request no GitHub.

---

## 🤖 Desenvolvendo Agentes

### Estrutura de um Agente

```
src/agents/official/meu-agente/
├── agent.yaml              # Configuração
├── memory-template.yaml    # Template de memória
├── tasks/                  # Workflows
│   ├── tarefa-1.md
│   └── tarefa-2.md
└── README.md              # Documentação
```

### Registrar Agente

Adicione ao `src/agents/agents.json`:

```json
{
  "id": "meu-agente",
  "name": "Meu Agente",
  "title": "Título Descritivo",
  "icon": "🎨",
  "description": "Descrição clara",
  "required": false,
  "recommended": false,
  "author": "oficial",
  "category": "criativo",
  "path": "src/agents/official/meu-agente",
  "version": "1.0.0"
}
```

### Testar Agente

```bash
# Validar estrutura
npm run validate-agents

# Instalar localmente
assistente-pessoal add meu-agente

# Testar no Claude Code
/meu-agente
```

---

## 📚 Documentação

### Arquitetura

- **[Agent Selector Monorepo](../architecture/agent-selector-monorepo.md)** - Arquitetura principal
- **[User-First Transformation](../architecture/user-first-transformation.md)** - NPM package design

### Stories

- **[Story 3.5](../stories/3.5.story.md)** - NPM Package e Instalador
- **[Roadmap 3.5](ROADMAP-3.5-npm-installer.md)** - Implementation roadmap

### Development

- **[CHANGELOG](CHANGELOG.md)** - Histórico de mudanças
- **[Implementation Summaries](.)** - Resumos de implementação por story

---

## 🐛 Troubleshooting

### NPM Link Não Funciona

```bash
npm unlink
npm link
```

### Erro ao Instalar Dependencies

```bash
rm -rf node_modules package-lock.json
npm install
```

### Agente Não Aparece no Selector

```bash
# Validar registry
npm run validate-agents

# Verificar se agent.yaml existe
ls -la src/agents/official/meu-agente/
```

---

## 🚀 Build e Deploy

### Build para Produção

```bash
# Validar tudo
npm test
npm run validate-agents

# Preparar para publish (quando pronto)
npm version patch  # ou minor, major
```

### Deploy Local (Testing)

```bash
# Instalar em diretório de teste
cd ~/test-install
npx /path/to/assistente-pessoal-ia install
```

---

## 📊 Métricas de Código

### Estrutura Atual

- **Total de Comandos CLI**: 6 (install, list, add, remove, available, info)
- **Total de Agentes**: 5 (1 core + 4 oficial)
- **Coverage de Testes**: Ver `npm test`
- **Linhas de Código**: ~3000 (src/)

---

## 🤝 Recursos

- **[GitHub Issues](https://github.com/yourusername/assistente-pessoal-ia/issues)**
- **[Discussions](https://github.com/yourusername/assistente-pessoal-ia/discussions)**
- **[Contributing Guide](../../CONTRIBUTING.md)** (criar)

---

**Happy Coding! 🤖**

Para qualquer dúvida, abra uma issue ou discussão no GitHub.
