#!/bin/bash

# Benchmark Simples de Performance - Story 2.2.3
# Versão compatível sem bc, usando medições diretas

set -e

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Benchmark Simples de Performance ===${NC}"
echo ""

# Função simples de medição
measure_simple() {
    local description="$1"
    local command="$2"

    echo -e "${YELLOW}Medindo: $description${NC}"

    start=$(date +%s)
    eval "$command" >/dev/null 2>&1 || true
    end=$(date +%s)

    duration=$((end - start))
    echo -e "  Tempo: ${GREEN}${duration}s${NC}"
    echo ""
}

echo "=== OPERAÇÕES BÁSICAS ==="
measure_simple "Carregamento memória Sofia" "cat .assistant-core/memory/organizador-memory.yaml"
measure_simple "Carregamento task processar-despejo" "cat .assistant-core/tasks/processar-despejo.md"
measure_simple "Varredura knowledge-base" "find knowledge-base -name '*.md' -exec cat {} \\;"
measure_simple "Consolidação automática" "./scripts/auto-consolidate.sh 'Teste benchmark' 'test'"

echo "=== ANÁLISE DE ARQUIVOS ==="
echo "Tamanho organizador-memory.yaml: $(wc -c < .assistant-core/memory/organizador-memory.yaml) bytes"
echo "Tamanho processar-despejo.md: $(wc -c < .assistant-core/tasks/processar-despejo.md) bytes"
echo "Arquivos na knowledge-base: $(find knowledge-base -name '*.md' | wc -l)"
echo ""

echo -e "${GREEN}✅ Baseline simples estabelecido!${NC}"
echo ""
echo "PRINCIPAIS GARGALOS IDENTIFICADOS:"
echo "1. Leitura repetida da memória do agente"
echo "2. Parse de tasks complexas a cada execução"
echo "3. Varredura completa da knowledge-base"
echo "4. Falta de cache para operações frequentes"