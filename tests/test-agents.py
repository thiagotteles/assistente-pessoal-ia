#!/usr/bin/env python3
"""
Test script for Assistente Pessoal IA agents and slash commands
Tests all 5 agents and their configurations
"""

import os
import sys
import json
import yaml
from pathlib import Path

# Add .assistant-core to path
sys.path.append(str(Path(__file__).parent / ".assistant-core"))

try:
    from slash_command_dispatcher import SlashCommandDispatcher
except ImportError as e:
    print(f"Error importing dispatcher: {e}")
    sys.exit(1)

def test_agent_configurations():
    """Test that all agent configuration files are valid"""
    print("🤖 Testing Agent Configurations...")

    project_root = Path(__file__).parent
    agents_dir = project_root / ".assistant-core" / "agents"
    memory_dir = project_root / ".assistant-core" / "memory"

    agents = ["organizador", "secretaria", "arquiteto", "psicologo", "mentor"]

    config_results = {}
    memory_results = {}

    for agent in agents:
        # Test config file
        config_file = agents_dir / f"{agent}.yaml"
        try:
            if config_file.exists():
                with open(config_file, 'r', encoding='utf-8') as f:
                    config = yaml.safe_load(f)
                    config_results[agent] = {
                        "exists": True,
                        "valid_yaml": True,
                        "has_name": "name" in config,
                        "has_personality": "personality" in config,
                        "has_functions": "functions" in config,
                        "functions_count": len(config.get("functions", []))
                    }
                    print(f"   ✅ {agent}.yaml: OK ({config_results[agent]['functions_count']} functions)")
            else:
                config_results[agent] = {"exists": False}
                print(f"   ❌ {agent}.yaml: Missing")
        except Exception as e:
            config_results[agent] = {"exists": True, "valid_yaml": False, "error": str(e)}
            print(f"   ❌ {agent}.yaml: Invalid YAML - {e}")

        # Test memory file
        memory_file = memory_dir / f"{agent}-memory.yaml"
        try:
            if memory_file.exists():
                with open(memory_file, 'r', encoding='utf-8') as f:
                    memory = yaml.safe_load(f)
                    memory_results[agent] = {
                        "exists": True,
                        "valid_yaml": True,
                        "has_context": "context" in memory,
                        "has_personality": "personality" in memory
                    }
                    print(f"   ✅ {agent}-memory.yaml: OK")
            else:
                memory_results[agent] = {"exists": False}
                print(f"   ❌ {agent}-memory.yaml: Missing")
        except Exception as e:
            memory_results[agent] = {"exists": True, "valid_yaml": False, "error": str(e)}
            print(f"   ❌ {agent}-memory.yaml: Invalid YAML - {e}")

    return config_results, memory_results

def test_slash_command_dispatcher():
    """Test the slash command dispatcher"""
    print("\n⚡ Testing Slash Command Dispatcher...")

    try:
        dispatcher = SlashCommandDispatcher()
        print("   ✅ Dispatcher initialized successfully")

        # Test each command
        test_cases = [
            ("status", [], "Testing system status"),
            ("organizador", [], "Testing organizador without args"),
            ("organizador", ["daily-dump.md"], "Testing organizador with file"),
            ("secretaria", [], "Testing secretaria agenda"),
            ("secretaria", ["status", "projetos"], "Testing secretaria project status"),
            ("arquiteto", ["análise", "sistema", "web"], "Testing arquiteto analysis"),
            ("psicologo", [], "Testing psicologo check-in"),
            ("psicologo", ["estou", "sobrecarregado"], "Testing psicologo with ADHD context"),
            ("mentor", [], "Testing mentor goals tracking"),
            ("mentor", ["carreira", "crescimento"], "Testing mentor career guidance")
        ]

        results = {}

        for command, args, description in test_cases:
            try:
                result = dispatcher.dispatch_command(command, args, "Test context")
                success = result.get("status") == "success"
                results[f"{command}_{len(args)}"] = {
                    "success": success,
                    "agent": result.get("agent"),
                    "action": result.get("action"),
                    "has_message": bool(result.get("message"))
                }

                status_icon = "✅" if success else "❌"
                print(f"   {status_icon} /{command} {' '.join(args)}: {result.get('status', 'unknown')}")

            except Exception as e:
                results[f"{command}_{len(args)}"] = {"success": False, "error": str(e)}
                print(f"   ❌ /{command} {' '.join(args)}: Error - {e}")

        return results

    except Exception as e:
        print(f"   ❌ Failed to initialize dispatcher: {e}")
        return {}

