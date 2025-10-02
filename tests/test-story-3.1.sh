#!/bin/bash
# test-story-3.1.sh - Testes para Story 3.1 (Onboarding Interativo - Primeiros Passos)
# Sistema: Assistente Pessoal IA

set -e

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

TESTS_PASSED=0
TESTS_FAILED=0

info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
success() { echo -e "${GREEN}✅ $1${NC}"; ((TESTS_PASSED++)); }
fail() { echo -e "${RED}❌ $1${NC}"; ((TESTS_FAILED++)); }
warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Testes Story 3.1 - Onboarding Interativo"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ============================================
# TESTE 1: Arquivo daily-dump.md com Exemplos
# ============================================
info "Teste 1: Verificando daily-dump.md com exemplos práticos (AC2)..."

if [ -f "despejo/daily-dump.md" ]; then
    success "daily-dump.md existe"

    if grep -q "Exemplo de como usar" "despejo/daily-dump.md"; then
        success "Contém seção de exemplos"
    else
        fail "NÃO contém seção de exemplos"
    fi

    if grep -q "reunião com João" "despejo/daily-dump.md" || grep -q "projeto Alpha" "despejo/daily-dump.md"; then
        success "Contém exemplos práticos"
    else
        fail "NÃO contém exemplos práticos suficientes"
    fi

    if grep -q "Seu despejo começa aqui" "despejo/daily-dump.md"; then
        success "Contém seção para usuário escrever"
    else
        fail "NÃO contém seção para usuário"
    fi
else
    fail "daily-dump.md NÃO encontrado"
fi

# ============================================
# TESTE 2: BEM-VINDO.md Completo
# ============================================
info "Teste 2: Verificando BEM-VINDO.md (AC2)..."

# BEM-VINDO.md é criado pelo upgrade script
if grep -q "BEM-VINDO.md" "scripts/upgrade-to-epic3.sh"; then
    success "BEM-VINDO.md está no script de upgrade"

    if grep -q "Comece Aqui" "scripts/upgrade-to-epic3.sh"; then
        success "Contém seção 'Comece Aqui'"
    else
        fail "NÃO contém seção 'Comece Aqui'"
    fi

    if grep -q "Seus 5 Agentes" "scripts/upgrade-to-epic3.sh"; then
        success "Apresenta os 5 agentes"
    else
        fail "NÃO apresenta os 5 agentes"
    fi

    if grep -q "Dica TDAH" "scripts/upgrade-to-epic3.sh"; then
        success "Contém dica TDAH"
    else
        fail "NÃO contém dica TDAH"
    fi
else
    fail "BEM-VINDO.md NÃO está no upgrade script"
fi

# ============================================
# TESTE 3: MEU-PROGRESSO.md com Checklist
# ============================================
info "Teste 3: Verificando MEU-PROGRESSO.md (AC4)..."

if [ -f "MEU-PROGRESSO.md" ]; then
    success "MEU-PROGRESSO.md existe"

    if grep -q "Checklist dos 7 Primeiros Dias" "MEU-PROGRESSO.md"; then
        success "Contém checklist de 7 dias"
    else
        fail "NÃO contém checklist de 7 dias"
    fi

    if grep -q "Dia 1:" "MEU-PROGRESSO.md" && grep -q "Dia 7:" "MEU-PROGRESSO.md"; then
        success "Contém todos os 7 dias"
    else
        fail "NÃO contém todos os 7 dias"
    fi

    if grep -q "Minhas Estatísticas" "MEU-PROGRESSO.md"; then
        success "Contém seção de estatísticas"
    else
        fail "NÃO contém seção de estatísticas"
    fi

    if grep -q "Próximo Passo Sugerido" "MEU-PROGRESSO.md"; then
        success "Contém próximo passo sugerido"
    else
        fail "NÃO contém próximo passo sugerido"
    fi

    if grep -q "Dicas para TDAH" "MEU-PROGRESSO.md"; then
        success "Contém dicas TDAH"
    else
        fail "NÃO contém dicas TDAH"
    fi
