#!/bin/bash
# Test script específico para Story 2.4: Agente Psicólogo Supportivo (Método Conversacional)

echo "🧪 Testing Story 2.4: Agente Psicólogo Supportivo (Método Conversacional)"
echo "==============================================================================="

EXIT_CODE=0

# Test 1: Definição do Agente Conversacional Psicólogo
echo "🧠 Test 1: Definição do Agente Psicólogo Dr. Helena..."

agent_file=".assistant-core/agents/psicologo.md"

if [ -f "$agent_file" ]; then
    echo "   ✅ Agent file: psicologo.md exists"

    # Check for conversational agent structure
    if grep -q "agent:" "$agent_file" && grep -q "persona:" "$agent_file"; then
        echo "   ✅ Estrutura conversacional: Seções agent e persona presentes"
    else
        echo "   ❌ Estrutura conversacional: Estrutura YAML agent/persona ausente"
        EXIT_CODE=1
    fi

    # Check for Dr. Helena personality and empathetic characteristics
    if grep -q "Helena\|Psicólog" "$agent_file" && grep -q "empát\|acolhedor\|TDAH" "$agent_file"; then
        echo "   ✅ Agent identity: Psicólogo with empathetic TDAH specialization defined"
    else
        echo "   ❌ Agent identity: Missing Psicólogo/empathetic/TDAH specialization"
        EXIT_CODE=1
    fi

    # Check for conversational commands
    if grep -q "commands:" "$agent_file" && grep -q "analise\|suporte\|tecnicas\|procrastinacao" "$agent_file"; then
        echo "   ✅ Commands: Conversational commands defined (analise, suporte, tecnicas, procrastinacao)"
    else
        echo "   ❌ Commands: Missing required conversational commands"
        EXIT_CODE=1
    fi

    # Check for TDAH/emotional support focus
    if grep -q "TDAH\|emocional\|humor\|energia\|autorregulação" "$agent_file"; then
        echo "   ✅ Support focus: TDAH and emotional support focus defined"
    else
        echo "   ❌ Support focus: Missing TDAH/emotional support focus"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Agent file: psicologo.md not found"
    EXIT_CODE=1
fi

# Test 2: Conversational Workflows (Tasks) do Psicólogo
echo ""
echo "📋 Test 2: Workflows conversacionais (Tasks)..."

