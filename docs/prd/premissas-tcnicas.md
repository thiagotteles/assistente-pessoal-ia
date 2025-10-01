# Premissas Técnicas

## Estrutura do Repositório: Monorepo

Repositório único contendo:
- `.bmad-core/` para configurações de agentes
- `despejo/`, `knowledge-base/`, `todos/`, `diario/` como estrutura base
- Documentação e templates

## Arquitetura de Serviços

**DECISÃO CRÍTICA - Arquitetura Baseada em Slash Commands + Arquivos Locais**

Sistema composto por:
- **Claude Code** como plataforma de IA (subscription existente)
- **Slash Commands** como interface de agentes especializados
- **Arquivos locais** (Markdown/YAML/JSON) como persistência
- **Knowledge-base compartilhada** como camada inteligente central

## Requisitos de Testes

**DECISÃO CRÍTICA - Validação por Uso Real + Backup via Git**

Estratégia focada em:
- Uso diário como teste primário de funcionalidade
- Git para versionamento e recovery de dados
- Validação de personalidades através de interações reais

## Premissas e Solicitações Técnicas Adicionais

**Estrutura de Arquivos Completa:**
```
c:/repos/assistente-pessoal-ia/
├── .bmad-core/                    # Configurações dos Agentes
│   ├── agents/
│   │   ├── organizador.yaml       # Configuração do /organizador
│   │   ├── secretaria.yaml        # Configuração do /secretaria
│   │   └── arquiteto.yaml         # Configuração do /arquiteto
│   ├── templates/
│   └── core-config.yaml           # Config principal
├── despejo/
│   └── daily-dump.md             # Arquivo único para despejo rápido
├── knowledge-base/                # Base Inteligente Compartilhada
│   ├── decisoes/                  # Decisões técnicas e pessoais
│   ├── contextos/                 # Contextos de reuniões
│   ├── projetos/                  # Por projeto específico
│   └── pessoas/                   # Contexto sobre pessoas
├── todos/
│   └── central-todos.md           # Todos centralizados
└── diario/                        # Diários estruturados
    ├── 2025-09-25-diario.md
    └── ...
```

**Tecnologias:**
- **Claude Code** - Interface e processamento de IA
- **Markdown/YAML** - Armazenamento human-readable
- **Git** - Versionamento e backup
- **Sistema de arquivos local** - Persistência simples
