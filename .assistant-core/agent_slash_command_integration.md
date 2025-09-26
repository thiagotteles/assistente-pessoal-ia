# Integração Agent Memory System com Slash Commands

Guia completo de integração do sistema de memória dos agentes com os comandos slash do Claude Code.

**Autor:** James (Dev Agent)
**Data:** 2025-09-25
**História:** 0.3 - Agent Memory System Foundation

---

## 🎯 Visão Geral

O Agent Memory System foi projetado para integrar seamlessly com os 5 slash commands dos agentes especializados:

- `/organizador` - Agente Organizador Pessoal
- `/secretaria` - Agente Assistente Executiva
- `/arquiteto` - Agente Arquiteto de Soluções
- `/psicologo` - Agente Psicólogo de Suporte TDAH
- `/mentor` - Agente Mentor de Carreira

## 🔧 Como Integrar

### 1. Carregamento Automático de Memória

Quando um slash command é executado, o sistema deve carregar automaticamente a memória do agente:

```python
from .assistant_core.agent_memory_system import create_agent_memory_system

# Exemplo para /organizador
def handle_organizador_command(user_input: str) -> str:
    # Inicializar sistema de memória
    ams = create_agent_memory_system()

    # Carregar memória do organizador
    memoria = ams.carregar_memoria_agente('organizador')

    if not memoria:
        print("⚠️  Memória do organizador não encontrada, usando configuração padrão")
        memoria = {}

    # Usar contexto da memória para personalizar resposta
    personality = memoria.get('personality_context', {})
    preferences = memoria.get('organization_patterns', {})

    # Processar comando com contexto personalizado
    response = process_with_memory_context(user_input, memoria)

    # Atualizar memória após interação
    interaction_data = {
        'user_input': user_input,
        'agent_response': response,
        'context': {'command': 'organizador'},
        'success': True
    }

    ams.atualizar_memoria_agente('organizador', interaction_data)

    return response
```

### 2. Integração por Agente

#### /organizador - Organizador Pessoal

```python
def integrate_organizador_memory(ams, user_input: str) -> dict:
    """Integração específica do organizador"""
    memoria = ams.carregar_memoria_agente('organizador')

    # Contexto de personalidade
    confrontation_level = memoria.get('personality_context', {}).get('confrontation_level', 'medium')

    # Padrões aprendidos
    frequent_categories = memoria.get('organization_patterns', {}).get('frequent_categories', [])

    # Aplicar personalização
    context = {
        'personality': {
            'confrontation_level': confrontation_level,
            'should_be_direct': confrontation_level in ['medium', 'high']
        },
        'learned_patterns': {
            'categories': frequent_categories
        }
    }

    return context
```

#### /secretaria - Assistente Executiva

```python
def integrate_secretaria_memory(ams, user_input: str) -> dict:
    """Integração específica da secretária"""
    memoria = ams.carregar_memoria_agente('secretaria')

    # Contexto executivo
    proactivity = memoria.get('personality_context', {}).get('proactivity_level', 'high')
    meetings_count = memoria.get('management_history', {}).get('meetings_processed', 0)

    context = {
        'personality': {
            'proactivity_level': proactivity,
            'experience_level': 'experienced' if meetings_count > 10 else 'learning'
        },
        'executive_patterns': memoria.get('executive_patterns', {})
    }

    return context
```

#### /arquiteto - Arquiteto de Soluções

```python
def integrate_arquiteto_memory(ams, user_input: str) -> dict:
    """Integração específica do arquiteto"""
    memoria = ams.carregar_memoria_agente('arquiteto')

    # Padrões técnicos
    preferred_tech = memoria.get('technical_patterns', {}).get('preferred_technologies', [])
    decisions_made = memoria.get('decision_history', {}).get('decisions_made', 0)

    context = {
        'personality': {
            'technical_depth': memoria.get('personality_context', {}).get('technical_depth', 'comprehensive'),
            'experience_level': 'senior' if decisions_made > 5 else 'standard'
        },
        'technical_preferences': preferred_tech
    }

    return context
```

#### /psicologo - Psicólogo de Suporte TDAH

