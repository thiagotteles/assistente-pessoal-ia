#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Agent Memory System Foundation

Sistema de memória persistente para os 5 agentes especializados do Assistente Pessoal IA.
Mantém personalidades consistentes, contexto e padrões aprendidos entre interações.

Author: James (Dev Agent)
Date: 2025-09-25
Story: 0.3 - Agent Memory System Foundation
"""

import os
import sys
import yaml
import uuid
import logging
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, List, Optional, Any, Union
from dataclasses import dataclass

# Importar Knowledge-Base Manager para integração
try:
    from .knowledge_base_manager import create_knowledge_manager
    KNOWLEDGE_BASE_AVAILABLE = True
except ImportError:
    KNOWLEDGE_BASE_AVAILABLE = False
    logger.warning("Knowledge-Base Manager não disponível - algumas funcionalidades serão limitadas")


# Setup logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger('AgentMemorySystem')


@dataclass
class InteractionRecord:
    """Registro de interação com um agente"""
    timestamp: str
    user_input: str
    agent_response: str
    context_data: Dict[str, Any]
    patterns_identified: List[str]


@dataclass
class AgentPersonality:
    """Estrutura de personalidade do agente"""
    agent_id: str
    traits: List[str]
    communication_style: str
    behavior_patterns: List[str]
    evolution_markers: List[str]


class AgentMemorySystem:
    """
    Sistema de Memória dos Agentes

    Gerencia memória persistente e personalidade dos 5 agentes especializados:
    - Organizador: Padrões de categorização e preferências
    - Secretária: Gestão executiva e reuniões
    - Arquiteto: Decisões técnicas e contexto arquitetural
    - Psicólogo: Suporte TDAH e padrões emocionais
    - Mentor: Desenvolvimento profissional e networking
    """

    def __init__(self, base_dir: Optional[str] = None):
        """
        Inicializa o sistema de memória dos agentes

        Args:
            base_dir: Diretório base do projeto (opcional)
        """
        self.base_dir = Path(base_dir) if base_dir else Path('.')
        self.memory_dir = self.base_dir / '.assistant-core' / 'memory'
        self.logs_dir = self.base_dir / '.assistant-core' / 'logs'

        # Lista dos 5 agentes especializados
        self.agents = [
            'organizador',
            'secretaria',
            'arquiteto',
            'psicologo',
            'mentor'
        ]

        # Configuração de encoding
        self.encoding = 'utf-8'

        # Cache de memórias carregadas
        self._memory_cache: Dict[str, Dict] = {}

        # Integração com Knowledge-Base Manager
        self.knowledge_manager = None
        if KNOWLEDGE_BASE_AVAILABLE:
            try:
                self.knowledge_manager = create_knowledge_manager(str(self.base_dir))
                logger.info("Knowledge-Base Manager integrado com sucesso")
            except Exception as e:
                logger.warning(f"Falha ao integrar Knowledge-Base Manager: {e}")

        # Inicializar estrutura se necessário
        self._ensure_directory_structure()

        logger.info(f"AgentMemorySystem inicializado em: {self.memory_dir}")


    def _ensure_directory_structure(self):
        """Garante que a estrutura de diretórios existe"""
        try:
            self.memory_dir.mkdir(parents=True, exist_ok=True)
            self.logs_dir.mkdir(parents=True, exist_ok=True)

            # Verificar se arquivos de memória existem
            for agent in self.agents:
                memory_file = self.memory_dir / f"{agent}-memory.yaml"
                if not memory_file.exists():
                    logger.warning(f"Arquivo de memória não encontrado: {memory_file}")

        except Exception as e:
            logger.error(f"Erro ao garantir estrutura de diretórios: {e}")
            raise


    def carregar_memoria_agente(self, agent_id: str) -> Optional[Dict[str, Any]]:
        """
        Carrega a memória completa de um agente específico

        Args:
            agent_id: ID do agente (organizador|secretaria|arquiteto|psicologo|mentor)

        Returns:
            Dict com a memória do agente ou None se não encontrado
        """
        if agent_id not in self.agents:
            logger.error(f"Agente '{agent_id}' não reconhecido. Agentes válidos: {self.agents}")
            return None

        # Verificar cache primeiro
        if agent_id in self._memory_cache:
            logger.debug(f"Memória do agente '{agent_id}' carregada do cache")
            return self._memory_cache[agent_id]

        memory_file = self.memory_dir / f"{agent_id}-memory.yaml"

        try:
            if not memory_file.exists():
                logger.warning(f"Arquivo de memória não encontrado: {memory_file}")
                return self._criar_memoria_padrao(agent_id)

            with open(memory_file, 'r', encoding=self.encoding) as f:
                memory_data = yaml.safe_load(f)

            if not memory_data:
                logger.warning(f"Arquivo de memória vazio para agente '{agent_id}'")
                return self._criar_memoria_padrao(agent_id)

            # Validar estrutura básica
            if not self._validar_estrutura_memoria(memory_data, agent_id):
                logger.warning(f"Estrutura de memória inválida para agente '{agent_id}' - usando padrão")
                return self._criar_memoria_padrao(agent_id)

            # Armazenar no cache
            self._memory_cache[agent_id] = memory_data

            logger.info(f"Memória do agente '{agent_id}' carregada com sucesso")
            return memory_data

        except yaml.YAMLError as e:
            logger.error(f"Erro ao parse YAML da memória do agente '{agent_id}': {e}")
            return self._criar_memoria_padrao(agent_id)
        except Exception as e:
            logger.error(f"Erro ao carregar memória do agente '{agent_id}': {e}")
            return None


    def atualizar_memoria_agente(self, agent_id: str, interaction_data: Dict[str, Any]) -> bool:
        """
        Atualiza a memória de um agente com dados de nova interação

        Args:
            agent_id: ID do agente
            interaction_data: Dados da interação (user_input, agent_response, context, etc.)

        Returns:
            True se atualização foi bem-sucedida
        """
        if agent_id not in self.agents:
            logger.error(f"Agente '{agent_id}' não reconhecido")
            return False

        try:
            # Carregar memória atual
            memory = self.carregar_memoria_agente(agent_id)
            if not memory:
                logger.error(f"Não foi possível carregar memória do agente '{agent_id}'")
                return False

            # Backup antes da atualização
            if not self._backup_memoria(agent_id, memory):
                logger.warning(f"Falha no backup da memória do agente '{agent_id}'")

            # Atualizar timestamp
            memory['last_updated'] = datetime.now(timezone.utc).isoformat()

            # Processar dados da interação
            self._processar_interacao(memory, interaction_data, agent_id)

            # Aplicar aprendizado de padrões
            self._aplicar_aprendizado_padroes(memory, interaction_data, agent_id)

            # Manter consistência de personalidade
            self._manter_personalidade(memory, agent_id)

            # Salvar memória atualizada
            if self._salvar_memoria_agente(agent_id, memory):
                # Atualizar cache
                self._memory_cache[agent_id] = memory
                logger.info(f"Memória do agente '{agent_id}' atualizada com sucesso")
                return True
            else:
                logger.error(f"Falha ao salvar memória atualizada do agente '{agent_id}'")
                return False

        except Exception as e:
            logger.error(f"Erro ao atualizar memória do agente '{agent_id}': {e}")
            return False


    def manter_personalidade(self, agent_id: str) -> bool:
        """
        Garante consistência comportamental específica do agente

        Args:
            agent_id: ID do agente

        Returns:
            True se personalidade foi mantida/ajustada
        """
        if agent_id not in self.agents:
            return False

        try:
            memory = self.carregar_memoria_agente(agent_id)
            if not memory:
                return False

            # Aplicar características específicas por agente
            personality_updated = False

            if 'personality_context' not in memory:
                memory['personality_context'] = {}
                personality_updated = True

            # Definir características base por agente
            base_personalities = {
                'organizador': {
                    'confrontation_level': 'medium',
                    'question_style': 'specific-direct',
                    'follow_up_tendency': 'persistent'
                },
                'secretaria': {
                    'proactivity_level': 'high',
                    'detail_orientation': 'comprehensive',
                    'urgency_detection': 'sensitive'
                },
                'arquiteto': {
                    'technical_depth': 'comprehensive',
                    'decision_style': 'evidence-based',
                    'documentation_preference': 'detailed'
                },
                'psicologo': {
                    'empathy_level': 'high',
                    'intervention_style': 'gentle-supportive',
                    'crisis_sensitivity': 'very-high'
                },
                'mentor': {
                    'coaching_style': 'growth-oriented',
                    'feedback_approach': 'constructive-direct',
                    'vision_tendency': 'long-term'
                }
            }

            if agent_id in base_personalities:
                for key, value in base_personalities[agent_id].items():
                    if key not in memory['personality_context']:
                        memory['personality_context'][key] = value
                        personality_updated = True

            # Salvar se houve mudanças
            if personality_updated:
                memory['last_updated'] = datetime.now(timezone.utc).isoformat()
                if self._salvar_memoria_agente(agent_id, memory):
                    self._memory_cache[agent_id] = memory
                    logger.info(f"Personalidade do agente '{agent_id}' atualizada")
                    return True

            return True

        except Exception as e:
            logger.error(f"Erro ao manter personalidade do agente '{agent_id}': {e}")
            return False


    def identificar_padroes_referencias(self, agent_id: str, content: str) -> List[str]:
        """
        Detecta padrões de uso de referências [[]] no conteúdo

        Args:
            agent_id: ID do agente
            content: Conteúdo para análise

        Returns:
            Lista de referências identificadas
        """
        import re

        try:
            # Regex para detectar padrões [[Nome]]
            reference_pattern = r'\[\[([^\]]+)\]\]'
            references = re.findall(reference_pattern, content)

            if references:
                # Atualizar memória com padrões identificados
                memory = self.carregar_memoria_agente(agent_id)
                if memory:
                    if 'learned_patterns' not in memory:
                        memory['learned_patterns'] = {}

                    if 'obsidian_references' not in memory['learned_patterns']:
                        memory['learned_patterns']['obsidian_references'] = []

                    # Adicionar novas referências (evitar duplicatas)
                    for ref in references:
                        if ref not in memory['learned_patterns']['obsidian_references']:
                            memory['learned_patterns']['obsidian_references'].append(ref)

                    # Salvar memória atualizada
                    self._salvar_memoria_agente(agent_id, memory)
                    self._memory_cache[agent_id] = memory

                logger.debug(f"Agente '{agent_id}' - referências identificadas: {references}")

            return references

        except Exception as e:
            logger.error(f"Erro ao identificar padrões de referências para agente '{agent_id}': {e}")
            return []


    def reset_memoria_agente(self, agent_id: str) -> bool:
        """
        Reset individual da memória de um agente

        Args:
            agent_id: ID do agente para reset

        Returns:
            True se reset foi bem-sucedido
        """
        if agent_id not in self.agents:
            logger.error(f"Agente '{agent_id}' não reconhecido")
            return False

        try:
            # Backup da memória atual antes do reset
            current_memory = self.carregar_memoria_agente(agent_id)
            if current_memory:
                backup_success = self._backup_memoria(agent_id, current_memory, suffix='_pre_reset')
                if not backup_success:
                    logger.warning(f"Falha no backup pré-reset do agente '{agent_id}'")

            # Criar nova memória padrão
            default_memory = self._criar_memoria_padrao(agent_id)

            # Salvar memória resetada
            if self._salvar_memoria_agente(agent_id, default_memory):
                # Limpar cache
                if agent_id in self._memory_cache:
                    del self._memory_cache[agent_id]

                logger.info(f"Memória do agente '{agent_id}' resetada com sucesso")
                return True
            else:
                logger.error(f"Falha ao salvar memória resetada do agente '{agent_id}'")
                return False

        except Exception as e:
            logger.error(f"Erro ao resetar memória do agente '{agent_id}': {e}")
            return False


    def backup_memoria(self, agent_id: Optional[str] = None) -> bool:
        """
        Backup de memória para recovery

        Args:
            agent_id: ID do agente específico ou None para todos

        Returns:
            True se backup foi bem-sucedido
        """
        try:
            agents_to_backup = [agent_id] if agent_id else self.agents
            success_count = 0

            for agent in agents_to_backup:
                if agent not in self.agents:
                    logger.warning(f"Agente '{agent}' não reconhecido - pulando backup")
                    continue

                memory = self.carregar_memoria_agente(agent)
                if memory and self._backup_memoria(agent, memory):
                    success_count += 1
                else:
                    logger.error(f"Falha no backup da memória do agente '{agent}'")

            total_agents = len(agents_to_backup) if agent_id else len(self.agents)
            success = success_count == total_agents

            if success:
                logger.info(f"Backup de memória concluído com sucesso para {success_count} agente(s)")
            else:
                logger.warning(f"Backup parcial: {success_count}/{total_agents} agentes")

            return success

        except Exception as e:
            logger.error(f"Erro durante backup de memória: {e}")
            return False


    def _criar_memoria_padrao(self, agent_id: str) -> Dict[str, Any]:
        """Cria estrutura de memória padrão para um agente"""
        base_memory = {
            'agent': agent_id,
            'last_updated': datetime.now(timezone.utc).isoformat(),
            'version': '1.0',
            'interaction_history': {
                'total_sessions': 0,
                'last_session': None,
                'successful_interactions': 0
            },
            'personality_context': {},
            'learned_patterns': {}
        }

        # Estruturas específicas por agente
        agent_specific = {
            'organizador': {
                'organization_patterns': {
                    'user_preferences': [],
                    'frequent_categories': [],
                    'rejected_suggestions': []
                },
                'learned_patterns': {
                    'procrastination_triggers': [],
                    'preferred_categorization': [],
                    'time_patterns': []
                }
            },
            'secretaria': {
                'executive_patterns': {
                    'meeting_frequency': {},
                    'project_priorities': [],
                    'workload_indicators': []
                },
                'management_history': {
                    'meetings_processed': 0,
                    'todos_extracted': 0,
                    'overload_warnings': 0
                },
                'learned_patterns': {
                    'stress_indicators': [],
                    'productivity_peaks': [],
                    'meeting_patterns': []
                }
            },
            'arquiteto': {
                'technical_patterns': {
                    'preferred_technologies': [],
                    'architectural_decisions': [],
                    'code_standards': []
                },
                'decision_history': {
                    'decisions_made': 0,
                    'reversed_decisions': 0,
                    'context_requests': 0
                },
                'learned_patterns': {
                    'technical_preferences': [],
                    'complexity_tolerance': [],
                    'documentation_style': []
                }
            },
            'psicologo': {
                'emotional_patterns': {
                    'mood_indicators': [],
                    'stress_triggers': [],
                    'coping_strategies': []
                },
                'support_history': {
                    'interventions_made': 0,
                    'crisis_episodes': 0,
                    'progress_markers': 0
                },
                'learned_patterns': {
                    'effective_interventions': [],
                    'emotional_cycles': [],
                    'adhd_patterns': []
                }
            },
            'mentor': {
                'development_patterns': {
                    'career_goals': [],
                    'skill_gaps': [],
                    'networking_opportunities': []
                },
                'mentoring_history': {
                    'sessions_conducted': 0,
                    'goals_achieved': 0,
                    'opportunities_identified': 0
                },
                'learned_patterns': {
                    'learning_style': [],
                    'motivation_factors': [],
                    'career_aspirations': []
                }
            }
        }

        # Mesclar estrutura específica
        if agent_id in agent_specific:
            base_memory.update(agent_specific[agent_id])

        return base_memory


    def _validar_estrutura_memoria(self, memory_data: Dict, agent_id: str) -> bool:
        """Valida se a estrutura de memória está correta"""
        required_fields = ['agent', 'last_updated', 'version']

        for field in required_fields:
            if field not in memory_data:
                logger.warning(f"Campo obrigatório '{field}' ausente na memória do agente '{agent_id}'")
                return False

        if memory_data.get('agent') != agent_id:
            logger.warning(f"ID do agente inconsistente na memória: esperado '{agent_id}', encontrado '{memory_data.get('agent')}'")
            return False

        return True


    def _processar_interacao(self, memory: Dict, interaction_data: Dict, agent_id: str):
        """Processa dados de interação e atualiza memória"""
        try:
            # Atualizar histórico de interações
            if 'interaction_history' not in memory:
                memory['interaction_history'] = {
                    'total_sessions': 0,
                    'last_session': None,
                    'successful_interactions': 0
                }

            memory['interaction_history']['total_sessions'] += 1
            memory['interaction_history']['last_session'] = datetime.now(timezone.utc).isoformat()

            if interaction_data.get('success', True):
                memory['interaction_history']['successful_interactions'] += 1

            # Processar contexto específico por tipo de agente
            self._processar_contexto_especifico(memory, interaction_data, agent_id)

        except Exception as e:
            logger.error(f"Erro ao processar interação para agente '{agent_id}': {e}")


    def _processar_contexto_especifico(self, memory: Dict, interaction_data: Dict, agent_id: str):
        """Processa contexto específico baseado no tipo de agente"""
        try:
            user_input = interaction_data.get('user_input', '')
            agent_response = interaction_data.get('agent_response', '')
            context = interaction_data.get('context', {})

            # Processamento específico por agente
            if agent_id == 'organizador':
                self._processar_organizador(memory, user_input, agent_response, context)
            elif agent_id == 'secretaria':
                self._processar_secretaria(memory, user_input, agent_response, context)
            elif agent_id == 'arquiteto':
                self._processar_arquiteto(memory, user_input, agent_response, context)
            elif agent_id == 'psicologo':
                self._processar_psicologo(memory, user_input, agent_response, context)
            elif agent_id == 'mentor':
                self._processar_mentor(memory, user_input, agent_response, context)

        except Exception as e:
            logger.error(f"Erro ao processar contexto específico do agente '{agent_id}': {e}")


    def _processar_organizador(self, memory: Dict, user_input: str, agent_response: str, context: Dict):
        """Processamento específico do Organizador"""
        # Detectar categorias mencionadas
        categorias = context.get('categories_identified', [])
        if categorias:
            if 'organization_patterns' not in memory:
                memory['organization_patterns'] = {'frequent_categories': []}

            for categoria in categorias:
                if categoria not in memory['organization_patterns']['frequent_categories']:
                    memory['organization_patterns']['frequent_categories'].append(categoria)


    def _processar_secretaria(self, memory: Dict, user_input: str, agent_response: str, context: Dict):
        """Processamento específico da Secretária"""
        # Detectar reuniões processadas
        if 'meeting' in user_input.lower() or 'reunião' in user_input.lower():
            if 'management_history' not in memory:
                memory['management_history'] = {'meetings_processed': 0}
            memory['management_history']['meetings_processed'] += 1


    def _processar_arquiteto(self, memory: Dict, user_input: str, agent_response: str, context: Dict):
        """Processamento específico do Arquiteto"""
        # Detectar decisões técnicas
        tecnologias = context.get('technologies_mentioned', [])
        if tecnologias:
            if 'technical_patterns' not in memory:
                memory['technical_patterns'] = {'preferred_technologies': []}

            for tech in tecnologias:
                if tech not in memory['technical_patterns']['preferred_technologies']:
                    memory['technical_patterns']['preferred_technologies'].append(tech)


    def _processar_psicologo(self, memory: Dict, user_input: str, agent_response: str, context: Dict):
        """Processamento específico do Psicólogo"""
        # Detectar indicadores emocionais
        mood = context.get('mood_detected', None)
        if mood:
            if 'emotional_patterns' not in memory:
                memory['emotional_patterns'] = {'mood_indicators': []}

            if mood not in memory['emotional_patterns']['mood_indicators']:
                memory['emotional_patterns']['mood_indicators'].append(mood)


    def _processar_mentor(self, memory: Dict, user_input: str, agent_response: str, context: Dict):
        """Processamento específico do Mentor"""
        # Detectar metas e aspirações
        goals = context.get('goals_identified', [])
        if goals:
            if 'development_patterns' not in memory:
                memory['development_patterns'] = {'career_goals': []}

            for goal in goals:
                if goal not in memory['development_patterns']['career_goals']:
                    memory['development_patterns']['career_goals'].append(goal)


    def _aplicar_aprendizado_padroes(self, memory: Dict, interaction_data: Dict, agent_id: str):
        """Aplica aprendizado de padrões baseado na interação"""
        try:
            # Identificar referências [[]]
            content = f"{interaction_data.get('user_input', '')} {interaction_data.get('agent_response', '')}"
            references = self.identificar_padroes_referencias(agent_id, content)

            # Atualizar padrões aprendidos
            if 'learned_patterns' not in memory:
                memory['learned_patterns'] = {}

            # Adicionar timestamp do aprendizado
            memory['learned_patterns']['last_pattern_update'] = datetime.now(timezone.utc).isoformat()

        except Exception as e:
            logger.error(f"Erro ao aplicar aprendizado de padrões para agente '{agent_id}': {e}")


    def _manter_personalidade(self, memory: Dict, agent_id: str):
        """Mantém características de personalidade consistentes"""
        # Chamar método público para manter personalidade
        self.manter_personalidade(agent_id)


    def _salvar_memoria_agente(self, agent_id: str, memory_data: Dict) -> bool:
        """Salva dados de memória do agente no arquivo YAML"""
        try:
            memory_file = self.memory_dir / f"{agent_id}-memory.yaml"

            with open(memory_file, 'w', encoding=self.encoding) as f:
                yaml.dump(memory_data, f, default_flow_style=False, allow_unicode=True, indent=2)

            logger.debug(f"Memória do agente '{agent_id}' salva em: {memory_file}")
            return True

        except Exception as e:
            logger.error(f"Erro ao salvar memória do agente '{agent_id}': {e}")
            return False


    def _backup_memoria(self, agent_id: str, memory_data: Dict, suffix: str = '') -> bool:
        """Cria backup da memória do agente"""
        try:
            # Criar diretório de backup
            backup_dir = self.memory_dir / '.backups'
            backup_dir.mkdir(exist_ok=True)

            # Nome do arquivo de backup com timestamp
            timestamp = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
            backup_filename = f"{agent_id}-memory_backup_{timestamp}{suffix}.yaml"
            backup_file = backup_dir / backup_filename

            with open(backup_file, 'w', encoding=self.encoding) as f:
                yaml.dump(memory_data, f, default_flow_style=False, allow_unicode=True, indent=2)

            logger.debug(f"Backup da memória do agente '{agent_id}' criado: {backup_file}")
            return True

        except Exception as e:
            logger.error(f"Erro ao criar backup da memória do agente '{agent_id}': {e}")
            return False


    def sincronizar_com_knowledge_base(self, agent_id: str) -> bool:
        """
        Sincroniza informações de memória do agente com a knowledge-base

        Args:
            agent_id: ID do agente

        Returns:
            True se sincronização foi bem-sucedida
        """
        if not self.knowledge_manager:
            logger.warning("Knowledge-Base Manager não disponível para sincronização")
            return False

        if agent_id not in self.agents:
            return False

        try:
            memory = self.carregar_memoria_agente(agent_id)
            if not memory:
                return False

            # Extrair informações relevantes para compartilhar na knowledge-base
            shared_info = self._extrair_informacoes_compartilhaveis(memory, agent_id)

            if shared_info:
                # Salvar na knowledge-base com contexto do agente
                for info in shared_info:
                    result = self.knowledge_manager.salvar_entrada(
                        titulo=info['titulo'],
                        conteudo=info['conteudo'],
                        entry_type=info.get('tipo', 'contexto'),
                        source_agent=agent_id,
                        tags=info.get('tags', []),
                        project_refs=info.get('project_refs', [])
                    )

                    if result:
                        logger.info(f"Informação do agente '{agent_id}' sincronizada: {info['titulo']}")

                return True

        except Exception as e:
            logger.error(f"Erro ao sincronizar agente '{agent_id}' com knowledge-base: {e}")

        return False


    def recuperar_contexto_knowledge_base(self, agent_id: str, query: str) -> List[Dict]:
        """
        Recupera contexto relevante da knowledge-base para o agente

        Args:
            agent_id: ID do agente
            query: Query de busca

        Returns:
            Lista de entradas relevantes da knowledge-base
        """
        if not self.knowledge_manager:
            return []

        try:
            # Buscar informações relevantes na knowledge-base
            results = self.knowledge_manager.busca_semantica(
                query=query,
                limit=5,
                entry_type=None,  # Buscar todos os tipos
                source_agent=None  # Buscar de todos os agentes
            )

            # Filtrar resultados mais relevantes para o agente
            filtered_results = self._filtrar_resultados_por_agente(results, agent_id)

            logger.debug(f"Contexto recuperado da knowledge-base para '{agent_id}': {len(filtered_results)} entradas")
            return filtered_results

        except Exception as e:
            logger.error(f"Erro ao recuperar contexto da knowledge-base para agente '{agent_id}': {e}")
            return []


    def atualizar_referencias_obsidian(self, agent_id: str, content: str) -> List[str]:
        """
        Identifica e atualiza referências [[]] usando Knowledge-Base Manager

        Args:
            agent_id: ID do agente
            content: Conteúdo para análise de referências

        Returns:
            Lista de referências processadas
        """
        if not self.knowledge_manager:
            # Fallback para identificação local
            return self.identificar_padroes_referencias(agent_id, content)

        try:
            # Usar Knowledge-Base Manager para processamento avançado de referências
            processed_content = self.knowledge_manager.gerar_referencias_obsidian(content)

            # Extrair referências do conteúdo processado
            import re
            references = re.findall(r'\[\[([^\]]+)\]\]', processed_content)

            # Atualizar memória do agente com as referências
            if references:
                memory = self.carregar_memoria_agente(agent_id)
                if memory:
                    if 'learned_patterns' not in memory:
                        memory['learned_patterns'] = {}

                    if 'obsidian_references' not in memory['learned_patterns']:
                        memory['learned_patterns']['obsidian_references'] = []

                    # Adicionar novas referências
                    for ref in references:
                        if ref not in memory['learned_patterns']['obsidian_references']:
                            memory['learned_patterns']['obsidian_references'].append(ref)

                    # Salvar memória atualizada
                    self._salvar_memoria_agente(agent_id, memory)
                    self._memory_cache[agent_id] = memory

            logger.debug(f"Referências Obsidian processadas para '{agent_id}': {references}")
            return references

        except Exception as e:
            logger.error(f"Erro ao processar referências Obsidian para agente '{agent_id}': {e}")
            return []


    def compartilhar_aprendizado_entre_agentes(self, source_agent: str, target_agents: List[str] = None) -> bool:
        """
        Compartilha aprendizados relevantes entre agentes via knowledge-base

        Args:
            source_agent: Agente fonte do aprendizado
            target_agents: Lista de agentes alvo (None para todos)

        Returns:
            True se compartilhamento foi bem-sucedido
        """
        if not self.knowledge_manager:
            logger.warning("Knowledge-Base Manager não disponível para compartilhamento")
            return False

        if source_agent not in self.agents:
            return False

        target_agents = target_agents or [agent for agent in self.agents if agent != source_agent]

        try:
            # Carregar memória do agente fonte
            source_memory = self.carregar_memoria_agente(source_agent)
            if not source_memory:
                return False

            # Identificar aprendizados compartilháveis
            shared_learnings = self._extrair_aprendizados_compartilhaveis(source_memory, source_agent)

            success_count = 0
            for learning in shared_learnings:
                # Salvar na knowledge-base
                result = self.knowledge_manager.salvar_entrada(
                    titulo=f"Aprendizado Compartilhado - {learning['titulo']}",
                    conteudo=learning['conteudo'],
                    entry_type='contexto',
                    source_agent=source_agent,
                    tags=['aprendizado-compartilhado', 'cross-agent'] + learning.get('tags', [])
                )

                if result:
                    success_count += 1
                    logger.info(f"Aprendizado compartilhado: {learning['titulo']} (de {source_agent})")

            # Notificar agentes alvo sobre novos aprendizados disponíveis
            for target_agent in target_agents:
                self._notificar_novo_aprendizado(target_agent, source_agent, len(shared_learnings))

            return success_count > 0

        except Exception as e:
            logger.error(f"Erro ao compartilhar aprendizado do agente '{source_agent}': {e}")
            return False


    def _extrair_informacoes_compartilhaveis(self, memory: Dict, agent_id: str) -> List[Dict]:
        """Extrai informações relevantes da memória para compartilhar na knowledge-base"""
        shared_info = []

        try:
            # Padrões aprendidos compartilháveis
            learned_patterns = memory.get('learned_patterns', {})

            # Referências Obsidian
            if 'obsidian_references' in learned_patterns:
                refs = learned_patterns['obsidian_references']
                if refs:
                    shared_info.append({
                        'titulo': f'Referências Obsidian - {agent_id.capitalize()}',
                        'conteudo': f'Referências identificadas pelo agente {agent_id}:\n\n' +
                                  '\n'.join([f'- [[{ref}]]' for ref in refs[-10:]]),  # Últimas 10
                        'tipo': 'contexto',
                        'tags': ['referencias', agent_id, 'obsidian']
                    })

            # Padrões específicos por agente
            if agent_id == 'organizador':
                categories = memory.get('organization_patterns', {}).get('frequent_categories', [])
                if categories:
                    shared_info.append({
                        'titulo': 'Categorias Frequentes de Organização',
                        'conteudo': f'Categorias mais usadas:\n\n' +
                                  '\n'.join([f'- {cat}' for cat in categories[-5:]]),
                        'tipo': 'contexto',
                        'tags': ['organizacao', 'categorias', agent_id]
                    })

            elif agent_id == 'secretaria':
                meetings = memory.get('management_history', {}).get('meetings_processed', 0)
                if meetings > 5:
                    shared_info.append({
                        'titulo': 'Padrões de Reuniões Identificados',
                        'conteudo': f'Total de reuniões processadas: {meetings}\n\n'
                                  f'Experiência acumulada em gestão de reuniões.',
                        'tipo': 'contexto',
                        'tags': ['reunioes', 'gestao', agent_id]
                    })

            # Adicionar mais padrões específicos conforme necessário...

        except Exception as e:
            logger.error(f"Erro ao extrair informações compartilháveis do agente '{agent_id}': {e}")

        return shared_info


    def _filtrar_resultados_por_agente(self, results: List[Dict], agent_id: str) -> List[Dict]:
        """Filtra resultados da knowledge-base relevantes para o agente específico"""
        if not results:
            return []

        filtered = []
        for result in results:
            # Verificar relevância baseada em tags e tipo
            tags = result.get('tags', [])
            entry_type = result.get('type', '')
            source_agent = result.get('source_agent', '')

            # Critérios de relevância por agente
            is_relevant = False

            if agent_id == 'organizador':
                is_relevant = (
                    'organizacao' in tags or
                    'categoria' in tags or
                    entry_type in ['projeto', 'contexto']
                )

            elif agent_id == 'secretaria':
                is_relevant = (
                    'reuniao' in tags or
                    'gestao' in tags or
                    entry_type in ['projeto', 'pessoa']
                )

            elif agent_id == 'arquiteto':
                is_relevant = (
                    'tecnico' in tags or
                    'arquitetura' in tags or
                    entry_type in ['decisao', 'projeto']
                )

            elif agent_id == 'psicologo':
                is_relevant = (
                    'emocional' in tags or
                    'adhd' in tags or
                    'suporte' in tags or
                    entry_type == 'contexto'
                )

            elif agent_id == 'mentor':
                is_relevant = (
                    'carreira' in tags or
                    'desenvolvimento' in tags or
                    'mentor' in tags or
                    entry_type in ['projeto', 'pessoa']
                )

            # Sempre incluir aprendizados compartilhados
            if 'aprendizado-compartilhado' in tags:
                is_relevant = True

            if is_relevant:
                filtered.append(result)

        return filtered[:3]  # Limitar a 3 resultados mais relevantes


    def _extrair_aprendizados_compartilhaveis(self, memory: Dict, agent_id: str) -> List[Dict]:
        """Extrai aprendizados específicos que podem ser úteis para outros agentes"""
        learnings = []

        try:
            learned_patterns = memory.get('learned_patterns', {})

            # Padrões de referências que podem ajudar outros agentes
            if 'obsidian_references' in learned_patterns:
                refs = learned_patterns['obsidian_references']
                if len(refs) >= 3:  # Só compartilhar se tiver padrão significativo
                    learnings.append({
                        'titulo': f'Padrões de Referência do {agent_id.capitalize()}',
                        'conteudo': f'O agente {agent_id} identificou estas referências frequentes:\n\n' +
                                  '\n'.join([f'- [[{ref}]]' for ref in refs[-5:]]),
                        'tags': ['padroes-referencia', agent_id]
                    })

            # Aprendizados específicos por agente que podem ajudar outros
            if agent_id == 'psicologo':
                effective_interventions = learned_patterns.get('effective_interventions', [])
                if effective_interventions:
                    learnings.append({
                        'titulo': 'Estratégias Eficazes de Suporte TDAH',
                        'conteudo': f'Estratégias que funcionaram bem:\n\n' +
                                  '\n'.join([f'- {strategy}' for strategy in effective_interventions]),
                        'tags': ['adhd', 'estrategias', 'suporte']
                    })

        except Exception as e:
            logger.error(f"Erro ao extrair aprendizados compartilháveis do agente '{agent_id}': {e}")

        return learnings


    def _notificar_novo_aprendizado(self, target_agent: str, source_agent: str, count: int):
        """Notifica agente sobre novos aprendizados disponíveis"""
        try:
            memory = self.carregar_memoria_agente(target_agent)
            if memory:
                if 'cross_agent_notifications' not in memory:
                    memory['cross_agent_notifications'] = []

                notification = {
                    'timestamp': datetime.now(timezone.utc).isoformat(),
                    'source_agent': source_agent,
                    'learnings_count': count,
                    'status': 'unread'
                }

                memory['cross_agent_notifications'].append(notification)

                # Manter apenas últimas 10 notificações
                memory['cross_agent_notifications'] = memory['cross_agent_notifications'][-10:]

                self._salvar_memoria_agente(target_agent, memory)
                logger.debug(f"Notificação enviada para '{target_agent}' sobre aprendizados de '{source_agent}'")

        except Exception as e:
            logger.error(f"Erro ao notificar agente '{target_agent}': {e}")


def create_agent_memory_system(base_dir: Optional[str] = None) -> AgentMemorySystem:
    """
    Factory function para criar instância do AgentMemorySystem

    Args:
        base_dir: Diretório base do projeto

    Returns:
        Instância configurada do AgentMemorySystem
    """
    try:
        ams = AgentMemorySystem(base_dir)
        logger.info("AgentMemorySystem criado com sucesso")
        return ams
    except Exception as e:
        logger.error(f"Erro ao criar AgentMemorySystem: {e}")
        raise


# Exemplo de uso
if __name__ == "__main__":
    # Criar sistema de memória
    ams = create_agent_memory_system()

    # Teste básico de funcionalidade
    print("🧠 Agent Memory System - Teste Básico")
    print("=" * 50)

    # Testar carregamento de memória
    for agent in ams.agents:
        memoria = ams.carregar_memoria_agente(agent)
        if memoria:
            print(f"✅ {agent.capitalize()}: Memória carregada")
            print(f"   Última atualização: {memoria.get('last_updated', 'N/A')}")
            print(f"   Versão: {memoria.get('version', 'N/A')}")
        else:
            print(f"❌ {agent.capitalize()}: Falha ao carregar memória")
        print()

    # Teste de atualização de memória
    test_interaction = {
        'user_input': 'Preciso organizar meu projeto [[Assistente Pessoal IA]]',
        'agent_response': 'Vou ajudar você a organizar o projeto. Que tal começarmos pelas tarefas prioritárias?',
        'context': {'categories_identified': ['projeto', 'organização']},
        'success': True
    }

    print("Testando atualização de memória do Organizador...")
    if ams.atualizar_memoria_agente('organizador', test_interaction):
        print("✅ Memória do Organizador atualizada com sucesso")
    else:
        print("❌ Falha ao atualizar memória do Organizador")

    print()
    print("🎯 Agent Memory System inicializado e testado!")