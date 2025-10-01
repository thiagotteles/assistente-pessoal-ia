#!/bin/bash

# Dashboard Executivo Simplificado - Secretária Digital
# Versão otimizada para Windows e compatibilidade

set -e

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Função para logging
log() {
    echo -e "${BLUE}[SECRETÁRIA]${NC} $1"
}

success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[⚠]${NC} $1"
}

error() {
    echo -e "${RED}[✗]${NC} $1"
}

highlight() {
    echo -e "${PURPLE}[★]${NC} $1"
}

# Função principal do dashboard
generate_dashboard() {
    local today=$(date '+%d/%m/%Y' 2>/dev/null || echo "29/09/2025")
    local time=$(date '+%H:%M' 2>/dev/null || echo "$(date)")

    echo "==============================================="
    highlight "🏢 DASHBOARD EXECUTIVO - $today $time"
    echo "==============================================="
    echo

    # Contadores
    local total_projects=0
    local active_projects=0
    local needs_attention=0

    # Listas para organização
    local urgent_list=""
    local active_list=""
    local attention_list=""

    log "📊 Analisando projetos na knowledge-base..."

    # Processar projetos
    for project_file in knowledge-base/projetos/projeto-*.md; do
        if [ -f "$project_file" ]; then
            local project_name=$(basename "$project_file" .md | sed 's/projeto-//')
            ((total_projects++))

            # Extrair informações básicas
            local status=$(grep -i "status" "$project_file" | head -1 | sed 's/.*[Ss]tatus[^:]*: *//' | sed 's/\*\*//g' | sed 's/^ *//')
            local priority=$(grep -i "prioridade" "$project_file" | head -1 | sed 's/.*[Pp]rioridade[^:]*: *//' | sed 's/\*\*//g' | sed 's/^ *//')

            # Classificar status
            if [[ "$status" =~ [Aa]ndamento|[Pp]rogresso|[Aa]tivo|"Em andamento" ]]; then
                ((active_projects++))
                active_list="${active_list}• $project_name - $status"$'\n'
            fi

            # Verificar se precisa atenção
            if [[ "$status" =~ [Bb]loqueado|[Pp]arado|[Pp]endente ]] || [[ "$priority" =~ [Aa]lta|[Uu]rgente ]]; then
                ((needs_attention++))
                if [[ "$priority" =~ [Aa]lta|[Uu]rgente ]]; then
                    urgent_list="${urgent_list}• $project_name - $status (Prioridade: $priority)"$'\n'
                else
                    attention_list="${attention_list}• $project_name - $status"$'\n'
                fi
            fi
        fi
    done

    # SEÇÃO 1: Resumo Executivo
    echo "🎯 RESUMO EXECUTIVO"
    echo "-------------------"
    success "Total de Projetos: $total_projects"
    success "Projetos Ativos: $active_projects"
    if [ $needs_attention -gt 0 ]; then
        warn "Precisam Atenção: $needs_attention"
    else
        success "Todos projetos estão atualizados"
    fi
    echo

    # SEÇÃO 2: Projetos Urgentes
    if [ -n "$urgent_list" ]; then
        error "🚨 PROJETOS URGENTES"
        echo "---------------------"
        echo -e "$urgent_list"
    fi

    # SEÇÃO 3: Projetos Ativos
    if [ -n "$active_list" ]; then
        highlight "⚡ PROJETOS ATIVOS"
        echo "-------------------"
        echo -e "$active_list"
    fi

    # SEÇÃO 4: Precisam de Atenção
    if [ -n "$attention_list" ]; then
        warn "⚠️  PRECISAM DE ATENÇÃO"
        echo "-----------------------"
        echo -e "$attention_list"
    fi

    # SEÇÃO 5: Central de Todos
    log "📝 Verificando central de todos..."
    if [ -f "todos/central-todos.md" ]; then
        local todos_pending=$(grep -c "^- \[ \]" "todos/central-todos.md" 2>/dev/null || echo 0)
        local todos_done=$(grep -c "^- \[x\]" "todos/central-todos.md" 2>/dev/null || echo 0)

        echo "📋 CENTRAL DE TODOS"
        echo "-------------------"
        if [ $todos_pending -gt 0 ]; then
            warn "Pendentes: $todos_pending todos"
        else
            success "Sem todos pendentes"
        fi
        success "Concluídos: $todos_done todos"
        echo
    fi

    # SEÇÃO 6: Agenda e Sugestões
    echo "📅 PRÓXIMAS AÇÕES SUGERIDAS"
    echo "----------------------------"

    if [ $needs_attention -gt 0 ]; then
        echo "• Revisar projetos que precisam de atenção"
    fi

    if [ $active_projects -eq 0 ]; then
        echo "• Considerar iniciar novos projetos"
    else
        echo "• Atualizar status dos projetos em andamento"
    fi

    echo "• Processar novos itens do daily-dump.md"
    echo "• Revisar e priorizar todos pendentes"

    # Verificar se há despejo para processar
    if [ -f "despejo/daily-dump.md" ] && [ -s "despejo/daily-dump.md" ]; then
        warn "• ATENÇÃO: Há conteúdo novo no daily-dump.md para processar"
    fi

    echo
    echo "==============================================="
    success "Dashboard gerado com sucesso!"
    log "Para detalhes: ./scripts/secretaria-dashboard.sh --detailed"
    echo "==============================================="
}

