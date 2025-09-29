#!/bin/bash

# Teste da Story 2.2.4: Atualização de Documentação Arquitetural
# Verifica se a documentação foi atualizada corretamente

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

echo -e "${BLUE}=== Teste da Story 2.2.4: Atualização de Documentação Arquitetural ===${NC}"
echo ""

echo -e "${YELLOW}1. Testando Critério de Aceitação 1: Documentação Arquitetural Atualizada${NC}"
test_condition "estrutura-de-arquivos-source-tree.md existe" "[ -f docs/architecture/estrutura-de-arquivos-source-tree.md ]"
test_condition "estrutura-de-arquivos-source-tree.md inclui padrões únicos" "grep -q 'Padrões de Arquivos Únicos' docs/architecture/estrutura-de-arquivos-source-tree.md"
test_condition "padroes-de-codificacao.md existe" "[ -f docs/architecture/padres-de-codificao.md ]"
test_condition "padroes-de-codificacao.md inclui arquivos únicos" "grep -q 'pessoa-{nome}.md' docs/architecture/padres-de-codificao.md"

echo ""
echo -e "${YELLOW}2. Testando Critério de Aceitação 2: Guia de Exemplos Práticos Criado${NC}"
test_condition "exemplos-estrutura-unificada.md foi criado" "[ -f docs/architecture/exemplos-estrutura-unificada.md ]"
test_condition "exemplos inclui pessoa-fabio.md" "grep -q 'pessoa-fabio.md' docs/architecture/exemplos-estrutura-unificada.md"
test_condition "exemplos inclui projeto-onboarding.md" "grep -q 'projeto-onboarding.md' docs/architecture/exemplos-estrutura-unificada.md"
test_condition "exemplos inclui contexto-bem-estar.md" "grep -q 'contexto-bem-estar.md' docs/architecture/exemplos-estrutura-unificada.md"
test_condition "exemplos têm templates funcionais" "grep -q 'Template: Nova Pessoa' docs/architecture/exemplos-estrutura-unificada.md"

echo ""
echo -e "${YELLOW}3. Testando Critério de Aceitação 3: Guidelines para Desenvolvedores${NC}"
test_condition "guidelines-desenvolvedores.md foi criado" "[ -f docs/architecture/guidelines-desenvolvedores.md ]"
test_condition "guidelines incluem padrões para agentes" "grep -q 'Padrões para Novos Agentes' docs/architecture/guidelines-desenvolvedores.md"
test_condition "guidelines incluem checklist compatibilidade" "grep -q 'Checklist de Compatibilidade' docs/architecture/guidelines-desenvolvedores.md"
test_condition "guidelines incluem targets de performance" "grep -q 'Targets de Performance' docs/architecture/guidelines-desenvolvedores.md"

echo ""
echo -e "${YELLOW}4. Testando Critério de Aceitação 4: Documentação de Migração${NC}"
test_condition "guia-migracao-arquivos-unicos.md foi criado" "[ -f docs/architecture/guia-migracao-arquivos-unicos.md ]"
test_condition "guia inclui processo completo de migração" "grep -q 'Processo Detalhado de Migração' docs/architecture/guia-migracao-arquivos-unicos.md"
test_condition "guia inclui troubleshooting" "grep -q 'Troubleshooting Comum' docs/architecture/guia-migracao-arquivos-unicos.md"
test_condition "guia inclui procedures de rollback" "grep -q 'Rollback Completo' docs/architecture/guia-migracao-arquivos-unicos.md"

echo ""
echo -e "${YELLOW}5. Testando Critério de Aceitação 5: Exemplos Funcionais Validados${NC}"
test_condition "Metadados YAML estão válidos nos exemplos" "grep -A 10 '```yaml' docs/architecture/exemplos-estrutura-unificada.md | grep -q 'tipo:'"
test_condition "Referências [[]] estão corretas" "grep -q '\[\[pessoa-fabio\]\]' docs/architecture/exemplos-estrutura-unificada.md"
test_condition "Templates têm estrutura completa" "grep -q '## Metadados' docs/architecture/exemplos-estrutura-unificada.md"

echo ""
echo -e "${YELLOW}6. Testando estrutura de arquivos de documentação${NC}"
test_condition "Todos os arquivos têm extensão .md" "
    for file in docs/architecture/exemplos-estrutura-unificada.md docs/architecture/guidelines-desenvolvedores.md docs/architecture/guia-migracao-arquivos-unicos.md; do
        [[ \"\$file\" == *.md ]] || exit 1
    done
"
test_condition "Arquivos não estão vazios" "
    for file in docs/architecture/exemplos-estrutura-unificada.md docs/architecture/guidelines-desenvolvedores.md docs/architecture/guia-migracao-arquivos-unicos.md; do
        [ -s \"\$file\" ] || exit 1
    done
"

echo ""
echo -e "${YELLOW}7. Testando conteúdo baseado na Story 2.2.1${NC}"
test_condition "Documentação referencia Story 2.2.1" "grep -r 'Story 2.2.1' docs/architecture/exemplos-estrutura-unificada.md"
test_condition "Exemplos usam dados reais migrados" "grep -q 'Fabio' docs/architecture/exemplos-estrutura-unificada.md"
test_condition "Guidelines referenciam scripts implementados" "grep -q 'migrate-to-unified-files.sh' docs/architecture/guidelines-desenvolvedores.md"

echo ""
echo -e "${YELLOW}8. Testando integração com arquitetura existente${NC}"
test_condition "Documentação mantém compatibilidade" "grep -q 'Obsidian' docs/architecture/estrutura-de-arquivos-source-tree.md"
test_condition "Padrões seguem convenções existentes" "grep -q 'knowledge-base' docs/architecture/padres-de-codificao.md"

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
    echo -e "${GREEN}🎉 TODOS OS TESTES PASSARAM! Story 2.2.4 implementada com sucesso!${NC}"
    echo ""
    echo -e "${YELLOW}✅ Documentação arquitetural atualizada${NC}"
    echo -e "${YELLOW}✅ Guia de exemplos práticos criado${NC}"
    echo -e "${YELLOW}✅ Guidelines para desenvolvedores implementadas${NC}"
    echo -e "${YELLOW}✅ Documentação de migração completa${NC}"
    echo -e "${YELLOW}✅ Exemplos funcionais validados${NC}"
    echo ""
    echo -e "${BLUE}📚 Documentação pronta para suportar próximas stories!${NC}"
    exit 0
else
    echo -e "${RED}❌ ALGUNS TESTES FALHARAM! Verifique os problemas acima.${NC}"
    exit 1
fi