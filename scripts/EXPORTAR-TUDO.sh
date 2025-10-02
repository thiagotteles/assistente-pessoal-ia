#!/bin/bash
# EXPORTAR-TUDO.sh - Export Manual para Backup Externo
# Sistema: Assistente Pessoal IA

set -e

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "📦 Exportador de Backup Completo - Assistente Pessoal IA"
echo ""
echo "Este script vai criar um arquivo ZIP com TODOS os seus dados:"
echo "  • Knowledge-Base (projetos, pessoas, decisões)"
echo "  • Despejo (capturas diárias)"
echo "  • Todos (tarefas)"
echo "  • Diário (entradas pessoais)"
echo "  • Memória dos agentes"
echo ""
echo -e "${YELLOW}⚠️  Recomendado: Execute isso 1x por mês e salve em local seguro${NC}"
echo "   (Dropbox, Google Drive, HD externo, email para si mesmo, etc.)"
echo ""

# Nome do arquivo
EXPORT_DATE=$(date +%Y-%m-%d_%H-%M-%S)
EXPORT_FILE="assistente-backup-completo-${EXPORT_DATE}.zip"

echo "📂 Criando arquivo: $EXPORT_FILE"
echo ""

# Verificar pastas existentes
FOLDERS_TO_EXPORT=()

if [ -d "knowledge-base" ]; then
    FOLDERS_TO_EXPORT+=("knowledge-base")
    echo "  ✓ knowledge-base/ encontrado"
fi

if [ -d "despejo" ]; then
    FOLDERS_TO_EXPORT+=("despejo")
    echo "  ✓ despejo/ encontrado"
fi

if [ -d "todos" ]; then
    FOLDERS_TO_EXPORT+=("todos")
    echo "  ✓ todos/ encontrado"
fi

if [ -d "diario" ]; then
    FOLDERS_TO_EXPORT+=("diario")
    echo "  ✓ diario/ encontrado"
fi

if [ -d ".assistant-core/memory" ]; then
    FOLDERS_TO_EXPORT+=(".assistant-core/memory")
    echo "  ✓ .assistant-core/memory/ encontrado"
fi

if [ -d ".assistant-core/agents" ]; then
    FOLDERS_TO_EXPORT+=(".assistant-core/agents")
    echo "  ✓ .assistant-core/agents/ encontrado"
fi

if [ -d ".assistant-core/data" ]; then
    FOLDERS_TO_EXPORT+=(".assistant-core/data")
    echo "  ✓ .assistant-core/data/ encontrado"
fi

# Adicionar .version se existir
if [ -f ".version" ]; then
    FOLDERS_TO_EXPORT+=(".version")
    echo "  ✓ .version encontrado"
fi

echo ""

# Criar ZIP
echo "🗜️  Comprimindo arquivos..."
zip -r "$EXPORT_FILE" "${FOLDERS_TO_EXPORT[@]}" -q

if [ $? -eq 0 ]; then
    # Calcular tamanho
    SIZE=$(du -h "$EXPORT_FILE" | cut -f1)

    echo ""
    echo -e "${GREEN}✅ Export concluído com sucesso!${NC}"
    echo ""
    echo "📦 Arquivo criado: $EXPORT_FILE"
    echo "📏 Tamanho: $SIZE"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}PRÓXIMOS PASSOS - SALVE SEU BACKUP EM LOCAL SEGURO:${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "1. 💾 Copie para HD externo ou pen drive"
    echo "2. ☁️  Upload para nuvem (Dropbox, Google Drive, OneDrive)"
    echo "3. 📧 Envie por email para você mesmo"
    echo "4. 🖥️  Copie para outro computador"
    echo ""
    echo "Para restaurar no futuro:"
    echo "  • Descompacte o ZIP"
    echo "  • Execute setup.bat/setup.sh se necessário"
    echo "  • Abra o Obsidian na pasta knowledge-base/"
    echo ""

    # Salvar timestamp
    echo "$EXPORT_DATE" > ULTIMA-EXPORTACAO.txt
    echo -e "${GREEN}📅 Timestamp salvo em ULTIMA-EXPORTACAO.txt${NC}"
    echo ""
else
    echo ""
    echo -e "${RED}❌ Erro ao criar backup. Verifique se há espaço em disco.${NC}"
    exit 1
fi
