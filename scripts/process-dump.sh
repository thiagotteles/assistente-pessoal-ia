#!/bin/bash
# Script para processar daily-dump.md e arquivar entradas processadas
# Prepara arquivo para processamento pelo /organizador

DUMP_FILE="despejo/daily-dump.md"
PROCESSED_DIR="despejo/processed"
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_ROOT"

# Ensure directories exist
mkdir -p "$PROCESSED_DIR"

# Function to archive current dump
archive_dump() {
    local timestamp=$(date '+%Y-%m-%d-%H%M%S')
    local archive_file="$PROCESSED_DIR/${timestamp}-processed.txt"

    if [ ! -f "$DUMP_FILE" ]; then
        echo "❌ Error: $DUMP_FILE not found"
        exit 1
    fi

    # Check if dump has content beyond the template
    content_lines=$(grep -v "^#\|^**\|^-\|^$\|^---" "$DUMP_FILE" | wc -l)

    if [ "$content_lines" -eq 0 ]; then
        echo "ℹ️  No new entries to process in daily-dump.md"
        exit 0
    fi

    # Copy current dump to processed directory
    cp "$DUMP_FILE" "$archive_file"

    echo "📦 Archived current dump to: $archive_file"

    # Reset daily-dump.md to template
    reset_dump_file

    echo "✅ daily-dump.md reset for new entries"
    echo "📊 Processed $content_lines lines of content"
}

# Function to reset dump file to template
reset_dump_file() {
    cat > "$DUMP_FILE" << 'EOF'
# Daily Dump - Captura Ultra-Rápida

**INSTRUÇÕES**: Jogue qualquer informação aqui sem se preocupar com formatação.
O `/organizador` processará posteriormente através de perguntas específicas.

---

## 🧠 Despejo Mental - Formato Livre

**📅 Timestamp Opcional**: Se quiser, adicione data/hora: `2025-09-26T16:30:00`

**Você pode escrever aqui em qualquer formato:**
- Ideias soltas e insights
- Reuniões e conversas importantes
- Decisões técnicas ou pessoais
- TODOs e tarefas urgentes
- Links interessantes
- Reflexões e aprendizados
- QUALQUER COISA que esteja na sua mente!

**📝 Dicas**:
- Use `[[Nome]]` para referenciar pessoas (ex: `[[João Silva]]`)
- Use `[[Projeto]]` para referenciar projetos (ex: `[[Sistema Alpha]]`)
- Não se preocupe com organização - o agente organizador fará isso por você
- Escreva como você pensa - natural e sem filtros

---

## 💭 Seus Pensamentos Começam Aqui:

EOF
}

# Function to show recent processed files
show_processed_files() {
    echo "📋 Recent processed files:"
    if [ -d "$PROCESSED_DIR" ]; then
        ls -lt "$PROCESSED_DIR"/*.txt 2>/dev/null | head -5 | while read line; do
            echo "   $line"
        done
    else
        echo "   No processed files found"
    fi
}

# Function to mark entries as processed (without archiving)
mark_processed() {
    if [ ! -f "$DUMP_FILE" ]; then
        echo "❌ Error: $DUMP_FILE not found"
        exit 1
    fi

    # Add processed marker at the end
    echo "" >> "$DUMP_FILE"
    echo "---" >> "$DUMP_FILE"
    echo "**🎯 PROCESSADO EM $(date '+%Y-%m-%dT%H:%M:%S')**" >> "$DUMP_FILE"
    echo "*Entradas acima foram processadas pelo /organizador*" >> "$DUMP_FILE"
    echo "" >> "$DUMP_FILE"

    echo "✅ Entries marked as processed"
}

# Display usage
show_usage() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  archive     Archive current dump and reset file (default)"
    echo "  mark        Mark current entries as processed without archiving"
    echo "  reset       Reset dump file to template"
    echo "  list        Show recent processed files"
    echo "  help        Show this help"
    echo ""
    echo "Examples:"
    echo "  $0                    # Archive current dump"
    echo "  $0 archive            # Same as above"
    echo "  $0 mark               # Mark as processed without archiving"
    echo "  $0 list               # Show processed files"
    echo ""
    echo "Features:"
    echo "  • Preserves all entries in processed/ directory"
    echo "  • Resets daily-dump.md for new entries"
    echo "  • Timestamps all operations"
    echo "  • No data loss - everything is archived"
}

# Parse command
COMMAND="${1:-archive}"

case "$COMMAND" in
    archive)
        archive_dump
        show_processed_files
        ;;
    mark)
        mark_processed
        ;;
    reset)
        reset_dump_file
        echo "✅ daily-dump.md reset to template"
        ;;
    list)
        show_processed_files
        ;;
    help|--help|-h)
        show_usage
        ;;
    *)
        echo "❌ Unknown command: $COMMAND"
        echo ""
        show_usage
        exit 1
        ;;
esac