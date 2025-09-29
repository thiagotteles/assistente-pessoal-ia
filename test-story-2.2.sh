#!/bin/bash

# Test Suite para Story 2.2 - Agente Secretária Executiva Completa
# Valida implementação de todos os critérios de aceitação

set -e

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Contadores
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Função para logging
log() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

success() {
    echo -e "${GREEN}[✓ PASS]${NC} $1"
    ((TESTS_PASSED++))
}

fail() {
    echo -e "${RED}[✗ FAIL]${NC} $1"
    ((TESTS_FAILED++))
}

warn() {
    echo -e "${YELLOW}[⚠ WARN]${NC} $1"
}

run_test() {
    ((TESTS_RUN++))
    echo -e "${BLUE}[TEST $TESTS_RUN]${NC} $1"
}

# Função para verificar se arquivo existe e tem conteúdo
check_file_exists() {
    local file="$1"
    local description="$2"

    if [ -f "$file" ]; then
        if [ -s "$file" ]; then
            success "Arquivo $description existe e tem conteúdo: $file"
            return 0
        else
            fail "Arquivo $description existe mas está vazio: $file"
            return 1
        fi
    else
        fail "Arquivo $description não encontrado: $file"
        return 1
    fi
}

# Função para verificar conteúdo específico em arquivo
check_file_content() {
    local file="$1"
    local pattern="$2"
    local description="$3"

    if [ -f "$file" ]; then
        if grep -q "$pattern" "$file"; then
            success "$description: padrão '$pattern' encontrado em $file"
            return 0
        else
            fail "$description: padrão '$pattern' NÃO encontrado em $file"
            return 1
        fi
    else
        fail "$description: arquivo $file não existe"
        return 1
    fi
}

echo "=================================================================="
echo "🧪 TESTE DA STORY 2.2 - SECRETÁRIA EXECUTIVA DIGITAL"
echo "=================================================================="
echo

# TESTE 1: Configuração Base do Agente (AC1)
echo "📋 BLOCO 1: CONFIGURAÇÃO BASE DO AGENTE SECRETÁRIA"
echo "--------------------------------------------------"

run_test "Verificar arquivo de configuração YAML da secretária"
check_file_exists ".assistant-core/agents/secretaria.yaml" "configuração YAML"

run_test "Verificar arquivo de agente conversacional da secretária"
check_file_exists ".assistant-core/agents/secretaria.md" "agente conversacional"

run_test "Verificar configuração de personalidade executiva"
check_file_content ".assistant-core/agents/secretaria.yaml" "executiva-eficiente" "personalidade executiva"

run_test "Verificar sistema de memória contextual"
check_file_exists ".assistant-core/memory/secretaria-memory.yaml" "memória contextual"

run_test "Verificar template de reunião expandido"
check_file_exists ".assistant-core/templates/reuniao-resumo.yaml" "template de reunião"
check_file_content ".assistant-core/templates/reuniao-resumo.yaml" "version.*2.0" "versão atualizada do template"

echo

# TESTE 2: Dashboard Executivo e Tasks (AC1, AC2)
echo "📊 BLOCO 2: DASHBOARD EXECUTIVO E STATUS DE PROJETOS"
echo "----------------------------------------------------"

run_test "Verificar task de agenda do dia"
check_file_exists ".assistant-core/tasks/agenda-do-dia.md" "task agenda do dia"

run_test "Verificar task de status de projetos"
check_file_exists ".assistant-core/tasks/status-projetos.md" "task status projetos"

run_test "Verificar integração com arquivos projeto-*.md"
check_file_content ".assistant-core/tasks/agenda-do-dia.md" "projeto-\*.md" "leitura de arquivos projeto"

run_test "Verificar detecção de projetos sem atividade"
check_file_content ".assistant-core/tasks/status-projetos.md" "atividade.*dias" "detecção inatividade"

run_test "Verificar alertas sobre deadlines"
check_file_content ".assistant-core/tasks/agenda-do-dia.md" "deadline\|prazo" "alertas de prazo"

echo

# TESTE 3: Sistema de Registro de Reuniões (AC3)
echo "🤝 BLOCO 3: SISTEMA DE REGISTRO DE REUNIÕES"
echo "-------------------------------------------"

