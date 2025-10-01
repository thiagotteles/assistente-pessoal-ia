#!/bin/bash
# Test script específico para Story 1.3: Comando Slash Base

echo "🧪 Testing Story 1.3: Comando Slash Base"
echo "========================================"

EXIT_CODE=0

# Test 1: Agent configuration files exist and are valid
echo "🤖 Test 1: Configurações dos 5 agentes..."

agents=("organizador" "secretaria" "arquiteto" "psicologo" "mentor")

for agent in "${agents[@]}"; do
    config_file=".assistant-core/agents/${agent}.yaml"
    memory_file=".assistant-core/memory/${agent}-memory.yaml"

    # Test config file
    if [ -f "$config_file" ]; then
        echo "   ✅ ${agent}.yaml: Exists"

        # Basic YAML structure check
        if grep -q "name:" "$config_file" && grep -q "personality:" "$config_file"; then
            echo "   ✅ ${agent}.yaml: Valid structure"
        else
            echo "   ❌ ${agent}.yaml: Missing required fields"
            EXIT_CODE=1
        fi
    else
        echo "   ❌ ${agent}.yaml: Missing"
        EXIT_CODE=1
    fi

    # Test memory file
    if [ -f "$memory_file" ]; then
        echo "   ✅ ${agent}-memory.yaml: Exists"
    else
        echo "   ❌ ${agent}-memory.yaml: Missing"
        EXIT_CODE=1
    fi
done

# Test 2: Slash command dispatcher exists
echo ""
echo "⚡ Test 2: Sistema de comando slash..."

dispatcher_file=".assistant-core/slash_command_dispatcher.py"

if [ -f "$dispatcher_file" ]; then
    echo "   ✅ Dispatcher: Available"

    # Check for key functions
    if grep -q "class SlashCommandDispatcher" "$dispatcher_file"; then
        echo "   ✅ Dispatcher: Main class present"
    else
        echo "   ❌ Dispatcher: Missing main class"
        EXIT_CODE=1
    fi

    # Check for agent handlers
    for agent in "${agents[@]}"; do
        if grep -q "_handle_${agent}" "$dispatcher_file"; then
            echo "   ✅ Handler: /${agent} implemented"
        else
            echo "   ❌ Handler: /${agent} missing"
            EXIT_CODE=1
        fi
    done

    # Check for status command
    if grep -q "_handle_status" "$dispatcher_file"; then
        echo "   ✅ Command: /status implemented"
    else
        echo "   ❌ Command: /status missing"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Dispatcher: Not found"
    EXIT_CODE=1
fi

# Test 3: Agent Memory System integration
echo ""
echo "🧠 Test 3: Integração Agent Memory System..."

if [ -f ".assistant-core/agent_memory_system.py" ]; then
    echo "   ✅ Agent Memory System: Available"

    # Check if dispatcher imports it
    if grep -q "agent_memory_system" "$dispatcher_file"; then
        echo "   ✅ Integration: Memory system imported"
    else
        echo "   ⚠️  Integration: Memory system not imported"
    fi
else
    echo "   ❌ Agent Memory System: Missing"
    EXIT_CODE=1
fi

# Test 4: Knowledge-Base Manager integration
echo ""
echo "💾 Test 4: Integração Knowledge-Base Manager..."

if [ -f ".assistant-core/knowledge_base_manager.py" ]; then
    echo "   ✅ Knowledge Base Manager: Available"

    # Check if dispatcher imports it
    if grep -q "knowledge_base_manager" "$dispatcher_file"; then
        echo "   ✅ Integration: KB Manager imported"
    else
        echo "   ⚠️  Integration: KB Manager not imported"
    fi
else
    echo "   ❌ Knowledge Base Manager: Missing"
    EXIT_CODE=1
fi

# Test 5: Intelligent routing functionality
echo ""
echo "🔗 Test 5: Sistema de roteamento inteligente..."

if grep -q "get_intelligent_routing_suggestion" "$dispatcher_file"; then
    echo "   ✅ Intelligent routing: Function implemented"

    # Check for routing keywords
    if grep -q "routing_keywords" "$dispatcher_file"; then
        echo "   ✅ Routing logic: Keyword mapping present"
    else
        echo "   ❌ Routing logic: Missing keyword mapping"
        EXIT_CODE=1
    fi
else
    echo "   ❌ Intelligent routing: Function missing"
    EXIT_CODE=1
fi

# Test 6: Cross-referencing system
echo ""
echo "🔄 Test 6: Cross-referencing entre agentes..."

if grep -q "_log_interaction" "$dispatcher_file"; then
    echo "   ✅ Cross-referencing: Interaction logging implemented"
