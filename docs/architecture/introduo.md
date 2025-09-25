# Introdução

Esta arquitetura define o sistema backend para o **Assistente Pessoal IA** - uma evolução do BMAD method para criar um "segundo cérebro" pessoal especializado para usuários com TDAH. O sistema mantém a simplicidade e eficácia do BMAD atual, mas adiciona inteligência para captura ultra-rápida, organização automática, e múltiplos agentes especializados.

## Starter Template ou Projeto Existente

**Projeto Base:** Conceitos BMAD + Estrutura `.assistant-core/` Especializada

**Estrutura Definitiva:**
```
assistente-pessoal-ia/
├── .assistant-core/             # Core do assistente pessoal
│   ├── agents/                  # Configurações dos 5 agentes especializados
│   │   ├── organizador.yaml
│   │   ├── secretaria.yaml
│   │   ├── arquiteto.yaml
│   │   ├── psicologo.yaml      # Fase 2
│   │   └── mentor.yaml         # Fase 2
│   ├── templates/               # Templates para diferentes tipos de documento
│   ├── tasks/                   # Workflows de automação inteligente
│   ├── data/                    # Configurações e métodos de elicitação
│   └── core-config.yaml         # Configuração central do sistema
├── despejo/
│   └── daily-dump.txt          # Captura ultra-rápida sem estrutura
├── knowledge-base/             # "Segundo cérebro" compartilhado
│   ├── decisoes/
│   ├── contextos/
│   ├── projetos/
│   └── pessoas/
├── todos/
│   └── central-todos.md
└── diario/                     # Diários estruturados por data
    ├── 2025-01-09-diario.md
    └── ...
```

**Vantagens da Estrutura `.assistant-core/`:**
- Nome claro e profissional que reflete o propósito
- Mantém padrões comprovados do BMAD (slash commands, YAML, workflows)
- Adiciona inteligência específica para TDAH e "segundo cérebro"
- Permite evolução independente sem limitações de framework externo

## Log de Mudanças

| Data | Versão | Descrição | Autor |
|------|---------|-----------|-------|
| 2025-01-09 | 1.0 | Arquitetura inicial baseada em evolução do BMAD | Winston (Architect) |
