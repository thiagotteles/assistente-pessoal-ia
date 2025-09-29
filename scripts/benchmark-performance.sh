#!/bin/bash

# Benchmark de Performance dos Agentes - Story 2.2.3
# Mede tempos de resposta atuais para estabelecer baseline

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configurações
LOG_FILE="logs/benchmark-$(date +"%Y%m%d_%H%M%S").log"
RESULTS_FILE="performance/baseline-results.json"
ITERATIONS=3

# Função de log
log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Função para medir tempo de execução
measure_time() {
    local description="$1"
    local command="$2"
    local total_time=0

    echo -e "${YELLOW}Medindo: $description${NC}"

    for i in $(seq 1 $ITERATIONS); do
        echo -n "  Iteração $i/$ITERATIONS... "

        start_time=$(date +%s.%N)
        eval "$command" >/dev/null 2>&1 || true
        end_time=$(date +%s.%N)

        iteration_time=$(echo "$end_time - $start_time" | bc -l)
        total_time=$(echo "$total_time + $iteration_time" | bc -l)

        echo -e "${GREEN}${iteration_time}s${NC}"
        log "$description - Iteração $i: ${iteration_time}s"
    done

    avg_time=$(echo "scale=3; $total_time / $ITERATIONS" | bc -l)
    echo -e "${BLUE}  Média: ${avg_time}s${NC}"
    log "$description - Média: ${avg_time}s"

    echo "$avg_time"
}

echo -e "${BLUE}=== Benchmark de Performance dos Agentes - Story 2.2.3 ===${NC}"
echo "Log: $LOG_FILE"
echo ""

# Criar diretórios necessários
mkdir -p logs performance temp

log "Iniciando benchmark de performance"

echo -e "${YELLOW}=== FASE 1: BASELINE DO SISTEMA DE ARQUIVOS ===${NC}"
echo ""

# 1. Tempo de leitura da memória do organizador
memory_time=$(measure_time "Leitura de organizador-memory.yaml" "cat .assistant-core/memory/organizador-memory.yaml")

# 2. Tempo de carregamento de task completa
task_time=$(measure_time "Leitura de processar-despejo.md" "cat .assistant-core/tasks/processar-despejo.md")

# 3. Tempo de carregamento de templates
template_time=$(measure_time "Leitura de templates YAML" "find .assistant-core/templates -name '*.yaml' -exec cat {} \\;")

# 4. Tempo de leitura da knowledge-base completa
kb_time=$(measure_time "Varredura completa da knowledge-base" "find knowledge-base -name '*.md' -exec cat {} \\;")

# 5. Tempo de leitura do daily-dump
dump_time=$(measure_time "Leitura do daily-dump.txt" "cat despejo/daily-dump.txt")

echo ""
echo -e "${YELLOW}=== FASE 2: OPERAÇÕES COMPOSTAS ===${NC}"
echo ""

