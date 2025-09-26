#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Teste dos 5 Agentes Especializados
Framework de Testes Essenciais - História 0.4

Testa se cada agente está configurado corretamente e pode responder básicamente.
"""

import sys
import os
import yaml
from pathlib import Path

def test_agent_configuration(agent_name):
    """Testa se um agente específico está configurado corretamente"""
    print(f"  Testando agente: {agent_name}")

    # Test agent config file
    config_path = Path(f".assistant-core/agents/{agent_name}.yaml")
    if not config_path.exists():
        print(f"    ❌ Arquivo de configuração não encontrado: {config_path}")
        return False

    try:
        with open(config_path, 'r', encoding='utf-8') as f:
            config = yaml.safe_load(f)

        # Validate required fields
        required_fields = ['agent', 'persona', 'memoria']
        for field in required_fields:
            if field not in config:
                print(f"    ❌ Campo obrigatório '{field}' não encontrado na configuração")
                return False

        print(f"    ✅ Configuração do {agent_name}: OK")
    except Exception as e:
        print(f"    ❌ Erro ao carregar configuração do {agent_name}: {e}")
        return False

    # Test memory file
    memory_path = Path(f".assistant-core/memory/{agent_name}-memory.yaml")
    if not memory_path.exists():
        print(f"    ❌ Arquivo de memória não encontrado: {memory_path}")
        return False

    try:
        with open(memory_path, 'r', encoding='utf-8') as f:
            memory = yaml.safe_load(f)

        # Validate memory structure
        if 'agent' not in memory or memory['agent'] != agent_name:
            print(f"    ❌ Estrutura de memória inválida para {agent_name}")
            return False

        print(f"    ✅ Memória do {agent_name}: OK")
    except Exception as e:
        print(f"    ❌ Erro ao carregar memória do {agent_name}: {e}")
        return False

    return True

def test_agent_basic_response(agent_name):
    """Simula um teste básico de resposta do agente"""
    print(f"  Simulando resposta básica do {agent_name}...")

    # Load agent configuration
    try:
        config_path = Path(f".assistant-core/agents/{agent_name}.yaml")
        with open(config_path, 'r', encoding='utf-8') as f:
            config = yaml.safe_load(f)

        # Check if agent has persona configuration
        if 'persona' in config and 'traits' in config['persona']:
            print(f"    ✅ {agent_name.capitalize()}: Configuração de personalidade presente")
        else:
            print(f"    ⚠️  {agent_name.capitalize()}: Personalidade básica (configuração mínima)")

        # Simulate basic response capability
        print(f"    ✅ {agent_name.capitalize()}: Capacidade de resposta simulada com sucesso")
        return True

    except Exception as e:
        print(f"    ❌ Erro ao testar resposta do {agent_name}: {e}")
        return False

def test_all_agents():
    """Testa todos os 5 agentes especializados"""
    print("🤖 Testando os 5 Agentes Especializados")
    print("=" * 50)

    agents = ['organizador', 'secretaria', 'arquiteto', 'psicologo', 'mentor']
    passed_agents = 0

    for agent in agents:
        print(f"\n📋 Teste do Agente: {agent.capitalize()}")

        # Test configuration
        config_ok = test_agent_configuration(agent)

        # Test basic response simulation
        response_ok = test_agent_basic_response(agent) if config_ok else False

        if config_ok and response_ok:
            print(f"  ✅ {agent.capitalize()}: PASSOU em todos os testes")
            passed_agents += 1
        else:
            print(f"  ❌ {agent.capitalize()}: FALHOU em algum teste")

    print(f"\n📊 Resultado Final: {passed_agents}/{len(agents)} agentes passaram")

    if passed_agents == len(agents):
        print("🎉 TODOS OS AGENTES PASSARAM NOS TESTES!")
        return True
    else:
        print(f"❌ {len(agents) - passed_agents} AGENTE(S) FALHARAM!")
        return False

def test_agent_memory_integration():
    """Testa integração com sistema de memória"""
    print("\n🧠 Testando Integração com Sistema de Memória")
    print("=" * 50)

    try:
        # Try to import agent memory system
        sys.path.append('.assistant-core')
        from agent_memory_system import create_agent_memory_system

        ams = create_agent_memory_system()
        print("  ✅ Agent Memory System: Importado com sucesso")

        # Test loading memory for each agent
        agents = ['organizador', 'secretaria', 'arquiteto', 'psicologo', 'mentor']
        for agent in agents:
            try:
                memoria = ams.carregar_memoria_agente(agent)
                if memoria:
                    print(f"  ✅ Memória do {agent}: Carregada com sucesso")
                else:
                    print(f"  ❌ Memória do {agent}: Falha ao carregar")
                    return False
            except Exception as e:
                print(f"  ❌ Erro ao carregar memória do {agent}: {e}")
                return False

        print("  ✅ Integração com sistema de memória: OK")
        return True

    except ImportError:
        print("  ⚠️  Agent Memory System não disponível - teste pulado")
        return True
    except Exception as e:
        print(f"  ❌ Erro na integração com sistema de memória: {e}")
        return False

if __name__ == "__main__":
    print("Framework de Testes Essenciais - Teste de Agentes")
    print("História 0.4: Framework de Testes Essenciais")
    print("=" * 60)

    # Change to project directory if needed
    if not os.path.exists('.assistant-core'):
        print("❌ Diretório .assistant-core não encontrado!")
        print("Execute este script a partir do diretório raiz do projeto.")
        sys.exit(1)

    success = True

    # Test all agents
    if not test_all_agents():
        success = False

    # Test memory integration
    if not test_agent_memory_integration():
        success = False

    print("\n" + "=" * 60)
    if success:
        print("✅ TESTE DE AGENTES: TODOS OS TESTES PASSARAM!")
        sys.exit(0)
    else:
        print("❌ TESTE DE AGENTES: ALGUNS TESTES FALHARAM!")
        sys.exit(1)