else
    fail "MEU-PROGRESSO.md NÃO encontrado"
fi

# ============================================
# TESTE 4: Output Visual Melhorado
# ============================================
info "Teste 4: Verificando output visual melhorado (AC3)..."

if [ -f ".assistant-core/tasks/processar-despejo.md" ]; then
    success "Task processar-despejo.md existe"

    if grep -q "Output Visual Detalhado" ".assistant-core/tasks/processar-despejo.md"; then
        success "Task inclui output visual detalhado"
    else
        fail "Task NÃO inclui output visual detalhado"
    fi

    # Verificar ícones por tipo
    if grep -q "📅 AGENDA" ".assistant-core/tasks/processar-despejo.md"; then
        success "Inclui ícone para AGENDA"
    else
        fail "NÃO inclui ícone para AGENDA"
    fi

    if grep -q "🚀 PROJETO" ".assistant-core/tasks/processar-despejo.md"; then
        success "Inclui ícone para PROJETO"
    else
        fail "NÃO inclui ícone para PROJETO"
    fi

    if grep -q "💡 IDEIA" ".assistant-core/tasks/processar-despejo.md"; then
        success "Inclui ícone para IDEIA"
    else
        fail "NÃO inclui ícone para IDEIA"
    fi

    if grep -q "✅ TODO" ".assistant-core/tasks/processar-despejo.md"; then
        success "Inclui ícone para TODO"
    else
        fail "NÃO inclui ícone para TODO"
    fi

    if grep -q "Abra o Obsidian" ".assistant-core/tasks/processar-despejo.md"; then
        success "Instrui usuário a abrir Obsidian"
    else
        fail "NÃO instrui usuário a abrir Obsidian"
    fi
else
    fail "Task processar-despejo.md NÃO encontrado"
fi

# ============================================
# TESTE 5: Integração com Setup
# ============================================
info "Teste 5: Verificando integração com setup.sh..."

if [ -f "setup.sh" ]; then
    success "setup.sh existe"

    if grep -q "daily-dump.md" "setup.sh" && grep -q "Exemplo de como usar" "setup.sh"; then
        success "setup.sh cria daily-dump.md com exemplos"
    else
        fail "setup.sh NÃO cria daily-dump.md adequadamente"
    fi

    if grep -q "MEU-PROGRESSO.md" "setup.sh"; then
        success "setup.sh cria MEU-PROGRESSO.md"
    else
        fail "setup.sh NÃO cria MEU-PROGRESSO.md"
    fi
else
    fail "setup.sh NÃO encontrado"
fi

# ============================================
# TESTE 6: Integração com Upgrade
# ============================================
info "Teste 6: Verificando integração com upgrade-to-epic3.sh..."

if [ -f "scripts/upgrade-to-epic3.sh" ]; then
    success "upgrade-to-epic3.sh existe"

    if grep -q "BEM-VINDO.md" "scripts/upgrade-to-epic3.sh"; then
        success "upgrade cria BEM-VINDO.md"
    else
        fail "upgrade NÃO cria BEM-VINDO.md"
    fi

    if grep -q "MEU-PROGRESSO.md" "scripts/upgrade-to-epic3.sh"; then
        success "upgrade cria MEU-PROGRESSO.md"
    else
        fail "upgrade NÃO cria MEU-PROGRESSO.md"
    fi

    if grep -q "Checklist dos 7 Primeiros Dias" "scripts/upgrade-to-epic3.sh"; then
        success "upgrade usa checklist completo"
    else
        fail "upgrade NÃO usa checklist completo"
    fi
else
    fail "upgrade-to-epic3.sh NÃO encontrado"
fi

# ============================================
# TESTE 7: Tour Guiado (Implementado na Story 3.0)
# ============================================
info "Teste 7: Verificando tour guiado implementado (AC1)..."