required_tasks=(
    ".assistant-core/tasks/analise-humor.md"
    ".assistant-core/tasks/suporte-emocional.md"
    ".assistant-core/tasks/sugerir-tecnicas.md"
    ".assistant-core/tasks/detectar-procrastinacao.md"
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
            echo "   ✅ Structure: Conversational workflow structure in $task_name"
        else
            echo "   ❌ Structure: Missing conversational workflow in $task_name"
            EXIT_CODE=1
        fi

    else
        echo "   ❌ Task: $(basename $task_file) not found"
        EXIT_CODE=1
    fi
done

# Test 3: Sistema de Memória Contextual do Psicólogo
echo ""
echo "🧠 Test 3: Sistema de memória contextual..."

memory_file=".assistant-core/memory/psicologo-memory.yaml"

if [ -f "$memory_file" ]; then
    echo "   ✅ Memory file: psicologo-memory.yaml exists"

    # Check for user patterns tracking
    if grep -q "user_patterns:\|indicadores_emocionais\|padroes_procrastinacao" "$memory_file"; then
        echo "   ✅ User patterns: Tracking structure for emotional patterns present"
    else
        echo "   ❌ User patterns: Missing tracking structure"
        EXIT_CODE=1
    fi

    # Check for cross-agent collaboration config
    if grep -q "cross_agent_collaboration:\|organizador:\|secretaria:" "$memory_file"; then
        echo "   ✅ Cross-agent: Collaboration structure configured"
    else
        echo "   ❌ Cross-agent: Missing collaboration configuration"
        EXIT_CODE=1
    fi

    # Check for interaction history tracking
    if grep -q "interaction_history:\|total_analises_humor\|total_suportes_emocionais" "$memory_file"; then
        echo "   ✅ History tracking: Interaction history structure present"
    else
        echo "   ❌ History tracking: Missing history structure"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Memory file: psicologo-memory.yaml not found"
    EXIT_CODE=1
fi

# Test 4: Biblioteca de Técnicas TDAH
echo ""
echo "📚 Test 4: Biblioteca de técnicas TDAH..."

tecnicas_file=".assistant-core/data/tecnicas-tdah.md"

if [ -f "$tecnicas_file" ]; then
    echo "   ✅ Library file: tecnicas-tdah.md exists"

    # Check for evidence-based techniques categories
    if grep -q "CBT\|Cognitive Behavioral" "$tecnicas_file"; then
        echo "   ✅ CBT techniques: Present"
    else
        echo "   ❌ CBT techniques: Missing"
        EXIT_CODE=1
    fi

    if grep -q "Mindfulness\|Respiração\|Grounding" "$tecnicas_file"; then
        echo "   ✅ Mindfulness techniques: Present"
    else
        echo "   ❌ Mindfulness techniques: Missing"
        EXIT_CODE=1
    fi

    if grep -q "Autorregulação\|Pomodoro\|Body Doubling" "$tecnicas_file"; then
        echo "   ✅ Executive function strategies: Present"
    else
        echo "   ❌ Executive function strategies: Missing"
        EXIT_CODE=1
    fi

    if grep -q "Energia\|Energy\|Gestão de Energia" "$tecnicas_file"; then
        echo "   ✅ Energy management: Present"
    else
        echo "   ❌ Energy management: Missing"
        EXIT_CODE=1
    fi

    if grep -q "Paralisia\|Decisória\|Micro-next-step" "$tecnicas_file"; then
        echo "   ✅ Decision paralysis interventions: Present"
    else
        echo "   ❌ Decision paralysis interventions: Missing"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Library file: tecnicas-tdah.md not found"
    EXIT_CODE=1
fi

# Test 5: Integração com Knowledge-Base
echo ""
echo "📁 Test 5: Integração com knowledge-base..."

# Check if knowledge-base directory structure exists
if [ -d "knowledge-base/contextos" ]; then
    echo "   ✅ Knowledge-base: contextos directory exists"

    # Check for expected integration points
    if [ -f "knowledge-base/contextos/contexto-bem-estar.md" ] || grep -q "contexto-bem-estar" "$agent_file" 2>/dev/null; then
        echo "   ✅ Integration point: contexto-bem-estar referenced or exists"
    else
        echo "   ⚠️  Integration point: contexto-bem-estar not yet created (ok for initial setup)"
    fi

else
    echo "   ⚠️  Knowledge-base: contextos directory not found (may need setup)"
fi

# Test 6: Compatibilidade com Agentes Anteriores (Stories 2.1, 2.2, 2.3)
echo ""
echo "🔗 Test 6: Compatibilidade com stories anteriores..."

# Check Organizador compatibility
if [ -f ".assistant-core/agents/organizador.md" ]; then
    echo "   ✅ Compatibility: Organizador (Story 2.1) agent exists"
else
    echo "   ❌ Compatibility: Organizador agent missing"
    EXIT_CODE=1
fi

# Check Secretária compatibility
if [ -f ".assistant-core/agents/secretaria.md" ]; then
    echo "   ✅ Compatibility: Secretária (Story 2.2) agent exists"
else
    echo "   ❌ Compatibility: Secretária agent missing"
    EXIT_CODE=1
fi

# Check Arquiteto compatibility
if [ -f ".assistant-core/agents/arquiteto.md" ]; then
    echo "   ✅ Compatibility: Arquiteto (Story 2.3) agent exists"
else
    echo "   ❌ Compatibility: Arquiteto agent missing"
    EXIT_CODE=1
fi

# Test 7: Validação de Padrões Empáticos e TDAH-Friendly
echo ""
echo "💙 Test 7: Padrões empáticos e TDAH-friendly..."

# Check for empathetic language in tasks
empathetic_count=0
for task_file in "${required_tasks[@]}"; do
    if [ -f "$task_file" ]; then
        if grep -qi "validação\|empatia\|validar\|acolh\|compreens" "$task_file"; then
            ((empathetic_count++))
        fi
    fi
done

if [ $empathetic_count -ge 3 ]; then
    echo "   ✅ Empathetic patterns: Found in $empathetic_count tasks"
else
    echo "   ❌ Empathetic patterns: Insufficient empathetic language ($empathetic_count tasks)"
    EXIT_CODE=1
fi

# Check for TDAH-friendly micro-steps
if grep -qi "micro-passo\|micro-step\|menor próximo passo" "$agent_file" "${required_tasks[@]}" 2>/dev/null; then
    echo "   ✅ TDAH-friendly: Micro-step approach present"
else
    echo "   ❌ TDAH-friendly: Missing micro-step methodology"
    EXIT_CODE=1
fi

# Test 8: Tracking Longitudinal de Padrões
echo ""
echo "📊 Test 8: Tracking longitudinal de padrões..."

if [ -f "$memory_file" ]; then
    if grep -q "ciclos_humor_energia\|tendencias\|padroes" "$memory_file"; then
        echo "   ✅ Longitudinal tracking: Pattern tracking structure configured"
    else
        echo "   ❌ Longitudinal tracking: Missing pattern tracking"
        EXIT_CODE=1
    fi

    if grep -q "gatilhos_identificados\|triggers" "$memory_file"; then
        echo "   ✅ Trigger identification: Structure configured"
    else
        echo "   ❌ Trigger identification: Missing structure"
        EXIT_CODE=1
    fi
fi

# Test 9: Deploy Script Atualizado
echo ""
echo "🚀 Test 9: Deploy script atualizado..."

deploy_script="scripts/deploy-assistant.sh"

if [ -f "$deploy_script" ]; then
    if grep -q "psicologo" "$deploy_script"; then
        echo "   ✅ Deploy script: psic\u00f3logo agent included in deployment"
    else
        echo "   ❌ Deploy script: psicólogo agent NOT included in deployment"
        EXIT_CODE=1
    fi
else
    echo "   ❌ Deploy script: deploy-assistant.sh not found"
    EXIT_CODE=1
fi

# Test 10: Zero Referências ao BMAD (CRITICAL)
echo ""
echo "🚫 Test 10: Zero referências ao BMAD..."

bmad_found=0

# Check all new files for BMAD references
check_files=(
    "$agent_file"
    "$memory_file"
    "$tecnicas_file"
    "${required_tasks[@]}"
)

for file in "${check_files[@]}"; do
    if [ -f "$file" ] && grep -qi "bmad\|BMAD" "$file" 2>/dev/null; then
        echo "   ❌ BMAD reference found in: $file"
        bmad_found=1
        EXIT_CODE=1
    fi
done

if [ $bmad_found -eq 0 ]; then
    echo "   ✅ Zero BMAD references: All files clean"
else
    echo "   ❌ BMAD references detected: Remove all BMAD references"
fi

# Test 11: Validação de todos os 6 Acceptance Criteria
echo ""
echo "✅ Test 11: Validação de todos os 6 Acceptance Criteria..."

ac_validated=0

# AC1: Personalidade Empática com Confronto Construtivo
if [ -f "$agent_file" ] && grep -qi "empát\|acolhedor\|confronto construtivo" "$agent_file"; then
    echo "   ✅ AC1: Personalidade empática com confronto construtivo - VALIDATED"
    ((ac_validated++))
else
    echo "   ❌ AC1: NOT validated"
    EXIT_CODE=1
fi

# AC2: Técnicas Especializadas TDAH
if [ -f "$tecnicas_file" ] && grep -qi "CBT\|mindfulness\|autorregulação" "$tecnicas_file"; then
    echo "   ✅ AC2: Técnicas especializadas de TDAH - VALIDATED"
    ((ac_validated++))
else
    echo "   ❌ AC2: NOT validated"
    EXIT_CODE=1
fi

# AC3: Tracking de Humor e Energia
if [ -f ".assistant-core/tasks/analise-humor.md" ] && grep -qi "humor\|energia\|daily-dump" ".assistant-core/tasks/analise-humor.md"; then
    echo "   ✅ AC3: Tracking de humor e energia - VALIDATED"
    ((ac_validated++))
else
    echo "   ❌ AC3: NOT validated"
    EXIT_CODE=1
fi

# AC4: Identificação Proativa de Procrastinação
if [ -f ".assistant-core/tasks/detectar-procrastinacao.md" ] && grep -qi "procrastinação\|overwhelm\|sobrecarga" ".assistant-core/tasks/detectar-procrastinacao.md"; then
    echo "   ✅ AC4: Identificação proativa de procrastinação - VALIDATED"
    ((ac_validated++))
else
    echo "   ❌ AC4: NOT validated"
    EXIT_CODE=1
fi

# AC5: Sugestões Práticas de Autorregulação
if [ -f ".assistant-core/tasks/sugerir-tecnicas.md" ] && grep -qi "micro-passo\|acionável\|contextualizada" ".assistant-core/tasks/sugerir-tecnicas.md"; then
    echo "   ✅ AC5: Sugestões práticas de autorregulação - VALIDATED"
    ((ac_validated++))
else
    echo "   ❌ AC5: NOT validated"
    EXIT_CODE=1
fi

# AC6: Integração com Organizador para Overwhelm
if [ -f "$memory_file" ] && grep -qi "organizador:" "$memory_file" && grep -qi "shared_insights\|overwhelm" "$memory_file"; then
    echo "   ✅ AC6: Integração com Organizador para overwhelm - VALIDATED"
    ((ac_validated++))
else
    echo "   ❌ AC6: NOT validated"
    EXIT_CODE=1
fi

echo ""
echo "📊 Acceptance Criteria Validation: $ac_validated/6 validated"

# Final Summary
echo ""
echo "==============================================================================="
if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ ALL TESTS PASSED - Story 2.4 implementation complete and validated!"
    echo "🎉 Agente Psicólogo Supportivo ready for deployment via /psicologo"
else
    echo "❌ SOME TESTS FAILED - Please fix issues above before completing story"
fi
echo "==============================================================================="

exit $EXIT_CODE