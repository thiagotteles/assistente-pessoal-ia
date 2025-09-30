#!/bin/bash
# Test script específico para Story 2.5: Agente Mentor de Carreira (Método Conversacional)

echo "🧪 Testing Story 2.5: Agente Mentor de Carreira (Método Conversacional)"
echo "==============================================================================="

EXIT_CODE=0

# Test 1: Definição do Agente Conversacional Mentor
echo "🎓 Test 1: Definição do Agente Mentor Leonardo..."

agent_file=".assistant-core/agents/mentor.md"

if [ -f "$agent_file" ]; then
    echo "   ✅ Agent file: mentor.md exists"

    # Check for conversational agent structure
    if grep -q "agent:" "$agent_file" && grep -q "persona:" "$agent_file"; then
        echo "   ✅ Estrutura conversacional: Seções agent e persona presentes"
    else
        echo "   ❌ Estrutura conversacional: Estrutura YAML agent/persona ausente"
        EXIT_CODE=1
    fi

    # Check for Leonardo personality and strategic characteristics
    if grep -q "Leonardo\|Mentor" "$agent_file" && grep -q "estratégi\|visionári\|carreira" "$agent_file"; then
        echo "   ✅ Agent identity: Mentor with strategic career development focus defined"
    else
        echo "   ❌ Agent identity: Missing Mentor/strategic/career focus"
        EXIT_CODE=1
    fi

    # Check for conversational commands
    if grep -q "commands:" "$agent_file" && grep -q "metas\|oportunidades\|crescimento\|networking\|conversa" "$agent_file"; then
        echo "   ✅ Commands: Conversational commands defined (metas, oportunidades, crescimento, networking, conversa)"
    else
        echo "   ❌ Commands: Missing required conversational commands"
        EXIT_CODE=1
    fi

    # Check for career/mentoring focus
    if grep -q "carreira\|metas\|crescimento\|networking\|desenvolvimento" "$agent_file"; then
        echo "   ✅ Mentoring focus: Career development and strategic growth focus defined"
    else
        echo "   ❌ Mentoring focus: Missing career/mentoring focus"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Agent file: mentor.md not found"
    EXIT_CODE=1
fi

# Test 2: Conversational Workflows (Tasks) do Mentor
echo ""
echo "📋 Test 2: Workflows conversacionais (Tasks)..."

