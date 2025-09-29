#!/bin/bash

# Script de Rollback da Knowledge-base para Story 2.2.1
# Restaura backup completo em caso de problemas na migração

set -e  # Sair imediatamente se qualquer comando falhar

# Configurações
BACKUP_DIR="backups/knowledge-base"
SOURCE_DIR="knowledge-base"
ROLLBACK_TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Verificar se foi fornecido o nome do backup
if [ $# -eq 0 ]; then
    echo -e "${RED}ERRO: Nome do backup não fornecido!${NC}"
    echo -e "${YELLOW}Uso: ./scripts/rollback-knowledge-base.sh <nome_do_backup>${NC}"
    echo ""
    echo -e "${YELLOW}Backups disponíveis:${NC}"
    ls -la "$BACKUP_DIR" 2>/dev/null || echo "Nenhum backup encontrado"
    exit 1
fi

BACKUP_NAME="$1"
BACKUP_PATH="${BACKUP_DIR}/${BACKUP_NAME}"

echo -e "${YELLOW}=== Rollback da Knowledge-base - Story 2.2.1 ===${NC}"
echo "Backup: $BACKUP_NAME"
echo "Rollback timestamp: $ROLLBACK_TIMESTAMP"
echo ""

# Verificar se o backup existe
if [ ! -d "$BACKUP_PATH" ]; then
    echo -e "${RED}ERRO: Backup $BACKUP_PATH não existe!${NC}"
    echo ""
    echo -e "${YELLOW}Backups disponíveis:${NC}"
    ls -la "$BACKUP_DIR" 2>/dev/null || echo "Nenhum backup encontrado"
    exit 1
fi

# Verificar se o backup tem metadados
if [ ! -f "${BACKUP_PATH}/backup_metadata.txt" ]; then
    echo -e "${RED}AVISO: Backup sem metadados - pode não ser íntegro${NC}"
    echo -e "${YELLOW}Continuar mesmo assim? (y/N):${NC}"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Rollback cancelado."
        exit 1
    fi
fi

# Mostrar informações do backup
echo -e "${YELLOW}1. Verificando informações do backup...${NC}"
if [ -f "${BACKUP_PATH}/backup_metadata.txt" ]; then
    echo "Metadados do backup:"
    head -10 "${BACKUP_PATH}/backup_metadata.txt"
    echo ""
fi

# Confirmar rollback
echo -e "${RED}ATENÇÃO: Esta operação irá SUBSTITUIR completamente a knowledge-base atual!${NC}"
echo -e "${YELLOW}Tem certeza que deseja continuar? (y/N):${NC}"
read -r confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Rollback cancelado."
    exit 1
fi

# Backup da situação atual antes do rollback (segurança)
if [ -d "$SOURCE_DIR" ]; then
    CURRENT_BACKUP="current_kb_before_rollback_${ROLLBACK_TIMESTAMP}"
    echo -e "${YELLOW}2. Fazendo backup da situação atual...${NC}"
    cp -r "$SOURCE_DIR" "${BACKUP_DIR}/${CURRENT_BACKUP}"
    echo "Backup atual criado em: ${BACKUP_DIR}/${CURRENT_BACKUP}"
fi

# Remover knowledge-base atual
echo -e "${YELLOW}3. Removendo knowledge-base atual...${NC}"
if [ -d "$SOURCE_DIR" ]; then
    rm -rf "$SOURCE_DIR"
fi

# Restaurar do backup
echo -e "${YELLOW}4. Restaurando do backup...${NC}"
cp -r "$BACKUP_PATH" "$SOURCE_DIR"

# Remover arquivo de metadados do backup restaurado
if [ -f "${SOURCE_DIR}/backup_metadata.txt" ]; then
    rm "${SOURCE_DIR}/backup_metadata.txt"
fi

# Validar restauração
echo -e "${YELLOW}5. Validando restauração...${NC}"
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}ERRO: Falha na restauração!${NC}"
    exit 1
fi

RESTORED_COUNT=$(find "$SOURCE_DIR" -name "*.md" -type f | wc -l)
echo "Arquivos restaurados: $RESTORED_COUNT"

# Criar log de rollback
echo -e "${YELLOW}6. Criando log de rollback...${NC}"
cat > "${BACKUP_DIR}/rollback_log_${ROLLBACK_TIMESTAMP}.txt" << EOF
# Rollback Log - Story 2.2.1
Rollback Timestamp: $ROLLBACK_TIMESTAMP
Backup Usado: $BACKUP_NAME
Backup Path: $BACKUP_PATH
Arquivos Restaurados: $RESTORED_COUNT
Status: SUCESSO

# Backup da situação anterior ao rollback:
# ${BACKUP_DIR}/${CURRENT_BACKUP}

# Estrutura restaurada:
$(find "$SOURCE_DIR" -name "*.md" -type f | sort)
EOF

echo -e "${GREEN}✅ Rollback executado com sucesso!${NC}"
echo -e "${GREEN}   Knowledge-base restaurada para: $BACKUP_NAME${NC}"
echo -e "${GREEN}   Arquivos restaurados: $RESTORED_COUNT${NC}"
echo -e "${GREEN}   Log: ${BACKUP_DIR}/rollback_log_${ROLLBACK_TIMESTAMP}.txt${NC}"
echo ""
echo -e "${YELLOW}Backup da situação anterior salvo em:${NC}"
echo -e "${YELLOW}  ${BACKUP_DIR}/${CURRENT_BACKUP}${NC}"
echo ""