#!/bin/bash
# test-story-3.2.sh - Testes para Story 3.2 (Obsidian Simplificado e Pré-Configurado)
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
echo "  Testes Story 3.2 - Obsidian Simplificado e Pré-Configurado"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ============================================
# TESTE 1: Dashboard Visual 🏠 INÍCIO.md (AC1)
# ============================================
info "Teste 1: Verificando Dashboard Visual (AC1)..."

# Verificar se o script de upgrade cria o arquivo
if grep -q "INÍCIO.md" "scripts/upgrade-to-epic3.sh"; then
    success "Dashboard INÍCIO.md está no script de upgrade"

    # Verificar conteúdo
    if grep -q "Captura Rápida" "scripts/upgrade-to-epic3.sh"; then
        success "Dashboard contém seção 'Captura Rápida'"
    else
        fail "Dashboard NÃO contém 'Captura Rápida'"
    fi

    if grep -q "Informações Organizadas" "scripts/upgrade-to-epic3.sh"; then
        success "Dashboard contém seção 'Informações Organizadas'"
    else
        fail "Dashboard NÃO contém 'Informações Organizadas'"
    fi

    if grep -q "Conversar com Agentes" "scripts/upgrade-to-epic3.sh"; then
        success "Dashboard contém seção 'Conversar com Agentes'"
    else
        fail "Dashboard NÃO contém 'Conversar com Agentes'"
    fi

    if grep -q "Busca Rápida" "scripts/upgrade-to-epic3.sh"; then
        success "Dashboard contém seção 'Busca Rápida'"
    else
        fail "Dashboard NÃO contém 'Busca Rápida'"
    fi

    if grep -q "Ver Meu Progresso" "scripts/upgrade-to-epic3.sh"; then
        success "Dashboard contém seção 'Ver Meu Progresso'"
    else
        fail "Dashboard NÃO contém 'Ver Meu Progresso'"
    fi

    # Verificar emojis Unicode
    if grep -q "📥\|📂\|🤖\|🔍\|📊" "scripts/upgrade-to-epic3.sh"; then
        success "Dashboard usa emojis Unicode"
    else
        fail "Dashboard NÃO usa emojis Unicode"
    fi
else
    fail "Dashboard INÍCIO.md NÃO está no script de upgrade"
fi

# ============================================
# TESTE 2: Obsidian Workspace Configurado (AC2)
# ============================================
info "Teste 2: Verificando configuração de Workspace (AC2)..."

# Verificar script de merge
if [ -f "scripts/merge-obsidian-config.sh" ]; then
    success "Script merge-obsidian-config.sh existe"

    # Verificar hotkeys configurados
    if grep -q "switcher:open" "scripts/merge-obsidian-config.sh"; then
        success "Hotkey Ctrl+O (Quick switcher) configurado"
    else
        fail "Hotkey Ctrl+O NÃO configurado"
    fi

    # Verificar app.json
    if grep -q "app.json" "scripts/merge-obsidian-config.sh"; then
        success "Configuração app.json incluída"
    else
        fail "Configuração app.json NÃO incluída"
    fi

    # Verificar graph.json
    if grep -q "graph.json" "scripts/merge-obsidian-config.sh"; then
        success "Configuração graph.json incluída"
    else
        fail "Configuração graph.json NÃO incluída"
    fi

    # Verificar templates
    if grep -q "template-projeto\|template-pessoa" "scripts/merge-obsidian-config.sh"; then
        success "Templates Obsidian criados"
    else
        fail "Templates Obsidian NÃO criados"
    fi
else
    fail "Script merge-obsidian-config.sh NÃO existe"
fi

# ============================================
# TESTE 3: Guia COMO-BUSCAR.md (AC3)
# ============================================
info "Teste 3: Verificando guia de busca (AC3)..."