run_test "Verificar task de registro de reunião"
check_file_exists ".assistant-core/tasks/registro-reuniao.md" "task registro reunião"

run_test "Verificar parsing de texto livre"
check_file_content ".assistant-core/tasks/registro-reuniao.md" "texto livre\|transcrição" "parsing texto livre"

run_test "Verificar extração automática de todos"
check_file_content ".assistant-core/tasks/registro-reuniao.md" "todos.*extrair" "extração de todos"

run_test "Verificar identificação de participantes [[]]"
check_file_content ".assistant-core/tasks/registro-reuniao.md" "\[\[pessoa-" "identificação participantes"

run_test "Verificar integração com arquivos únicos pessoa-*.md"
check_file_content ".assistant-core/tasks/registro-reuniao.md" "pessoa-\*.md" "integração pessoa únicos"

echo

# TESTE 4: Funcionalidades What's Next (AC4)
echo "🎯 BLOCO 4: FUNCIONALIDADES WHAT'S NEXT E PRIORIZAÇÃO"
echo "-----------------------------------------------------"

run_test "Verificar task What's Next"
check_file_exists ".assistant-core/tasks/whats-next.md" "task What's Next"

run_test "Verificar algoritmo de priorização"
check_file_content ".assistant-core/tasks/whats-next.md" "matriz.*2x2\|urgência.*impacto" "matriz priorização"

run_test "Verificar detecção de sobrecarga"
check_file_content ".assistant-core/tasks/whats-next.md" "sobrecarga" "detecção sobrecarga"

run_test "Verificar integração com central-todos.md"
check_file_content ".assistant-core/tasks/whats-next.md" "central-todos.md" "integração central todos"

echo

# TESTE 5: Processamento de Calendário (AC5)
echo "📅 BLOCO 5: PROCESSAMENTO DE CALENDÁRIO VIA TEXTO"
echo "-------------------------------------------------"

run_test "Verificar task de processamento de calendário"
check_file_exists ".assistant-core/tasks/processar-calendario.md" "task calendário"

run_test "Verificar parser de datas em português"
check_file_content ".assistant-core/tasks/processar-calendario.md" "português\|15.*março\|amanhã" "parser português"

run_test "Verificar detecção de conflitos"
check_file_content ".assistant-core/tasks/processar-calendario.md" "conflito" "detecção conflitos"

run_test "Verificar suporte a eventos recorrentes"
check_file_content ".assistant-core/tasks/processar-calendario.md" "recorrente\|toda.*segunda" "eventos recorrentes"

echo

# TESTE 6: Relatórios Executivos (AC6)
echo "📈 BLOCO 6: RELATÓRIOS EXECUTIVOS AUTOMÁTICOS"
echo "---------------------------------------------"

run_test "Verificar task de relatório executivo"
check_file_exists ".assistant-core/tasks/relatorio-executivo.md" "task relatório"

run_test "Verificar geração sob demanda"
check_file_content ".assistant-core/tasks/relatorio-executivo.md" "sob demanda" "geração sob demanda"

run_test "Verificar análise de padrões"
check_file_content ".assistant-core/tasks/relatorio-executivo.md" "padrão" "análise padrões"

run_test "Verificar recomendações automáticas"
check_file_content ".assistant-core/tasks/relatorio-executivo.md" "recomendações" "recomendações automáticas"

echo

# TESTE 7: Integração Geral e Compatibilidade
echo "🔗 BLOCO 7: INTEGRAÇÃO E COMPATIBILIDADE"
echo "----------------------------------------"

run_test "Verificar compatibilidade com arquivos únicos"
projects_count=$(ls knowledge-base/projetos/projeto-*.md 2>/dev/null | wc -l || echo 0)
if [ $projects_count -gt 0 ]; then
    success "Encontrados $projects_count arquivos de projeto únicos compatíveis"
else
    fail "Nenhum arquivo projeto-*.md encontrado para testar compatibilidade"
fi