```python
def integrate_psicologo_memory(ams, user_input: str) -> dict:
    """Integração específica do psicólogo"""
    memoria = ams.carregar_memoria_agente('psicologo')

    # Padrões emocionais aprendidos
    mood_indicators = memoria.get('emotional_patterns', {}).get('mood_indicators', [])
    interventions = memoria.get('support_history', {}).get('interventions_made', 0)

    context = {
        'personality': {
            'empathy_level': memoria.get('personality_context', {}).get('empathy_level', 'high'),
            'intervention_experience': 'experienced' if interventions > 3 else 'careful'
        },
        'emotional_context': {
            'known_patterns': mood_indicators,
            'effective_strategies': memoria.get('learned_patterns', {}).get('effective_interventions', [])
        }
    }

    return context
```

#### /mentor - Mentor de Carreira

```python
def integrate_mentor_memory(ams, user_input: str) -> dict:
    """Integração específica do mentor"""
    memoria = ams.carregar_memoria_agente('mentor')

    # Padrões de desenvolvimento
    career_goals = memoria.get('development_patterns', {}).get('career_goals', [])
    sessions = memoria.get('mentoring_history', {}).get('sessions_conducted', 0)

    context = {
        'personality': {
            'coaching_style': memoria.get('personality_context', {}).get('coaching_style', 'growth-oriented'),
            'mentoring_experience': 'seasoned' if sessions > 5 else 'developing'
        },
        'development_context': {
            'known_goals': career_goals,
            'learning_style': memoria.get('learned_patterns', {}).get('learning_style', [])
        }
    }

    return context
```

### 3. Hook de Inicialização

Crie um hook que é executado quando qualquer slash command é chamado:

```python
def initialize_agent_memory_hook(agent_id: str) -> dict:
    """
    Hook de inicialização chamado antes de executar slash command

    Args:
        agent_id: ID do agente (organizador|secretaria|arquiteto|psicologo|mentor)

    Returns:
        Contexto de memória para o agente
    """
    try:
        ams = create_agent_memory_system()

        # Carregar e manter personalidade
        memoria = ams.carregar_memoria_agente(agent_id)
        ams.manter_personalidade(agent_id)

        # Preparar contexto baseado no agente
        integration_functions = {
            'organizador': integrate_organizador_memory,
            'secretaria': integrate_secretaria_memory,
            'arquiteto': integrate_arquiteto_memory,
            'psicologo': integrate_psicologo_memory,
            'mentor': integrate_mentor_memory
        }

        if agent_id in integration_functions:
            context = integration_functions[agent_id](ams, "")
        else:
            context = {'personality': {}, 'learned_patterns': {}}

        # Log da inicialização
        print(f"🧠 Memória do agente '{agent_id}' carregada e pronta")

        return {
            'memory_loaded': True,
            'agent_context': context,
            'last_updated': memoria.get('last_updated', 'N/A') if memoria else 'N/A'
        }

    except Exception as e:
        print(f"⚠️  Erro ao carregar memória do agente '{agent_id}': {e}")
        return {
            'memory_loaded': False,
            'agent_context': {'personality': {}, 'learned_patterns': {}},
            'error': str(e)
        }
```

### 4. Hook de Finalização

Hook executado após completar o comando:

```python
def finalize_agent_memory_hook(agent_id: str, user_input: str, agent_response: str, context: dict = None) -> bool:
    """
    Hook de finalização chamado depois de executar slash command

    Args:
        agent_id: ID do agente
        user_input: Input do usuário
        agent_response: Resposta do agente
        context: Contexto adicional da interação

    Returns:
        True se memória foi atualizada com sucesso
    """
    try:
        ams = create_agent_memory_system()

        # Preparar dados da interação
        interaction_data = {
            'user_input': user_input,
            'agent_response': agent_response,
            'context': context or {},
            'success': True,
            'timestamp': datetime.now(timezone.utc).isoformat()
        }

        # Identificar referências [[]] no conteúdo
        references = ams.identificar_padroes_referencias(agent_id, f"{user_input} {agent_response}")
        if references:
            interaction_data['context']['references_found'] = references

        # Atualizar memória
        success = ams.atualizar_memoria_agente(agent_id, interaction_data)

        if success:
            print(f"✅ Memória do agente '{agent_id}' atualizada")
        else:
            print(f"⚠️  Falha ao atualizar memória do agente '{agent_id}'")

        return success

    except Exception as e:
        print(f"❌ Erro ao finalizar memória do agente '{agent_id}': {e}")
        return False
```

## 🚀 Exemplo Completo de Integração

