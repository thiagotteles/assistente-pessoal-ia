#!/bin/bash
# Test script específico para Story 2.1: Agente Organizador Completo (Método Conversacional)

echo "🧪 Testing Story 2.1: Agente Organizador Completo (Método Conversacional)"
echo "========================================================="

EXIT_CODE=0

# Test 1: Definição do Agente Conversacional
echo "🤖 Test 1: Definição do Agente Organizador Sofia..."

agent_file=".assistant-core/agents/organizador.md"

if [ -f "$agent_file" ]; then
    echo "   ✅ Agent file: organizador.md exists"

    # Check for conversational agent structure
    if grep -q "agent:" "$agent_file" && grep -q "persona:" "$agent_file"; then
        echo "   ✅ Estrutura conversacional: Seções agent e persona presentes"
    else
        echo "   ❌ Estrutura conversacional: Estrutura YAML agent/persona ausente"
        EXIT_CODE=1
    fi

    # Check for Sofia personality
    if grep -q "Sofia" "$agent_file" && grep -q "TDAH" "$agent_file"; then
        echo "   ✅ Agent identity: Sofia with TDAH specialization defined"
    else
        echo "   ❌ Agent identity: Missing Sofia/TDAH specialization"
        EXIT_CODE=1
    fi

    # Check for conversational commands
    if grep -q "commands:" "$agent_file" && grep -q "\*processar\|\*organizar" "$agent_file"; then
        echo "   ✅ Commands: Conversational commands defined"
    else
        echo "   ❌ Commands: Missing conversational command structure"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Agent file: organizador.md not found"
    EXIT_CODE=1
fi

# Test 2: Conversational Workflows (Tasks)
echo ""
echo "📋 Test 2: Workflows conversacionais (Tasks)..."

required_tasks=(
    ".assistant-core/tasks/processar-despejo.md"
    ".assistant-core/tasks/organizar-por-projeto.md"
    ".assistant-core/tasks/revisar-pendencias.md"
)

for task_file in "${required_tasks[@]}"; do
    if [ -f "$task_file" ]; then
        task_name=$(basename "$task_file" .md)
        echo "   ✅ Task: $task_name exists"

        # Check for YAML configuration
        if grep -q "elicit:\|language:\|interaction_style:" "$task_file"; then
            echo "   ✅ Configuration: YAML config present in $task_name"
        else
            echo "   ❌ Configuration: Missing YAML config in $task_name"
            EXIT_CODE=1
        fi

        # Check for conversational structure
        if grep -q "Workflow\|Etapa\|Conversação" "$task_file"; then
            echo "   ✅ Structure: Conversational workflow in $task_name"
        else
            echo "   ❌ Structure: Missing conversational structure in $task_name"
            EXIT_CODE=1
        fi

    else
        echo "   ❌ Task: $task_file missing"
        EXIT_CODE=1
    fi
done

# Test 3: Agent Memory System
echo ""
echo "🧠 Test 3: Sistema de memória adaptativa..."

memory_file=".assistant-core/memory/organizador-memory.yaml"

if [ -f "$memory_file" ]; then
    echo "   ✅ Memory file: organizador-memory.yaml exists"

    # Check for agent identity
    if grep -q "agent_identity:" "$memory_file" && grep -q "Sofia" "$memory_file"; then
        echo "   ✅ Identity: Agent Sofia identity in memory"
    else
        echo "   ❌ Identity: Missing agent identity in memory"
        EXIT_CODE=1
    fi

    # Check for TDAH-specific patterns
    if grep -q "tdah_indicators:" "$memory_file" && grep -q "stress_words\|overwhelm_patterns" "$memory_file"; then
        echo "   ✅ TDAH patterns: TDAH-specific tracking present"
    else
        echo "   ❌ TDAH patterns: Missing TDAH pattern tracking"
        EXIT_CODE=1
    fi

    # Check for learning metrics
    if grep -q "interaction_history:\|performance_metrics:" "$memory_file"; then
        echo "   ✅ Learning: Interaction tracking and metrics present"
    else
        echo "   ❌ Learning: Missing learning/tracking systems"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Memory file: organizador-memory.yaml not found"
    EXIT_CODE=1
fi

# Test 4: YAML Templates
echo ""
echo "📄 Test 4: Templates YAML inteligentes..."

required_templates=(
    ".assistant-core/templates/entrada-categorizada.yaml"
    ".assistant-core/templates/todo-extraido.yaml"
    ".assistant-core/templates/relatorio-sessao.yaml"
)

