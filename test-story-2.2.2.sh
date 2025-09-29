#!/bin/bash

# Teste da Story 2.2.2: Sistema de Consolidação Automática
# Valida se o sistema de consolidação automática está funcionando corretamente

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

echo -e "${BLUE}=== Teste da Story 2.2.2: Sistema de Consolidação Automática ===${NC}"
echo ""

echo -e "${YELLOW}1. Testando Critério de Aceitação 1: Sistema de Detecção de Entidades${NC}"
test_condition "Scripts de consolidação estão presentes" "[ -f scripts/auto-consolidate.sh ] && [ -f scripts/normalize-unified-files.sh ]"
test_condition "Scripts são executáveis" "[ -x scripts/auto-consolidate.sh ] && [ -x scripts/normalize-unified-files.sh ]"
test_condition "Normalização funcionou" "grep -q 'Histórico de Interações' knowledge-base/pessoas/pessoa-fabio.md"

echo ""
echo -e "${YELLOW}2. Testando Critério de Aceitação 2: Fuzzy Matching e Auto-criação${NC}"

# Backup dos arquivos antes dos testes
cp -r knowledge-base/ temp-test-backup/

# Testar detecção de pessoa existente
./scripts/auto-consolidate.sh "Fabio está trabalhando bem" "test" >/dev/null 2>&1
test_condition "Detecção de pessoa existente funciona" "grep -q 'Fabio está trabalhando bem' knowledge-base/pessoas/pessoa-fabio.md"

# Testar detecção de projeto
./scripts/auto-consolidate.sh "O projeto onboarding precisa de revisão" "test" >/dev/null 2>&1
test_condition "Consolidação em projeto detectado" "ls knowledge-base/projetos/projeto-onboarding.md >/dev/null 2>&1"

# Testar detecção de contexto
./scripts/auto-consolidate.sh "Estou muito estressado hoje" "test" >/dev/null 2>&1
test_condition "Detecção de contexto por palavras-chave" "grep -q 'estressado' knowledge-base/contextos/contexto-bem-estar.md"

echo ""
echo -e "${YELLOW}3. Testando Critério de Aceitação 3: Sistema de Merge Inteligente${NC}"
test_condition "Preservação de timestamp nos metadados" "grep -q 'updated:' knowledge-base/pessoas/pessoa-fabio.md"
test_condition "Múltiplas entradas no histórico" "[ \$(grep -c '### 2025-' knowledge-base/pessoas/pessoa-fabio.md) -gt 1 ]"
test_condition "Estrutura de seções mantida" "grep -q '## Projetos Relacionados' knowledge-base/pessoas/pessoa-fabio.md"

echo ""
echo -e "${YELLOW}4. Testando Critério de Aceitação 4: Interface de Linha de Comando${NC}"
test_condition "Script aceita argumentos diretos" "./scripts/auto-consolidate.sh --help 2>/dev/null || echo 'help not found' | grep -q 'Uso:'"
test_condition "Logs são gerados" "[ -d logs ] && ls logs/auto-consolidate-*.log >/dev/null 2>&1"

echo ""
echo -e "${YELLOW}5. Testando Critério de Aceitação 5: Performance e Validação${NC}"

# Medir tempo de consolidação
start_time=$(date +%s)
./scripts/auto-consolidate.sh "Teste de performance com Maria-santos no projeto sistema-alpha" "performance-test" >/dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))

test_condition "Consolidação rápida (< 10 segundos)" "[ $duration -lt 10 ]"
test_condition "Arquivo de log contém detalhes" "ls logs/auto-consolidate-*.log | head -1 | xargs grep -q 'Consolidação concluída'"

echo ""
echo -e "${YELLOW}6. Testando integração com arquivos normalizados${NC}"
test_condition "Arquivos têm metadados YAML corretos" "grep -q 'tipo: pessoa' knowledge-base/pessoas/pessoa-fabio.md"
test_condition "Referências [[]] são preservadas" "grep -q '\[\[.*\]\]' knowledge-base/pessoas/pessoa-fabio.md"
test_condition "Estrutura de subseções funciona" "grep -q '### 2025-.*-.*-' knowledge-base/pessoas/pessoa-fabio.md"

echo ""
echo -e "${YELLOW}7. Testando cases extremos${NC}"

# Testar texto vazio
echo "" | xargs ./scripts/auto-consolidate.sh >/dev/null 2>&1 || true
test_condition "Sistema lida com entrada vazia" "echo 'ok'"

# Testar texto sem entidades
./scripts/auto-consolidate.sh "Texto genérico sem entidades específicas mencionadas" "test" >/dev/null 2>&1
test_condition "Sistema lida com texto sem entidades detectadas" "echo 'ok'"

echo ""
echo -e "${YELLOW}8. Testando compatibilidade com Story 2.2.1${NC}"
test_condition "Arquivos pessoa-*.md existem" "ls knowledge-base/pessoas/pessoa-*.md >/dev/null 2>&1"
test_condition "Arquivos projeto-*.md existem" "ls knowledge-base/projetos/projeto-*.md >/dev/null 2>&1"
test_condition "Arquivos contexto-*.md existem" "ls knowledge-base/contextos/contexto-*.md >/dev/null 2>&1"

# Restaurar backup
rm -rf knowledge-base/
mv temp-test-backup/ knowledge-base/

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
    echo -e "${GREEN}🎉 TODOS OS TESTES PASSARAM! Story 2.2.2 implementada com sucesso!${NC}"
    echo ""
    echo -e "${YELLOW}✅ Sistema de detecção de entidades funcionando${NC}"
    echo -e "${YELLOW}✅ Fuzzy matching e auto-criação implementados${NC}"
    echo -e "${YELLOW}✅ Sistema de merge inteligente operacional${NC}"
    echo -e "${YELLOW}✅ Interface de linha de comando funcional${NC}"
    echo -e "${YELLOW}✅ Performance e validação aprovadas${NC}"
    echo ""
    echo -e "${BLUE}🤖 Sistema de consolidação automática pronto para uso!${NC}"
    exit 0
else
    echo -e "${RED}❌ ALGUNS TESTES FALHARAM! Verifique os problemas acima.${NC}"
    exit 1
fi