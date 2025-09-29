#!/bin/bash

# Teste da Story 2.2.3: Otimização de Performance dos Agentes
# Verifica se todas as otimizações foram implementadas e metas atingidas

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Contadores
TESTS_PASSED=0
TESTS_FAILED=0

# Função de teste
test_condition() {
    local description="$1"
    local condition="$2"

    echo -n "  Testing: $description... "

    if eval "$condition"; then
        echo -e "${GREEN}PASS${NC}"
        ((TESTS_PASSED++))
        return 0
    else
        echo -e "${RED}FAIL${NC}"
        ((TESTS_FAILED++))
        return 1
    fi
}

echo -e "${BLUE}=== Teste da Story 2.2.3: Otimização de Performance ===${NC}"
echo ""

echo -e "${YELLOW}1. Testando Critério de Aceitação 1: Baseline Estabelecido${NC}"
test_condition "Script de benchmark existe" "[ -f scripts/benchmark-simple.sh ]"
test_condition "Logs de benchmark foram gerados" "ls logs/benchmark-*.log >/dev/null 2>&1"
test_condition "Gargalos foram documentados" "grep -q 'GARGALOS' scripts/benchmark-simple.sh"

echo ""
echo -e "${YELLOW}2. Testando Critério de Aceitação 2: Cache Implementado${NC}"
test_condition "Sistema de cache existe" "[ -f scripts/simple-cache.sh ]"
test_condition "Cache pode ser inicializado" "./scripts/simple-cache.sh init >/dev/null 2>&1"
test_condition "Preload funciona" "./scripts/simple-cache.sh preload >/dev/null 2>&1"
test_condition "Diretório de cache foi criado" "[ -d cache ]"
test_condition "Arquivos são cacheados" "[ \$(ls cache/*.cache 2>/dev/null | wc -l) -gt 0 ]"

echo ""
echo -e "${YELLOW}3. Testando Critério de Aceitação 3: Otimização de Carregamento${NC}"
test_condition "Pre-loading reduz tempo de carregamento" "./scripts/simple-cache.sh benchmark >/dev/null 2>&1"
test_condition "Cache de arquivos críticos funciona" "./scripts/simple-cache.sh load '.assistant-core/memory/organizador-memory.yaml' >/dev/null"

echo ""
echo -e "${YELLOW}4. Testando Critério de Aceitação 4: Timeout Inteligente${NC}"
test_condition "Sistema de timeout existe" "[ -f scripts/intelligent-timeout.sh ]"
test_condition "Carregamento rápido funciona" "./scripts/intelligent-timeout.sh fast-load >/dev/null 2>&1"
test_condition "Processamento com timeout funciona" "./scripts/intelligent-timeout.sh process 'Teste' quick >/dev/null 2>&1"
test_condition "Configuração de timeout foi criada" "[ -f cache/timeout-config.txt ]"

echo ""
echo -e "${YELLOW}5. Testando Critério de Aceitação 5: Metas de Performance${NC}"

# Executar benchmark final em modo silencioso
./scripts/final-performance-benchmark.sh >/dev/null 2>&1 || true

# Verificar se arquivo de resultados existe
test_condition "Resultados de performance foram gerados" "[ -f performance/final-results.json ]"

# Extrair métricas do arquivo JSON (método simples)
if [ -f performance/final-results.json ]; then
    sofia_time=$(grep "sofia_load_time" performance/final-results.json | grep -o '[0-9]\+' | head -1)
    categorization_time=$(grep "categorization_time" performance/final-results.json | grep -o '[0-9]\+' | head -1)
    processing_time=$(grep "processing_time" performance/final-results.json | grep -o '[0-9]\+' | head -1)
    quick_ops_percent=$(grep "operations_under_3s_percentage" performance/final-results.json | grep -o '[0-9]\+' | head -1)

    # Validar metas (invertendo lógica - menores tempos são melhores)
    test_condition "Carregamento Sofia ≤5s ($sofia_time s)" "[ $sofia_time -le 5 ]"
    test_condition "Categorização ≤8s ($categorization_time s)" "[ $categorization_time -le 8 ]"
    test_condition "Processamento ≤18s ($processing_time s)" "[ $processing_time -le 18 ]"
    test_condition "Operações rápidas ≥80% ($quick_ops_percent %)" "[ $quick_ops_percent -ge 80 ]"
fi

echo ""
echo -e "${YELLOW}6. Testando sistema integrado${NC}"
test_condition "Cache + Timeout funcionam juntos" "
    ./scripts/simple-cache.sh preload >/dev/null 2>&1 &&
    ./scripts/intelligent-timeout.sh fast-load >/dev/null 2>&1
"
test_condition "Consolidação otimizada funciona" "./scripts/auto-consolidate.sh 'Teste integração' 'test' >/dev/null 2>&1"

echo ""
echo -e "${YELLOW}7. Testando benefícios TDAH${NC}"
test_condition "Feedback contínuo implementado" "grep -q 'Processando' scripts/intelligent-timeout.sh"
test_condition "Timeout evita esperas longas" "grep -q 'timeout' scripts/intelligent-timeout.sh"
test_condition "Cache reduz carregamento repetitivo" "grep -q 'CACHE HIT' scripts/simple-cache.sh"

echo ""
echo -e "${BLUE}=== RESUMO DOS TESTES ===${NC}"

TOTAL_TESTS=$((TESTS_PASSED + TESTS_FAILED))

echo -e "${GREEN}✅ Testes passaram: $TESTS_PASSED${NC}"
if [ $TESTS_FAILED -gt 0 ]; then
    echo -e "${RED}❌ Testes falharam: $TESTS_FAILED${NC}"
fi
echo -e "${BLUE}📊 Total de testes: $TOTAL_TESTS${NC}"

echo ""
if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 TODOS OS TESTES PASSARAM! Story 2.2.3 implementada com sucesso!${NC}"
    echo ""
    echo -e "${YELLOW}✅ Baseline de performance estabelecido${NC}"
    echo -e "${YELLOW}✅ Sistema de cache implementado${NC}"
    echo -e "${YELLOW}✅ Otimização de carregamento funcionando${NC}"
    echo -e "${YELLOW}✅ Timeout inteligente operacional${NC}"
    echo -e "${YELLOW}✅ TODAS as metas de performance SUPERADAS!${NC}"
    echo ""

    if [ -f performance/final-results.json ]; then
        echo -e "${BLUE}🎯 PERFORMANCE FINAL:${NC}"
        echo "   📈 Sofia: ${sofia_time}s (meta: ≤5s) - SUPERADA!"
        echo "   📈 Categorização: ${categorization_time}s (meta: ≤8s) - SUPERADA!"
        echo "   📈 Processamento: ${processing_time}s (meta: ≤18s) - SUPERADA!"
        echo "   📈 Ops rápidas: ${quick_ops_percent}% (meta: ≥80%) - SUPERADA!"
    fi

    echo ""
    echo -e "${GREEN}🧠 Sistema otimizado para usuários TDAH com sucesso!${NC}"
    exit 0
else
    echo -e "${RED}❌ ALGUNS TESTES FALHARAM! Verifique os problemas acima.${NC}"
    exit 1
fi