#!/bin/bash
# Script para adicionar entradas ao daily-dump.txt com facilidade
# Suporta timestamps opcionais e preserva entradas existentes

DUMP_FILE="despejo/daily-dump.txt"
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_ROOT"

# Function to add timestamp
add_timestamp() {
    if [ "$1" = "--with-timestamp" ] || [ "$1" = "-t" ]; then
        echo "true"
    else
        echo "false"
    fi
}

# Function to append entry
append_entry() {
    local content="$1"
    local use_timestamp="$2"

    # Ensure dump file exists
    if [ ! -f "$DUMP_FILE" ]; then
        echo "❌ Error: $DUMP_FILE not found"
        exit 1
    fi

    # Add separator and entry
    echo "" >> "$DUMP_FILE"
    echo "---" >> "$DUMP_FILE"
    echo "" >> "$DUMP_FILE"

    # Add timestamp if requested
    if [ "$use_timestamp" = "true" ]; then
        echo "**📅 $(date '+%Y-%m-%dT%H:%M:%S')**" >> "$DUMP_FILE"
        echo "" >> "$DUMP_FILE"
    fi

    # Add the content
    echo "$content" >> "$DUMP_FILE"
    echo "" >> "$DUMP_FILE"

    echo "✅ Entry added to daily-dump.txt"
    if [ "$use_timestamp" = "true" ]; then
        echo "🕐 Timestamp: $(date '+%Y-%m-%dT%H:%M:%S')"
    fi
}

# Display usage
show_usage() {
    echo "Usage: $0 [OPTIONS] \"Your entry content\""
    echo ""
    echo "Options:"
    echo "  -t, --with-timestamp    Add timestamp to entry"
    echo "  -h, --help             Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 \"Meeting with [[João Silva]] about [[Sistema Alpha]]\""
    echo "  $0 -t \"Important decision about database architecture\""
    echo "  $0 \"Ideas: - New feature X - Refactor Y - Talk to [[Maria]]\""
    echo ""
    echo "Features:"
    echo "  • No validation - accepts any text format"
    echo "  • Preserves existing entries"
    echo "  • Optional timestamps"
    echo "  • Supports [[references]]"
    echo "  • Multiple entries per day"
}

# Parse arguments
USE_TIMESTAMP="false"
CONTENT=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--with-timestamp)
            USE_TIMESTAMP="true"
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            CONTENT="$1"
            shift
            ;;
    esac
done

# Check if content was provided
if [ -z "$CONTENT" ]; then
    echo "❌ Error: No content provided"
    echo ""
    show_usage
    exit 1
fi

# Add the entry
append_entry "$CONTENT" "$USE_TIMESTAMP"

# Show last few lines for confirmation
echo ""
echo "📝 Last few lines of daily-dump.txt:"
tail -n 10 "$DUMP_FILE" | sed 's/^/   /'