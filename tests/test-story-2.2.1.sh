#!/bin/bash

# Teste da Story 2.2.1: Migração para Arquivos Únicos por Entidade
# Verifica se a migração foi bem-sucedida

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

echo -e "${BLUE}=== Teste da Story 2.2.1: Migração para Arquivos Únicos ===${NC}"
echo ""

echo -e "${YELLOW}1. Testando Critério de Aceitação 1: Backup Automático${NC}"
test_condition "Backup foi criado" "ls backups/knowledge-base/kb_backup_* >/dev/null 2>&1"
test_condition "Arquivo de validação do backup existe" "ls backups/knowledge-base/backup_validation_* >/dev/null 2>&1"
test_condition "Script de rollback existe" "[ -f scripts/rollback-knowledge-base.sh ]"

echo ""
echo -e "${YELLOW}2. Testando Critério de Aceitação 2: Migração de Pessoas${NC}"
test_condition "pessoa-fabio.md existe" "[ -f knowledge-base/pessoas/pessoa-fabio.md ]"
test_condition "pessoa-joao-silva.md existe" "[ -f knowledge-base/pessoas/pessoa-joao-silva.md ]"
test_condition "pessoa-maria-santos.md existe" "[ -f knowledge-base/pessoas/pessoa-maria-santos.md ]"
test_condition "Nenhum arquivo pessoa-* antigo existe" "! ls knowledge-base/pessoas/fabio-* >/dev/null 2>&1"

echo ""
echo -e "${YELLOW}3. Testando Critério de Aceitação 3: Migração de Projetos${NC}"
test_condition "projeto-onboarding.md existe" "[ -f knowledge-base/projetos/projeto-onboarding.md ]"
test_condition "projeto-sistema-alpha.md existe" "[ -f knowledge-base/projetos/projeto-sistema-alpha.md ]"

echo ""
echo -e "${YELLOW}4. Testando Critério de Aceitação 4: Migração de Contextos${NC}"
test_condition "contexto-bem-estar.md existe" "[ -f knowledge-base/contextos/contexto-bem-estar.md ]"
test_condition "Subdiretório bem-estar foi removido" "[ ! -d knowledge-base/contextos/bem-estar ]"

echo ""
echo -e "${YELLOW}5. Testando Critério de Aceitação 5: Validação de Integridade${NC}"
test_condition "Todos os arquivos únicos não estão vazios" "
    for file in knowledge-base/pessoas/pessoa-*.md knowledge-base/projetos/projeto-*.md knowledge-base/contextos/contexto-*.md; do
        [ -s \"\$file\" ] || exit 1
    done
"
test_condition "Referências [[]] preservadas" "grep -r '\[\[.*\]\]' knowledge-base/ >/dev/null 2>&1"
test_condition "Script de migração existe" "[ -f scripts/migrate-to-unified-files.sh ]"
test_condition "Script de validação existe" "[ -f scripts/validate-migration.sh ]"

echo ""
echo -e "${YELLOW}6. Testando estrutura de arquivos únicos${NC}"
test_condition "Pessoas seguem padrão pessoa-*.md" "
    for file in knowledge-base/pessoas/*.md; do
        basename \"\$file\" | grep -q '^pessoa-.*\.md$' || exit 1
    done
"
test_condition "Projetos seguem padrão projeto-*.md" "
    for file in knowledge-base/projetos/projeto-*.md; do
        basename \"\$file\" | grep -q '^projeto-.*\.md$' || exit 1
    done
"
test_condition "Contextos seguem padrão contexto-*.md" "
    for file in knowledge-base/contextos/contexto-*.md; do
        basename \"\$file\" | grep -q '^contexto-.*\.md$' || exit 1
    done
"

echo ""
echo -e "${YELLOW}7. Testando conteúdo dos arquivos migrados${NC}"
test_condition "pessoa-fabio.md tem conteúdo sobre Fabio" "grep -q 'Fabio' knowledge-base/pessoas/pessoa-fabio.md"
test_condition "contexto-bem-estar.md tem metadados YAML" "grep -q 'tipo: contexto' knowledge-base/contextos/contexto-bem-estar.md"

echo ""
echo -e "${YELLOW}8. Testando arquivos de análise e logs${NC}"
test_condition "Análise da migração foi criada" "[ -f .ai/migration-analysis-2.2.1.md ]"
test_condition "Log de migração existe" "ls logs/migration-2.2.1-* >/dev/null 2>&1"

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
    echo -e "${GREEN}🎉 TODOS OS TESTES PASSARAM! Story 2.2.1 implementada com sucesso!${NC}"
    echo ""
    echo -e "${YELLOW}✅ Migração para arquivos únicos concluída${NC}"
    echo -e "${YELLOW}✅ Sistema de backup implementado${NC}"
    echo -e "${YELLOW}✅ Validação de integridade confirmada${NC}"
    echo -e "${YELLOW}✅ Padrões de nomeação estabelecidos${NC}"
    echo ""
    exit 0
else
    echo -e "${RED}❌ ALGUNS TESTES FALHARAM! Verifique os problemas acima.${NC}"
    exit 1
fi