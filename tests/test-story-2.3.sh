#!/bin/bash
# Test script específico para Story 2.3: Agente Arquiteto Confrontador Completo (Método Conversacional)

echo "🧪 Testing Story 2.3: Agente Arquiteto Confrontador Completo (Método Conversacional)"
echo "====================================================================================="

EXIT_CODE=0

# Test 1: Definição do Agente Conversacional Arquiteto
echo "🤖 Test 1: Definição do Agente Arquiteto Marcus..."

agent_file=".assistant-core/agents/arquiteto.md"

if [ -f "$agent_file" ]; then
    echo "   ✅ Agent file: arquiteto.md exists"

    # Check for conversational agent structure
    if grep -q "agent:" "$agent_file" && grep -q "persona:" "$agent_file"; then
        echo "   ✅ Estrutura conversacional: Seções agent e persona presentes"
    else
        echo "   ❌ Estrutura conversacional: Estrutura YAML agent/persona ausente"
        EXIT_CODE=1
    fi

    # Check for Marcus personality and confrontador characteristics
    if grep -q "Marcus" "$agent_file" && grep -q "confrontador\|Confrontador" "$agent_file"; then
        echo "   ✅ Agent identity: Marcus with confrontador characteristics defined"
    else
        echo "   ❌ Agent identity: Missing Marcus/confrontador specialization"
        EXIT_CODE=1
    fi

    # Check for conversational commands
    if grep -q "commands:" "$agent_file" && grep -q "\*analise\|\*consultoria\|\*confronto\|\*decisao" "$agent_file"; then
        echo "   ✅ Commands: Conversational commands defined (analise, consultoria, confronto, decisao)"
    else
        echo "   ❌ Commands: Missing required conversational commands"
        EXIT_CODE=1
    fi

    # Check for technical/architectural focus
    if grep -q "arquitetura\|arquitetural\|técnico\|decisões técnicas" "$agent_file"; then
        echo "   ✅ Technical focus: Architectural and technical focus defined"
    else
        echo "   ❌ Technical focus: Missing architectural focus"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Agent file: arquiteto.md not found"
    EXIT_CODE=1
fi

# Test 2: Conversational Workflows (Tasks) do Arquiteto
echo ""
echo "📋 Test 2: Workflows conversacionais (Tasks)..."

required_tasks=(
    ".assistant-core/tasks/consultoria-tecnica.md"
    ".assistant-core/tasks/analise-projeto.md"
    ".assistant-core/tasks/confronto-tecnico.md"
    ".assistant-core/tasks/registrar-decisao.md"
    ".assistant-core/tasks/historico-decisoes.md"
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
        if grep -q "Workflow\|Processo\|Etapa\|Execução" "$task_file"; then
            echo "   ✅ Structure: Conversational workflow in $task_name"
        else
            echo "   ❌ Structure: Missing conversational structure in $task_name"
            EXIT_CODE=1
        fi

        # Task-specific validations
        case "$task_name" in
            "consultoria-tecnica")
                if grep -q "memória contextual\|contexto histórico\|decisões anteriores" "$task_file"; then
                    echo "   ✅ Context: Memory-based consultancy in $task_name"
                else
                    echo "   ❌ Context: Missing historical context reference"
                    EXIT_CODE=1
                fi
                ;;
            "confronto-tecnico")
                if grep -q "Por que não\|E se\|construtivo" "$task_file"; then
                    echo "   ✅ Questioning: Confrontational questioning patterns in $task_name"
                else
                    echo "   ❌ Questioning: Missing confrontational patterns"
                    EXIT_CODE=1
                fi
                ;;
            "registrar-decisao")
                if grep -q "cross-referencing\|\\[\\[" "$task_file"; then
                    echo "   ✅ Cross-ref: Cross-referencing logic in $task_name"
                else
                    echo "   ❌ Cross-ref: Missing cross-referencing"
                    EXIT_CODE=1
                fi
                ;;
        esac

    else
        echo "   ❌ Task: $task_file missing"
        EXIT_CODE=1
    fi
done

# Test 3: Agent Memory System do Arquiteto
echo ""
echo "🧠 Test 3: Sistema de memória contextual profunda..."

memory_file=".assistant-core/memory/arquiteto-memory.yaml"

if [ -f "$memory_file" ]; then
    echo "   ✅ Memory file: arquiteto-memory.yaml exists"

    # Check for agent identity
    if grep -q "agent_identity:" "$memory_file" && grep -q "Marcus" "$memory_file"; then
        echo "   ✅ Identity: Agent Marcus identity in memory"
    else
        echo "   ❌ Identity: Missing agent identity in memory"
        EXIT_CODE=1
    fi

    # Check for architectural patterns tracking
    if grep -q "preferencias_arquiteturais\|decisoes_recorrentes\|padroes_evitados" "$memory_file"; then
        echo "   ✅ Architectural patterns: Pattern tracking present"
    else
        echo "   ❌ Architectural patterns: Missing pattern tracking"
        EXIT_CODE=1
    fi

    # Check for interaction history with technical context
    if grep -q "interaction_history:\|total_consultorias\|total_confrontos\|total_decisoes" "$memory_file"; then
        echo "   ✅ Technical history: Technical interaction tracking present"
    else
        echo "   ❌ Technical history: Missing technical interaction tracking"
        EXIT_CODE=1
    fi

    # Check for cross-agent context
    if grep -q "cross_agent_context:\|mentor:\|secretaria:" "$memory_file"; then
        echo "   ✅ Cross-agent: Collaboration context with other agents present"
    else
        echo "   ❌ Cross-agent: Missing cross-agent collaboration context"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Memory file: arquiteto-memory.yaml not found"
    EXIT_CODE=1