run_test "Verificar integração com Knowledge-Base Manager"
if grep -q "knowledge-base.*manager\|Knowledge-Base Manager" .assistant-core/tasks/*.md; then
    success "Referências ao Knowledge-Base Manager encontradas nas tasks"
else
    fail "Nenhuma referência ao Knowledge-Base Manager encontrada"
fi

run_test "Verificar cross-referencing automático"
ref_count=$(grep -c "\[\[pessoa-\|\[\[projeto-" .assistant-core/tasks/*.md 2>/dev/null || echo 0)
if [ $ref_count -gt 5 ]; then
    success "Cross-referencing automático implementado ($ref_count referências)"
else
    fail "Insuficientes referências [[]] automáticas encontradas ($ref_count)"
fi

echo

# TESTE 8: Performance e TDAH
echo "⚡ BLOCO 8: PERFORMANCE E OTIMIZAÇÕES TDAH"
echo "------------------------------------------"

run_test "Verificar requisitos de performance TDAH"
tdah_count=$(grep -c "TDAH\|3 segundos\|3s\|overwhelm" .assistant-core/tasks/*.md .assistant-core/agents/secretaria.* 2>/dev/null || echo 0)
if [ $tdah_count -gt 3 ]; then
    success "Otimizações TDAH implementadas ($tdah_count menções)"
else
    fail "Insuficientes otimizações TDAH ($tdah_count menções)"
fi

run_test "Verificar feedback de progresso visual"
if grep -q "visual\|feedback\|progress" .assistant-core/tasks/*.md; then
    success "Feedback visual implementado"
else
    warn "Feedback visual pode estar limitado"
fi

echo

# TESTE 9: Estrutura de Comandos do Agente
echo "🤖 BLOCO 9: ESTRUTURA DE COMANDOS DO AGENTE"
echo "-------------------------------------------"

run_test "Verificar comandos disponíveis na secretária"
commands_count=$(grep -c "- help:\|- agenda:\|- projetos:\|- reuniao:\|- proximos:\|- calendario:\|- relatorio:" .assistant-core/agents/secretaria.md 2>/dev/null || echo 0)
if [ $commands_count -ge 6 ]; then
    success "Comandos da secretária implementados ($commands_count comandos)"
else
    fail "Comandos insuficientes implementados ($commands_count de 7 esperados)"
fi

run_test "Verificar definição de persona Beatriz"
if grep -q "name.*Beatriz\|Secretária.*Executiva" .assistant-core/agents/secretaria.md; then
    success "Persona Beatriz definida corretamente"
else
    fail "Persona Beatriz não encontrada na definição"
fi

echo

# TESTE 10: Validação Final de Integração
echo "✅ BLOCO 10: VALIDAÇÃO FINAL"
echo "----------------------------"

run_test "Verificar atualização do script de deploy"
if [ -f "scripts/deploy-assistant.sh" ]; then
    if grep -q "secretaria\|Secretária" scripts/deploy-assistant.sh; then
        success "Script de deploy atualizado com secretária"
    else
        warn "Script de deploy pode precisar de atualização para incluir secretária"
    fi
else
    fail "Script de deploy não encontrado"
fi

run_test "Verificar integridade geral do sistema"
if [ -d ".assistant-core/agents" ] && [ -d ".assistant-core/tasks" ] && [ -d ".assistant-core/templates" ]; then
    success "Estrutura básica do sistema íntegra"
else
    fail "Estrutura básica do sistema comprometida"
fi

echo
echo "=================================================================="
echo "📊 RELATÓRIO FINAL DOS TESTES"
echo "=================================================================="
echo
echo "Total de Testes Executados: $TESTS_RUN"
echo -e "${GREEN}Testes Aprovados: $TESTS_PASSED${NC}"
echo -e "${RED}Testes Falhados: $TESTS_FAILED${NC}"
echo

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 TODOS OS TESTES PASSARAM! Story 2.2 implementada com sucesso!${NC}"
    exit 0
else
    echo -e "${RED}❌ ALGUNS TESTES FALHARAM. Revisar implementação necessária.${NC}"
    echo
    echo "Resumo dos problemas encontrados:"
    echo "- $TESTS_FAILED teste(s) falharam de $TESTS_RUN executados"
    echo "- Taxa de sucesso: $((TESTS_PASSED * 100 / TESTS_RUN))%"
    exit 1
fi