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
│   ├── contextos/                   # Contextos de reuniões e conversas
│   │   ├── reuniao-fabio-performance.md      # [[Fabio H]] + [[Projeto Alpha]]
│   │   ├── call-cliente-requirements.md      # [[Cliente XYZ]]
│   │   └── brainstorm-features-beta.md       # [[Sistema Beta]]
│   ├── projetos/                    # Informações por projeto
│   │   ├── projeto-alpha/           # [[Projeto Alpha]]
│   │   │   ├── overview.md          # Visão geral do projeto
│   │   │   ├── team.md              # [[Fabio H]], [[Maria Santos]]
│   │   │   ├── decisions.md         # Decisões específicas
│   │   │   └── timeline.md          # Histórico e próximos passos
│   │   └── sistema-beta/            # [[Sistema Beta]]
│   │       ├── overview.md
│   │       └── architecture.md
│   └── pessoas/                     # Perfis de pessoas
│       ├── fabio-h.md               # [[Fabio H]]
│       ├── maria-santos.md          # [[Maria Santos]]
│       └── joao-silva.md            # [[João Silva]]
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