for template_file in "${required_templates[@]}"; do
    if [ -f "$template_file" ]; then
        template_name=$(basename "$template_file" .yaml)
        echo "   ✅ Template: $template_name exists"

        # Check for TDAH considerations
        if grep -q "tdah\|TDAH\|overwhelm\|emotional" "$template_file"; then
            echo "   ✅ TDAH context: TDAH considerations in $template_name"
        else
            echo "   ⚠️  TDAH context: Limited TDAH context in $template_name"
        fi

        # Check for template variables
        if grep -q "{{.*}}" "$template_file"; then
            echo "   ✅ Variables: Template variables in $template_name"
        else
            echo "   ❌ Variables: Missing template variables in $template_name"
            EXIT_CODE=1
        fi

    else
        echo "   ❌ Template: $template_file missing"
        EXIT_CODE=1
    fi
done

# Test 5: NO Python Scripts (Método Conversacional)
echo ""
echo "🚫 Test 5: Verificação Conversacional - Ausência de scripts Python..."

# Check for incorrect Python implementations
python_files=$(find .assistant-core -name "*.py" 2>/dev/null | grep -E "(organizador|organizer)" | wc -l)

if [ "$python_files" -eq 0 ]; then
    echo "   ✅ Conformidade conversacional: Nenhum script Python para lógica de agente"
else
    echo "   ❌ Violação conversacional: Encontrados $python_files scripts Python para lógica de agente"
    find .assistant-core -name "*.py" | grep -E "(organizador|organizer)"
    EXIT_CODE=1
fi

# Check for traditional code patterns that shouldn't exist
if [ -f "$agent_file" ]; then
    if grep -q "\bclass\s\|^def\s\|^import\s\|function(" "$agent_file"; then
        echo "   ❌ Violação conversacional: Padrões de código tradicional encontrados na definição do agente"
        EXIT_CODE=1
    else
        echo "   ✅ Estrutura conversacional: Definição pura de agente conversacional"
    fi
fi

# Test 6: Portuguese Language Implementation
echo ""
echo "🇧🇷 Test 6: Implementação em português..."

portuguese_files=0

for file in "$agent_file" "${required_tasks[@]}" "$memory_file"; do
    if [ -f "$file" ] && grep -q "português\|empática\|bem-estar\|conversação" "$file"; then
        portuguese_files=$((portuguese_files + 1))
    fi
done

if [ "$portuguese_files" -ge 4 ]; then
    echo "   ✅ Language: Portuguese implementation detected in $portuguese_files files"
else
    echo "   ❌ Language: Insufficient Portuguese implementation"
    EXIT_CODE=1
fi

# Test 7: Integration with Existing Systems
echo ""
echo "🔗 Test 7: Integração com sistemas existentes..."

# Check integration with knowledge-base
if [ -d "knowledge-base" ] && [ -f "$agent_file" ]; then
    if grep -q "knowledge-base\|Knowledge-Base" "$agent_file"; then
        echo "   ✅ Knowledge-base: Integration referenced in agent"
    else
        echo "   ⚠️  Knowledge-base: Limited integration reference"
    fi
fi

# Check integration with central todos
if [ -f "todos/central-todos.md" ] && [ -f ".assistant-core/tasks/processar-despejo.md" ]; then
    if grep -q "central-todos\|todos" ".assistant-core/tasks/processar-despejo.md"; then
        echo "   ✅ Central todos: Integration with todos system"
    else
        echo "   ❌ Central todos: Missing todos integration"
        EXIT_CODE=1
    fi
fi

# Check for daily-dump.txt processing
if [ -f "despejo/daily-dump.txt" ] && [ -f ".assistant-core/tasks/processar-despejo.md" ]; then
    if grep -q "daily-dump\|despejo" ".assistant-core/tasks/processar-despejo.md"; then
        echo "   ✅ Daily dump: Integration with capture system"
    else
        echo "   ❌ Daily dump: Missing daily-dump integration"
        EXIT_CODE=1
    fi
fi

# Test 8: Elicitation Methods Integration
echo ""
echo "🔍 Test 8: Integração com métodos de elicitação..."

elicitation_file=".assistant-core/data/elicitation-methods.md"

if [ -f "$elicitation_file" ]; then
    echo "   ✅ Elicitation methods: File present"

    # Check if tasks reference elicitation methods
    tasks_with_elicitation=0
    for task_file in "${required_tasks[@]}"; do
        if [ -f "$task_file" ] && grep -q "elicit.*true\|perguntas\|question" "$task_file"; then
            tasks_with_elicitation=$((tasks_with_elicitation + 1))
        fi
    done

    if [ "$tasks_with_elicitation" -ge 2 ]; then
        echo "   ✅ Integration: $tasks_with_elicitation tasks use elicitation"
    else
        echo "   ❌ Integration: Insufficient elicitation integration"
        EXIT_CODE=1
    fi