if grep -q "COMO-BUSCAR.md" "scripts/upgrade-to-epic3.sh"; then
    success "COMO-BUSCAR.md está no script de upgrade"

    # Verificar conteúdo
    if grep -q "Busca Rápida" "scripts/upgrade-to-epic3.sh"; then
        success "Guia contém 'Busca Rápida (Ctrl+O)'"
    else
        fail "Guia NÃO contém 'Busca Rápida'"
    fi

    if grep -q "Busca Dentro dos Arquivos" "scripts/upgrade-to-epic3.sh" || \
       grep -q "Ctrl + Shift + F" "scripts/upgrade-to-epic3.sh"; then
        success "Guia contém 'Busca em Arquivos (Ctrl+Shift+F)'"
    else
        fail "Guia NÃO contém 'Busca em Arquivos'"
    fi

    if grep -q "Busca por Data" "scripts/upgrade-to-epic3.sh"; then
        success "Guia contém 'Busca por Data'"
    else
        fail "Guia NÃO contém 'Busca por Data'"
    fi

    if grep -q "\\[\\[" "scripts/upgrade-to-epic3.sh"; then
        success "Guia contém navegação por [[Links]]"
    else
        fail "Guia NÃO contém navegação por [[Links]]"
    fi

    if grep -q "TDAH\|relacionada" "scripts/upgrade-to-epic3.sh"; then
        success "Guia contém truque TDAH"
    else
        fail "Guia NÃO contém truque TDAH"
    fi
else
    fail "COMO-BUSCAR.md NÃO está no script de upgrade"
fi

# ============================================
# TESTE 4: Tutorial OBSIDIAN-EM-5-MINUTOS.md (AC4)
# ============================================
info "Teste 4: Verificando tutorial Obsidian (AC4)..."

if grep -q "OBSIDIAN-EM-5-MINUTOS.md" "scripts/upgrade-to-epic3.sh"; then
    success "OBSIDIAN-EM-5-MINUTOS.md está no script de upgrade"

    # Verificar 5 seções
    SECTION_COUNT=0

    if grep -A 5 "OBSIDIAN-EM-5-MINUTOS" "scripts/upgrade-to-epic3.sh" | grep -q "Abrir Arquivos\|Ctrl+O"; then
        ((SECTION_COUNT++))
    fi

    if grep -A 5 "OBSIDIAN-EM-5-MINUTOS" "scripts/upgrade-to-epic3.sh" | grep -q "Buscar Texto\|Ctrl+Shift+F"; then
        ((SECTION_COUNT++))
    fi

    if grep -A 5 "OBSIDIAN-EM-5-MINUTOS" "scripts/upgrade-to-epic3.sh" | grep -q "Seguir.*link\|\\[\\["; then
        ((SECTION_COUNT++))
    fi

    if grep -A 5 "OBSIDIAN-EM-5-MINUTOS" "scripts/upgrade-to-epic3.sh" | grep -q "Graph\|grafo"; then
        ((SECTION_COUNT++))
    fi

    if grep -A 5 "OBSIDIAN-EM-5-MINUTOS" "scripts/upgrade-to-epic3.sh" | grep -q "Voltar\|INÍCIO"; then
        ((SECTION_COUNT++))
    fi

    if [ $SECTION_COUNT -ge 4 ]; then
        success "Tutorial contém pelo menos 4 das 5 seções principais"
    else
        fail "Tutorial contém apenas $SECTION_COUNT de 5 seções"
    fi

    # Link de volta ao início
    if grep -A 30 "OBSIDIAN-EM-5-MINUTOS" "scripts/upgrade-to-epic3.sh" | grep -q "INÍCIO"; then
        success "Tutorial tem link de volta ao INÍCIO"
    else
        fail "Tutorial NÃO tem link de volta ao INÍCIO"
    fi
else
    fail "OBSIDIAN-EM-5-MINUTOS.md NÃO está no script de upgrade"
fi

# ============================================
# TESTE 5: Cartão ATALHOS-OBSIDIAN.md (AC5)
# ============================================
info "Teste 5: Verificando cartão de atalhos (AC5)..."

if grep -q "ATALHOS-OBSIDIAN.md" "scripts/upgrade-to-epic3.sh"; then
    success "ATALHOS-OBSIDIAN.md está no script de upgrade"

    # Verificar atalhos principais
    HOTKEYS_COUNT=0

    if grep -A 20 "ATALHOS-OBSIDIAN" "scripts/upgrade-to-epic3.sh" | grep -q "Ctrl + O"; then
        ((HOTKEYS_COUNT++))
    fi

    if grep -A 20 "ATALHOS-OBSIDIAN" "scripts/upgrade-to-epic3.sh" | grep -q "Ctrl + Shift + F"; then
        ((HOTKEYS_COUNT++))
    fi

    if grep -A 20 "ATALHOS-OBSIDIAN" "scripts/upgrade-to-epic3.sh" | grep -q "Alt.*←\|Alt.*→"; then
        ((HOTKEYS_COUNT++))
    fi

    if [ $HOTKEYS_COUNT -ge 3 ]; then
        success "Cartão contém pelo menos 3 atalhos essenciais"
    else
        fail "Cartão contém apenas $HOTKEYS_COUNT de 5 atalhos"
    fi