# Função para análise detalhada
generate_detailed_analysis() {
    echo "==============================================="
    highlight "📊 ANÁLISE DETALHADA - SECRETÁRIA EXECUTIVA"
    echo "==============================================="
    echo

    for project_file in knowledge-base/projetos/projeto-*.md; do
        if [ -f "$project_file" ]; then
            local project_name=$(basename "$project_file" .md | sed 's/projeto-//')

            echo "🔍 PROJETO: $project_name"
            echo "$(echo $project_name | sed 's/./-/g')----------"

            # Informações básicas
            local status=$(grep -i "status" "$project_file" | head -1 | sed 's/.*[Ss]tatus[^:]*: *//' | sed 's/\*\*//g')
            local priority=$(grep -i "prioridade" "$project_file" | head -1 | sed 's/.*[Pp]rioridade[^:]*: *//' | sed 's/\*\*//g')

            if [ -n "$status" ]; then
                echo "Status: $status"
            fi

            if [ -n "$priority" ]; then
                echo "Prioridade: $priority"
            fi

            # Pessoas envolvidas
            local people_count=$(grep -c "\[\[pessoa-" "$project_file" 2>/dev/null || echo 0)
            echo "Pessoas envolvidas: $people_count"

            # Próximas ações
            echo "Próximas ações identificadas:"
            grep -i -A 3 "próxim\|next\|ação" "$project_file" 2>/dev/null | head -3 | sed 's/^/  • /' || echo "  • Nenhuma ação específica encontrada"

            echo
        fi
    done

    # Análise da knowledge-base
    echo "📚 ANÁLISE DA KNOWLEDGE-BASE"
    echo "-----------------------------"

    local pessoas_count=$(ls knowledge-base/pessoas/pessoa-*.md 2>/dev/null | wc -l || echo 0)
    local contextos_count=$(ls knowledge-base/contextos/contexto-*.md 2>/dev/null | wc -l || echo 0)
    local decisoes_count=$(ls knowledge-base/decisoes/*.md 2>/dev/null | wc -l || echo 0)

    echo "Pessoas catalogadas: $pessoas_count"
    echo "Contextos documentados: $contextos_count"
    echo "Decisões registradas: $decisoes_count"
    echo
}

# Função principal
main() {
    case "${1:-}" in
        "--detailed"|"-d")
            generate_detailed_analysis
            ;;
        "--help"|"-h")
            echo "Dashboard Executivo - Secretária Digital"
            echo ""
            echo "Uso: $0 [opção]"
            echo ""
            echo "Opções:"
            echo "  (sem opção)    Dashboard resumido"
            echo "  --detailed     Análise detalhada completa"
            echo "  --help         Mostrar esta ajuda"
            ;;
        *)
            generate_dashboard
            ;;
    esac
}

# Executar
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi