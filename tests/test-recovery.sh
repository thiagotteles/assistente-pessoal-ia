#!/bin/bash

# Assistente Pessoal IA - Script de Recuperação de Testes
# Framework de Testes Essenciais - História 0.4
# Versão 1.0

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE} Script de Recuperação de Testes${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

# Recovery functions
recover_directory_structure() {
    print_info "Recuperação 1: Criando estrutura de diretórios ausentes"

    local required_dirs=(
        ".assistant-core"
        ".assistant-core/agents"
        ".assistant-core/templates"
        ".assistant-core/tasks"
        ".assistant-core/data"
        ".assistant-core/memory"
        ".assistant-core/logs"
        "despejo"
        "despejo/processed"
        "knowledge-base"
        "knowledge-base/decisoes"
        "knowledge-base/contextos"
        "knowledge-base/projetos"
        "knowledge-base/pessoas"
        "knowledge-base/.obsidian"
        "knowledge-base/.backups"
        "todos"
        "todos/por-projeto"
        "todos/por-pessoa"
        "diario"
        "diario/templates"
        "scripts"
    )

    for dir in "${required_dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            print_success "Criado: $dir"
        fi
    done

    print_success "Estrutura de diretórios verificada e corrigida"
}

recover_base_files() {
    print_info "Recuperação 2: Criando arquivos base ausentes"

    # Create daily-dump.md if missing
    if [ ! -f "despejo/daily-dump.md" ]; then
        cat > "despejo/daily-dump.md" << 'EOF'
# Daily Dump - Captura Ultra-Rápida

**Data:** $(date +%Y-%m-%d)
**Status:** Pronto para uso

## Despejo de hoje
Digite aqui tudo que está na sua mente...

---
*Processado pelo /organizador*
EOF
        print_success "Criado: despejo/daily-dump.md"
    fi

    # Create .gitignore if missing
    if [ ! -f ".gitignore" ]; then
        cat > ".gitignore" << 'EOF'
# Logs
*.log
logs/

# Temporary files
*.tmp
*.temp
temp/

# OS files
.DS_Store
Thumbs.db

# IDE files
.vscode/
.idea/

# Python
__pycache__/
*.pyc
*.pyo

# Backup files
*.bak
*~
EOF
        print_success "Criado: .gitignore"
    fi

    # Create basic README.md if missing
    if [ ! -f "README.md" ]; then
        cat > "README.md" << 'EOF'
# Assistente Pessoal IA

Sistema de assistente pessoal com 5 agentes especializados para pessoas com TDAH.

## Quick Start

1. Execute o setup: `bash setup.sh` (Linux/Mac) ou `setup.bat` (Windows)
2. Execute os testes: `bash test-basic.sh`
3. Abra `knowledge-base/` no Obsidian
4. Use `despejo/daily-dump.md` para captura rápida

## Agentes Disponíveis

- `/organizador` - Organizador Pessoal
- `/secretaria` - Assistente Executiva
- `/arquiteto` - Arquiteto de Soluções
- `/psicologo` - Psicólogo de Suporte TDAH
- `/mentor` - Mentor de Carreira

## Testes

Execute `bash test-basic.sh` para validar a instalação.
Execute `bash test-recovery.sh` para recuperar arquivos ausentes.
EOF
        print_success "Criado: README.md"
    fi

    print_success "Arquivos base verificados e corrigidos"
}

recover_obsidian_config() {
    print_info "Recuperação 3: Configuração do Obsidian"

    # Create basic Obsidian configuration
    if [ ! -f "knowledge-base/.obsidian/app.json" ]; then
        mkdir -p "knowledge-base/.obsidian"
        cat > "knowledge-base/.obsidian/app.json" << 'EOF'
{
  "legacyEditor": false,
  "livePreview": true,
  "defaultViewMode": "preview",
  "showLineNumber": true,
  "spellcheck": true,
  "spellcheckLanguages": [
    "pt-BR",
    "en-US"
  ]
}
EOF
        print_success "Criado: knowledge-base/.obsidian/app.json"
    fi

    if [ ! -f "knowledge-base/.obsidian/graph.json" ]; then
        cat > "knowledge-base/.obsidian/graph.json" << 'EOF'
{
  "collapse-filter": false,
  "search": "",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": false,
  "showOrphans": true,
  "collapse-color-groups": false,
  "colorGroups": [
    {
      "query": "path:pessoas",
      "color": {
        "a": 1,
        "rgb": 5431473
      }
    },
    {
      "query": "path:projetos",
      "color": {
        "a": 1,
        "rgb": 5419488
      }
    },
    {
      "query": "path:decisoes",
      "color": {
        "a": 1,
        "rgb": 11621088
      }
    }
  ],
  "collapse-display": false,
  "showArrow": true,
  "textFadeMultiplier": -0.2,
  "nodeSizeMultiplier": 1.2,
  "lineSizeMultiplier": 1,
  "collapse-forces": false,
  "centerStrength": 0.3,
  "repelStrength": 8,
  "linkStrength": 0.7,
  "linkDistance": 200,
  "scale": 0.8
}
EOF
        print_success "Criado: knowledge-base/.obsidian/graph.json"
    fi

    if [ ! -f "knowledge-base/.obsidian/hotkeys.json" ]; then
        cat > "knowledge-base/.obsidian/hotkeys.json" << 'EOF'
{
  "app:go-back": [
    {
      "modifiers": [
        "Alt"
      ],
      "key": "ArrowLeft"
    }
  ],
  "app:go-forward": [
    {
      "modifiers": [
        "Alt"
      ],
      "key": "ArrowRight"
    }
  ]
}
EOF
        print_success "Criado: knowledge-base/.obsidian/hotkeys.json"
    fi

    print_success "Configuração do Obsidian verificada e corrigida"
}

recover_python_modules() {
    print_info "Recuperação 4: Verificando módulos Python"

    local modules_missing=false

    if [ ! -f ".assistant-core/knowledge_base_manager.py" ]; then
        print_error "CRÍTICO: knowledge_base_manager.py ausente (História 0.2 não implementada)"
        modules_missing=true
    fi

    if [ ! -f ".assistant-core/agent_memory_system.py" ]; then
        print_error "CRÍTICO: agent_memory_system.py ausente (História 0.3 não implementada)"
        modules_missing=true
    fi

    if [ "$modules_missing" = true ]; then
        print_warning "Módulos Python críticos ausentes - execute as histórias 0.2 e 0.3 primeiro"
        return 1
    else
        print_success "Módulos Python principais verificados"
    fi
}

create_sample_content() {
    print_info "Recuperação 5: Criando conteúdo de exemplo"

    # Create sample person file
    if [ ! -f "knowledge-base/pessoas/exemplo-pessoa.md" ]; then
        cat > "knowledge-base/pessoas/exemplo-pessoa.md" << 'EOF'
---
id: exemplo-pessoa
type: pessoa
created: 2025-01-09T10:00:00
updated: 2025-01-09T10:00:00
tags: [exemplo, pessoa]
---

# Exemplo Pessoa

Arquivo de exemplo para demonstrar estrutura de pessoa.

## Informações Básicas

- **Nome:** Exemplo Pessoa
- **Função:** Demonstração
- **Projeto:** [[Assistente Pessoal IA]]

## Notas

Este é um arquivo de exemplo que pode ser removido após confirmar que o sistema está funcionando.
EOF
        print_success "Criado: knowledge-base/pessoas/exemplo-pessoa.md"
    fi

    # Create sample project file
    if [ ! -f "knowledge-base/projetos/assistente-pessoal-ia.md" ]; then
        cat > "knowledge-base/projetos/assistente-pessoal-ia.md" << 'EOF'
---
id: assistente-pessoal-ia
type: projeto
created: 2025-01-09T10:00:00
updated: 2025-01-09T10:00:00
tags: [projeto, ia, tdah, assistente]
---

# Assistente Pessoal IA

Sistema de assistente pessoal com 5 agentes especializados.

## Visão Geral

Este projeto implementa um assistente pessoal IA com foco em pessoas com TDAH, utilizando:

- **5 Agentes Especializados**: Organizador, Secretária, Arquiteto, Psicólogo, Mentor
- **Knowledge Base**: Sistema de persistência com referências [[]]
- **Agent Memory**: Sistema de memória persistente para agentes
- **Obsidian Integration**: Vault configurado para máximo aproveitamento

## Status

- ✅ História 0.1: Environment Setup Foundation
- ✅ História 0.2: Knowledge-Base Manager Core
- ✅ História 0.3: Agent Memory System Foundation
- 🚧 História 0.4: Framework de Testes Essenciais
- 📋 História 0.5: Documentação Operacional Completa
EOF
        print_success "Criado: knowledge-base/projetos/assistente-pessoal-ia.md"
    fi

    print_success "Conteúdo de exemplo criado"
}

# Main recovery function
run_recovery() {
    print_header

    print_info "Iniciando processo de recuperação..."
    echo

    local recovery_count=0
    local total_recoveries=5

    # Run recovery functions
    if recover_directory_structure; then
        ((recovery_count++))
    fi

    if recover_base_files; then
        ((recovery_count++))
    fi

    if recover_obsidian_config; then
        ((recovery_count++))
    fi

    if recover_python_modules; then
        ((recovery_count++))
    fi

    if create_sample_content; then
        ((recovery_count++))
    fi

    # Final result
    echo
    print_info "Resultado da Recuperação: $recovery_count/$total_recoveries processos concluídos"

    if [ $recovery_count -eq $total_recoveries ]; then
        print_success "🎉 RECUPERAÇÃO CONCLUÍDA COM SUCESSO!"
        print_success "Execute 'bash test-basic.sh' para validar as correções"
        return 0
    else
        print_warning "⚠️  RECUPERAÇÃO PARCIAL: $((total_recoveries - recovery_count)) processo(s) com problemas"
        print_info "Verifique as mensagens acima para detalhes"
        return 1
    fi
}

# Execute recovery
run_recovery