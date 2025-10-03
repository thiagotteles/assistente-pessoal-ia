# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2] - 2025-10-03

### Fixed
- **CRÍTICO**: Estrutura de diretórios agora segue padrão Claude Code
  - Agentes instalados em `.claude/commands/{agentId}/` (antes: `.claude/`)
  - Arquivo principal: `.claude/commands/{agentId}/{agentId}.md`
  - Tasks: `.claude/commands/{agentId}/tasks/*.md`
  - Compatível com slash commands do Claude Code (/organizador, /secretaria)

### Changed
- Comando `list` atualizado para ler de `.claude/commands/`
- Comando `add` atualizado para instalar em `.claude/commands/`
- Comando `remove` atualizado para remover de `.claude/commands/`

## [1.0.1] - 2025-10-03

### Fixed
- **CRÍTICO**: Agentes agora instalados em `.claude/` para suporte a slash commands
  - Antes: `.assistant/agents/` (não funcionava com Claude Code)
  - Depois: `.claude/` (slash commands funcionando)

### Removed
- Removida pergunta sobre backup Git durante instalação
  - Usuário é responsável por configurar seu próprio backup

### Changed
- Documentação atualizada para refletir nova estrutura
- Mensagens de instalação simplificadas

## [1.0.0] - 2025-10-03

### Added
- 🎉 **Primeira release do Assistente Pessoal IA como pacote NPM**
- Instalação via `npx assistente-pessoal-ia@latest install`
- CLI interativo para gerenciar agentes:
  - `list` - Listar agentes instalados
  - `available` - Ver agentes disponíveis
  - `add` - Adicionar novo agente
  - `remove` - Remover agente
  - `info` - Ver informações de um agente
- 5 agentes disponíveis:
  - 📋 **Sofia** (Organizador) - essencial
  - 📊 **Secretária** - produtividade
  - 🏗️ **Marcus** (Arquiteto) - desenvolvimento
  - 🧠 **Dr. Silva** (Psicólogo) - bem-estar
  - 📚 **Carlos** (Mentor) - carreira
- Sistema de registro de agentes (`src/agents/agents.json`)
- Templates para contribuição da comunidade
- Workflow completo para aceitar agentes da comunidade:
  - `.github/PULL_REQUEST_TEMPLATE/agent.md`
  - `.github/workflows/validate-agents.yml`
  - `CONTRIBUTING-AGENTS.md`
- Documentação completa:
  - `README.md` com badges e links
  - `QUICK-START.md` - Guia de 5 minutos
  - `docs/user-guide/` - Documentação completa
- Licença MIT

### Changed
- Migração de instalação local (git clone) para NPM package
- Sistema de agentes migrado para `src/agents/`
- Templates movidos para `templates/`
- Estrutura de pastas otimizada para publicação NPM

### Deprecated
- Script `setup.sh` (substituído por `npx assistente-pessoal-ia install`)

## [Pre-release] - 2025-09-29

### Epic 5 - Transformação em Pacote NPM
- Story 5.1: Migração de agentes para `src/agents/`
- Story 5.2: Sistema de templates
- Story 5.3: Testes E2E
- Story 5.4: CLI interativo
- Story 5.5: Workflow de contribuição
- Story 5.6: Documentação
- Story 5.7: Preparação para NPM
- Story 5.8: Deprecação de setup.sh

---

## Links

- [NPM Package](https://www.npmjs.com/package/assistente-pessoal-ia)
- [GitHub Repository](https://github.com/thiagotteles/assistente-pessoal-ia)
- [Issues](https://github.com/thiagotteles/assistente-pessoal-ia/issues)