fi

# Test 4: Template de Decisão Técnica
echo ""
echo "📄 Test 4: Template de decisão técnica..."

template_file=".assistant-core/templates/decisao-tecnica.yaml"

if [ -f "$template_file" ]; then
    echo "   ✅ Template: decisao-tecnica.yaml exists"

    # Check for technical decision sections
    if grep -q "rationale\|consequences\|options" "$template_file"; then
        echo "   ✅ Decision sections: Rationale, consequences, options present"
    else
        echo "   ❌ Decision sections: Missing critical decision sections"
        EXIT_CODE=1
    fi

    # Check for auto-linking
    if grep -q "auto_link_people\|auto_link_projects\|auto_link_technologies" "$template_file"; then
        echo "   ✅ Auto-linking: Cross-referencing automation configured"
    else
        echo "   ❌ Auto-linking: Missing auto-linking configuration"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Template: decisao-tecnica.yaml not found"
    EXIT_CODE=1
fi

# Test 5: Integration with Knowledge-Base (Unique Files Structure)
echo ""
echo "🗄️  Test 5: Integração com estrutura de arquivos únicos..."

# Check if knowledge-base structure supports decisoes/
if [ -d "knowledge-base/decisoes" ]; then
    echo "   ✅ KB Structure: knowledge-base/decisoes/ directory exists"
else
    echo "   ⚠️  KB Structure: knowledge-base/decisoes/ directory missing (will be created on first use)"
fi

# Check for cross-referencing with projetos/
if [ -d "knowledge-base/projetos" ]; then
    echo "   ✅ KB Integration: knowledge-base/projetos/ available for cross-referencing"
else
    echo "   ❌ KB Integration: knowledge-base/projetos/ missing (required for integration)"
    EXIT_CODE=1
fi

# Check for cross-referencing with pessoas/
if [ -d "knowledge-base/pessoas" ]; then
    echo "   ✅ KB Integration: knowledge-base/pessoas/ available for cross-referencing"
else
    echo "   ❌ KB Integration: knowledge-base/pessoas/ missing (required for integration)"
    EXIT_CODE=1
fi

# Test 6: Compatibility with Previous Stories (2.1 Organizador, 2.2 Secretária)
echo ""
echo "🔗 Test 6: Compatibilidade com stories anteriores..."

# Check if Organizador exists (Story 2.1)
if [ -f ".assistant-core/agents/organizador.md" ]; then
    echo "   ✅ Story 2.1: Organizador agent exists (compatibility OK)"
else
    echo "   ❌ Story 2.1: Missing Organizador agent (dependency)"
    EXIT_CODE=1
fi

# Check if Secretária exists (Story 2.2)
if [ -f ".assistant-core/agents/secretaria.md" ]; then
    echo "   ✅ Story 2.2: Secretária agent exists (compatibility OK)"
else
    echo "   ❌ Story 2.2: Missing Secretária agent (dependency)"
    EXIT_CODE=1
fi

# Test 7: Confrontational and Questioning Patterns
echo ""
echo "❓ Test 7: Padrões de confronto construtivo e questionamento..."

# Check confronto-tecnico for questioning patterns
confronto_file=".assistant-core/tasks/confronto-tecnico.md"
if [ -f "$confronto_file" ]; then
    # Check for "Por que não" patterns
    if grep -q "Por que não\|Por que você" "$confronto_file"; then
        echo "   ✅ Questioning: 'Por que não X?' pattern present"
    else
        echo "   ❌ Questioning: Missing 'Por que não' questioning pattern"
        EXIT_CODE=1
    fi

    # Check for "E se" patterns
    if grep -q "E se\|e se.*acontecer" "$confronto_file"; then
        echo "   ✅ Scenarios: 'E se...?' scenario exploration present"
    else
        echo "   ❌ Scenarios: Missing 'E se' scenario patterns"
        EXIT_CODE=1
    fi

    # Check for historical context requirement
    if grep -q "OBRIGATÓRIO.*histórico\|CRÍTICO.*contexto histórico" "$confronto_file"; then
        echo "   ✅ Historical: Mandatory historical context validation present"
    else
        echo "   ❌ Historical: Missing mandatory historical context requirement"
        EXIT_CODE=1
    fi
else
    echo "   ❌ File: confronto-tecnico.md missing"
    EXIT_CODE=1
fi

# Test 8: No BMAD References (Validation per IMPORTANTE-LEIA-PRIMEIRO.md)
echo ""
echo "🚫 Test 8: Validação de ausência de referências ao BMAD..."

