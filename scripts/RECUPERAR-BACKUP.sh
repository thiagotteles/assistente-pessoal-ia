#!/bin/bash
# RECUPERAR-BACKUP.sh - Recovery Simples para Usuários
# Sistema: Assistente Pessoal IA

set -e

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "🔄 Recuperador de Backup - Assistente Pessoal IA"
echo ""
echo "Últimos 10 backups disponíveis:"
echo ""

# Listar últimos 10 commits de forma amigável
git log -10 --pretty=format:"%h|%ad|%s" --date=format:"%d/%m/%Y %H:%M" 2>/dev/null | \
while IFS='|' read hash data mensagem; do
    echo "[$hash] $data - $mensagem"
done

# Se não há Git
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Git não está inicializado neste diretório.${NC}"
    echo ""
    echo "Backups ZIP disponíveis:"
    ls -lht backup-pre-epic3-*.zip 2>/dev/null | head -10 || echo "Nenhum backup ZIP encontrado"
    exit 1
fi

echo ""
echo "Digite o código [XXXX] do backup que deseja recuperar:"
read backup_hash

# Validação
if [ -z "$backup_hash" ]; then
    echo -e "${RED}❌ Nenhum código fornecido. Operação cancelada.${NC}"
    exit 1
fi

# Confirmação
echo ""
echo -e "${YELLOW}⚠️  ATENÇÃO: Isso vai restaurar seus arquivos para o estado do backup escolhido.${NC}"
echo -e "${YELLOW}   Alterações não salvas desde esse backup serão perdidas.${NC}"
echo ""
echo "Tem certeza? (sim/não)"
read confirmacao

if [ "$confirmacao" != "sim" ]; then
    echo -e "${RED}❌ Operação cancelada.${NC}"
    exit 0
fi

# Recovery
echo ""
echo "🔄 Restaurando backup..."
git reset --hard "$backup_hash"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Backup restaurado com sucesso!${NC}"
    echo "📂 Abra o Obsidian para ver seus arquivos restaurados."
else
    echo -e "${RED}❌ Erro ao restaurar backup. Entre em contato com suporte.${NC}"
    exit 1
fi