else
    echo "   ⚠️  Elicitation methods: File not found (may be in different location)"
fi

# Test 9: Documentação do Método Conversacional
echo ""
echo "📚 Test 9: Documentação do Método Conversacional..."

guidelines_file="docs/architecture/agentes-conversacionais-guidelines.md"

if [ -f "$guidelines_file" ]; then
    echo "   ✅ Guidelines: Diretrizes conversacionais existem"

    # Check for critical sections
    if grep -q "O Que NÃO É\|O Que É o Método Conversacional" "$guidelines_file"; then
        echo "   ✅ Content: Distinções claras entre implementação correta/incorreta"
    else
        echo "   ❌ Content: Distinções conversacionais ausentes"
        EXIT_CODE=1
    fi

    # Check for examples
    if grep -q "Exemplos\|Examples" "$guidelines_file" && grep -q "ERRADO\|CORRETO" "$guidelines_file"; then
        echo "   ✅ Examples: Correct/incorrect examples provided"
    else
        echo "   ❌ Examples: Missing practical examples"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Guidelines: Documentação das diretrizes conversacionais ausente"
    EXIT_CODE=1
fi

# Test 10: Story 2.1 Documentation Update
echo ""
echo "📋 Test 10: Atualização da documentação Story 2.1..."

story_file="docs/stories/2.1.story.md"

if [ -f "$story_file" ]; then
    echo "   ✅ Story file: 2.1.story.md exists"

    # Check for completion markers
    if grep -q "\[x\].*Tarefa.*:" "$story_file"; then
        completed_tasks=$(grep -c "\[x\].*Tarefa.*:" "$story_file")
        echo "   ✅ Completion: $completed_tasks tasks marked as completed"
    else
        echo "   ❌ Completion: No completed tasks marked"
        EXIT_CODE=1
    fi

    # Check for conversational implementation notes
    if grep -q "Conversacional.*Completa\|implementação.*conversacional" "$story_file"; then
        echo "   ✅ Notas conversacionais: Implementação conversacional documentada"
    else
        echo "   ❌ Notas conversacionais: Documentação de implementação conversacional ausente"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Story file: 2.1.story.md not found"
    EXIT_CODE=1
fi

# Final summary
echo ""
echo "📊 Story 2.1 Test Results"
echo "========================="

if [ $EXIT_CODE -eq 0 ]; then
    echo "🎉 TODOS OS TESTES PASSARAM! Implementação conversacional da Story 2.1 completa."
    echo ""
    echo "✅ Agente Sofia: Agente conversacional com especialização em TDAH"
    echo "✅ Workflows: Tasks conversacionais com suporte a elicitação"
    echo "✅ Sistema de Memória: Aprendizado adaptativo e personalização"
    echo "✅ Templates: Templates YAML para saídas estruturadas"
    echo "✅ Conformidade Conversacional: Sem scripts Python, abordagem puramente conversacional"
    echo "✅ Português: Implementação nativa em português"
    echo "✅ Integração: Conectado com sistemas knowledge-base e todos"
    echo "✅ Documentação: Diretrizes conversacionais completas e atualizações da story"
    echo ""
    echo "🚀 Agente Organizador Sofia totalmente funcional via método conversacional!"
    echo ""
    echo "📋 Como usar o agente:"
    echo "• /organizador *processar - Processar daily-dump.txt"
    echo "• /organizador *organizar - Organizar por projeto"
    echo "• /organizador *revisar - Revisar pendências"
    echo "• /organizador *relatorio - Gerar relatório de sessão"
    echo "• /organizador *menu - Ver todos os comandos"
    echo ""
    echo "🤖 Personalidade Sofia:"
    echo "• Empática e estruturada"
    echo "• Especialista em TDAH"
    echo "• Comunicação natural em português"
    echo "• Máximo 3 perguntas por entrada"
    echo "• Aprendizado contínuo de padrões"
else
    echo "❌ Alguns testes falharam. Verifique os erros acima."
    echo ""
    echo "🔧 Corrija os problemas e execute o teste novamente:"
    echo "   bash test-story-2.1.sh"
    echo ""
    echo "💡 Lembre-se: O método conversacional usa agentes conversacionais, não scripts Python!"
fi

exit $EXIT_CODE