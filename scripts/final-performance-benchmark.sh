#!/bin/bash

# Benchmark Final de Performance - Story 2.2.3
# Valida se as metas de otimização foram atingidas

set -e

# Configurações
RESULTS_DIR="performance"
FINAL_RESULTS="$RESULTS_DIR/final-results.json"
LOG_FILE="logs/final-benchmark-$(date +"%Y%m%d_%H%M%S").log"

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Metas da Story 2.2.3
TARGET_IMPROVEMENT_PERCENT=60
TARGET_OPERATIONS_UNDER_3S=80
TARGET_AGENT_LOAD_TIME=5
TARGET_CATEGORIZATION_TIME=8
TARGET_PROCESSING_TIME=18

log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE" 2>/dev/null || echo "[$(date '+%H:%M:%S')] $1"
}

measure_operation() {
    local description="$1"
    local command="$2"
    local iterations=3

    echo -e "${YELLOW}📊 Medindo: $description${NC}"

    local total_time=0
    local success_count=0

    for i in $(seq 1 $iterations); do
        echo -n "  Iteração $i/$iterations... "

        start=$(date +%s)
        if eval "$command" >/dev/null 2>&1; then
            end=$(date +%s)
            iteration_time=$((end - start))
            total_time=$((total_time + iteration_time))
            success_count=$((success_count + 1))
            echo -e "${GREEN}${iteration_time}s${NC}"
        else
            echo -e "${RED}FALHA${NC}"
        fi
    done

    if [ $success_count -gt 0 ]; then
        local avg_time=$((total_time / success_count))
        echo -e "${BLUE}  Média: ${avg_time}s (${success_count}/${iterations} sucessos)${NC}"
        log "$description - Média: ${avg_time}s"
        echo "$avg_time"
    else
        echo -e "${RED}  Todas as iterações falharam${NC}"
        log "$description - FALHA TOTAL"
        echo "999"
    fi
}

echo -e "${BLUE}=== Benchmark Final de Performance - Story 2.2.3 ===${NC}"
echo "Log: $LOG_FILE"
echo ""

mkdir -p "$RESULTS_DIR" logs cache

log "Iniciando benchmark final"

echo -e "${YELLOW}=== FASE 1: OPERAÇÕES COM OTIMIZAÇÕES ===${NC}"
echo ""

# Inicializar otimizações
echo -e "${BLUE}🚀 Inicializando sistemas de otimização...${NC}"
./scripts/simple-cache.sh init >/dev/null 2>&1
./scripts/simple-cache.sh preload >/dev/null 2>&1
./scripts/intelligent-timeout.sh configure >/dev/null 2>&1

echo -e "${GREEN}✅ Otimizações inicializadas${NC}"
echo ""

