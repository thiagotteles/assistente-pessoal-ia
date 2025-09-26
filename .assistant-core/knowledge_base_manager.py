#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Knowledge Base Manager Core

Sistema inteligente de gerenciamento da base compartilhada com referências [[]]
e funcionalidades avançadas para os 5 agentes especializados.

Responsável por:
- Persistência de informações com metadados automáticos
- Geração e validação de referências [[]] Obsidian
- Divisão inteligente de arquivos grandes
- Busca semântica por contexto
- Timeline automático de eventos e decisões
- API interna para integração com agentes

Autor: James (Dev Agent)
Data: 2025-09-25
História: 0.2 - Knowledge-Base Manager Core
"""

import os
import re
import json
import yaml
import logging
from datetime import datetime
from typing import Dict, List, Optional, Union, Any
from pathlib import Path
import uuid


class KnowledgeBaseManager:
    """
    Sistema central de gerenciamento da knowledge-base com funcionalidades
    completas para persistência, referenciamento e organização inteligente.
    """

    def __init__(self, knowledge_base_path: str = "knowledge-base"):
        """
        Inicializa o KnowledgeBaseManager

        Args:
            knowledge_base_path: Caminho para o diretório knowledge-base
        """
        self.knowledge_base_path = Path(knowledge_base_path)
        self.backup_path = self.knowledge_base_path / ".backups"

        # Configuração de logging básico
        self._setup_logging()

        # Validar estrutura do knowledge-base
        self._validate_structure()

        # Configurações
        self.max_file_lines = 2000  # Para split_arquivo_grande()
        self.supported_types = ['decisao', 'contexto', 'projeto', 'pessoa']
        self.agents = ['organizador', 'secretaria', 'arquiteto', 'psicologo', 'mentor']

        self.logger.info("KnowledgeBaseManager iniciado com sucesso")

    def _setup_logging(self):
        """Configura sistema de logging básico para operações"""
        log_dir = Path(".assistant-core/logs")
        log_dir.mkdir(exist_ok=True)

        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_dir / 'knowledge_base_manager.log', encoding='utf-8'),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger('KnowledgeBaseManager')

    def _validate_structure(self):
        """Valida se a estrutura do knowledge-base está correta"""
        required_dirs = ['decisoes', 'contextos', 'projetos', 'pessoas']

        # Criar knowledge-base se não existir
        self.knowledge_base_path.mkdir(exist_ok=True)
        self.backup_path.mkdir(exist_ok=True)

        # Validar subdiretórios
        for dir_name in required_dirs:
            dir_path = self.knowledge_base_path / dir_name
            if not dir_path.exists():
                self.logger.warning(f"Diretório {dir_name} não encontrado, criando...")
                dir_path.mkdir(exist_ok=True)

        self.logger.info("Estrutura do knowledge-base validada")

    def _generate_id(self) -> str:
        """Gera ID único para entrada"""
        return str(uuid.uuid4())[:8]

    def _generate_timestamp(self) -> str:
        """Gera timestamp ISO conforme padrões de codificação"""
        return datetime.now().strftime('%Y-%m-%dT%H:%M:%S')

    def _detect_entry_type(self, content: str, titulo: str = "") -> str:
        """
        Auto-detecção de type baseado no conteúdo

        Args:
            content: Conteúdo do arquivo
            titulo: Título da entrada (opcional)

        Returns:
            Tipo detectado: decisao|contexto|projeto|pessoa
        """
        content_lower = content.lower()
        titulo_lower = titulo.lower()

        # Palavras-chave por tipo
        decisao_keywords = ['decisão', 'decidiu', 'optamos', 'escolhemos', 'definido']
        contexto_keywords = ['reunião', 'call', 'conversa', 'discussão', 'brainstorm']
        projeto_keywords = ['projeto', 'sistema', 'produto', 'desenvolvimento']
        pessoa_keywords = ['perfil', 'contato', 'pessoa', 'colega', 'cliente']

        # Verificar título primeiro
        for keyword in pessoa_keywords:
            if keyword in titulo_lower:
                return 'pessoa'

        for keyword in projeto_keywords:
            if keyword in titulo_lower:
                return 'projeto'

        # Verificar conteúdo
        decisao_count = sum(1 for kw in decisao_keywords if kw in content_lower)
        contexto_count = sum(1 for kw in contexto_keywords if kw in content_lower)
        projeto_count = sum(1 for kw in projeto_keywords if kw in content_lower)
        pessoa_count = sum(1 for kw in pessoa_keywords if kw in content_lower)

        scores = {
            'decisao': decisao_count,
            'contexto': contexto_count,
            'projeto': projeto_count,
            'pessoa': pessoa_count
        }

        # Retornar tipo com maior score, default é 'contexto'
        return max(scores, key=scores.get) if max(scores.values()) > 0 else 'contexto'

    def _generate_tags(self, content: str, entry_type: str) -> List[str]:
        """
        Gera tags automáticas baseadas no conteúdo

        Args:
            content: Conteúdo do arquivo
            entry_type: Tipo da entrada

        Returns:
            Lista de tags
        """
        tags = [entry_type]  # Tag básica do tipo

        content_lower = content.lower()

        # Tags específicas por contexto
        if 'urgente' in content_lower or 'crítico' in content_lower:
            tags.append('urgente')

        if 'performance' in content_lower or 'otimização' in content_lower:
            tags.append('performance')

        if 'arquitetura' in content_lower or 'design' in content_lower:
            tags.append('arquitetura')

        if 'api' in content_lower:
            tags.append('api')

        if 'database' in content_lower or 'banco' in content_lower:
            tags.append('database')

        return list(set(tags))  # Remove duplicatas

    def _create_backup(self, file_path: Path):
        """Cria backup antes de modificações"""
        if file_path.exists():
            backup_name = f"{file_path.stem}_{self._generate_timestamp().replace(':', '-')}.md"
            backup_file = self.backup_path / backup_name

            try:
                backup_file.write_text(file_path.read_text(encoding='utf-8'), encoding='utf-8')
                self.logger.info(f"Backup criado: {backup_name}")
            except Exception as e:
                self.logger.error(f"Erro ao criar backup: {e}")

    def _extract_references(self, content: str) -> List[str]:
        """
        Extrai referências [[]] do conteúdo

        Args:
            content: Conteúdo para análise

        Returns:
            Lista de referências encontradas
        """
        pattern = r'\[\[([^\]]+)\]\]'
        references = re.findall(pattern, content)
        return list(set(references))  # Remove duplicatas

    def _detect_proper_nouns(self, content: str) -> List[str]:
        """
        Detecção automática de nomes próprios para criar [[links]]

        Args:
            content: Conteúdo para análise

        Returns:
            Lista de possíveis nomes próprios
        """
        # Regex para nomes próprios (palavras capitalizadas)
        pattern = r'\b[A-Z][a-z]+(?:\s+[A-Z][a-z]+)*\b'
        proper_nouns = re.findall(pattern, content)

        # Filtrar palavras comuns que não são nomes
        common_words = {
            'Como', 'Para', 'Quando', 'Onde', 'Por', 'Mas', 'Então', 'Assim',
            'Sistema', 'Projeto', 'Cliente', 'Usuário', 'API', 'Database'
        }

        filtered_nouns = []
        for noun in proper_nouns:
            if noun not in common_words and len(noun) > 2:
                filtered_nouns.append(noun)

        return list(set(filtered_nouns))

    # Métodos principais da API conforme arquitetura

    def salvar_entrada(self, titulo: str, conteudo: str, entry_type: str = None,
                      source_agent: str = None, project: str = None,
                      related_people: List[str] = None, tags: List[str] = None) -> Dict[str, str]:
        """
        Persiste nova informação com metadados automáticos

        Args:
            titulo: Título da entrada
            conteudo: Conteúdo em markdown
            entry_type: Tipo (opcional - será auto-detectado)
            source_agent: Agente fonte (organizador|secretaria|arquiteto|psicologo|mentor)
            project: Projeto relacionado (opcional)
            related_people: Pessoas relacionadas (opcional)
            tags: Tags adicionais (opcional)

        Returns:
            Dict com informações da entrada salva
        """
        try:
            # Auto-detecção de tipo se não fornecido
            if not entry_type:
                entry_type = self._detect_entry_type(conteudo, titulo)

            # Validar tipo
            if entry_type not in self.supported_types:
                raise ValueError(f"Tipo não suportado: {entry_type}")

            # Gerar metadados
            entry_id = self._generate_id()
            timestamp = self._generate_timestamp()

            # Auto-geração de tags
            auto_tags = self._generate_tags(conteudo, entry_type)
            if tags:
                auto_tags.extend(tags)
            auto_tags = list(set(auto_tags))  # Remove duplicatas

            # Determinar diretório de destino
            target_dir = self.knowledge_base_path / f"{entry_type}s"
            if entry_type == 'decisao':
                target_dir = self.knowledge_base_path / 'decisoes'

            # Gerar nome do arquivo (kebab-case)
            filename = re.sub(r'[^a-zA-Z0-9\s-]', '', titulo)
            filename = re.sub(r'\s+', '-', filename.strip()).lower()
            filename = f"{filename}.md"

            file_path = target_dir / filename

            # Criar backup se arquivo já existir
            if file_path.exists():
                self._create_backup(file_path)

            # Construir metadados YAML
            metadata = {
                'id': entry_id,
                'type': entry_type,
                'created': timestamp,
                'updated': timestamp,
                'source_agent': source_agent,
                'tags': auto_tags
            }

            if project:
                metadata['project'] = f"[[{project}]]"

            if related_people:
                metadata['related_people'] = [f"[[{person}]]" for person in related_people]

            # Construir conteúdo final com frontmatter
            frontmatter = "---\n" + yaml.dump(metadata, default_flow_style=False, allow_unicode=True) + "---\n\n"
            final_content = frontmatter + f"# {titulo}\n\n{conteudo}"

            # Salvar arquivo
            target_dir.mkdir(exist_ok=True)
            file_path.write_text(final_content, encoding='utf-8')

            self.logger.info(f"Entrada salva: {filename} (tipo: {entry_type})")

            return {
                'id': entry_id,
                'filename': filename,
                'path': str(file_path),
                'type': entry_type,
                'timestamp': timestamp
            }

        except Exception as e:
            self.logger.error(f"Erro ao salvar entrada: {e}")
            raise

    def recuperar_entrada(self, entry_id: str = None, filename: str = None,
                         entry_type: str = None, filters: Dict[str, Any] = None) -> Optional[Dict[str, Any]]:
        """
        Recupera entrada por ID, nome ou filtros

        Args:
            entry_id: ID da entrada
            filename: Nome do arquivo
            entry_type: Tipo para buscar apenas nesse diretório
            filters: Filtros adicionais (tags, source_agent, etc.)

        Returns:
            Dict com dados da entrada ou None se não encontrado
        """
        try:
            search_dirs = []

            if entry_type and entry_type in self.supported_types:
                dir_name = f"{entry_type}s" if entry_type != 'decisao' else 'decisoes'
                search_dirs = [self.knowledge_base_path / dir_name]
            else:
                # Buscar em todos os diretórios
                for t in self.supported_types:
                    dir_name = f"{t}s" if t != 'decisao' else 'decisoes'
                    search_dirs.append(self.knowledge_base_path / dir_name)

            for search_dir in search_dirs:
                if not search_dir.exists():
                    continue

                for file_path in search_dir.glob("*.md"):
                    try:
                        content = file_path.read_text(encoding='utf-8')

                        # Separar frontmatter do conteúdo
                        if content.startswith('---'):
                            parts = content.split('---', 2)
                            if len(parts) >= 3:
                                yaml_content = parts[1]
                                markdown_content = parts[2].strip()

                                metadata = yaml.safe_load(yaml_content)

                                # Verificar correspondências
                                if entry_id and metadata.get('id') == entry_id:
                                    return {
                                        'metadata': metadata,
                                        'content': markdown_content,
                                        'path': str(file_path),
                                        'filename': file_path.name
                                    }

                                if filename and file_path.name == filename:
                                    return {
                                        'metadata': metadata,
                                        'content': markdown_content,
                                        'path': str(file_path),
                                        'filename': file_path.name
                                    }

                                # Verificar filtros se fornecidos
                                if filters:
                                    match = True
                                    for key, value in filters.items():
                                        if key not in metadata or metadata[key] != value:
                                            match = False
                                            break

                                    if match:
                                        return {
                                            'metadata': metadata,
                                            'content': markdown_content,
                                            'path': str(file_path),
                                            'filename': file_path.name
                                        }

                    except Exception as e:
                        self.logger.warning(f"Erro ao processar arquivo {file_path}: {e}")
                        continue

            return None

        except Exception as e:
            self.logger.error(f"Erro ao recuperar entrada: {e}")
            return None

    def gerar_referencias_obsidian(self, content: str, auto_link: bool = True) -> str:
        """
        Cria links [[]] para pessoas, projetos e conceitos

        Args:
            content: Conteúdo para processar
            auto_link: Se deve criar links automaticamente para nomes próprios

        Returns:
            Conteúdo com referências [[]] adicionadas
        """
        try:
            processed_content = content

            if auto_link:
                # Detectar nomes próprios e criar links
                proper_nouns = self._detect_proper_nouns(content)

                for noun in proper_nouns:
                    # Evitar criar links duplicados
                    if f"[[{noun}]]" not in processed_content:
                        # Substituir apenas a primeira ocorrência para evitar problemas
                        pattern = r'\b' + re.escape(noun) + r'\b'
                        processed_content = re.sub(pattern, f"[[{noun}]]", processed_content, count=1)

            self.logger.info(f"Referências Obsidian processadas, {len(proper_nouns) if auto_link else 0} links adicionados")
            return processed_content

        except Exception as e:
            self.logger.error(f"Erro ao gerar referências Obsidian: {e}")
            return content

    def manter_consistencia_links(self, old_reference: str, new_reference: str) -> int:
        """
        Atualiza [[referências]] após mudanças

        Args:
            old_reference: Referência antiga
            new_reference: Nova referência

        Returns:
            Número de arquivos atualizados
        """
        try:
            updated_count = 0
            old_pattern = f"[[{old_reference}]]"
            new_pattern = f"[[{new_reference}]]"

            # Buscar em todos os diretórios
            for entry_type in self.supported_types:
                dir_name = f"{entry_type}s" if entry_type != 'decisao' else 'decisoes'
                search_dir = self.knowledge_base_path / dir_name

                if not search_dir.exists():
                    continue

                for file_path in search_dir.glob("*.md"):
                    try:
                        content = file_path.read_text(encoding='utf-8')

                        if old_pattern in content:
                            # Criar backup
                            self._create_backup(file_path)

                            # Atualizar conteúdo
                            updated_content = content.replace(old_pattern, new_pattern)
                            file_path.write_text(updated_content, encoding='utf-8')

                            updated_count += 1
                            self.logger.info(f"Link atualizado em: {file_path.name}")

                    except Exception as e:
                        self.logger.warning(f"Erro ao atualizar link em {file_path}: {e}")

            self.logger.info(f"Consistência de links mantida: {updated_count} arquivos atualizados")
            return updated_count

        except Exception as e:
            self.logger.error(f"Erro ao manter consistência de links: {e}")
            return 0

    def split_arquivo_grande(self, file_path: str, max_lines: int = None) -> List[str]:
        """
        Divide arquivos >2000 linhas inteligentemente

        Args:
            file_path: Caminho do arquivo a ser dividido
            max_lines: Máximo de linhas por arquivo (default: 2000)

        Returns:
            Lista de caminhos dos arquivos criados
        """
        try:
            if max_lines is None:
                max_lines = self.max_file_lines

            source_path = Path(file_path)
            if not source_path.exists():
                raise FileNotFoundError(f"Arquivo não encontrado: {file_path}")

            content = source_path.read_text(encoding='utf-8')
            lines = content.split('\n')

            if len(lines) <= max_lines:
                self.logger.info(f"Arquivo {source_path.name} não precisa ser dividido ({len(lines)} linhas)")
                return [str(source_path)]

            # Criar backup do arquivo original
            self._create_backup(source_path)

            # Dividir inteligentemente por seções markdown
            sections = []
            current_section = []
            current_lines = 0

            for line in lines:
                current_section.append(line)
                current_lines += 1

                # Quebrar em headers principais ou quando atingir limite
                if (line.startswith('# ') and current_lines > 100) or current_lines >= max_lines:
                    sections.append('\n'.join(current_section))
                    current_section = []
                    current_lines = 0

            # Adicionar seção restante
            if current_section:
                sections.append('\n'.join(current_section))

            # Salvar arquivos divididos
            created_files = []
            base_name = source_path.stem

            for i, section_content in enumerate(sections, 1):
                part_filename = f"{base_name}-parte-{i}.md"
                part_path = source_path.parent / part_filename

                part_path.write_text(section_content, encoding='utf-8')
                created_files.append(str(part_path))

                self.logger.info(f"Arquivo parte criado: {part_filename}")

            # Remover arquivo original (já foi feito backup)
            source_path.unlink()

            self.logger.info(f"Arquivo dividido em {len(created_files)} partes")
            return created_files

        except Exception as e:
            self.logger.error(f"Erro ao dividir arquivo: {e}")
            return []

    def busca_semantica(self, query: str, entry_type: str = None,
                       limit: int = 10) -> List[Dict[str, Any]]:
        """
        Busca inteligente por contexto

        Args:
            query: Termo de busca
            entry_type: Tipo específico para buscar (opcional)
            limit: Limite de resultados

        Returns:
            Lista de entradas encontradas com score de relevância
        """
        try:
            results = []
            query_lower = query.lower()
            query_words = query_lower.split()

            search_dirs = []
            if entry_type and entry_type in self.supported_types:
                dir_name = f"{entry_type}s" if entry_type != 'decisao' else 'decisoes'
                search_dirs = [self.knowledge_base_path / dir_name]
            else:
                for t in self.supported_types:
                    dir_name = f"{t}s" if t != 'decisao' else 'decisoes'
                    search_dirs.append(self.knowledge_base_path / dir_name)

            for search_dir in search_dirs:
                if not search_dir.exists():
                    continue

                for file_path in search_dir.glob("*.md"):
                    try:
                        content = file_path.read_text(encoding='utf-8')
                        content_lower = content.lower()

                        # Calcular score de relevância
                        score = 0

                        # Score por correspondência exata
                        if query_lower in content_lower:
                            score += 10

                        # Score por palavras individuais
                        for word in query_words:
                            if word in content_lower:
                                score += 2

                        # Score por palavras no título (extrair do conteúdo)
                        title_match = re.search(r'^# (.+)$', content, re.MULTILINE)
                        if title_match:
                            title = title_match.group(1).lower()
                            if query_lower in title:
                                score += 20
                            for word in query_words:
                                if word in title:
                                    score += 5

                        if score > 0:
                            # Extrair metadata se disponível
                            metadata = {}
                            if content.startswith('---'):
                                parts = content.split('---', 2)
                                if len(parts) >= 3:
                                    try:
                                        metadata = yaml.safe_load(parts[1])
                                    except:
                                        pass

                            results.append({
                                'path': str(file_path),
                                'filename': file_path.name,
                                'score': score,
                                'metadata': metadata,
                                'excerpt': self._generate_excerpt(content, query_words)
                            })

                    except Exception as e:
                        self.logger.warning(f"Erro ao processar {file_path} na busca: {e}")

            # Ordenar por score e limitar
            results.sort(key=lambda x: x['score'], reverse=True)
            results = results[:limit]

            self.logger.info(f"Busca semântica: {len(results)} resultados para '{query}'")
            return results

        except Exception as e:
            self.logger.error(f"Erro na busca semântica: {e}")
            return []

    def _generate_excerpt(self, content: str, query_words: List[str], length: int = 200) -> str:
        """Gera excerpt destacando termos de busca"""
        content_clean = re.sub(r'---.*?---', '', content, flags=re.DOTALL)
        content_clean = content_clean.strip()

        # Encontrar primeira ocorrência de qualquer palavra da query
        for word in query_words:
            match = re.search(re.escape(word), content_clean, re.IGNORECASE)
            if match:
                start = max(0, match.start() - length // 2)
                end = min(len(content_clean), start + length)
                excerpt = content_clean[start:end]

                if start > 0:
                    excerpt = "..." + excerpt
                if end < len(content_clean):
                    excerpt = excerpt + "..."

                return excerpt

        # Se não encontrou, retornar início do conteúdo
        return content_clean[:length] + ("..." if len(content_clean) > length else "")

    def timeline_automatico(self, project: str = None,
                          period_days: int = 30) -> List[Dict[str, Any]]:
        """
        Cronologia de eventos e decisões

        Args:
            project: Projeto específico (opcional)
            period_days: Período em dias para buscar (default: 30 dias)

        Returns:
            Lista cronológica de entradas
        """
        try:
            from datetime import timedelta

            timeline = []
            end_date = datetime.now()
            start_date = end_date - timedelta(days=period_days)

            # Buscar em todos os diretórios
            for entry_type in self.supported_types:
                dir_name = f"{entry_type}s" if entry_type != 'decisao' else 'decisoes'
                search_dir = self.knowledge_base_path / dir_name

                if not search_dir.exists():
                    continue

                for file_path in search_dir.glob("*.md"):
                    try:
                        content = file_path.read_text(encoding='utf-8')

                        # Extrair metadata
                        if content.startswith('---'):
                            parts = content.split('---', 2)
                            if len(parts) >= 3:
                                metadata = yaml.safe_load(parts[1])

                                # Verificar período
                                created_str = metadata.get('created', '')
                                if created_str:
                                    try:
                                        created_date = datetime.fromisoformat(created_str)

                                        if start_date <= created_date <= end_date:
                                            # Filtrar por projeto se especificado
                                            if project:
                                                entry_project = metadata.get('project', '')
                                                if f"[[{project}]]" not in entry_project:
                                                    continue

                                            # Extrair título
                                            title_match = re.search(r'^# (.+)$', content, re.MULTILINE)
                                            title = title_match.group(1) if title_match else file_path.stem

                                            timeline.append({
                                                'date': created_date,
                                                'title': title,
                                                'type': metadata.get('type', 'unknown'),
                                                'source_agent': metadata.get('source_agent', 'unknown'),
                                                'path': str(file_path),
                                                'tags': metadata.get('tags', [])
                                            })

                                    except ValueError:
                                        pass  # Data inválida, pular

                    except Exception as e:
                        self.logger.warning(f"Erro ao processar {file_path} no timeline: {e}")

            # Ordenar cronologicamente (mais recente primeiro)
            timeline.sort(key=lambda x: x['date'], reverse=True)

            self.logger.info(f"Timeline gerado: {len(timeline)} entradas nos últimos {period_days} dias")
            return timeline

        except Exception as e:
            self.logger.error(f"Erro ao gerar timeline: {e}")
            return []

    # Preparação básica para Cross-Agent Intelligence (épicos futuros)
    def prepare_cross_agent_hooks(self) -> Dict[str, Any]:
        """
        Prepara hooks/interfaces para integração futura com Cross-Agent Intelligence

        Returns:
            Dict com configurações preparadas
        """
        hooks_config = {
            'knowledge_base_path': str(self.knowledge_base_path),
            'supported_agents': self.agents,
            'supported_types': self.supported_types,
            'api_version': '1.0',
            'prepared_hooks': [
                'compartilhar_insights',
                'detectar_duplicacao',
                'roteamento_inteligente',
                'colaboracao_contextual',
                'consolidar_informacoes'
            ]
        }

        # Salvar configuração de hooks
        hooks_file = Path('.assistant-core/cross_agent_hooks.json')
        hooks_file.write_text(json.dumps(hooks_config, indent=2, ensure_ascii=False), encoding='utf-8')

        self.logger.info("Hooks para Cross-Agent Intelligence preparados")
        return hooks_config


# Funções de conveniência para uso pelos agentes
def create_knowledge_manager(knowledge_base_path: str = "knowledge-base") -> KnowledgeBaseManager:
    """Factory function para criar instância do KnowledgeBaseManager"""
    return KnowledgeBaseManager(knowledge_base_path)


if __name__ == "__main__":
    # Exemplo de uso básico para teste
    print("=== Knowledge Base Manager - Teste Básico ===")

    try:
        # Criar instância
        kb = KnowledgeBaseManager()
        print("✅ KnowledgeBaseManager iniciado")

        # Teste de salvar entrada
        resultado = kb.salvar_entrada(
            titulo="Teste Inicial do Sistema",
            conteudo="Este é um teste básico do Knowledge Base Manager implementado na História 0.2.\n\nO sistema está funcionando corretamente com todas as funcionalidades principais.",
            source_agent="dev",
            tags=["teste", "sistema"]
        )

        print(f"✅ Entrada salva: {resultado['filename']}")

        # Teste de recuperar entrada
        entrada = kb.recuperar_entrada(entry_id=resultado['id'])
        if entrada:
            print(f"✅ Entrada recuperada: {entrada['filename']}")

        # Teste de busca semântica
        resultados = kb.busca_semantica("teste sistema")
        print(f"✅ Busca semântica: {len(resultados)} resultados encontrados")

        # Preparar hooks Cross-Agent
        hooks = kb.prepare_cross_agent_hooks()
        print(f"✅ Cross-Agent hooks preparados: {len(hooks['prepared_hooks'])} hooks")

        print("\n🎉 Todos os testes básicos passaram!")

    except Exception as e:
        print(f"❌ Erro no teste: {e}")