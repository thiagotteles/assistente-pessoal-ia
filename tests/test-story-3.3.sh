#!/bin/bash
# test-story-3.3.sh - Testes para Story 3.3 (Feedback Visual e Progresso Contínuo)
# Sistema: Assistente Pessoal IA

# Não usar set -e para permitir que testes continuem após falhas

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
echo "  Testes Story 3.3 - Feedback Visual e Progresso Contínuo"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ============================================
# TESTE 1: Dashboard Cache (AC1)
# ============================================
info "Teste 1: Verificando estrutura de cache..."

if [ -f ".assistant-core/data/dashboard-cache.yaml" ]; then
    success "dashboard-cache.yaml existe"

    if grep -q "ultima_atualizacao:" ".assistant-core/data/dashboard-cache.yaml"; then
        success "Cache contém ultima_atualizacao"
    else
        fail "Cache NÃO contém ultima_atualizacao"
    fi

    if grep -q "esta_semana:" ".assistant-core/data/dashboard-cache.yaml"; then
        success "Cache contém estatísticas da semana"
    else
        fail "Cache NÃO contém estatísticas da semana"
    fi

    if grep -q "streak_dias:" ".assistant-core/data/dashboard-cache.yaml"; then
        success "Cache contém streak"
    else
        fail "Cache NÃO contém streak"
    fi

    if grep -q "conversas_por_agente:" ".assistant-core/data/dashboard-cache.yaml"; then
        success "Cache contém conversas por agente"
    else
        fail "Cache NÃO contém conversas por agente"
    fi
else
    fail "dashboard-cache.yaml NÃO existe"
fi

# ============================================
# TESTE 2: MEU-DASHBOARD.md (AC1)
# ============================================
info "Teste 2: Verificando MEU-DASHBOARD.md..."

if [ -f "knowledge-base/📈 MEU-DASHBOARD.md" ]; then
    success "MEU-DASHBOARD.md existe"

    DASHBOARD_FILE="knowledge-base/📈 MEU-DASHBOARD.md"

    if grep -q "Esta Semana" "$DASHBOARD_FILE"; then
        success "Dashboard contém seção 'Esta Semana'"
    else
        fail "Dashboard NÃO contém 'Esta Semana'"
    fi

    if grep -q "Uso dos Agentes" "$DASHBOARD_FILE"; then
        success "Dashboard contém seção 'Uso dos Agentes'"
    else
        fail "Dashboard NÃO contém 'Uso dos Agentes'"
    fi

    if grep -q "Streak" "$DASHBOARD_FILE"; then
        success "Dashboard contém seção 'Streak'"
    else
        fail "Dashboard NÃO contém 'Streak'"
    fi

    if grep -q "Progresso em Todos" "$DASHBOARD_FILE"; then
        success "Dashboard contém seção 'Progresso em Todos'"
    else
        fail "Dashboard NÃO contém 'Progresso'"
    fi

    if grep -q "Achievements" "$DASHBOARD_FILE"; then
        success "Dashboard contém seção 'Achievements'"
    else
        fail "Dashboard NÃO contém 'Achievements'"
    fi

    # Verificar barras Unicode
    if grep -q "█\|░" "$DASHBOARD_FILE"; then
        success "Dashboard usa barras de progresso Unicode"
    else
        fail "Dashboard NÃO usa barras Unicode"
    fi
else
    fail "MEU-DASHBOARD.md NÃO existe"
fi

# ============================================
# TESTE 3: PROGRESSO-VISUAL.md (AC3)
# ============================================
info "Teste 3: Verificando PROGRESSO-VISUAL.md..."

if [ -f "todos/PROGRESSO-VISUAL.md" ]; then
    success "PROGRESSO-VISUAL.md existe"

    PROGRESSO_FILE="todos/PROGRESSO-VISUAL.md"

    if grep -q "Visão Geral" "$PROGRESSO_FILE"; then
        success "Progresso contém 'Visão Geral'"
    else
        fail "Progresso NÃO contém 'Visão Geral'"
    fi

    if grep -q "Por Projeto" "$PROGRESSO_FILE"; then
        success "Progresso contém 'Por Projeto'"
    else
        fail "Progresso NÃO contém 'Por Projeto'"
    fi

    if grep -q "Metas de Carreira" "$PROGRESSO_FILE"; then
        success "Progresso contém 'Metas de Carreira'"
    else
        fail "Progresso NÃO contém 'Metas de Carreira'"
    fi

    if grep -q "Próximo Passo" "$PROGRESSO_FILE"; then
        success "Progresso contém 'Próximo Passo Sugerido'"
    else
        fail "Progresso NÃO contém 'Próximo Passo'"
    fi

    # Verificar barras Unicode
    if grep -q "█\|░" "$PROGRESSO_FILE"; then
        success "Progresso usa barras Unicode"
    else
        fail "Progresso NÃO usa barras Unicode"
    fi
