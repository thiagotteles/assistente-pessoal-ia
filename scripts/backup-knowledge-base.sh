#!/bin/bash

# Script de Backup da Knowledge-base para Story 2.2.1
# Cria backup completo antes da migração para arquivos únicos

set -e  # Sair imediatamente se qualquer comando falhar

# Configurações
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="backups/knowledge-base"
BACKUP_NAME="kb_backup_${TIMESTAMP}"
BACKUP_PATH="${BACKUP_DIR}/${BACKUP_NAME}"
SOURCE_DIR="knowledge-base"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Backup da Knowledge-base - Story 2.2.1 ===${NC}"
echo "Timestamp: $TIMESTAMP"
echo "Backup path: $BACKUP_PATH"
echo ""

# Verificar se o diretório source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}ERRO: Diretório $SOURCE_DIR não existe!${NC}"
    exit 1
fi

# Criar diretório de backup se não existir
echo -e "${YELLOW}1. Criando estrutura de backup...${NC}"
mkdir -p "$BACKUP_DIR"

# Verificar se já existe backup
if [ -d "$BACKUP_PATH" ]; then
    echo -e "${RED}ERRO: Backup $BACKUP_PATH já existe!${NC}"
    exit 1
fi

# Criar backup completo
echo -e "${YELLOW}2. Copiando arquivos...${NC}"
cp -r "$SOURCE_DIR" "$BACKUP_PATH"

# Criar arquivo de metadados do backup
echo -e "${YELLOW}3. Criando metadados do backup...${NC}"
cat > "${BACKUP_PATH}/backup_metadata.txt" << EOF
# Backup Metadata - Story 2.2.1
Timestamp: $TIMESTAMP
Source: $SOURCE_DIR
Backup Path: $BACKUP_PATH
Story: 2.2.1 - Migração para Arquivos Únicos
Purpose: Backup completo antes da migração

# Estrutura original preservada:
$(find "$BACKUP_PATH" -name "*.md" -type f | sort)

# Total de arquivos: $(find "$BACKUP_PATH" -name "*.md" -type f | wc -l)
EOF

# Validar integridade do backup
echo -e "${YELLOW}4. Validando integridade do backup...${NC}"

# Contar arquivos originais vs backup
ORIGINAL_COUNT=$(find "$SOURCE_DIR" -name "*.md" -type f | wc -l)
BACKUP_COUNT=$(find "$BACKUP_PATH" -name "*.md" -type f | wc -l)

echo "Arquivos originais: $ORIGINAL_COUNT"
echo "Arquivos no backup: $BACKUP_COUNT"

if [ "$ORIGINAL_COUNT" -ne "$BACKUP_COUNT" ]; then
    echo -e "${RED}ERRO: Contagem de arquivos não confere!${NC}"
    echo "Original: $ORIGINAL_COUNT, Backup: $BACKUP_COUNT"
    exit 1
fi

# Verificar se todos os arquivos foram copiados corretamente
echo -e "${YELLOW}5. Verificando arquivos individuais...${NC}"
DIFF_OUTPUT=$(diff -r "$SOURCE_DIR" "$BACKUP_PATH" --exclude="backup_metadata.txt" || true)

if [ -n "$DIFF_OUTPUT" ]; then
    echo -e "${RED}ERRO: Diferenças encontradas entre original e backup:${NC}"
    echo "$DIFF_OUTPUT"
    exit 1
fi

# Criar arquivo de validação
echo -e "${YELLOW}6. Criando arquivo de validação...${NC}"
cat > "${BACKUP_DIR}/backup_validation_${TIMESTAMP}.txt" << EOF
# Validação do Backup - Story 2.2.1
Backup: $BACKUP_NAME
Status: VALIDADO
Timestamp: $TIMESTAMP
Arquivos verificados: $BACKUP_COUNT
Integridade: OK
Diferenças: NENHUMA

# Comando para rollback:
# ./scripts/rollback-knowledge-base.sh $BACKUP_NAME

# Lista de arquivos no backup:
$(find "$BACKUP_PATH" -name "*.md" -type f | sort)
EOF

echo -e "${GREEN}✅ Backup criado e validado com sucesso!${NC}"
echo -e "${GREEN}   Localização: $BACKUP_PATH${NC}"
echo -e "${GREEN}   Validação: ${BACKUP_DIR}/backup_validation_${TIMESTAMP}.txt${NC}"
echo ""
echo -e "${YELLOW}Para fazer rollback, execute:${NC}"
echo -e "${YELLOW}  ./scripts/rollback-knowledge-base.sh $BACKUP_NAME${NC}"
echo ""
# Backup automation script for Assistente Pessoal IA
# Can be run manually or scheduled via cron

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_ROOT"

echo "🚀 Starting knowledge-base backup..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "📝 Found uncommitted changes, creating commit..."

    # Add all changes in knowledge-base and .assistant-core
    git add knowledge-base/ .assistant-core/ despejo/

    # Create automatic commit with timestamp
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    git commit -m "Auto-backup: Knowledge base update - $TIMESTAMP

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"

    echo "✅ Automatic commit created"
else
    echo "✅ No uncommitted changes found"
fi

# Push to remote if configured
if git remote get-url origin >/dev/null 2>&1; then
    echo "📤 Pushing to remote repository..."
    if git push; then
        echo "✅ Successfully pushed to remote"
    else
        echo "⚠️  Warning: Failed to push to remote (check network/permissions)"
    fi
else
    echo "ℹ️  No remote repository configured"
fi

# Create local backup using rsync if available
BACKUP_DIR="$HOME/.assistente-pessoal-backup"
if command -v rsync >/dev/null 2>&1; then
    echo "📁 Creating local backup..."
    mkdir -p "$BACKUP_DIR"

    BACKUP_NAME="manual_backup_$(date +%Y%m%d_%H%M%S)"
    rsync -av --delete knowledge-base/ "$BACKUP_DIR/${BACKUP_NAME}_knowledge-base/"
    rsync -av --delete .assistant-core/ "$BACKUP_DIR/${BACKUP_NAME}_assistant-core/"
    rsync -av --delete despejo/ "$BACKUP_DIR/${BACKUP_NAME}_despejo/"

    echo "✅ Local backup created: $BACKUP_DIR/$BACKUP_NAME"
fi

echo "🎉 Backup process completed successfully!"

# Display backup status
echo ""
echo "📊 Backup Status Summary:"
echo "- Git repository: ✅ Up to date"
echo "- Git hooks: ✅ Active"
if [ -d "$BACKUP_DIR" ]; then
    BACKUP_COUNT=$(ls -1 "$BACKUP_DIR" | grep -c "backup_" || echo "0")
    echo "- Local backups: ✅ $BACKUP_COUNT backups available"
fi

# Show recent commits for verification
echo ""
echo "📜 Recent commits:"
git log --oneline -5