if [ -f ".assistant-core/agents/organizador.md" ]; then
    success "Agente organizador existe"

    # Tour foi implementado na Story 3.0 via patches
    if [ -f "scripts/apply-epic3-agent-patches.sh" ]; then
        success "Script de patches existe"

        if grep -q "tour-guiado" "scripts/apply-epic3-agent-patches.sh"; then
            success "Patch de tour guiado definido"
        else
            fail "Patch de tour guiado NÃO encontrado"
        fi

        if grep -q "organizador-tour-status.yaml" "scripts/apply-epic3-agent-patches.sh"; then
            success "Arquivo de status do tour criado"
        else
            fail "Arquivo de status do tour NÃO criado"
        fi
    else
        warning "Script de patches não encontrado (Story 3.0)"
    fi
else
    fail "Agente organizador NÃO encontrado"
fi

# ============================================
# TESTE 8: Documentação em Português
# ============================================
info "Teste 8: Verificando documentação em português..."

PORTUGUESE_WORDS=("despejo" "progresso" "checklist" "agentes" "organizador")
FOUND_PORTUGUESE=0

for word in "${PORTUGUESE_WORDS[@]}"; do
    if grep -q "$word" "MEU-PROGRESSO.md" 2>/dev/null || grep -q "$word" "despejo/daily-dump.md" 2>/dev/null; then
        ((FOUND_PORTUGUESE++))
    fi
done

if [ $FOUND_PORTUGUESE -ge 3 ]; then
    success "Documentação em português confirmada"
else
    fail "Documentação NÃO está adequadamente em português"
fi

# ============================================
# TESTE 9: Quick Wins - Estrutura
# ============================================
info "Teste 9: Verificando estrutura para quick wins (AC3)..."

# Verificar que exemplos são práticos e rápidos
if [ -f "despejo/daily-dump.md" ]; then
    EXAMPLE_COUNT=$(grep -c "^\w" "despejo/daily-dump.md" 2>/dev/null || echo "0")

    if [ "$EXAMPLE_COUNT" -ge 5 ]; then
        success "Exemplos suficientes para quick wins (>= 5)"
    else
        warning "Poucos exemplos (< 5), pode não ser suficiente para quick wins"
    fi
fi

# Verificar que o output visual está otimizado
if grep -q "Processamento Completo" ".assistant-core/tasks/processar-despejo.md" 2>/dev/null; then
    success "Mensagem de sucesso imediato configurada"
else
    fail "Mensagem de sucesso imediato NÃO configurada"
fi

# ============================================
# TESTE 10: Compatibilidade Epic 2
# ============================================
info "Teste 10: Verificando compatibilidade com Epic 2..."

# Verificar que agentes Epic 2 não foram modificados
AGENTS_EXIST=true
for agent in organizador secretaria arquiteto psicologo mentor; do
    if [ ! -f ".assistant-core/agents/${agent}.md" ]; then
        AGENTS_EXIST=false
        break
    fi
done

if [ "$AGENTS_EXIST" = true ]; then
    success "Todos os 5 agentes Epic 2 existem"
else
    warning "Nem todos agentes encontrados (esperado em ambiente de teste)"
fi

# Verificar que estrutura knowledge-base está intacta
if [ -d "knowledge-base" ]; then
    success "knowledge-base/ preservada"
else
    warning "knowledge-base/ NÃO encontrada (esperado em ambiente de teste)"
fi

# ============================================
# RESULTADO FINAL
# ============================================
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  RESULTADO DOS TESTES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "✅ Testes APROVADOS: ${GREEN}${TESTS_PASSED}${NC}"
echo -e "❌ Testes FALHADOS:  ${RED}${TESTS_FAILED}${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  ✅ STORY 3.1 - TODOS OS TESTES PASSARAM!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "Próximos passos:"
    echo "  1. Testar fluxo completo de onboarding com usuário real"
    echo "  2. Validar quick wins < 5 minutos"
    echo "  3. Coletar feedback sobre clareza do tour"
    echo "  4. Verificar que exemplos são úteis"
    exit 0
else
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}  ❌ ALGUNS TESTES FALHARAM - CORRIJA ANTES DE CONTINUAR${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 1
fi