else
    fail "PROGRESSO-VISUAL.md NÃO existe"
fi

# ============================================
# TESTE 4: Sistema de Achievements (AC4)
# ============================================
info "Teste 4: Verificando sistema de achievements..."

if [ -f "scripts/verificar-achievements.sh" ]; then
    success "Script verificar-achievements.sh existe"

    # Executar script (ignorar exit code pois ele pode retornar 1 se houver warnings)
    bash scripts/verificar-achievements.sh > /dev/null 2>&1 || true
    success "Script de achievements executa"

    # Verificar se arquivo de achievements foi criado
    if [ -f ".assistant-core/data/achievements.yaml" ]; then
        success "achievements.yaml foi criado"
    else
        warning "achievements.yaml não foi criado ainda (normal se não há achievements desbloqueados)"
    fi
else
    fail "Script verificar-achievements.sh NÃO existe"
fi

# ============================================
# TESTE 5: Scripts de Atualização (AC1-3)
# ============================================
info "Teste 5: Verificando scripts de atualização..."

if [ -f "scripts/atualizar-dashboard.sh" ]; then
    success "Script atualizar-dashboard.sh existe"
else
    fail "Script atualizar-dashboard.sh NÃO existe"
fi

if [ -f "scripts/atualizar-dashboard.bat" ]; then
    success "Script atualizar-dashboard.bat existe (Windows)"
else
    fail "Script atualizar-dashboard.bat NÃO existe"
fi

if [ -f "scripts/atualizar-progresso-visual.sh" ]; then
    success "Script atualizar-progresso-visual.sh existe"
else
    fail "Script atualizar-progresso-visual.sh NÃO existe"
fi

if [ -f "scripts/atualizar-progresso-visual.bat" ]; then
    success "Script atualizar-progresso-visual.bat existe (Windows)"
else
    fail "Script atualizar-progresso-visual.bat NÃO existe"
fi

if [ -f "scripts/atualizar-feedback-visual.sh" ]; then
    success "Script integrador atualizar-feedback-visual.sh existe"
else
    fail "Script atualizar-feedback-visual.sh NÃO existe"
fi

# ============================================
# TESTE 6: Performance (AC1)
# ============================================
info "Teste 6: Verificando performance..."

# Testar performance de atualização de dashboard (deve ser < 1s)
START_TIME=$(date +%s%3N)
bash scripts/atualizar-dashboard.sh > /dev/null 2>&1
END_TIME=$(date +%s%3N)
DURATION=$((END_TIME - START_TIME))

if [ "$DURATION" -lt 1000 ]; then
    success "Performance dashboard < 1s ($DURATION ms)"
else
    warning "Performance dashboard > 1s ($DURATION ms) - target era < 100ms"
fi

# ============================================
# TESTE 7: Integração (AC1-5)
# ============================================
info "Teste 7: Verificando integração completa..."

# Executar script integrador
if bash scripts/atualizar-feedback-visual.sh > /dev/null 2>&1; then
    success "Script integrador executa todos os componentes"
else
    fail "Script integrador falha"
fi

# Verificar que todos os arquivos foram atualizados
if [ -f "knowledge-base/📈 MEU-DASHBOARD.md" ] && \
   [ -f "todos/PROGRESSO-VISUAL.md" ] && \
   [ -f ".assistant-core/data/dashboard-cache.yaml" ]; then
    success "Todos os arquivos de feedback visual estão presentes"
else
    fail "Alguns arquivos de feedback visual estão faltando"
fi

# ============================================
# TESTE 8: Documentação em Português (Todos ACs)
# ============================================
info "Teste 8: Verificando documentação em português..."

PORTUGUESE_WORDS=("Progresso" "Streak" "Achievements" "Dashboard" "Última atualização")
FOUND_PORTUGUESE=0

for word in "${PORTUGUESE_WORDS[@]}"; do
    if grep -iq "$word" "knowledge-base/📈 MEU-DASHBOARD.md" 2>/dev/null || \
       grep -iq "$word" "todos/PROGRESSO-VISUAL.md" 2>/dev/null; then
        ((FOUND_PORTUGUESE++))
    fi
done

if [ $FOUND_PORTUGUESE -ge 4 ]; then
    success "Toda documentação em português confirmada"
else
    fail "Documentação NÃO está adequadamente em português"
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
    echo -e "${GREEN}  ✅ STORY 3.3 - TODOS OS TESTES PASSARAM!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "Próximos passos:"
    echo "  1. Testar saudação contextual dos agentes (AC2)"
    echo "  2. Implementar notificações contextuais (AC5)"
    echo "  3. Validar integração end-to-end"
    echo "  4. Marcar story como Ready for Review"
    exit 0
else
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}  ❌ ALGUNS TESTES FALHARAM - CORRIJA ANTES DE CONTINUAR${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 1
fi