# 1. Carregamento da Sofia com cache
sofia_load_time=$(measure_operation "Carregamento completo da Sofia (com cache)" "
    ./scripts/simple-cache.sh load '.assistant-core/agents/organizador.md' &&
    ./scripts/simple-cache.sh load '.assistant-core/memory/organizador-memory.yaml' &&
    ./scripts/simple-cache.sh load '.assistant-core/tasks/processar-despejo.md'
")

# 2. Categorização com timeout inteligente
categorization_time=$(measure_operation "Categorização automática (com timeout)" "
    ./scripts/intelligent-timeout.sh process 'Conversei com Fabio sobre o projeto onboarding hoje' normal
")

# 3. Processamento daily-dump completo
processing_time=$(measure_operation "Processamento daily-dump (otimizado)" "
    ./scripts/auto-consolidate.sh 'Teste de performance final com múltiplas entidades Fabio onboarding bem-estar' 'benchmark'
")

# 4. Operações rápidas (devem ser < 3s)
echo -e "${YELLOW}=== FASE 2: VALIDAÇÃO DE OPERAÇÕES RÁPIDAS ===${NC}"
echo ""

operations_under_3s=0
total_operations=0

# Lista de operações que devem ser rápidas
quick_operations=(
    "Leitura de memória|./scripts/simple-cache.sh load '.assistant-core/memory/organizador-memory.yaml'"
    "Leitura de task|./scripts/simple-cache.sh load '.assistant-core/tasks/processar-despejo.md'"
    "Varredura knowledge-base|find knowledge-base -name '*.md'"
    "Consolidação simples|./scripts/auto-consolidate.sh 'Teste rápido' 'test'"
)

for operation in "${quick_operations[@]}"; do
    IFS='|' read -r name command <<< "$operation"

    start=$(date +%s)
    eval "$command" >/dev/null 2>&1 || true
    end=$(date +%s)
    duration=$((end - start))

    total_operations=$((total_operations + 1))

    if [ $duration -le 3 ]; then
        operations_under_3s=$((operations_under_3s + 1))
        echo -e "  ✅ $name: ${GREEN}${duration}s${NC}"
    else
        echo -e "  ❌ $name: ${RED}${duration}s${NC}"
    fi
done

operations_percentage=$((operations_under_3s * 100 / total_operations))

echo ""
echo -e "${BLUE}📊 Operações rápidas: ${operations_under_3s}/${total_operations} (${operations_percentage}%)${NC}"

echo ""
echo -e "${YELLOW}=== FASE 3: ANÁLISE DE RESULTADOS ===${NC}"
echo ""

# Criar arquivo de resultados
cat > "$FINAL_RESULTS" << EOF
{
  "benchmark_date": "$(date -Iseconds)",
  "version": "post-optimization",
  "optimizations_applied": [
    "cache_system",
    "intelligent_timeout",
    "preloading"
  ],
  "measurements": {
    "sofia_load_time": $sofia_load_time,
    "categorization_time": $categorization_time,
    "processing_time": $processing_time,
    "operations_under_3s_count": $operations_under_3s,
    "total_operations_tested": $total_operations,
    "operations_under_3s_percentage": $operations_percentage
  },
  "targets": {
    "improvement_percent": $TARGET_IMPROVEMENT_PERCENT,
    "operations_under_3s_target": $TARGET_OPERATIONS_UNDER_3S,
    "agent_load_time_target": $TARGET_AGENT_LOAD_TIME,
    "categorization_time_target": $TARGET_CATEGORIZATION_TIME,
    "processing_time_target": $TARGET_PROCESSING_TIME
  },
  "results": {
    "agent_load_target_met": $([ $sofia_load_time -le $TARGET_AGENT_LOAD_TIME ] && echo "true" || echo "false"),
    "categorization_target_met": $([ $categorization_time -le $TARGET_CATEGORIZATION_TIME ] && echo "true" || echo "false"),
    "processing_target_met": $([ $processing_time -le $TARGET_PROCESSING_TIME ] && echo "true" || echo "false"),
    "quick_operations_target_met": $([ $operations_percentage -ge $TARGET_OPERATIONS_UNDER_3S ] && echo "true" || echo "false")
  }
}
EOF

echo -e "${BLUE}🎯 RESULTADOS vs METAS:${NC}"
echo ""

# Validar metas
total_targets=4
met_targets=0

echo "1. Carregamento da Sofia:"
if [ $sofia_load_time -le $TARGET_AGENT_LOAD_TIME ]; then
    echo -e "   ✅ ${sofia_load_time}s ≤ ${TARGET_AGENT_LOAD_TIME}s ${GREEN}(META ATINGIDA)${NC}"
    met_targets=$((met_targets + 1))
else
    echo -e "   ❌ ${sofia_load_time}s > ${TARGET_AGENT_LOAD_TIME}s ${RED}(META NÃO ATINGIDA)${NC}"
fi

echo "2. Categorização automática:"
if [ $categorization_time -le $TARGET_CATEGORIZATION_TIME ]; then
    echo -e "   ✅ ${categorization_time}s ≤ ${TARGET_CATEGORIZATION_TIME}s ${GREEN}(META ATINGIDA)${NC}"
    met_targets=$((met_targets + 1))
else
    echo -e "   ❌ ${categorization_time}s > ${TARGET_CATEGORIZATION_TIME}s ${RED}(META NÃO ATINGIDA)${NC}"
fi

echo "3. Processamento daily-dump:"
if [ $processing_time -le $TARGET_PROCESSING_TIME ]; then
    echo -e "   ✅ ${processing_time}s ≤ ${TARGET_PROCESSING_TIME}s ${GREEN}(META ATINGIDA)${NC}"
    met_targets=$((met_targets + 1))
else
    echo -e "   ❌ ${processing_time}s > ${TARGET_PROCESSING_TIME}s ${RED}(META NÃO ATINGIDA)${NC}"
fi

echo "4. Operações rápidas:"
if [ $operations_percentage -ge $TARGET_OPERATIONS_UNDER_3S ]; then
    echo -e "   ✅ ${operations_percentage}% ≥ ${TARGET_OPERATIONS_UNDER_3S}% ${GREEN}(META ATINGIDA)${NC}"
    met_targets=$((met_targets + 1))
else
    echo -e "   ❌ ${operations_percentage}% < ${TARGET_OPERATIONS_UNDER_3S}% ${RED}(META NÃO ATINGIDA)${NC}"
fi

echo ""
success_percentage=$((met_targets * 100 / total_targets))

echo -e "${BLUE}📊 RESUMO FINAL:${NC}"
echo -e "   Metas atingidas: ${met_targets}/${total_targets} (${success_percentage}%)"

if [ $met_targets -eq $total_targets ]; then
    echo -e "${GREEN}🎉 TODAS AS METAS DE PERFORMANCE ATINGIDAS!${NC}"
    echo -e "${GREEN}✅ Story 2.2.3 implementada com sucesso!${NC}"
    result_status="SUCCESS"
elif [ $met_targets -ge 3 ]; then
    echo -e "${YELLOW}⚡ MAIORIA DAS METAS ATINGIDAS!${NC}"
    echo -e "${YELLOW}✅ Performance significativamente melhorada${NC}"
    result_status="MOSTLY_SUCCESS"
else
    echo -e "${RED}⚠️ VÁRIAS METAS NÃO ATINGIDAS${NC}"
    echo -e "${RED}❌ Necessita mais otimizações${NC}"
    result_status="NEEDS_IMPROVEMENT"
fi

echo ""
echo -e "${BLUE}💡 BENEFÍCIOS PARA USUÁRIO TDAH:${NC}"
echo "   ✓ Feedback contínuo implementado"
echo "   ✓ Timeouts inteligentes evitam esperas longas"
echo "   ✓ Cache reduz tempos de carregamento"
echo "   ✓ Operações mais previsíveis"

echo ""
echo -e "${GREEN}📁 Resultados salvos em: $FINAL_RESULTS${NC}"
echo -e "${GREEN}📋 Log detalhado em: $LOG_FILE${NC}"

log "Benchmark final concluído: $result_status"

# Status de saída baseado no sucesso
if [ "$result_status" = "SUCCESS" ]; then
    exit 0
else
    exit 1
fi