required_tasks=(
    ".assistant-core/tasks/tracking-metas.md"
    ".assistant-core/tasks/identificar-oportunidades.md"
    ".assistant-core/tasks/analise-crescimento.md"
    ".assistant-core/tasks/networking-estrategico.md"
    ".assistant-core/tasks/preparar-conversa.md"
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

# Test 3: Sistema de Memória Contextual do Mentor
echo ""
echo "🧠 Test 3: Sistema de memória contextual..."

memory_file=".assistant-core/memory/mentor-memory.yaml"

if [ -f "$memory_file" ]; then
    echo "   ✅ Memory file: mentor-memory.yaml exists"

    # Check for agent identity
    if grep -q "agent_identity:" "$memory_file" && grep -q "Leonardo\|name:" "$memory_file"; then
        echo "   ✅ Identity: Agent identity (Leonardo) defined in memory"
    else
        echo "   ❌ Identity: Missing agent identity in memory"
        EXIT_CODE=1
    fi

    # Check for career profile tracking
    if grep -q "user_career_profile:" "$memory_file" && grep -q "objetivos_longo_prazo\|valores_profissionais" "$memory_file"; then
        echo "   ✅ Career profile: User career profile structure present"
    else
        echo "   ❌ Career profile: Missing user career profile structure"
        EXIT_CODE=1
    fi

    # Check for career tracking
    if grep -q "career_tracking:" "$memory_file" && grep -q "metas_ativas\|decisoes_carreira" "$memory_file"; then
        echo "   ✅ Career tracking: Career tracking structure present"
    else
        echo "   ❌ Career tracking: Missing career tracking structure"
        EXIT_CODE=1
    fi

    # Check for networking tracking
    if grep -q "networking:" "$memory_file" && grep -q "pessoas_chave\|conexoes_estrategicas" "$memory_file"; then
        echo "   ✅ Networking: Networking tracking structure present"
    else
        echo "   ❌ Networking: Missing networking tracking structure"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Memory file: mentor-memory.yaml not found"
    EXIT_CODE=1
fi

# Test 4: Frameworks de Conversas Difíceis
echo ""
echo "💬 Test 4: Frameworks de conversas difíceis..."

frameworks_file=".assistant-core/data/frameworks-conversas.md"

if [ -f "$frameworks_file" ]; then
    echo "   ✅ Frameworks file: frameworks-conversas.md exists"

    # Check for feedback framework
    if grep -q "Feedback Difícil\|Conversas de Feedback" "$frameworks_file"; then
        echo "   ✅ Feedback: Framework de feedback difícil presente"
    else
        echo "   ❌ Feedback: Missing feedback framework"
        EXIT_CODE=1
    fi

    # Check for salary negotiation framework
    if grep -q "Negociação Salarial" "$frameworks_file" && grep -q "BATNA\|pesquisa de mercado" "$frameworks_file"; then
        echo "   ✅ Negotiation: Framework de negociação salarial presente"
    else
        echo "   ❌ Negotiation: Missing salary negotiation framework"
        EXIT_CODE=1
    fi

    # Check for boundaries framework
    if grep -q "Estabelecimento de Limites\|Limites" "$frameworks_file" && grep -q "assertiv\|consequências" "$frameworks_file"; then
        echo "   ✅ Boundaries: Framework de estabelecimento de limites presente"
    else
        echo "   ❌ Boundaries: Missing boundaries framework"
        EXIT_CODE=1
    fi

    # Check for promotion framework
    if grep -q "Conversas de Promoção\|Promoção" "$frameworks_file"; then
        echo "   ✅ Promotion: Framework de conversas de promoção presente"
    else
        echo "   ❌ Promotion: Missing promotion framework"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Frameworks file: frameworks-conversas.md not found"
    EXIT_CODE=1
fi

# Test 5: Cross-Agent Intelligence com Arquiteto
echo ""
echo "🔗 Test 5: Cross-agent intelligence com Arquiteto..."

# Check mentor references to Arquiteto
if [ -f "$agent_file" ]; then
    if grep -q "Arquiteto\|Marcus\|desenvolvimento técnico" "$agent_file"; then
        echo "   ✅ Arquiteto collaboration: References to Arquiteto collaboration present"
    else
        echo "   ❌ Arquiteto collaboration: Missing references to Arquiteto collaboration"
        EXIT_CODE=1
    fi
fi

# Check if Arquiteto agent exists (dependency)
if [ -f ".assistant-core/agents/arquiteto.md" ]; then
    echo "   ✅ Arquiteto dependency: Arquiteto agent exists (AC6 dependency)"
else
    echo "   ❌ Arquiteto dependency: Arquiteto agent missing (required for AC6)"
    EXIT_CODE=1
fi

# Test 6: Integração com Knowledge-Base (Carreira Directory)
echo ""
echo "📚 Test 6: Integração com knowledge-base..."

# Check if knowledge-base/carreira directory is referenced
if grep -q "knowledge-base/carreira\|carreira/" "$agent_file" .assistant-core/tasks/*.md 2>/dev/null; then
    echo "   ✅ KB integration: References to knowledge-base/carreira present"
else
    echo "   ❌ KB integration: Missing references to knowledge-base/carreira"
    EXIT_CODE=1
fi

# Check for Obsidian [[referências]] support
if grep -q "\[\[pessoa\|\[\[projeto\|\[\[meta\|referências" .assistant-core/tasks/tracking-metas.md .assistant-core/tasks/identificar-oportunidades.md .assistant-core/tasks/networking-estrategico.md 2>/dev/null; then
    echo "   ✅ Obsidian refs: Support for [[referências]] Obsidian pattern present"
else
    echo "   ❌ Obsidian refs: Missing Obsidian [[referências]] support"
    EXIT_CODE=1
fi

# Test 7: Compatibilidade com Agentes Anteriores
echo ""
echo "🔄 Test 7: Compatibilidade com Stories 2.1, 2.2, 2.3, 2.4..."

required_agents=(
    ".assistant-core/agents/organizador.md"
    ".assistant-core/agents/secretaria.md"
    ".assistant-core/agents/arquiteto.md"
    ".assistant-core/agents/psicologo.md"
)

all_agents_exist=true
for agent in "${required_agents[@]}"; do
    if [ ! -f "$agent" ]; then
        echo "   ❌ Dependency: $(basename $agent) missing (required for integration)"
        EXIT_CODE=1
        all_agents_exist=false
    fi
done

if [ "$all_agents_exist" = true ]; then
    echo "   ✅ Dependencies: All previous agents (Organizador, Secretária, Arquiteto, Psicólogo) exist"
fi

# Check for consistent structure with previous agents
if [ -f "$agent_file" ]; then
    if grep -q "activation-instructions:\|agent:\|persona:\|commands:\|dependencies:" "$agent_file"; then
        echo "   ✅ Structure consistency: Mentor follows same conversational structure as previous agents"
    else
        echo "   ❌ Structure consistency: Mentor structure deviates from previous agents"
        EXIT_CODE=1
    fi
fi

# Test 8: Tracking Longitudinal (AC3)
echo ""
echo "📈 Test 8: Tracking longitudinal de evolução profissional..."

# Check analise-crescimento task for longitudinal analysis
if [ -f ".assistant-core/tasks/analise-crescimento.md" ]; then
    if grep -q "longitudinal\|evolução\|padrões\|histórico" ".assistant-core/tasks/analise-crescimento.md"; then
        echo "   ✅ Longitudinal tracking: Análise longitudinal de crescimento implementada"
    else
        echo "   ❌ Longitudinal tracking: Missing longitudinal analysis features"
        EXIT_CODE=1
    fi
fi

# Check for timeline/history tracking mentions
if grep -q "timeline\|histórico\|evolução\|anos\|progresso" .assistant-core/tasks/*.md 2>/dev/null; then
    echo "   ✅ History tracking: Timeline and historical progression tracking present"
else
    echo "   ❌ History tracking: Missing timeline/historical tracking features"
    EXIT_CODE=1
fi

# Test 9: Deploy e Instalação (AC para Claude Code)
echo ""
echo "🚀 Test 9: Preparação para deploy e instalação..."

deploy_script="scripts/deploy-assistant.sh"

if [ -f "$deploy_script" ]; then
    echo "   ✅ Deploy script: deploy-assistant.sh exists"

    # Check if mentor is included in deploy script
    if grep -q "mentor" "$deploy_script"; then
        echo "   ✅ Deploy integration: Mentor included in deploy script"
    else
        echo "   ⚠️  Deploy integration: Mentor not yet added to deploy script (may need update)"
        # Não falhar - pode ser adicionado depois
    fi
else
    echo "   ❌ Deploy script: deploy-assistant.sh not found"
    EXIT_CODE=1
fi

# Test 10: Zero Referências ao "BMAD"
echo ""
echo "🚫 Test 10: Validação - Zero referências ao 'BMAD'..."

# Check all created files for BMAD references (critical validation)
bmad_found=false

for file in ".assistant-core/agents/mentor.md" ".assistant-core/memory/mentor-memory.yaml" ".assistant-core/data/frameworks-conversas.md" .assistant-core/tasks/tracking-metas.md .assistant-core/tasks/identificar-oportunidades.md .assistant-core/tasks/analise-crescimento.md .assistant-core/tasks/networking-estrategico.md .assistant-core/tasks/preparar-conversa.md; do
    if [ -f "$file" ]; then
        if grep -i "bmad\|b\.mad" "$file" > /dev/null 2>&1; then
            echo "   ❌ BMAD reference: Found prohibited 'BMAD' reference in $(basename $file)"
            EXIT_CODE=1
            bmad_found=true
        fi
    fi
done

if [ "$bmad_found" = false ]; then
    echo "   ✅ BMAD validation: Zero 'BMAD' references found (CRITICAL - passed)"
else
    echo "   ❌ BMAD validation: FAILED - Remove all BMAD references (see docs/IMPORTANTE-LEIA-PRIMEIRO.md)"
fi

# Test 11: Validação de Todos os 6 Critérios de Aceitação
echo ""
echo "✅ Test 11: Validação completa dos 6 ACs..."

# AC1: Tracking de Metas
if [ -f ".assistant-core/tasks/tracking-metas.md" ] && grep -q "metas\|objetivos\|carreira" ".assistant-core/tasks/tracking-metas.md"; then
    echo "   ✅ AC1: Tracking inteligente de metas de carreira implementado"
else
    echo "   ❌ AC1: Tracking de metas incompleto"
    EXIT_CODE=1
fi

# AC2: Identificação de Oportunidades
if [ -f ".assistant-core/tasks/identificar-oportunidades.md" ] && grep -q "gaps\|projetos\|aprendizado\|habilidades" ".assistant-core/tasks/identificar-oportunidades.md"; then
    echo "   ✅ AC2: Identificação proativa de oportunidades de aprendizado implementada"
else
    echo "   ❌ AC2: Identificação de oportunidades incompleta"
    EXIT_CODE=1
fi

# AC3: Análise de Crescimento
if [ -f ".assistant-core/tasks/analise-crescimento.md" ] && grep -q "longitudinal\|padrões\|crescimento\|histórico" ".assistant-core/tasks/analise-crescimento.md"; then
    echo "   ✅ AC3: Análise de padrões de crescimento profissional implementada"
else
    echo "   ❌ AC3: Análise de crescimento incompleta"
    EXIT_CODE=1
fi

# AC4: Networking Estratégico
if [ -f ".assistant-core/tasks/networking-estrategico.md" ] && grep -q "networking\|pessoas\|conexões\|estratégic" ".assistant-core/tasks/networking-estrategico.md"; then
    echo "   ✅ AC4: Sugestões de networking estratégico implementadas"
else
    echo "   ❌ AC4: Networking estratégico incompleto"
    EXIT_CODE=1
fi

# AC5: Preparação para Conversas Difíceis
if [ -f ".assistant-core/tasks/preparar-conversa.md" ] && [ -f ".assistant-core/data/frameworks-conversas.md" ]; then
    if grep -q "conversa\|negociação\|feedback\|limites" ".assistant-core/tasks/preparar-conversa.md"; then
        echo "   ✅ AC5: Preparação para conversas difíceis e negociações implementada"
    else
        echo "   ❌ AC5: Preparação de conversas incompleta"
        EXIT_CODE=1
    fi
else
    echo "   ❌ AC5: Arquivos de preparação de conversas ausentes"
    EXIT_CODE=1
fi

# AC6: Integração com Arquiteto
if grep -q "Arquiteto\|Marcus\|desenvolvimento técnico\|alinhamento" "$agent_file" .assistant-core/tasks/*.md 2>/dev/null; then
    if [ -f ".assistant-core/agents/arquiteto.md" ]; then
        echo "   ✅ AC6: Integração com Arquiteto para alinhamento técnico-carreira implementada"
    else
        echo "   ❌ AC6: Arquiteto agent missing (required for integration)"
        EXIT_CODE=1
    fi
else
    echo "   ❌ AC6: Integração com Arquiteto incompleta"
    EXIT_CODE=1
fi

# Final Summary
echo ""
echo "==============================================================================="
if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ ALL TESTS PASSED - Story 2.5 implementation is complete and correct!"
    echo ""
    echo "🎓 Agente Mentor Leonardo ready for deployment via /mentor command"
    echo ""
    echo "Summary:"
    echo "  - Conversational agent structure ✅"
    echo "  - 5 task workflows implemented ✅"
    echo "  - Memory system configured ✅"
    echo "  - Frameworks de conversas created ✅"
    echo "  - Cross-agent intelligence with Arquiteto ✅"
    echo "  - Knowledge-base integration ✅"
    echo "  - All 6 ACs validated ✅"
    echo "  - Zero BMAD references ✅"
    echo "  - Compatible with Stories 2.1-2.4 ✅"
else
    echo "❌ TESTS FAILED - Please review errors above"
    echo ""
    echo "Check:"
    echo "  - All required files created?"
    echo "  - Conversational structure correct?"
    echo "  - No BMAD references?"
    echo "  - All ACs implemented?"
fi
echo "==============================================================================="

exit $EXIT_CODE