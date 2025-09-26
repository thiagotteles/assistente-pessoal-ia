#!/usr/bin/env python3
"""
Slash Command Dispatcher for Assistente Pessoal IA
Handles routing and execution of /organizador, /secretaria, /arquiteto, /psicologo, /mentor commands
Integrates with Agent Memory System and Knowledge-Base Manager
"""

import os
import sys
import yaml
import json
import datetime
from typing import Dict, List, Optional, Any, Tuple
from pathlib import Path

# Add current directory to path for imports
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

try:
    from agent_memory_system import create_agent_memory_system
    from knowledge_base_manager import create_knowledge_manager
except ImportError as e:
    print(f"Warning: Could not import core systems: {e}")
    print("Running in standalone mode...")

class SlashCommandDispatcher:
    """Main dispatcher for handling slash commands and agent routing"""

    def __init__(self, project_root: str = None):
        self.project_root = Path(project_root) if project_root else Path(__file__).parent.parent
        self.core_path = self.project_root / ".assistant-core"

        # Initialize core systems
        self.agents_config = {}
        self.agents_memory = {}
        self.agent_memory_system = None
        self.knowledge_manager = None

        # Command mapping
        self.available_commands = {
            "organizador": self._handle_organizador,
            "secretaria": self._handle_secretaria,
            "arquiteto": self._handle_arquiteto,
            "psicologo": self._handle_psicologo,
            "mentor": self._handle_mentor,
            "status": self._handle_status
        }

        # Initialize systems
        self._load_agents_config()
        self._initialize_core_systems()

    def _load_agents_config(self):
        """Load agent configurations and memory"""
        agents_dir = self.core_path / "agents"
        memory_dir = self.core_path / "memory"

        agent_names = ["organizador", "secretaria", "arquiteto", "psicologo", "mentor"]

        for agent in agent_names:
            # Load config
            config_file = agents_dir / f"{agent}.yaml"
            if config_file.exists():
                with open(config_file, 'r', encoding='utf-8') as f:
                    self.agents_config[agent] = yaml.safe_load(f)

            # Load memory
            memory_file = memory_dir / f"{agent}-memory.yaml"
            if memory_file.exists():
                with open(memory_file, 'r', encoding='utf-8') as f:
                    self.agents_memory[agent] = yaml.safe_load(f)

    def _initialize_core_systems(self):
        """Initialize Agent Memory System and Knowledge Manager"""
        try:
            self.agent_memory_system = create_agent_memory_system()
            self.knowledge_manager = create_knowledge_manager()
            print("✅ Core systems initialized successfully")
        except Exception as e:
            print(f"⚠️  Warning: Core systems not fully available: {e}")

    def dispatch_command(self, command: str, args: List[str] = None, context: str = "") -> Dict[str, Any]:
        """
        Main entry point for slash command processing

        Args:
            command: Command name (without /)
            args: Command arguments
            context: Additional context for processing

        Returns:
            Dict with response, status, and metadata
        """
        if args is None:
            args = []

        # Clean command name
        command = command.lstrip('/')

        # Check if command exists
        if command not in self.available_commands:
            return self._suggest_command(command)

        # Route to appropriate handler
        try:
            result = self.available_commands[command](args, context)

            # Log interaction if systems available
            self._log_interaction(command, args, context, result)

            return result

        except Exception as e:
            return {
                "status": "error",
                "message": f"Erro ao executar comando /{command}: {str(e)}",
                "agent": command,
                "timestamp": datetime.datetime.now().isoformat()
            }

    def _handle_organizador(self, args: List[str], context: str) -> Dict[str, Any]:
        """Handle /organizador command - processes dumps and organizes information"""
        agent_config = self.agents_config.get("organizador", {})
        agent_memory = self.agents_memory.get("organizador", {})

        # Load personality
        personality = agent_config.get("personality", {})
        greeting = agent_config.get("prompts", {}).get("greeting",
                                   "Organizador aqui! Vou processar suas informações e categorizá-las automaticamente.")

        response = {
            "status": "success",
            "agent": "organizador",
            "personality": personality.get("type", "organizador-inteligente"),
            "message": greeting,
            "timestamp": datetime.datetime.now().isoformat()
        }

        # Check if processing daily-dump
        if not args or (len(args) == 1 and "daily-dump" in args[0]):
            dump_file = self.project_root / "despejo" / "daily-dump.txt"
            if dump_file.exists():
                response["action"] = "process_dump"
                response["file"] = str(dump_file)
                response["message"] += f"\n\n📋 Vou processar seu despejo mental do arquivo {dump_file.name}"
                response["instructions"] = [
                    "Analisando conteúdo do daily-dump.txt",
                    "Identificando pessoas com [[referências]]",
                    "Categorizando projetos e decisões",
                    "Criando estrutura na knowledge-base",
                    "Sugerindo próximos passos organizacionais"
                ]
            else:
                response["message"] += f"\n\n⚠️  Arquivo daily-dump.txt não encontrado em {dump_file}"
        else:
            # Process specific content
            content = " ".join(args) if args else context
            response["action"] = "organize_content"
            response["content"] = content
            response["message"] += f"\n\n📝 Vou organizar o seguinte conteúdo: {content[:100]}..."

        return response

    def _handle_secretaria(self, args: List[str], context: str) -> Dict[str, Any]:
        """Handle /secretaria command - executive management and scheduling"""
        agent_config = self.agents_config.get("secretaria", {})

        greeting = agent_config.get("prompts", {}).get("greeting",
                                  "Secretária Executiva aqui! Como posso ajudar com sua agenda e projetos hoje?")

        response = {
            "status": "success",
            "agent": "secretaria",
            "message": greeting,
            "timestamp": datetime.datetime.now().isoformat()
        }

        # Determine action based on args
        if not args:
            response["action"] = "agenda_do_dia"
            response["message"] += "\n\n📅 **Agenda do Dia**"
            response["instructions"] = [
                "Verificando compromissos pendentes",
                "Analisando status de projetos ativos",
                "Identificando tarefas urgentes",
                "Preparando relatório executivo"
            ]
        elif "status" in " ".join(args).lower():
            response["action"] = "status_projetos"
            response["message"] += "\n\n📊 **Status dos Projetos**"
        elif "reuniao" in " ".join(args).lower() or "meeting" in " ".join(args).lower():
            response["action"] = "registro_reuniao"
            response["message"] += "\n\n🎯 **Registro de Reunião**"
        else:
            content = " ".join(args)
            response["action"] = "executive_task"
            response["content"] = content
            response["message"] += f"\n\n📋 Processando solicitação executiva: {content}"

        return response

    def _handle_arquiteto(self, args: List[str], context: str) -> Dict[str, Any]:
        """Handle /arquiteto command - technical consultation with constructive confrontation"""
        agent_config = self.agents_config.get("arquiteto", {})

        greeting = agent_config.get("prompts", {}).get("greeting",
                                  "Arquiteto aqui. Me mostre o que você está construindo. Vou questionar suas decisões baseado no que já discutimos antes.")

        response = {
            "status": "success",
            "agent": "arquiteto",
            "message": greeting,
            "timestamp": datetime.datetime.now().isoformat()
        }

        if args:
            content = " ".join(args)
            response["action"] = "analise_tecnica"
            response["content"] = content
            response["message"] += f"\n\n🏗️ **Análise Técnica**\nAnalisando: {content}"
            response["instructions"] = [
                "Recuperando decisões técnicas anteriores",
                "Identificando padrões arquiteturais",
                "Preparando questionamento construtivo",
                "Sugerindo alternativas baseadas em histórico"
            ]
        else:
            response["action"] = "analise_projeto"
            response["message"] += "\n\n🔍 **Consultoria Arquitetural**"
            response["instructions"] = [
                "Pronto para revisar arquitetura",
                "Envie URL do repositório ou descrição do projeto",
                "Farei questionamento baseado em decisões anteriores"
            ]

        return response

    def _handle_psicologo(self, args: List[str], context: str) -> Dict[str, Any]:
        """Handle /psicologo command - ADHD support and emotional guidance"""
        agent_config = self.agents_config.get("psicologo", {})

        greeting = agent_config.get("prompts", {}).get("greeting",
                                  "Psicólogo aqui. Como você está se sentindo hoje? Estou aqui para ajudar com estratégias para TDAH e bem-estar.")

        response = {
            "status": "success",
            "agent": "psicologo",
            "message": greeting,
            "timestamp": datetime.datetime.now().isoformat()
        }

        if args:
            content = " ".join(args)
            response["action"] = "suporte_emocional"
            response["content"] = content
            response["message"] += f"\n\n🧠 **Suporte Especializado**\nVamos trabalhar com: {content}"

            # Detect specific ADHD-related keywords
            content_lower = content.lower()
            if any(word in content_lower for word in ["sobrecarregado", "ansioso", "foco", "concentração", "procrastinação"]):
                response["focus_area"] = "adhd_strategies"
                response["instructions"] = [
                    "Analisando padrões de TDAH",
                    "Identificando gatilhos específicos",
                    "Preparando estratégias de autorregulação",
                    "Sugerindo técnicas baseadas em evidências"
                ]
            else:
                response["focus_area"] = "emotional_support"
                response["instructions"] = [
                    "Avaliando estado emocional",
                    "Identificando padrões comportamentais",
                    "Preparando suporte empático",
                    "Sugerindo estratégias de enfrentamento"
                ]
        else:
            response["action"] = "analise_humor_energia"
            response["message"] += "\n\n💭 **Check-in Emocional**"
            response["instructions"] = [
                "Como está seu humor hoje?",
                "Níveis de energia e motivação?",
                "Algum desafio específico com TDAH?",
                "Precisa de estratégias de foco?"
            ]

        return response

    def _handle_mentor(self, args: List[str], context: str) -> Dict[str, Any]:
        """Handle /mentor command - career development and strategic guidance"""
        agent_config = self.agents_config.get("mentor", {})

        greeting = agent_config.get("prompts", {}).get("greeting",
                                  "Mentor de carreira aqui! Vamos trabalhar no seu desenvolvimento profissional estratégico.")

        response = {
            "status": "success",
            "agent": "mentor",
            "message": greeting,
            "timestamp": datetime.datetime.now().isoformat()
        }

        if args:
            content = " ".join(args)
            response["action"] = "orientacao_carreira"
            response["content"] = content
            response["message"] += f"\n\n🚀 **Orientação Estratégica**\nFoco: {content}"

            # Detect career-related keywords
            content_lower = content.lower()
            if any(word in content_lower for word in ["carreira", "crescimento", "promoção", "objetivo"]):
                response["focus_area"] = "career_planning"
                response["instructions"] = [
                    "Analisando objetivos de carreira",
                    "Mapeando oportunidades de crescimento",
                    "Identificando skills necessários",
                    "Criando plano de desenvolvimento"
                ]
            elif any(word in content_lower for word in ["networking", "relacionamento", "equipe"]):
                response["focus_area"] = "networking"
            else:
                response["focus_area"] = "skill_development"
        else:
            response["action"] = "tracking_metas"
            response["message"] += "\n\n🎯 **Acompanhamento de Metas**"
            response["instructions"] = [
                "Revisando objetivos de carreira atuais",
                "Avaliando progresso em projetos",
                "Identificando próximas oportunidades",
                "Sugerindo desenvolvimento estratégico"
            ]

        return response

    def _handle_status(self, args: List[str], context: str) -> Dict[str, Any]:
        """Handle /status command - system health check"""
        status_report = {
            "status": "success",
            "command": "status",
            "timestamp": datetime.datetime.now().isoformat(),
            "system_health": {},
            "agents_status": {},
            "core_systems": {}
        }

        # Check agents availability
        for agent_name in ["organizador", "secretaria", "arquiteto", "psicologo", "mentor"]:
            agent_status = {
                "available": agent_name in self.agents_config,
                "config_loaded": agent_name in self.agents_config,
                "memory_loaded": agent_name in self.agents_memory,
                "last_interaction": None
            }

            if agent_name in self.agents_config:
                config = self.agents_config[agent_name]
                agent_status["personality"] = config.get("personality", {}).get("type", "unknown")
                agent_status["functions"] = len(config.get("functions", []))

            status_report["agents_status"][agent_name] = agent_status

        # Check core systems
        status_report["core_systems"] = {
            "agent_memory_system": self.agent_memory_system is not None,
            "knowledge_manager": self.knowledge_manager is not None,
            "project_structure": (self.project_root / ".assistant-core").exists(),
            "daily_dump": (self.project_root / "despejo" / "daily-dump.txt").exists(),
            "knowledge_base": (self.project_root / "knowledge-base").exists()
        }

        # Overall health
        agents_healthy = sum(1 for status in status_report["agents_status"].values()
                           if status["available"]) >= 4
        systems_healthy = sum(1 for status in status_report["core_systems"].values()
                            if status) >= 3

        status_report["system_health"] = {
            "overall": "healthy" if agents_healthy and systems_healthy else "degraded",
            "agents_available": sum(1 for status in status_report["agents_status"].values()
                                  if status["available"]),
            "total_agents": 5,
            "core_systems_online": sum(1 for status in status_report["core_systems"].values()
                                     if status)
        }

        # Generate human-readable message
        health = status_report["system_health"]
        if health["overall"] == "healthy":
            status_report["message"] = f"🟢 **Sistema Saudável**\n\n✅ {health['agents_available']}/5 agentes disponíveis\n✅ Sistemas core operacionais\n✅ Estrutura de arquivos íntegra"
        else:
            status_report["message"] = f"🟡 **Sistema Parcialmente Operacional**\n\n⚠️ {health['agents_available']}/5 agentes disponíveis\n⚠️ Alguns sistemas precisam de atenção"

        return status_report

    def _suggest_command(self, command: str) -> Dict[str, Any]:
        """Suggest alternative commands when user types invalid command"""
        available = list(self.available_commands.keys())

        # Simple fuzzy matching
        suggestions = []
        for cmd in available:
            if command.lower() in cmd.lower() or cmd.lower() in command.lower():
                suggestions.append(cmd)

        if not suggestions:
            suggestions = available[:3]  # Show first 3 as examples

        return {
            "status": "error",
            "message": f"Comando '/{command}' não reconhecido.",
            "suggestions": [f"/{cmd}" for cmd in suggestions],
            "available_commands": [f"/{cmd}" for cmd in available],
            "timestamp": datetime.datetime.now().isoformat()
        }

    def _log_interaction(self, command: str, args: List[str], context: str, result: Dict[str, Any]):
        """Log interaction for learning and improvement"""
        if self.agent_memory_system:
            try:
                interaction_data = {
                    "command": command,
                    "args": args,
                    "context": context[:200] if context else "",  # Limit context size
                    "result_status": result.get("status"),
                    "timestamp": datetime.datetime.now().isoformat()
                }

                # Update agent memory with interaction
                if command in ["organizador", "secretaria", "arquiteto", "psicologo", "mentor"]:
                    self.agent_memory_system.atualizar_interacao(command, interaction_data)

            except Exception as e:
                print(f"Warning: Could not log interaction: {e}")

    def get_intelligent_routing_suggestion(self, user_input: str) -> str:
        """Suggest the most appropriate agent based on user input"""
        input_lower = user_input.lower()

        # Keyword-based routing
        routing_keywords = {
            "organizador": ["organizar", "categorizar", "processar", "despejo", "daily-dump", "estruturar"],
            "secretaria": ["agenda", "reunião", "projeto", "status", "executivo", "coordenar"],
            "arquiteto": ["arquitetura", "técnico", "código", "sistema", "design", "implementar"],
            "psicologo": ["humor", "ansioso", "foco", "TDAH", "estresse", "emocional", "procrastinação"],
            "mentor": ["carreira", "crescimento", "meta", "objetivo", "desenvolvimento", "networking"]
        }

        scores = {}
        for agent, keywords in routing_keywords.items():
            score = sum(1 for keyword in keywords if keyword in input_lower)
            if score > 0:
                scores[agent] = score

        if scores:
            best_agent = max(scores, key=scores.get)
            return best_agent

        return "organizador"  # Default fallback


def main():
    """CLI interface for testing slash commands"""
    import argparse

    parser = argparse.ArgumentParser(description="Assistente Pessoal IA - Slash Command Dispatcher")
    parser.add_argument("command", help="Command to execute (e.g., organizador, status)")
    parser.add_argument("args", nargs="*", help="Command arguments")
    parser.add_argument("--context", default="", help="Additional context")
    parser.add_argument("--project-root", help="Project root directory")

    args = parser.parse_args()

    # Initialize dispatcher
    dispatcher = SlashCommandDispatcher(args.project_root)

    # Execute command
    result = dispatcher.dispatch_command(args.command, args.args, args.context)

    # Pretty print result
    print(json.dumps(result, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()