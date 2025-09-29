#!/bin/bash

# Sistema de Timeout Inteligente - Story 2.2.3
# Previne esperas excessivas que quebram foco TDAH

set -e

# Configurações
DEFAULT_TIMEOUT=8
QUICK_TIMEOUT=3
SLOW_TIMEOUT=15
LOG_FILE="logs/timeout-$(date +"%Y%m%d_%H%M%S").log"

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Função de log
log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE" 2>/dev/null || echo "[$(date '+%H:%M:%S')] $1"
}

# Função de timeout inteligente
smart_timeout() {
    local timeout_duration="$1"
    local command="$2"
    local operation_name="$3"
    local show_progress="${4:-true}"

    log "Iniciando operação: $operation_name (timeout: ${timeout_duration}s)"

    if [ "$show_progress" = "true" ]; then
        echo -e "${BLUE}🔄 $operation_name...${NC}"
    fi

    # Executar comando com timeout
    if timeout "${timeout_duration}s" bash -c "$command" 2>/dev/null; then
        if [ "$show_progress" = "true" ]; then
            echo -e "${GREEN}✅ $operation_name concluída${NC}"
        fi
        log "Sucesso: $operation_name"
        return 0
    else
        local exit_code=$?
        if [ $exit_code -eq 124 ]; then
            if [ "$show_progress" = "true" ]; then
                echo -e "${YELLOW}⏰ $operation_name demorou muito (>${timeout_duration}s)${NC}"
                echo -e "${YELLOW}💡 Continuando com resposta parcial...${NC}"
            fi
            log "Timeout: $operation_name após ${timeout_duration}s"
            return 124
        else
            if [ "$show_progress" = "true" ]; then
                echo -e "${RED}❌ Erro em $operation_name${NC}"
            fi
            log "Erro: $operation_name (código: $exit_code)"
            return $exit_code
        fi
    fi
}

# Carregamento rápido da Sofia
fast_load_sofia() {
    echo -e "${YELLOW}🚀 Carregamento rápido da Sofia...${NC}"

    # Carregar dados essenciais com timeout curto
    smart_timeout $QUICK_TIMEOUT "cat .assistant-core/agents/organizador.md" "Definição do agente" false

    smart_timeout $QUICK_TIMEOUT "cat .assistant-core/memory/organizador-memory.yaml" "Memória pessoal" false

    smart_timeout $QUICK_TIMEOUT "ls .assistant-core/tasks/" "Lista de tarefas" false

    echo -e "${GREEN}✅ Sofia carregada rapidamente${NC}"
}

# Processamento com timeout adaptativo
process_with_timeout() {
    local input_text="$1"
    local operation_type="$2"

    case "$operation_type" in
        "quick")
            timeout_val=$QUICK_TIMEOUT
            ;;
        "normal")
            timeout_val=$DEFAULT_TIMEOUT
            ;;
        "slow")
            timeout_val=$SLOW_TIMEOUT
            ;;
        *)
            timeout_val=$DEFAULT_TIMEOUT
            ;;
    esac

    echo -e "${BLUE}🧠 Processando entrada (${operation_type}): ${input_text:0:50}...${NC}"

    # Detectar entidades com timeout
    if smart_timeout $timeout_val "./scripts/auto-consolidate.sh '$input_text' 'timeout-test'" "Detecção de entidades" true; then
        echo -e "${GREEN}✅ Processamento completo${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️ Processamento parcial (timeout)${NC}"
        echo -e "${YELLOW}💭 Resultado: Entrada salva em contexto geral${NC}"
        return 1
    fi
}

# Indicador de progresso simples
show_progress() {
    local duration="$1"
    local message="$2"

    echo -n -e "${BLUE}$message${NC}"

    for i in $(seq 1 $duration); do
        echo -n "."
        sleep 1
    done

    echo -e " ${GREEN}OK${NC}"
}

# Sistema de feedback contínuo
continuous_feedback() {
    local command="$1"
    local max_time="$2"
    local operation="$3"

    echo -e "${BLUE}🔄 $operation em andamento...${NC}"

    # Executar comando em background
    eval "$command" &
    local cmd_pid=$!

    # Contador de tempo
    local elapsed=0

    while kill -0 $cmd_pid 2>/dev/null; do
        sleep 1
        elapsed=$((elapsed + 1))

        case $elapsed in
            3)
                echo -e "${YELLOW}⏳ Processando... (${elapsed}s)${NC}"
                ;;
            6)
                echo -e "${YELLOW}⏳ Ainda processando... (${elapsed}s)${NC}"
                ;;
            10)
                echo -e "${YELLOW}⚠️ Operação demorada... (${elapsed}s)${NC}"
                ;;
        esac

        if [ $elapsed -ge $max_time ]; then
            kill $cmd_pid 2>/dev/null || true
            wait $cmd_pid 2>/dev/null || true
            echo -e "${RED}⏰ Timeout após ${elapsed}s${NC}"
            return 124
        fi
    done

    wait $cmd_pid
    local result=$?

    if [ $result -eq 0 ]; then
        echo -e "${GREEN}✅ $operation concluída em ${elapsed}s${NC}"
    else
        echo -e "${RED}❌ $operation falhou após ${elapsed}s${NC}"
    fi

    return $result
}

