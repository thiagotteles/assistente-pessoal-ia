# Estrutura de Arquivos (Source Tree)

```
assistente-pessoal-ia/
├── .assistant-core/                 # Core do assistente pessoal
│   ├── agents/                      # Configurações dos 5 agentes especializados
│   │   ├── organizador.yaml         # Config do /organizador
│   │   ├── secretaria.yaml          # Config do /secretaria
│   │   ├── arquiteto.yaml           # Config do /arquiteto
│   │   ├── psicologo.yaml           # Config do /psicologo
│   │   └── mentor.yaml              # Config do /mentor
│   ├── templates/                   # Templates para documentos
│   │   ├── reuniao-resumo.yaml      # Template para registro de reuniões
│   │   ├── projeto-analise.yaml     # Template para análise de projetos
│   │   ├── pessoa-profile.yaml      # Template para páginas de pessoas
│   │   └── decisao-tecnica.yaml     # Template para decisões arquiteturais
│   ├── tasks/                       # Workflows de automação
│   │   ├── processar-despejo.md     # Workflow do organizador
│   │   ├── extrair-todos.md         # Workflow da secretaria
│   │   └── criar-referencias.md     # Workflow para gerar [[]] links
│   ├── data/                        # Dados de configuração
│   │   └── elicitation-methods.md   # Métodos de elicitação 1-9
│   ├── memory/                      # Memória dos 5 agentes
│   │   ├── organizador-memory.yaml  # Contexto e personalidade
│   │   ├── secretaria-memory.yaml   # Histórico de interações
│   │   ├── arquiteto-memory.yaml    # Padrões técnicos aprendidos
│   │   ├── psicologo-memory.yaml    # Padrões emocionais e TDAH
│   │   └── mentor-memory.yaml       # Objetivos de carreira e crescimento
│   └── core-config.yaml             # Configuração central
│
├── despejo/                         # Captura ultra-rápida
│   ├── daily-dump.txt               # Arquivo principal de despejo
│   └── processed/                   # Histórico de despejos processados
│       ├── 2025-01-09-processed.txt
│       └── 2025-01-08-processed.txt
│
├── knowledge-base/                  # "Segundo cérebro" compartilhado (Obsidian Vault)
│   ├── decisoes/                    # Decisões técnicas e pessoais
│   │   ├── bounded-context-duvida.md          # [[Bounded Context]]
│   │   ├── arquitetura-monolitica-alpha.md   # [[Projeto Alpha]]
│   │   └── cache-redis-implementacao.md      # [[Cache Redis]]
│   ├── contextos/                   # Contextos temáticos - ARQUIVOS ÚNICOS POR TEMA
│   │   ├── contexto-bem-estar.md             # [[Bem-estar]] - Todas as entradas de bem-estar
│   │   ├── contexto-reunioes.md              # [[Reuniões]] - Histórico de reuniões
│   │   └── contexto-brainstorm.md            # [[Brainstorm]] - Sessões de ideação
│   ├── projetos/                    # Informações por projeto - ARQUIVOS ÚNICOS POR PROJETO
│   │   ├── projeto-onboarding.md             # [[Onboarding]] - Todo histórico do projeto
│   │   ├── projeto-sistema-alpha.md          # [[Sistema Alpha]] - Consolidado
│   │   └── projeto-assistente-ia.md          # [[Assistente IA]] - Este projeto
│   └── pessoas/                     # Perfis de pessoas - ARQUIVOS ÚNICOS POR PESSOA
│       ├── pessoa-fabio.md                   # [[Fabio]] - Todo histórico da pessoa
│       ├── pessoa-joao-silva.md              # [[João Silva]] - Consolidado
│       └── pessoa-maria-santos.md            # [[Maria Santos]] - Consolidado
│
├── todos/                           # Central de tarefas
│   ├── central-todos.md             # Lista principal de todos
│   ├── por-projeto/                 # Todos agrupados por projeto
│   │   ├── projeto-alpha-todos.md   # [[Projeto Alpha]]
│   │   └── sistema-beta-todos.md    # [[Sistema Beta]]
│   └── por-pessoa/                  # Todos delegados
│       ├── fabio-h-todos.md         # [[Fabio H]]
│       └── maria-santos-todos.md    # [[Maria Santos]]
│
├── diario/                          # Diários estruturados por data
│   ├── 2025-01-09-diario.md         # Reflexões do dia
│   ├── 2025-01-08-diario.md         # Histórico de diários
│   └── templates/                   # Templates para diferentes tipos
│       ├── diario-trabalho.md       # Template para dias de trabalho
│       └── diario-pessoal.md        # Template para reflexões pessoais
│
├── docs/                            # Documentação do projeto
│   ├── prd.md                       # Product Requirements Document
│   ├── front-end-spec.md            # Especificação UX/UI
│   ├── architecture.md              # Este documento
│   └── usage-guide.md               # Guia de uso do sistema
│
├── scripts/                         # Scripts de automação (futuros)
│   ├── backup-knowledge-base.sh     # Backup automatizado via Git
│   └── generate-stats.py            # Estatísticas de uso
│
├── .gitignore                       # Exclusões do Git
├── README.md                        # Instruções básicas de uso
└── CHANGELOG.md                     # Histórico de mudanças do sistema
```

## 📋 Padrões de Arquivos Únicos (Story 2.2.1)

A partir da Story 2.2.1, a knowledge-base foi migrada para **arquivos únicos por entidade**:

### 🔧 Padrões de Nomeação

#### Pessoas
- **Formato**: `pessoa-{nome}.md`
- **Exemplos**: `pessoa-fabio.md`, `pessoa-joao-silva.md`
- **Consolidação**: Todas as menções de uma pessoa em um único arquivo

#### Projetos
- **Formato**: `projeto-{nome}.md`
- **Exemplos**: `projeto-onboarding.md`, `projeto-sistema-alpha.md`
- **Consolidação**: Todo histórico do projeto em um único arquivo

#### Contextos
- **Formato**: `contexto-{tema}.md`
- **Exemplos**: `contexto-bem-estar.md`, `contexto-reunioes.md`
- **Consolidação**: Todas as entradas do tema em um único arquivo

### 📁 Estrutura Interna dos Arquivos Únicos

#### Pessoa (pessoa-{nome}.md)
```markdown
# {Nome} - Pessoa

## Metadados
```yaml
tipo: pessoa
nome: {Nome}
tags: [pessoa, ...]
created: YYYY-MM-DD
updated: YYYY-MM-DD
arquivos_origem: [lista-arquivos-originais]
```

## Histórico de Interações
### YYYY-MM-DD - Título da Interação
[Conteúdo da interação]

## Projetos Relacionados
- [[projeto-nome]]

## Notas e Contexto
[Informações consolidadas]
```

#### Projeto (projeto-{nome}.md)
```markdown
# {Nome} - Projeto

## Metadados
```yaml
tipo: projeto
nome: {Nome}
tags: [projeto, ...]
created: YYYY-MM-DD
updated: YYYY-MM-DD
```

## Status e Progresso
[Status atual]

## Histórico de Desenvolvimento
### YYYY-MM-DD - Marco/Evento
[Conteúdo do evento]

## Pessoas Envolvidas
- [[pessoa-nome]]

## Decisões Técnicas
[Decisões importantes]
```

#### Contexto (contexto-{tema}.md)
```markdown
# {Tema} - Contexto

## Metadados
```yaml
tipo: contexto
nome: {Tema}
tags: [contexto, ...]
created: YYYY-MM-DD
updated: YYYY-MM-DD
```

## Entradas
### YYYY-MM-DD - Título da Entrada
[Conteúdo da entrada]

## Padrões Identificados
[Padrões observados]

## Notas e Reflexões
[Insights]
```

### 🎯 Benefícios dos Arquivos Únicos

1. **Contexto Consolidado**: Todo histórico de uma entidade em um lugar
2. **Navegação Simplificada**: Estrutura previsível e consistente
3. **Referências [[]] Otimizadas**: Links funcionam perfeitamente no Obsidian
4. **TDAH-Friendly**: Reduz sobrecarga cognitiva de múltiplos arquivos
5. **Performance**: Menos arquivos para gerenciar e indexar

### 🔄 Migração e Backup

- **Scripts**: `scripts/migrate-to-unified-files.sh`
- **Backup**: `scripts/backup-knowledge-base.sh`
- **Rollback**: `scripts/rollback-knowledge-base.sh`
- **Validação**: `scripts/validate-migration.sh`