# 6. Tempo simulado de carregamento completo do agente
agent_load_time=$(measure_time "Simulação carregamento completo agente" "
    cat .assistant-core/agents/organizador.md &&
    cat .assistant-core/memory/organizador-memory.yaml &&
    cat .assistant-core/tasks/processar-despejo.md
")

# 7. Tempo simulado de processamento de uma entrada
process_entry_time=$(measure_time "Simulação processamento entrada daily-dump" "
    cat despejo/daily-dump.txt | head -5 &&
    cat .assistant-core/templates/entrada-categorizada.yaml &&
    ls knowledge-base/pessoas/ &&
    ls knowledge-base/projetos/
")

# 8. Tempo de consolidação usando auto-consolidate
consolidate_time=$(measure_time "Consolidação automática (scripts/auto-consolidate.sh)" "
    ./scripts/auto-consolidate.sh 'Teste de performance benchmark' 'benchmark'
")

echo ""
echo -e "${YELLOW}=== FASE 3: ANÁLISE DE GARGALOS ===${NC}"
echo ""

# Identificar arquivos grandes
echo "Analisando tamanhos de arquivos críticos:"
echo "organizador-memory.yaml: $(wc -c < .assistant-core/memory/organizador-memory.yaml) bytes"
echo "processar-despejo.md: $(wc -c < .assistant-core/tasks/processar-despejo.md) bytes"
echo "daily-dump.txt: $(wc -c < despejo/daily-dump.txt) bytes"

# Contar arquivos na knowledge-base
kb_files=$(find knowledge-base -name "*.md" | wc -l)
echo "Arquivos na knowledge-base: $kb_files"

# Identificar diretórios com mais arquivos
echo "Diretórios com mais arquivos:"
find knowledge-base -type d -exec sh -c 'echo "$(find "$1" -maxdepth 1 -name "*.md" | wc -l) $1"' _ {} \; | sort -nr | head -5

echo ""
echo -e "${BLUE}=== RESULTADOS DO BASELINE ===${NC}"

# Criar arquivo JSON com resultados
cat > "$RESULTS_FILE" << EOF
{
  "baseline_date": "$(date -Iseconds)",
  "version": "pre-optimization",
  "measurements": {
    "memory_load_time": $memory_time,
    "task_load_time": $task_time,
    "template_load_time": $template_time,
    "knowledge_base_scan_time": $kb_time,
    "daily_dump_read_time": $dump_time,
    "agent_full_load_time": $agent_load_time,
    "entry_processing_time": $process_entry_time,
    "consolidation_time": $consolidate_time
  },
  "system_metrics": {
    "knowledge_base_files": $kb_files,
    "memory_file_size": $(wc -c < .assistant-core/memory/organizador-memory.yaml),
    "task_file_size": $(wc -c < .assistant-core/tasks/processar-despejo.md),
    "daily_dump_size": $(wc -c < despejo/daily-dump.txt)
  },
  "performance_targets": {
    "agent_load_time_target": 5.0,
    "entry_processing_target": 8.0,
    "consolidation_target": 3.0,
    "improvement_goal_percent": 60
  }
}
EOF

echo ""
echo -e "${GREEN}📊 BASELINE ESTABELECIDO:${NC}"
echo -e "${YELLOW}  Carregamento da memória: ${memory_time}s${NC}"
echo -e "${YELLOW}  Carregamento de task: ${task_time}s${NC}"
echo -e "${YELLOW}  Carregamento de templates: ${template_time}s${NC}"
echo -e "${YELLOW}  Varredura knowledge-base: ${kb_time}s${NC}"
echo -e "${YELLOW}  Leitura daily-dump: ${dump_time}s${NC}"
echo ""
echo -e "${BLUE}🎯 OPERAÇÕES COMPLEXAS:${NC}"
echo -e "${YELLOW}  Carregamento completo agente: ${agent_load_time}s${NC}"
echo -e "${YELLOW}  Processamento de entrada: ${process_entry_time}s${NC}"
echo -e "${YELLOW}  Consolidação automática: ${consolidate_time}s${NC}"
echo ""
echo -e "${RED}🚨 GARGALOS IDENTIFICADOS:${NC}"

# Análise automática de gargalos
if (( $(echo "$kb_time > 2.0" | bc -l) )); then
    echo -e "${RED}  ❌ Knowledge-base scan muito lento (${kb_time}s > 2.0s)${NC}"
fi

if (( $(echo "$agent_load_time > 5.0" | bc -l) )); then
    echo -e "${RED}  ❌ Carregamento de agente lento (${agent_load_time}s > 5.0s)${NC}"
fi

if (( $(echo "$process_entry_time > 8.0" | bc -l) )); then
    echo -e "${RED}  ❌ Processamento de entrada lento (${process_entry_time}s > 8.0s)${NC}"
fi

echo ""
echo -e "${GREEN}✅ Baseline salvo em: $RESULTS_FILE${NC}"
echo -e "${GREEN}✅ Log detalhado em: $LOG_FILE${NC}"

log "Baseline concluído. Próximo: implementar otimizações."

echo ""
echo -e "${BLUE}🎯 PRÓXIMOS PASSOS PARA OTIMIZAÇÃO:${NC}"
echo "1. Implementar cache de arquivos frequentes"
echo "2. Pre-loading de dados críticos"
echo "3. Otimização de parsing YAML"
echo "4. Sistema de timeout inteligente"
echo "5. Re-executar benchmark pós-otimização"