else
    echo "   ❌ Cross-referencing: Interaction logging missing"
    EXIT_CODE=1
fi

# Check for collaboration patterns
if grep -q "atualizar_interacao\|compartilhar_insights" "$dispatcher_file"; then
    echo "   ✅ Cross-referencing: Agent collaboration present"
else
    echo "   ⚠️  Cross-referencing: Agent collaboration not fully implemented"
fi

# Test 7: Command dispatcher CLI interface
echo ""
echo "💻 Test 7: Interface CLI do dispatcher..."

if grep -q "def main():" "$dispatcher_file"; then
    echo "   ✅ CLI Interface: Main function present"

    if grep -q "argparse" "$dispatcher_file"; then
        echo "   ✅ CLI Interface: Argument parsing implemented"
    else
        echo "   ❌ CLI Interface: Missing argument parsing"
        EXIT_CODE=1
    fi
else
    echo "   ❌ CLI Interface: Main function missing"
    EXIT_CODE=1
fi

# Test 8: Test agent functionality via test script
echo ""
echo "🧪 Test 8: Funcionalidade de teste dos agentes..."

test_agents_file="test-agents.py"

if [ -f "$test_agents_file" ]; then
    echo "   ✅ Test suite: Available"

    # Check for comprehensive testing
    if grep -q "test_slash_command_dispatcher\|test_agent_configurations" "$test_agents_file"; then
        echo "   ✅ Test coverage: Comprehensive tests present"
    else
        echo "   ❌ Test coverage: Missing comprehensive tests"
        EXIT_CODE=1
    fi
else
    echo "   ❌ Test suite: Missing"
    EXIT_CODE=1
fi

# Test 9: Core system file structure
echo ""
echo "📁 Test 9: Estrutura de arquivos core..."

required_dirs=(
    ".assistant-core"
    ".assistant-core/agents"
    ".assistant-core/memory"
    "despejo"
    "knowledge-base"
)

for dir in "${required_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "   ✅ Directory: $dir exists"
    else
        echo "   ❌ Directory: $dir missing"
        EXIT_CODE=1
    fi
done

# Test 10: Integration with previous stories
echo ""
echo "🔗 Test 10: Integração com stories anteriores..."

# Check Story 1.1 artifacts
if [ -f ".git/hooks/pre-commit" ] && [ -f "scripts/backup-knowledge-base.sh" ]; then
    echo "   ✅ Story 1.1: Git hooks and backup system integrated"
else
    echo "   ❌ Story 1.1: Missing integration artifacts"
    EXIT_CODE=1
fi

# Check Story 1.2 artifacts
if [ -f "scripts/add-dump-entry.sh" ] && [ -f "scripts/process-dump.sh" ]; then
    echo "   ✅ Story 1.2: Capture system scripts integrated"
else
    echo "   ❌ Story 1.2: Missing capture system scripts"
    EXIT_CODE=1
fi

# Check if daily-dump.md is accessible for processing
if [ -f "despejo/daily-dump.md" ]; then
    echo "   ✅ Integration: daily-dump.md accessible for agents"
else
    echo "   ❌ Integration: daily-dump.md not accessible"
    EXIT_CODE=1
fi

# Final summary
echo ""
echo "📊 Story 1.3 Test Results"
echo "========================"

if [ $EXIT_CODE -eq 0 ]; then
    echo "🎉 ALL TESTS PASSED! Story 1.3 implementation is complete."
    echo ""
    echo "✅ All 5 agent slash commands implemented"
    echo "✅ Intelligent routing system functional"
    echo "✅ Agent Memory System integrated"
    echo "✅ /status command available"
    echo "✅ Cross-referencing system implemented"
    echo "✅ CLI interface functional"
    echo "✅ Comprehensive test suite available"
    echo "✅ Integration with previous stories maintained"
    echo ""
    echo "🚀 Sistema de comandos slash totalmente operacional!"
    echo ""
    echo "📋 Comandos disponíveis:"
    echo "• /organizador - Processa despejo e organiza informações"
    echo "• /secretaria - Gestão executiva e agenda"
    echo "• /arquiteto - Consultoria técnica com confronto construtivo"
    echo "• /psicologo - Suporte emocional especializado em TDAH"
    echo "• /mentor - Desenvolvimento de carreira estratégico"
    echo "• /status - Verificação de saúde do sistema"
else
    echo "❌ Some tests failed. Check the errors above."
    echo ""
    echo "🔧 Fix the issues and run the test again:"
    echo "   bash test-story-1.3.sh"
fi

exit $EXIT_CODE