def test_intelligent_routing():
    """Test intelligent routing suggestions"""
    print("\n🧠 Testing Intelligent Routing...")

    try:
        dispatcher = SlashCommandDispatcher()

        test_inputs = [
            ("Preciso organizar minhas ideias do daily-dump", "organizador"),
            ("Como está minha agenda hoje?", "secretaria"),
            ("Quero revisar a arquitetura do sistema", "arquiteto"),
            ("Estou me sentindo sobrecarregado", "psicologo"),
            ("Preciso de orientação para minha carreira", "mentor"),
            ("Como implementar autenticação OAuth?", "arquiteto"),
            ("Tenho uma reunião importante amanhã", "secretaria")
        ]

        routing_results = {}

        for user_input, expected in test_inputs:
            suggestion = dispatcher.get_intelligent_routing_suggestion(user_input)
            correct = suggestion == expected
            routing_results[user_input[:30]] = {
                "expected": expected,
                "suggested": suggestion,
                "correct": correct
            }

            status_icon = "✅" if correct else "⚠️"
            print(f"   {status_icon} '{user_input[:40]}...' → /{suggestion}")

        accuracy = sum(1 for r in routing_results.values() if r["correct"]) / len(routing_results)
        print(f"\n   📊 Routing accuracy: {accuracy:.1%}")

        return routing_results

    except Exception as e:
        print(f"   ❌ Routing test failed: {e}")
        return {}

def test_system_integration():
    """Test integration with core systems"""
    print("\n🔗 Testing System Integration...")

    integration_results = {}

    # Test Agent Memory System
    try:
        from agent_memory_system import create_agent_memory_system
        ams = create_agent_memory_system()
        integration_results["agent_memory_system"] = True
        print("   ✅ Agent Memory System: Available")
    except Exception as e:
        integration_results["agent_memory_system"] = False
        print(f"   ⚠️  Agent Memory System: {e}")

    # Test Knowledge Base Manager
    try:
        from knowledge_base_manager import create_knowledge_manager
        kb = create_knowledge_manager()
        integration_results["knowledge_base_manager"] = True
        print("   ✅ Knowledge Base Manager: Available")
    except Exception as e:
        integration_results["knowledge_base_manager"] = False
        print(f"   ⚠️  Knowledge Base Manager: {e}")

    # Test file structure
    project_root = Path(__file__).parent
    required_paths = [
        "despejo/daily-dump.md",
        "knowledge-base",
        ".assistant-core/agents",
        ".assistant-core/memory"
    ]

    for path in required_paths:
        full_path = project_root / path
        exists = full_path.exists()
        integration_results[f"path_{path}"] = exists
        status_icon = "✅" if exists else "❌"
        print(f"   {status_icon} {path}: {'Exists' if exists else 'Missing'}")

    return integration_results

def generate_test_report(config_results, memory_results, dispatcher_results, routing_results, integration_results):
    """Generate comprehensive test report"""
    print("\n📊 Test Report Summary")
    print("=" * 50)

    # Agent configurations
    config_passed = sum(1 for r in config_results.values() if r.get("valid_yaml", False))
    memory_passed = sum(1 for r in memory_results.values() if r.get("valid_yaml", False))
    print(f"Agent Configs: {config_passed}/5 valid")
    print(f"Agent Memory: {memory_passed}/5 valid")

    # Dispatcher tests
    dispatcher_passed = sum(1 for r in dispatcher_results.values() if r.get("success", False))
    print(f"Slash Commands: {dispatcher_passed}/{len(dispatcher_results)} working")

    # Routing accuracy
    if routing_results:
        routing_passed = sum(1 for r in routing_results.values() if r.get("correct", False))
        routing_accuracy = routing_passed / len(routing_results)
        print(f"Intelligent Routing: {routing_accuracy:.1%} accuracy")

    # Integration
    integration_passed = sum(1 for r in integration_results.values() if r)
    print(f"System Integration: {integration_passed}/{len(integration_results)} components")

    # Overall health
    total_tests = len(config_results) + len(memory_results) + len(dispatcher_results) + len(integration_results)
    passed_tests = config_passed + memory_passed + dispatcher_passed + integration_passed

    health_percentage = passed_tests / total_tests

    print(f"\nOverall System Health: {health_percentage:.1%}")

    if health_percentage >= 0.8:
        print("🟢 System Status: HEALTHY")
        print("✅ Ready for production use")
    elif health_percentage >= 0.6:
        print("🟡 System Status: FUNCTIONAL")
        print("⚠️  Some components need attention")
    else:
        print("🔴 System Status: NEEDS REPAIR")
        print("❌ Critical issues detected")

def main():
    """Run all tests"""
    print("🧪 Assistente Pessoal IA - Agent Testing Suite")
    print("=" * 60)

    # Run all tests
    config_results, memory_results = test_agent_configurations()
    dispatcher_results = test_slash_command_dispatcher()
    routing_results = test_intelligent_routing()
    integration_results = test_system_integration()

    # Generate report
    generate_test_report(config_results, memory_results, dispatcher_results, routing_results, integration_results)

    # Exit with appropriate code
    all_results = [config_results, memory_results, dispatcher_results, routing_results, integration_results]

    # Simple health check - if most things work, exit 0
    total_items = sum(len(results) for results in all_results if isinstance(results, dict))
    working_items = sum(
        sum(1 for item in results.values()
            if (isinstance(item, dict) and item.get("success", item.get("valid_yaml", item.get("correct", bool(item))))))
        for results in all_results if isinstance(results, dict)
    )

    if total_items > 0 and working_items / total_items >= 0.7:
        sys.exit(0)
    else:
        sys.exit(1)

if __name__ == "__main__":
    main()