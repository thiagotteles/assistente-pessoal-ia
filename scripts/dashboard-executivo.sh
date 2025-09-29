#!/bin/bash

# Dashboard Executivo - Secretária Digital
# Análise de status de projetos e agenda do dia

set -e

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Função para logging
log() {
    echo -e "${BLUE}[DASHBOARD]${NC} $1"
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

# Função para análise de status de projeto
analyze_project_status() {
    local project_file="$1"
    local project_name=$(basename "$project_file" .md | sed 's/projeto-//')

    # Extrair informações do arquivo
    local status=$(grep "Status:" "$project_file" 2>/dev/null | head -1 | sed 's/.*Status.*: *//' | sed 's/\*\*//')
    local last_update=$(grep "updated:" "$project_file" 2>/dev/null | head -1 | cut -d: -f2- | xargs)
    local priority=$(grep -i "prioridade" "$project_file" 2>/dev/null | head -1 | sed 's/.*[Pp]rioridade[^:]*: *//' | sed 's/\*\*//')

    # Calcular dias desde última atualização (versão simplificada para Windows)
    if [ -n "$last_update" ]; then
        # Versão simplificada - apenas extrair o ano-mes-dia
        local update_date=$(echo "$last_update" | grep -o "[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]" | head -1)
        local today_date=$(date '+%Y-%m-%d' 2>/dev/null || echo "2025-09-29")

        if [ "$update_date" == "$today_date" ]; then
            local days_since=0
        elif [ -z "$update_date" ]; then
            local days_since=999
        else
            # Estimativa simples baseada na data
            local days_since=3
        fi
    else
        local days_since=999
    fi

    # Contar pessoas envolvidas
    local people_count=$(grep -c "\[\[pessoa-" "$project_file" 2>/dev/null || echo 0)

    # Contar decisões técnicas
    local decisions_count=$(grep -A 10 "## Decisões Técnicas" "$project_file" 2>/dev/null | grep -c "^-\|^*\|^[0-9]" || echo 0)

    # Determinar prioridade de atenção
    local attention_level="normal"
    if [ $days_since -gt 7 ]; then
        attention_level="high"
    elif [ $days_since -gt 3 ]; then
        attention_level="medium"
    fi

    # Determinar urgência baseada em status e prioridade
    local urgency="baixa"
    if [[ "$status" =~ [Bb]loqueado|[Pp]arado|[Pp]endente ]] || [[ "$priority" =~ [Aa]lta|[Uu]rgente ]]; then
        urgency="alta"
    elif [[ "$status" =~ [Aa]ndamento|[Pp]rogresso ]] && [[ "$priority" =~ [Mm]édia ]]; then
        urgency="media"
    fi

    # Output estruturado
    echo "PROJECT_NAME:$project_name"
    echo "STATUS:$status"
    echo "PRIORITY:$priority"
    echo "LAST_UPDATE:$last_update"
    echo "DAYS_SINCE:$days_since"
    echo "PEOPLE_COUNT:$people_count"
    echo "DECISIONS_COUNT:$decisions_count"
    echo "ATTENTION_LEVEL:$attention_level"
    echo "URGENCY:$urgency"
    echo "---"
}

# Função para gerar dashboard
generate_dashboard() {
    echo "==============================================="
    highlight "🏢 DASHBOARD EXECUTIVO - $(date '+%d/%m/%Y %H:%M')"
    echo "==============================================="
    echo

    # Contadores gerais
    local total_projects=0
    local active_projects=0
    local blocked_projects=0
    local high_priority=0
    local needs_attention=0

    # Arrays para classificação
    declare -a urgent_projects=()
    declare -a active_projects_list=()
    declare -a attention_needed=()
    declare -a completed_projects=()

    log "Analisando projetos..."

    # Processar todos os projetos
    for project_file in knowledge-base/projetos/projeto-*.md; do
        if [ -f "$project_file" ]; then
            ((total_projects++))

            # Analisar projeto
            local analysis=$(analyze_project_status "$project_file")

            # Extrair dados da análise
            local name=$(echo "$analysis" | grep "PROJECT_NAME:" | cut -d: -f2)
            local status=$(echo "$analysis" | grep "STATUS:" | cut -d: -f2)
            local priority=$(echo "$analysis" | grep "PRIORITY:" | cut -d: -f2)
            local days_since=$(echo "$analysis" | grep "DAYS_SINCE:" | cut -d: -f2)
            local urgency=$(echo "$analysis" | grep "URGENCY:" | cut -d: -f2)
            local attention=$(echo "$analysis" | grep "ATTENTION_LEVEL:" | cut -d: -f2)

            # Classificar projetos
            if [[ "$urgency" == "alta" ]]; then
                urgent_projects+=("$name|$status|$priority|$days_since")
                ((high_priority++))
            fi

            if [[ "$status" =~ [Aa]ndamento|[Pp]rogresso|[Aa]tivo ]]; then
                active_projects_list+=("$name|$status|$priority|$days_since")
                ((active_projects++))
            fi

            if [[ "$attention" == "high" ]] || [[ "$attention" == "medium" ]]; then
                attention_needed+=("$name|$status|$priority|$days_since")
                ((needs_attention++))
            fi

            if [[ "$status" =~ [Cc]ompleto|[Ff]inalizado|[Cc]oncluído ]]; then
                completed_projects+=("$name|$status|$priority|$days_since")
            fi

            if [[ "$status" =~ [Bb]loqueado|[Pp]arado ]]; then
                ((blocked_projects++))
            fi
        fi
    done

    # SEÇÃO 1: Resumo Executivo
    echo "🎯 RESUMO EXECUTIVO"
    echo "-------------------"
    echo "Total de Projetos: $total_projects"
    echo "Projetos Ativos: $active_projects"
    echo "Alta Prioridade: $high_priority"
    echo "Precisam Atenção: $needs_attention"
    echo "Bloqueados: $blocked_projects"
    echo

    # SEÇÃO 2: Projetos Urgentes
    if [ ${#urgent_projects[@]} -gt 0 ]; then
        error "🚨 PROJETOS URGENTES (${#urgent_projects[@]})"
        echo "-------------------------"
        for project in "${urgent_projects[@]}"; do
            IFS='|' read -r name status priority days <<< "$project"
            printf "• %-20s | Status: %-15s | Prioridade: %-10s | %s dias\n" \
                   "$name" "$status" "$priority" "$days"
        done
        echo
    fi

    # SEÇÃO 3: Projetos Ativos
    if [ ${#active_projects_list[@]} -gt 0 ]; then
        success "⚡ PROJETOS ATIVOS (${#active_projects_list[@]})"
        echo "---------------------"
        for project in "${active_projects_list[@]}"; do
            IFS='|' read -r name status priority days <<< "$project"
            printf "• %-20s | Status: %-15s | Prioridade: %-10s | %s dias\n" \
                   "$name" "$status" "$priority" "$days"
        done
        echo
    fi

    # SEÇÃO 4: Precisam de Atenção
    if [ ${#attention_needed[@]} -gt 0 ]; then
        warn "⚠️  PRECISAM DE ATENÇÃO (${#attention_needed[@]})"
        echo "------------------------"
        for project in "${attention_needed[@]}"; do
            IFS='|' read -r name status priority days <<< "$project"
            printf "• %-20s | Status: %-15s | Últimos %s dias\n" \
                   "$name" "$status" "$days"
        done
        echo
    fi

    # SEÇÃO 5: Próximas Ações Sugeridas
    echo "📋 PRÓXIMAS AÇÕES SUGERIDAS"
    echo "----------------------------"

    if [ $high_priority -gt 0 ]; then
        echo "• Revisar projetos de alta prioridade"
    fi

    if [ $needs_attention -gt 0 ]; then
        echo "• Acompanhar projetos sem atividade recente"
    fi

    if [ $blocked_projects -gt 0 ]; then
        echo "• Desbloquear projetos parados"
    fi

    if [ $active_projects -eq 0 ]; then
        echo "• Iniciar novos projetos - nenhum ativo no momento"
    fi

    echo "• Atualizar status dos projetos em andamento"
    echo

    # SEÇÃO 6: Central de Todos
    log "Verificando todos pendentes..."
    if [ -f "todos/central-todos.md" ]; then
        local todos_count=$(grep -c "^- \[ \]" "todos/central-todos.md" 2>/dev/null || echo 0)
        if [ $todos_count -gt 0 ]; then
            highlight "📝 TODOS PENDENTES: $todos_count itens em central-todos.md"
        else
            success "✅ Sem todos pendentes na central"
        fi
    else
        warn "Central de todos não encontrada"
    fi

    echo
    echo "==============================================="
    log "Dashboard gerado com sucesso!"
    echo "Para análise detalhada: ./scripts/dashboard-executivo.sh --detailed"
    echo "==============================================="
}

# Função para análise detalhada
generate_detailed_analysis() {
    echo "==============================================="
    highlight "📊 ANÁLISE DETALHADA DE PROJETOS"
    echo "==============================================="
    echo

    for project_file in knowledge-base/projetos/projeto-*.md; do
        if [ -f "$project_file" ]; then
            local project_name=$(basename "$project_file" .md | sed 's/projeto-//')
            echo "🔍 PROJETO: $project_name"
            echo "-------------------"

            # Análise completa
            local analysis=$(analyze_project_status "$project_file")
            echo "$analysis" | grep -v "^---$" | while IFS=: read -r key value; do
                case $key in
                    "STATUS") echo "Status: $value" ;;
                    "PRIORITY") echo "Prioridade: $value" ;;
                    "LAST_UPDATE") echo "Última Atualização: $value" ;;
                    "DAYS_SINCE") echo "Dias desde atualização: $value" ;;
                    "PEOPLE_COUNT") echo "Pessoas envolvidas: $value" ;;
                    "DECISIONS_COUNT") echo "Decisões técnicas: $value" ;;
                    "URGENCY") echo "Nível de urgência: $value" ;;
                esac
            done

            # Próximas ações específicas
            echo "Próximas ações:"
            grep -A 5 -i "próxim\|next\|ação\|action" "$project_file" 2>/dev/null | head -3 | sed 's/^/  • /'

            echo
        fi
    done
}

# Main function
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
            echo "  (sem opção)    Mostrar dashboard resumido"
            echo "  --detailed     Análise detalhada de cada projeto"
            echo "  --help         Mostrar esta ajuda"
            ;;
        *)
            generate_dashboard
            ;;
    esac
}

# Executar apenas se for chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi