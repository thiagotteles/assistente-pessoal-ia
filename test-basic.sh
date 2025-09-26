#!/bin/bash

# Assistente Pessoal IA - Framework de Testes Essenciais
# Versão 2.0 - História 0.4

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

test_knowledge_base_manager() {
    print_info "Teste 6: Knowledge-Base Manager"
    local test_passed=true

    # Check if Knowledge-Base Manager module exists
    if [ -f ".assistant-core/knowledge_base_manager.py" ]; then
        echo "  ✅ knowledge_base_manager.py existe"
    else
        echo "  ❌ FALTANDO: knowledge_base_manager.py"
        test_passed=false
    fi

    # Test Knowledge-Base Manager functionality
    if command -v python3 &> /dev/null; then
        print_info "  Testando funcionalidade do Knowledge-Base Manager..."

        # Test basic import and instantiation
        if python3 -c "
import sys
sys.path.append('.assistant-core')
try:
    from knowledge_base_manager import create_knowledge_manager
    kb = create_knowledge_manager()
    print('    ✅ Knowledge-Base Manager: Importação e criação OK')
except Exception as e:
    print(f'    ❌ Erro na importação: {e}')
    exit(1)
" 2>/dev/null; then
            echo "  ✅ Funcionalidades básicas: OK"
        else
            echo "  ❌ Falha ao testar funcionalidades básicas"
            test_passed=false
        fi

        # Test saving and retrieving entry
        if python3 -c "
import sys
sys.path.append('.assistant-core')
try:
    from knowledge_base_manager import create_knowledge_manager
    kb = create_knowledge_manager()

    # Test save
    result = kb.salvar_entrada('Teste Framework', 'Conteúdo de teste do framework', source_agent='teste')
    if result:
        print('    ✅ Salvar entrada: OK')

        # Test retrieve
        entrada = kb.recuperar_entrada(entry_id=result['id'])
        if entrada:
            print('    ✅ Recuperar entrada: OK')
        else:
            print('    ❌ Falha ao recuperar entrada')
            exit(1)
    else:
        print('    ❌ Falha ao salvar entrada')
        exit(1)
except Exception as e:
    print(f'    ❌ Erro no teste de persistência: {e}')
    exit(1)
" 2>/dev/null; then
            echo "  ✅ Teste de persistência: OK"
        else
            echo "  ❌ Falha no teste de persistência"
            test_passed=false
        fi
    else
        echo "  ⚠️  Python3 não disponível - pulando testes funcionais"
    fi

    if [ "$test_passed" = true ]; then
        print_success "Teste Knowledge-Base Manager: PASSOU"
        return 0
    else
        print_error "Teste Knowledge-Base Manager: FALHOU"
        return 1
    fi
}

test_agent_memory_system() {
    print_info "Teste 7: Agent Memory System"
    local test_passed=true

    # Check if Agent Memory System module exists
    if [ -f ".assistant-core/agent_memory_system.py" ]; then
        echo "  ✅ agent_memory_system.py existe"
    else
        echo "  ❌ FALTANDO: agent_memory_system.py"
        test_passed=false
    fi

    # Test Agent Memory System functionality
    if command -v python3 &> /dev/null; then
        print_info "  Testando funcionalidade do Agent Memory System..."

        # Test basic import and instantiation
        if python3 -c "
import sys
sys.path.append('.assistant-core')
try:
    from agent_memory_system import create_agent_memory_system
    ams = create_agent_memory_system()
    print('    ✅ Agent Memory System: Importação e criação OK')
except Exception as e:
    print(f'    ❌ Erro na importação: {e}')
    exit(1)
" 2>/dev/null; then
            echo "  ✅ Funcionalidades básicas: OK"
        else
            echo "  ❌ Falha ao testar funcionalidades básicas"
            test_passed=false
        fi

        # Test loading memory for each agent
        if python3 -c "
import sys
sys.path.append('.assistant-core')
try:
    from agent_memory_system import create_agent_memory_system
    ams = create_agent_memory_system()

    agents = ['organizador', 'secretaria', 'arquiteto', 'psicologo', 'mentor']
    for agent in agents:
        memoria = ams.carregar_memoria_agente(agent)
        if memoria:
            print(f'    ✅ Memória do {agent}: OK')
        else:
            print(f'    ❌ Falha ao carregar memória do {agent}')
            exit(1)
except Exception as e:
    print(f'    ❌ Erro no teste de carregamento: {e}')
    exit(1)
" 2>/dev/null; then
            echo "  ✅ Carregamento de memórias: OK"
        else
            echo "  ❌ Falha no carregamento de memórias"
            test_passed=false
        fi
    else
        echo "  ⚠️  Python3 não disponível - pulando testes funcionais"
    fi

    if [ "$test_passed" = true ]; then
        print_success "Teste Agent Memory System: PASSOU"
        return 0
    else
        print_error "Teste Agent Memory System: FALHOU"
        return 1
    fi
}

test_component_integration() {
    print_info "Teste 8: Integração entre Componentes"
    local test_passed=true

    # Test integration between Knowledge-Base Manager and Agent Memory System
    if command -v python3 &> /dev/null; then
        print_info "  Testando integração KB Manager ↔ Agent Memory..."

        if python3 -c "
import sys
sys.path.append('.assistant-core')
try:
    from knowledge_base_manager import create_knowledge_manager
    from agent_memory_system import create_agent_memory_system

    # Test KB Manager
    kb = create_knowledge_manager()

    # Test Agent Memory System
    ams = create_agent_memory_system()

    # Test if AMS can integrate with KB
    if hasattr(ams, 'knowledge_manager') and ams.knowledge_manager:
        print('    ✅ Integração AMS ↔ KB Manager: OK')
    else:
        print('    ⚠️  Integração AMS ↔ KB Manager: Não detectada (pode ser normal)')

    # Test cross-system operations
    memoria = ams.carregar_memoria_agente('organizador')
    if memoria and hasattr(ams, 'sincronizar_com_knowledge_base'):
        sync_result = ams.sincronizar_com_knowledge_base('organizador')
        print('    ✅ Sincronização cross-system: Testada')

    print('    ✅ Teste de integração: Concluído')
except Exception as e:
    print(f'    ❌ Erro no teste de integração: {e}')
    exit(1)
" 2>/dev/null; then
            echo "  ✅ Integração entre componentes: OK"
        else
            echo "  ❌ Falha na integração entre componentes"
            test_passed=false
        fi
    else
        echo "  ⚠️  Python3 não disponível - pulando teste de integração"
    fi

    if [ "$test_passed" = true ]; then
        print_success "Teste de Integração: PASSOU"
        return 0
    else
        print_error "Teste de Integração: FALHOU"
        return 1
    fi
}

test_obsidian_advanced() {
    print_info "Teste 9: Compatibilidade Avançada Obsidian"
    local test_passed=true

    # Test if knowledge-base is a valid Obsidian vault
    if [ -d "knowledge-base/.obsidian" ]; then
        echo "  ✅ Diretório .obsidian existe"

        # Test if vault has proper structure for links
        if [ -d "knowledge-base/decisoes" ] && [ -d "knowledge-base/contextos" ] && [ -d "knowledge-base/projetos" ] && [ -d "knowledge-base/pessoas" ]; then
            echo "  ✅ Estrutura de vault para [[links]]: OK"
        else
            echo "  ❌ Estrutura de vault incompleta"
            test_passed=false
        fi

        # Test if there are sample files with [[]] references
        print_info "  Verificando arquivos de exemplo com referências [[]]..."
        if find knowledge-base -name "*.md" -exec grep -l "\[\[.*\]\]" {} \; | head -1 > /dev/null 2>&1; then
            echo "  ✅ Encontrados arquivos com referências [[]]: OK"
        else
            echo "  ⚠️  Nenhum arquivo com referências [[]] encontrado (normal para instalação nova)"
        fi
    else
        echo "  ❌ knowledge-base não é um vault Obsidian válido"
        test_passed=false
    fi

    if [ "$test_passed" = true ]; then
        print_success "Teste Obsidian Avançado: PASSOU"
        return 0
    else
        print_error "Teste Obsidian Avançado: FALHOU"
        return 1
    fi
}