# Check agent file for BMAD references
if grep -i "bmad\|.bmad-core" "$agent_file" 2>/dev/null; then
    echo "   ❌ BMAD reference: Found BMAD references in $agent_file (PROHIBITED)"
    EXIT_CODE=1
else
    echo "   ✅ BMAD reference: No BMAD references in agent file"
fi

# Check tasks for BMAD references
bmad_found=0
for task_file in "${required_tasks[@]}"; do
    if [ -f "$task_file" ] && grep -i "bmad\|.bmad-core" "$task_file" 2>/dev/null; then
        echo "   ❌ BMAD reference: Found BMAD references in $task_file (PROHIBITED)"
        bmad_found=1
    fi
done

if [ $bmad_found -eq 0 ]; then
    echo "   ✅ BMAD reference: No BMAD references in task files"
else
    EXIT_CODE=1
fi

# Test 9: Cross-Agent Intelligence Implementation
echo ""
echo "🤝 Test 9: Implementação de Cross-Agent Intelligence..."

# Check for Mentor collaboration mentions
if grep -q "mentor\|Mentor.*carreira\|alinhamento.*carreira" "$agent_file"; then
    echo "   ✅ Mentor collaboration: Mentor agent collaboration defined"
else
    echo "   ❌ Mentor collaboration: Missing Mentor collaboration"
    EXIT_CODE=1
fi

# Check for Secretária collaboration mentions
if grep -q "secretaria\|Secretária.*deadlines\|projetos_tecnicos" "$agent_file" || grep -q "secretaria" "$memory_file"; then
    echo "   ✅ Secretária collaboration: Secretária agent collaboration defined"
else
    echo "   ❌ Secretária collaboration: Missing Secretária collaboration"
    EXIT_CODE=1
fi

# Test 10: Validation of All Acceptance Criteria
echo ""
echo "✅ Test 10: Validação de todos os critérios de aceitação..."

ac_count=0

# AC1: Consultoria Técnica com Memória Contextual Profunda
if [ -f ".assistant-core/tasks/consultoria-tecnica.md" ] && grep -q "contexto histórico\|memória" ".assistant-core/tasks/consultoria-tecnica.md"; then
    echo "   ✅ AC1: Consultoria técnica com memória contextual implementada"
    ((ac_count++))
else
    echo "   ❌ AC1: Consultoria técnica com memória contextual FALHOU"
    EXIT_CODE=1
fi

# AC2: Análise Crítica de Projetos via URLs/Repositórios
if [ -f ".assistant-core/tasks/analise-projeto.md" ] && grep -q "URL\|repositório\|código" ".assistant-core/tasks/analise-projeto.md"; then
    echo "   ✅ AC2: Análise crítica de projetos e código implementada"
    ((ac_count++))
else
    echo "   ❌ AC2: Análise crítica de projetos FALHOU"
    EXIT_CODE=1
fi

# AC3: Discussão Técnica Especializada sobre Padrões
if [ -f ".assistant-core/tasks/consultoria-tecnica.md" ] && grep -q "padrões\|trade-offs\|alternativas" ".assistant-core/tasks/consultoria-tecnica.md"; then
    echo "   ✅ AC3: Discussão técnica especializada implementada"
    ((ac_count++))
else
    echo "   ❌ AC3: Discussão técnica especializada FALHOU"
    EXIT_CODE=1
fi

# AC4: Integração com Knowledge-Base Técnica
if [ -f ".assistant-core/tasks/registrar-decisao.md" ] && grep -q "knowledge-base\|\\[\\[.*\\]\\]" ".assistant-core/tasks/registrar-decisao.md"; then
    echo "   ✅ AC4: Integração com knowledge-base técnica implementada"
    ((ac_count++))
else
    echo "   ❌ AC4: Integração com knowledge-base FALHOU"
    EXIT_CODE=1
fi

# AC5: Análise de Código e Questionamento Ativo
if [ -f ".assistant-core/tasks/analise-projeto.md" ] && grep -q "Por que\|E se" ".assistant-core/tasks/analise-projeto.md"; then
    echo "   ✅ AC5: Análise de código com questionamento ativo implementada"
    ((ac_count++))
else
    echo "   ❌ AC5: Análise de código com questionamento FALHOU"
    EXIT_CODE=1
fi

# AC6: Tracking Contínuo de Decisões
if [ -f ".assistant-core/tasks/historico-decisoes.md" ]; then
    echo "   ✅ AC6: Tracking contínuo de decisões implementado"
    ((ac_count++))
else
    echo "   ❌ AC6: Tracking contínuo de decisões FALHOU"
    EXIT_CODE=1
fi

echo ""
echo "   📊 Acceptance Criteria Score: $ac_count/6"

if [ $ac_count -eq 6 ]; then
    echo "   ✅ All acceptance criteria met!"
else
    echo "   ❌ Some acceptance criteria failed"
    EXIT_CODE=1
fi

# Final Summary
echo ""
echo "========================================================="
if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ All tests PASSED - Story 2.3 implementation complete!"
else
    echo "❌ Some tests FAILED - Review implementation"
fi
echo "========================================================="

exit $EXIT_CODE