```python
def execute_agent_slash_command(agent_id: str, user_input: str) -> str:
    """
    Exemplo completo de execução de slash command com integração de memória
    """

    # 1. Hook de inicialização - carregar memória
    memory_context = initialize_agent_memory_hook(agent_id)

    if not memory_context['memory_loaded']:
        print(f"⚠️  Executando {agent_id} sem contexto de memória")

    # 2. Processar comando com contexto de memória
    agent_context = memory_context['agent_context']

    # Personalizar resposta baseada na memória
    if agent_id == 'organizador':
        response = f"Olá! Como seu organizador pessoal, vou ajudar com base no que já sei sobre suas preferências."
        if agent_context.get('learned_patterns', {}).get('categories'):
            categories = agent_context['learned_patterns']['categories']
            response += f" Percebi que você costuma trabalhar com: {', '.join(categories[:3])}."

    elif agent_id == 'psicologo':
        empathy = agent_context.get('personality', {}).get('empathy_level', 'high')
        if empathy == 'high':
            response = "Oi! Como você está se sentindo hoje? Estou aqui para te apoiar."
        else:
            response = "Olá! Vamos trabalhar juntos hoje?"

    else:
        # Resposta padrão para outros agentes
        response = f"Olá! Sou seu agente {agent_id} e estou pronto para ajudar."

    # Simular processamento mais elaborado aqui
    response += f"\n\nSua mensagem: {user_input}\nProcessando com base na memória carregada..."

    # 3. Hook de finalização - atualizar memória
    context = {
        'agent_id': agent_id,
        'memory_context_used': True,
        'response_personalized': True
    }

    finalize_agent_memory_hook(agent_id, user_input, response, context)

    return response


# Exemplo de uso
if __name__ == "__main__":
    # Testar integração com cada agente
    test_input = "Preciso organizar meu projeto [[Assistente Pessoal IA]] e estou meio perdido"

    for agent in ['organizador', 'secretaria', 'arquiteto', 'psicologo', 'mentor']:
        print(f"\n{'='*50}")
        print(f"Testando /{agent}")
        print('='*50)

        response = execute_agent_slash_command(agent, test_input)
        print(f"Resposta: {response}")
```

## 📋 Configuração dos Hooks no Claude Code

Para integrar no Claude Code, adicione os hooks no arquivo de configuração:

```json
{
  "agent_memory_hooks": {
    "pre_command": ".assistant-core.agent_memory_system:initialize_agent_memory_hook",
    "post_command": ".assistant-core.agent_memory_system:finalize_agent_memory_hook"
  },
  "slash_commands": {
    "/organizador": {
      "agent_id": "organizador",
      "memory_integration": true
    },
    "/secretaria": {
      "agent_id": "secretaria",
      "memory_integration": true
    },
    "/arquiteto": {
      "agent_id": "arquiteto",
      "memory_integration": true
    },
    "/psicologo": {
      "agent_id": "psicologo",
      "memory_integration": true
    },
    "/mentor": {
      "agent_id": "mentor",
      "memory_integration": true
    }
  }
}
```

## 🔍 Debugging e Troubleshooting

### Verificar se Memória está Carregando

```bash
# Testar carregamento básico
python -c "
from .assistant_core.agent_memory_system import create_agent_memory_system
ams = create_agent_memory_system()
for agent in ['organizador', 'secretaria', 'arquiteto', 'psicologo', 'mentor']:
    memoria = ams.carregar_memoria_agente(agent)
    print(f'{agent}: {\"✅\" if memoria else \"❌\"}')
"
```

### Logs de Integração

Os logs da integração ficam em:
- `.assistant-core/logs/agent_memory_system.log`

### Problemas Comuns

1. **Memória não carrega**: Verificar se arquivos YAML existem em `.assistant-core/memory/`
2. **Hooks não executam**: Verificar configuração do Claude Code
3. **Performance lenta**: Verificar cache de memória e tamanho dos arquivos

---

## ✅ Checklist de Integração

- [ ] Agent Memory System instalado e funcionando
- [ ] Arquivos de memória existem para todos os 5 agentes
- [ ] Hooks de inicialização e finalização configurados
- [ ] Slash commands integrados com contexto de memória
- [ ] Testes básicos de carregamento e atualização funcionando
- [ ] Logs habilitados para debugging

**Status: Integração Pronta para Implementação ✅**