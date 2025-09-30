#!/bin/bash

# Deploy Script para Assistente Pessoal IA
# Este script instala apenas os arquivos essenciais do assistente em uma nova localização

set -e

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Função para logging
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Verificar se o diretório de destino foi fornecido
if [ -z "$1" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Deploy Script para Assistente Pessoal IA"
    echo ""
    echo "Uso: $0 <diretório_destino>"
    echo "Exemplo: $0 /home/user/meu-assistente"
    echo "Exemplo: $0 ~/assistente"
    echo ""
    echo "Este script copia apenas os arquivos essenciais para o assistente funcionar."
    exit 1
fi

DEST_DIR="$1"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

log "Iniciando deploy do Assistente Pessoal IA"
log "Origem: $SOURCE_DIR"
log "Destino: $DEST_DIR"

# Criar diretório de destino se não existir
if [ ! -d "$DEST_DIR" ]; then
    log "Criando diretório de destino: $DEST_DIR"
    mkdir -p "$DEST_DIR"
fi

# Verificar se o diretório de destino está vazio ou perguntar se deve sobrescrever
if [ "$(ls -A "$DEST_DIR" 2>/dev/null)" ]; then
    warn "O diretório de destino não está vazio."
    read -p "Deseja continuar e sobrescrever arquivos existentes? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log "Deploy cancelado pelo usuário."
        exit 0
    fi
fi

# Lista de arquivos e pastas ESSENCIAIS para o assistente funcionar
log "Copiando arquivos essenciais..."

# 1. Configuração do Claude Code (.claude)
if [ -d "$SOURCE_DIR/.claude" ]; then
    log "Copiando configurações do Claude Code..."
    cp -r "$SOURCE_DIR/.claude" "$DEST_DIR/"
    success "✓ Configurações do Claude Code copiadas"
else
    error "Pasta .claude não encontrada! O assistente pode não funcionar corretamente."
fi

# 2. Core do Assistant (.assistant-core)
if [ -d "$SOURCE_DIR/.assistant-core" ]; then
    log "Copiando core do assistant..."
    cp -r "$SOURCE_DIR/.assistant-core" "$DEST_DIR/"
    success "✓ Assistant core copiado"

    # Instalar agentes no Claude Code
    log "Instalando agentes no Claude Code..."
    mkdir -p "$DEST_DIR/.claude/commands/assistentes/agents"
    mkdir -p "$DEST_DIR/.claude/commands/assistentes/tasks"

    # Instalar agentes
    if [ -f "$SOURCE_DIR/.assistant-core/agents/organizador.md" ]; then
        cp "$SOURCE_DIR/.assistant-core/agents/organizador.md" "$DEST_DIR/.claude/commands/assistentes/agents/"
    fi
    if [ -f "$SOURCE_DIR/.assistant-core/agents/secretaria.md" ]; then
        cp "$SOURCE_DIR/.assistant-core/agents/secretaria.md" "$DEST_DIR/.claude/commands/assistentes/agents/"
    fi
    if [ -f "$SOURCE_DIR/.assistant-core/agents/arquiteto.md" ]; then
        cp "$SOURCE_DIR/.assistant-core/agents/arquiteto.md" "$DEST_DIR/.claude/commands/assistentes/agents/"
        success "✓ Agente Arquiteto encontrado e instalado"
    else
        warn "⚠ Agente Arquiteto não encontrado"
    fi

    # Instalar tasks dos agentes
    for task in organizar-por-projeto processar-despejo revisar-pendencias agenda-do-dia status-projetos registro-reuniao whats-next processar-calendario relatorio-executivo consultoria-tecnica analise-projeto confronto-tecnico registrar-decisao historico-decisoes; do
        if [ -f "$SOURCE_DIR/.assistant-core/tasks/${task}.md" ]; then
            cp "$SOURCE_DIR/.assistant-core/tasks/${task}.md" "$DEST_DIR/.claude/commands/assistentes/tasks/"
        fi
    done

    success "✓ Agentes e tasks instalados no Claude Code"
else
    warn "Pasta .assistant-core não encontrada. Criando estrutura básica..."
    mkdir -p "$DEST_DIR/.assistant-core"
fi

# 3. Knowledge Base
if [ -d "$SOURCE_DIR/knowledge-base" ]; then
    log "Copiando knowledge base..."
    cp -r "$SOURCE_DIR/knowledge-base" "$DEST_DIR/"
    success "✓ Knowledge base copiada"
else
    log "Criando estrutura básica da knowledge base..."
    mkdir -p "$DEST_DIR/knowledge-base/"{contextos,pessoas,projetos,decisoes}
fi

# 4. Todos
if [ -d "$SOURCE_DIR/todos" ]; then
    log "Copiando sistema de todos..."
    cp -r "$SOURCE_DIR/todos" "$DEST_DIR/"
    success "✓ Sistema de todos copiado"
else
    log "Criando estrutura básica de todos..."
    mkdir -p "$DEST_DIR/todos"
    cat > "$DEST_DIR/todos/central-todos.md" << 'EOF'
# Central de Todos

## Visão Geral
Este arquivo centraliza todos os todos extraídos automaticamente do daily-dump.txt e outros agentes do sistema.

## Todos Ativos

### Alta Prioridade
<!-- Todos de alta prioridade aparecerão aqui automaticamente -->

### Média Prioridade
<!-- Todos de média prioridade aparecerão aqui automaticamente -->

### Baixa Prioridade
<!-- Todos de baixa prioridade aparecerão aqui automaticamente -->

---
*Arquivo gerado e mantido automaticamente pelo Agente Organizador*
EOF
fi

# 5. Despejo (daily dump)
if [ -d "$SOURCE_DIR/despejo" ]; then
    log "Copiando sistema de despejo..."
    cp -r "$SOURCE_DIR/despejo" "$DEST_DIR/"
    success "✓ Sistema de despejo copiado"
else
    log "Criando estrutura básica de despejo..."
    mkdir -p "$DEST_DIR/despejo"
    touch "$DEST_DIR/despejo/daily-dump.txt"
fi

# 6. Diário
if [ -d "$SOURCE_DIR/diario" ]; then
    log "Copiando diário..."
    cp -r "$SOURCE_DIR/diario" "$DEST_DIR/"
    success "✓ Diário copiado"
else
    log "Criando estrutura básica do diário..."
    mkdir -p "$DEST_DIR/diario"
fi

# 7. Scripts essenciais (apenas os que o usuário precisa)
log "Copiando scripts essenciais..."
mkdir -p "$DEST_DIR/scripts"

# Copiar apenas scripts essenciais para o usuário final
if [ -f "$SOURCE_DIR/scripts/backup-knowledge-base.sh" ]; then
    cp "$SOURCE_DIR/scripts/backup-knowledge-base.sh" "$DEST_DIR/scripts/"
fi

# Copiar este script para facilitar futuras instalações
cp "$SOURCE_DIR/scripts/deploy-assistant.sh" "$DEST_DIR/scripts/"
success "✓ Scripts essenciais copiados"

# 8. Arquivos de configuração na raiz
log "Copiando arquivos de configuração..."

# README personalizado para a instalação
cat > "$DEST_DIR/README.md" << 'EOF'
# Assistente Pessoal IA - Instalação Limpa

Este é seu assistente pessoal IA pronto para uso!

## Estrutura dos Arquivos

- `.claude/` - Configurações do Claude Code (ESSENCIAL)
- `.assistant-core/` - Core dos agentes e memória
- `knowledge-base/` - Sua base de conhecimento pessoal
- `todos/` - Sistema de gerenciamento de tarefas
- `despejo/` - Para dumps mentais rápidos
- `diario/` - Seu diário pessoal
- `scripts/` - Scripts úteis

## Como Usar

1. Abra o Claude Code neste diretório
2. Use `/assistentes:agents:organizador` para começar
3. Adicione informações em `despejo/daily-dump.txt`
4. Deixe o assistente organizar tudo para você!

## Backup

Execute `./scripts/backup-knowledge-base.sh` regularmente para fazer backup dos seus dados.
EOF

# .gitignore personalizado
cat > "$DEST_DIR/.gitignore" << 'EOF'
# Arquivos temporários
temp/
*.tmp
*.log

# Backups automáticos
backups/
*.backup

# Cache
cache/
.cache/

# Logs
logs/
*.log

# Arquivos de sistema
.DS_Store
Thumbs.db

# Arquivos sensíveis (se houver)
.env
*.key
EOF

success "✓ Arquivos de configuração criados"

# 9. Criar estrutura de cache e logs (vazias)
mkdir -p "$DEST_DIR/cache"
mkdir -p "$DEST_DIR/logs"

log "Finalizando instalação..."

# Verificar se tudo foi copiado corretamente
ESSENTIAL_DIRS=(".claude" ".assistant-core" "knowledge-base" "todos" "despejo")
MISSING_DIRS=()

for dir in "${ESSENTIAL_DIRS[@]}"; do
    if [ ! -d "$DEST_DIR/$dir" ]; then
        MISSING_DIRS+=("$dir")
    fi
done

if [ ${#MISSING_DIRS[@]} -eq 0 ]; then
    success "🎉 Deploy concluído com sucesso!"
    echo
    log "Seu assistente está pronto em: $DEST_DIR"
    log "Para começar, navegue até o diretório e abra o Claude Code:"
    echo "  cd \"$DEST_DIR\""
    echo "  # Abra o Claude Code aqui"
    echo
    log "Agentes disponíveis:"
    log "  - Organizador: /assistentes:agents:organizador"
    log "  - Secretária Executiva: /assistentes:agents:secretaria"
else
    error "Deploy incompleto! Diretórios não encontrados: ${MISSING_DIRS[*]}"
    exit 1
fi

echo
log "=== RESUMO DA INSTALAÇÃO ==="
log "✓ Configurações do Claude Code"
log "✓ Core do assistente (Organizador + Secretária)"
log "✓ Base de conhecimento"
log "✓ Sistema de todos"
log "✓ Sistema de despejo"
log "✓ Diário pessoal"
log "✓ Scripts essenciais"
log "✓ Documentação personalizada"
echo
success "Instalação completa! 🚀"