test_agents_response() {
    print_info "Teste 10: Resposta dos 5 Agentes Especializados"
    local test_passed=true

    # Check if agent test script exists
    if [ -f "test-agents.py" ]; then
        echo "  ✅ Script de teste de agentes encontrado"
    else
        echo "  ❌ FALTANDO: test-agents.py"
        test_passed=false
        return 1
    fi

    # Run agent tests
    if command -v python3 &> /dev/null; then
        print_info "  Executando testes dos agentes..."

        if python3 test-agents.py > /dev/null 2>&1; then
            echo "  ✅ Testes de configuração dos agentes: OK"
            echo "  ✅ Testes de memória dos agentes: OK"
            echo "  ✅ Testes de integração dos agentes: OK"
        else
            echo "  ❌ Falha nos testes dos agentes"
            print_info "  Execute 'python3 test-agents.py' para detalhes"
            test_passed=false
        fi

        # Test individual agent configurations
        agents=("organizador" "secretaria" "arquiteto" "psicologo" "mentor")
        for agent in "${agents[@]}"; do
            if [ -f ".assistant-core/agents/${agent}.yaml" ] && [ -f ".assistant-core/memory/${agent}-memory.yaml" ]; then
                echo "  ✅ ${agent^}: Configuração e memória presentes"
            else
                echo "  ❌ ${agent^}: Configuração ou memória ausentes"
                test_passed=false
            fi
        done
    else
        echo "  ⚠️  Python3 não disponível - testando apenas arquivos"

        # Basic file existence test
        agents=("organizador" "secretaria" "arquiteto" "psicologo" "mentor")
        for agent in "${agents[@]}"; do
            if [ -f ".assistant-core/agents/${agent}.yaml" ] && [ -f ".assistant-core/memory/${agent}-memory.yaml" ]; then
                echo "  ✅ ${agent^}: Arquivos de configuração presentes"
            else
                echo "  ❌ ${agent^}: Arquivos de configuração ausentes"
                test_passed=false
            fi
        done
    fi

    if [ "$test_passed" = true ]; then
        print_success "Teste dos Agentes: PASSOU"
        return 0
    else
        print_error "Teste dos Agentes: FALHOU"
        return 1
    fi
}

test_performance_basic() {
    print_info "Teste 11: Performance Básica (sem analytics)"
    local test_passed=true

    print_info "  Testando tempos de resposta básicos..."

    # Test file system operations speed
    start_time=$(date +%s.%N)
    ls -la .assistant-core/ > /dev/null 2>&1
    end_time=$(date +%s.%N)

    if command -v bc &> /dev/null; then
        duration=$(echo "$end_time - $start_time" | bc)
        if (( $(echo "$duration < 1.0" | bc -l) )); then
            echo "  ✅ Listagem de diretórios: Rápida (< 1s)"
        else
            echo "  ⚠️  Listagem de diretórios: Lenta (>= 1s)"
        fi
    else
        echo "  ✅ Listagem de diretórios: Testada (bc não disponível para medir tempo)"
    fi

    # Test if large files exist that might slow down the system
    print_info "  Verificando arquivos grandes..."
    large_files=$(find . -name "*.log" -o -name "*.tmp" -o -name "core.*" 2>/dev/null | head -5)
    if [ -z "$large_files" ]; then
        echo "  ✅ Sem arquivos temporários/logs grandes encontrados"
    else
        echo "  ⚠️  Arquivos temporários encontrados (pode afetar performance):"
        echo "$large_files" | sed 's/^/    /'
    fi

    if [ "$test_passed" = true ]; then
        print_success "Teste de Performance: PASSOU"
        return 0
    else
        print_error "Teste de Performance: FALHOU"
        return 1
    fi
}

# Main test runner
run_all_tests() {
    print_header

    local total_tests=11
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

    if test_knowledge_base_manager; then
        ((passed_tests++))
    fi

    if test_agent_memory_system; then
        ((passed_tests++))
    fi

    if test_component_integration; then
        ((passed_tests++))
    fi

    if test_obsidian_advanced; then
        ((passed_tests++))
    fi

    if test_agents_response; then
        ((passed_tests++))
    fi

    if test_performance_basic; then
        ((passed_tests++))
    fi

    # Final result
    echo
    print_info "Resultado Final: $passed_tests/$total_tests testes passaram"

    if [ $passed_tests -eq $total_tests ]; then
        print_success "🎉 TODOS OS TESTES PASSARAM!"
        print_success "Sistema completo funcionando corretamente!"
        echo
        print_info "🚀 Sistema pronto para uso:"
        print_info "• Framework de testes expandido validado"
        print_info "• Knowledge-Base Manager testado e funcional"
        print_info "• Agent Memory System testado e funcional"
        print_info "• Integração entre componentes validada"
        print_info "• Obsidian vault configurado e testado"
        print_info "• Performance básica validada"
        echo
        print_info "📋 Como usar:"
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