# Configuração de timeouts por operação
configure_timeouts() {
    echo -e "${YELLOW}⚙️ Configurando timeouts otimizados para TDAH...${NC}"

    cat > "cache/timeout-config.txt" << EOF
# Configuração de Timeouts Inteligentes
# Valores otimizados para usuários TDAH

# Operações rápidas (devem ser instantâneas)
MEMORY_LOAD_TIMEOUT=2
TASK_LOAD_TIMEOUT=2
TEMPLATE_LOAD_TIMEOUT=2

# Operações normais (processamento básico)
ENTITY_DETECTION_TIMEOUT=5
CATEGORIZATION_TIMEOUT=8
FILE_READ_TIMEOUT=3

# Operações complexas (mas com limite)
CONSOLIDATION_TIMEOUT=10
FULL_PROCESSING_TIMEOUT=15
KNOWLEDGE_SCAN_TIMEOUT=12

# Operações que podem ser lentas
BACKUP_TIMEOUT=30
MIGRATION_TIMEOUT=60
EOF

    echo -e "${GREEN}✅ Configuração salva em cache/timeout-config.txt${NC}"
}

# Benchmark de timeout
benchmark_timeout() {
    echo -e "${BLUE}=== Benchmark do Sistema de Timeout ===${NC}"

    echo -e "${YELLOW}Teste 1: Operação rápida${NC}"
    smart_timeout $QUICK_TIMEOUT "cat .assistant-core/memory/organizador-memory.yaml" "Carregamento memória" true

    echo -e "${YELLOW}Teste 2: Operação normal${NC}"
    smart_timeout $DEFAULT_TIMEOUT "find knowledge-base -name '*.md'" "Varredura knowledge-base" true

    echo -e "${YELLOW}Teste 3: Operação potencialmente lenta${NC}"
    smart_timeout $SLOW_TIMEOUT "./scripts/auto-consolidate.sh 'Teste de timeout benchmark' 'benchmark'" "Consolidação automática" true

    echo -e "${YELLOW}Teste 4: Feedback contínuo${NC}"
    continuous_feedback "sleep 7" 10 "Simulação de processamento"

    echo -e "${GREEN}✅ Todos os testes de timeout concluídos${NC}"
}

# Interface principal
case "${1:-help}" in
    "fast-load")
        mkdir -p logs cache
        fast_load_sofia
        ;;
    "process")
        if [ -z "$2" ]; then
            echo "Uso: $0 process \"<texto>\" [quick|normal|slow]"
            exit 1
        fi
        mkdir -p logs cache
        process_with_timeout "$2" "${3:-normal}"
        ;;
    "configure")
        mkdir -p cache
        configure_timeouts
        ;;
    "benchmark")
        mkdir -p logs cache
        benchmark_timeout
        ;;
    "progress")
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Uso: $0 progress <segundos> \"<mensagem>\""
            exit 1
        fi
        show_progress "$2" "$3"
        ;;
    "feedback")
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Uso: $0 feedback \"<comando>\" <max_segundos>"
            exit 1
        fi
        mkdir -p logs
        continuous_feedback "$2" "$3" "Operação customizada"
        ;;
    *)
        echo -e "${BLUE}Sistema de Timeout Inteligente para TDAH${NC}"
        echo ""
        echo "Comandos:"
        echo "  fast-load                    - Carregamento rápido da Sofia"
        echo "  process \"<texto>\" [tipo]      - Processar com timeout adaptativo"
        echo "  configure                    - Configurar timeouts otimizados"
        echo "  benchmark                    - Testar sistema de timeout"
        echo "  progress <seg> \"<msg>\"        - Mostrar progresso simples"
        echo "  feedback \"<cmd>\" <max_seg>    - Feedback contínuo"
        echo ""
        echo "Tipos de processamento:"
        echo "  quick  - ${QUICK_TIMEOUT}s timeout"
        echo "  normal - ${DEFAULT_TIMEOUT}s timeout"
        echo "  slow   - ${SLOW_TIMEOUT}s timeout"
        ;;
esac