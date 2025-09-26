#!/bin/bash

# Assistente Pessoal IA - Teste Básico de Validação
# Versão 1.0

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_header() {
    echo -e "\n${BLUE}================================${NC}"
    echo -e "${BLUE} Assistente Pessoal IA - Testes${NC}"
    echo -e "${BLUE}================================${NC}\n"
}

# Test functions
test_directory_structure() {
    print_info "Teste 1: Estrutura de Diretórios"
    local test_passed=true

    local required_dirs=(
        ".assistant-core"
        ".assistant-core/agents"
        ".assistant-core/templates"
        ".assistant-core/tasks"
        ".assistant-core/data"
        ".assistant-core/memory"
        "despejo"
        "knowledge-base"
        "knowledge-base/decisoes"
        "knowledge-base/contextos"
        "knowledge-base/projetos"
        "knowledge-base/pessoas"
        "todos"
        "diario"
        "scripts"
    )

    for dir in "${required_dirs[@]}"; do
        if [ -d "$dir" ]; then
            echo "  ✅ $dir"
        else
            echo "  ❌ FALTANDO: $dir"
            test_passed=false
        fi
    done

    if [ "$test_passed" = true ]; then
        print_success "Teste de estrutura: PASSOU"
        return 0
    else
        print_error "Teste de estrutura: FALHOU"
        return 1
    fi
}

test_base_files() {
    print_info "Teste 2: Arquivos Base"
    local test_passed=true

    local required_files=(
        "despejo/daily-dump.txt"
        "README.md"
        ".gitignore"
        "CHANGELOG.md"
        ".assistant-core/core-config.yaml"
        "setup.sh"
        "setup.bat"
    )

    for file in "${required_files[@]}"; do
        if [ -f "$file" ]; then
            echo "  ✅ $file"
        else
            echo "  ❌ FALTANDO: $file"
            test_passed=false
        fi
    done

    if [ "$test_passed" = true ]; then
        print_success "Teste de arquivos base: PASSOU"
        return 0
    else
        print_error "Teste de arquivos base: FALHOU"
        return 1
    fi
}

test_agent_configs() {
    print_info "Teste 3: Configurações dos Agentes"
    local test_passed=true

    local agent_configs=(
        ".assistant-core/agents/organizador.yaml"
        ".assistant-core/agents/secretaria.yaml"
        ".assistant-core/agents/arquiteto.yaml"
        ".assistant-core/agents/psicologo.yaml"
        ".assistant-core/agents/mentor.yaml"
    )

    for config in "${agent_configs[@]}"; do
        if [ -f "$config" ]; then
            echo "  ✅ $config"
        else
            echo "  ❌ FALTANDO: $config"
            test_passed=false
        fi
    done

    # Test memory files
    local memory_files=(
        ".assistant-core/memory/organizador-memory.yaml"
        ".assistant-core/memory/secretaria-memory.yaml"
        ".assistant-core/memory/arquiteto-memory.yaml"
        ".assistant-core/memory/psicologo-memory.yaml"
        ".assistant-core/memory/mentor-memory.yaml"
    )

    for memory in "${memory_files[@]}"; do
        if [ -f "$memory" ]; then
            echo "  ✅ $memory"
        else
            echo "  ❌ FALTANDO: $memory"
            test_passed=false
        fi
    done

    if [ "$test_passed" = true ]; then
        print_success "Teste de configurações: PASSOU"
        return 0
    else
        print_error "Teste de configurações: FALHOU"
        return 1
    fi
}

test_obsidian_integration() {
    print_info "Teste 4: Integração Obsidian"
    local test_passed=true

    # Check Obsidian configuration files
    local obsidian_configs=(
        "knowledge-base/.obsidian/app.json"
        "knowledge-base/.obsidian/graph.json"
        "knowledge-base/.obsidian/hotkeys.json"
    )

    for config in "${obsidian_configs[@]}"; do
        if [ -f "$config" ]; then
            echo "  ✅ $config"
        else
            echo "  ❌ FALTANDO: $config"
            test_passed=false
        fi
    done

    # Test if knowledge-base can be used as Obsidian vault
    if [ -d "knowledge-base" ] && [ -d "knowledge-base/.obsidian" ]; then
        echo "  ✅ knowledge-base configured as Obsidian vault"
    else
        echo "  ❌ PROBLEMA: knowledge-base não configurado como vault Obsidian"
        test_passed=false
    fi

    if [ "$test_passed" = true ]; then
        print_success "Teste de integração Obsidian: PASSOU"
        return 0
    else
        print_error "Teste de integração Obsidian: FALHOU"
        return 1
    fi
}

test_file_contents() {
    print_info "Teste 5: Conteúdo dos Arquivos"
    local test_passed=true

    # Test if daily-dump.txt has initial content
    if [ -f "despejo/daily-dump.txt" ] && [ -s "despejo/daily-dump.txt" ]; then
        echo "  ✅ daily-dump.txt tem conteúdo inicial"
    else
        echo "  ❌ daily-dump.txt vazio ou inexistente"
        test_passed=false
    fi

    # Test if core-config.yaml has agent configurations
    if [ -f ".assistant-core/core-config.yaml" ]; then
        if grep -q "agentes:" ".assistant-core/core-config.yaml"; then
            echo "  ✅ core-config.yaml contém configurações de agentes"
        else
            echo "  ❌ core-config.yaml não contém configurações de agentes"
            test_passed=false
        fi
    fi

    # Test if README.md has content
    if [ -f "README.md" ] && [ -s "README.md" ]; then
        echo "  ✅ README.md tem conteúdo"
    else
        echo "  ❌ README.md vazio ou inexistente"
        test_passed=false
    fi

    if [ "$test_passed" = true ]; then
        print_success "Teste de conteúdo: PASSOU"
        return 0
    else
        print_error "Teste de conteúdo: FALHOU"
        return 1
    fi
}

# Main test runner
run_all_tests() {
    print_header

    local total_tests=5
    local passed_tests=0

    # Run all tests
    if test_directory_structure; then
        ((passed_tests++))
    fi

    if test_base_files; then
        ((passed_tests++))
    fi

    if test_agent_configs; then
        ((passed_tests++))
    fi

    if test_obsidian_integration; then
        ((passed_tests++))
    fi

    if test_file_contents; then
        ((passed_tests++))
    fi

    # Final result
    echo
    print_info "Resultado Final: $passed_tests/$total_tests testes passaram"

    if [ $passed_tests -eq $total_tests ]; then
        print_success "🎉 TODOS OS TESTES PASSARAM!"
        print_success "Sistema está funcionando corretamente!"
        echo
        print_info "O sistema está pronto para uso:"
        print_info "• Use despejo/daily-dump.txt para captura rápida"
        print_info "• Abra knowledge-base/ no Obsidian"
        print_info "• Experimente os comandos: /organizador, /secretaria, /arquiteto, /psicologo, /mentor"
        return 0
    else
        print_error "❌ $((total_tests - passed_tests)) TESTE(S) FALHARAM!"
        print_error "Verifique os problemas identificados acima"
        return 1
    fi
}

# Execute tests
run_all_tests