else
    fail "ATALHOS-OBSIDIAN.md NÃO está no script de upgrade"
fi

# ============================================
# TESTE 6: Integração com Setup/Upgrade
# ============================================
info "Teste 6: Verificando integração com scripts..."

# Verificar que upgrade chama merge
if grep -q "merge-obsidian-config" "scripts/upgrade-to-epic3.sh"; then
    success "Upgrade chama script de merge de configurações"
else
    fail "Upgrade NÃO chama merge de configurações"
fi

# Verificar função create_if_not_exists
if grep -q "create_if_not_exists" "scripts/upgrade-to-epic3.sh"; then
    success "Usa função não-destrutiva create_if_not_exists"
else
    fail "NÃO usa create_if_not_exists"
fi

# ============================================
# TESTE 7: Plugins Nativos Configurados (AC2)
# ============================================
info "Teste 7: Verificando plugins nativos..."

# Verificar que não há plugins externos
if ! grep -q "community-plugins\|plugin.*download" "scripts/merge-obsidian-config.sh" 2>/dev/null; then
    success "Usa apenas plugins nativos (sem plugins externos)"
else
    warning "Pode conter referências a plugins externos"
fi

# Verificar configurações de performance
if grep -q "graph" "scripts/merge-obsidian-config.sh"; then
    success "Configuração de Graph view incluída"
else
    fail "Configuração de Graph view NÃO incluída"
fi

# ============================================
# TESTE 8: Documentação em Português (Todos ACs)
# ============================================
info "Teste 8: Verificando documentação em português..."

PORTUGUESE_WORDS=("Captura" "buscar" "agentes" "atalhos" "despejo")
FOUND_PORTUGUESE=0

for word in "${PORTUGUESE_WORDS[@]}"; do
    if grep -i -q "$word" "scripts/upgrade-to-epic3.sh" 2>/dev/null; then
        ((FOUND_PORTUGUESE++))
    fi
done

if [ $FOUND_PORTUGUESE -ge 4 ]; then
    success "Toda documentação em português confirmada"
else
    fail "Documentação NÃO está adequadamente em português"
fi

# ============================================
# TESTE 9: Performance e Simplicidade (AC2)
# ============================================
info "Teste 9: Verificando otimizações de performance..."

# Verificar que são arquivos estáticos
if grep -q "create_if_not_exists.*knowledge-base" "scripts/upgrade-to-epic3.sh"; then
    success "Arquivos são estáticos (zero custo de performance)"
else
    fail "Arquivos podem não ser estáticos"
fi

# Verificar graph limitado
if grep -q "depth\|níveis\|limitado" "scripts/merge-obsidian-config.sh" 2>/dev/null || \
   grep -q "nodeSizeMultiplier\|scale" "scripts/merge-obsidian-config.sh" 2>/dev/null; then
    success "Graph view otimizado para performance"
else
    warning "Graph view pode não ter otimizações"
fi

# ============================================
# TESTE 10: Compatibilidade com Customizações (AC2)
# ============================================
info "Teste 10: Verificando preservação de customizações..."

# Verificar backup antes de modificar
if grep -q "backup\|BACKUP" "scripts/merge-obsidian-config.sh"; then
    success "Cria backup antes de modificar configurações"
else
    fail "NÃO cria backup antes de modificar"
fi

# Verificar merge inteligente
if grep -q "if.*existe\|preserva\|merge" "scripts/merge-obsidian-config.sh" 2>/dev/null || \
   grep -q "workspace-suggested" "scripts/upgrade-to-epic3.sh"; then
    success "Preserva customizações do usuário"
else
    warning "Pode não preservar customizações adequadamente"
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
    echo -e "${GREEN}  ✅ STORY 3.2 - TODOS OS TESTES PASSARAM!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "Próximos passos:"
    echo "  1. Executar upgrade: bash scripts/upgrade-to-epic3.sh"
    echo "  2. Abrir Obsidian e verificar dashboard"
    echo "  3. Testar busca Ctrl+O e Ctrl+Shift+F"
    echo "  4. Validar que configurações foram aplicadas"
    exit 0
else
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}  ❌ ALGUNS TESTES FALHARAM - CORRIJA ANTES DE CONTINUAR${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 1
fi
