# Componentes

## Sistema de 5 Agentes Especializados

### Organizador Agent

**Responsabilidade:** Processamento inteligente do arquivo despejo e categorização automática na knowledge-base.

**Interfaces Principais:**
- `processar_despejo()` - Analisa daily-dump.txt via perguntas específicas
- `categorizar_automaticamente()` - Salva informações na knowledge-base com metadados
- `criar_referencias()` - Gera links [[]] automaticamente para pessoas/projetos
- `organizar_por_projeto()` - Agrupa informações por contexto de projeto
- `cross_reference_agentes()` - Colabora com outros agentes via knowledge-base

**Dependências:** Knowledge-base Manager, daily-dump.txt, Agent Memory System, Cross-Agent Intelligence

**Stack Tecnológico:** Claude Code + YAML configs + Markdown templates

### Secretaria Agent

**Responsabilidade:** Gestão executiva completa com processamento de reuniões e extração automática de todos.

**Interfaces Principais:**
- `agenda_do_dia()` - Dashboard executivo de compromissos
- `status_projetos()` - Visão consolidada de todos projetos ativos
- `registro_reuniao()` - Transcrição → resumo estruturado + todos automáticos
- `extrair_referencias_pessoas()` - Identifica [[pessoas]] em contextos
- `whats_next()` - Sugestões inteligentes baseadas em contexto
- `detectar_sobrecarga()` - Colabora com Psicólogo para identificar burnout

**Dependências:** Knowledge-base Manager, central-todos.md, diario/*.md, Agent Memory, Cross-Agent Intelligence

**Stack Tecnológico:** Claude Code + templates de reunião + processamento de texto

### Arquiteto Agent

**Responsabilidade:** Consultoria técnica especializada com memória contextual profunda e confronto construtivo sobre decisões arquiteturais.

**Interfaces Principais:**
- `analise_projeto()` - Review técnico de URLs/repositórios
- `discussao_tecnica()` - Consultoria sobre padrões e decisões
- `contexto_decisoes()` - Recuperação de rationale histórico via [[referências]]
- `confronto_tecnico()` - Questionamento construtivo baseado em histórico
- `conectar_decisoes()` - Liga decisões técnicas relacionadas via [[]]
- `colaborar_mentor()` - Alinha desenvolvimento técnico com objetivos de carreira

**Dependências:** Knowledge-base Manager, Agent Memory, Cross-Agent Intelligence, histórico técnico

**Stack Tecnológico:** Claude Code + templates técnicos + contexto arquitetural

### Psicólogo Agent

**Responsabilidade:** Suporte emocional especializado para TDAH com técnicas baseadas em evidências.

**Interfaces Principais:**
- `analise_humor_energia()` - Tracking via daily-dump e padrões
- `detectar_procrastinacao()` - Identificação de padrões problemáticos
- `sugerir_autorregulacao()` - Técnicas específicas para TDAH
- `colaborar_secretaria()` - Detecção conjunta de sobrecarga
- `suporte_confrontador()` - Confronto empático quando necessário

**Dependências:** Knowledge-base Manager, Agent Memory, Cross-Agent Intelligence, daily-dump.txt

**Stack Tecnológico:** Claude Code + YAML configs + padrões comportamentais

### Mentor Agent

**Responsabilidade:** Desenvolvimento profissional de longo prazo e orientação de carreira estratégica.

**Interfaces Principais:**
- `tracking_metas_carreira()` - Acompanhamento de objetivos de longo prazo
- `identificar_oportunidades()` - Aprendizado baseado em projetos atuais
- `analise_crescimento()` - Padrões via histórico da knowledge-base
- `networking_estrategico()` - Sugestões baseadas em contexto
- `preparacao_conversas()` - Negociações e decisões de carreira
- `alinhar_arquiteto()` - Desenvolvimento técnico + objetivos

**Dependências:** Knowledge-base Manager, Agent Memory, Cross-Agent Intelligence, histórico de carreira

**Stack Tecnológico:** Claude Code + templates de carreira + análise de padrões

## Componentes de Infraestrutura

### Knowledge-Base Manager

**Responsabilidade:** Sistema inteligente de gerenciamento da base compartilhada com referências [[]] e splitting automático.

**Interfaces Principais:**
- `salvar_entrada()` - Persiste nova informação com metadados automáticos
- `gerar_referencias_obsidian()` - Cria links [[]] para pessoas, projetos, conceitos
- `split_arquivo_grande()` - Divide arquivos >2000 linhas inteligentemente
- `manter_consistencia_links()` - Atualiza [[referências]] após mudanças
- `busca_semantica()` - Busca inteligente por contexto
- `timeline_automatico()` - Cronologia de eventos e decisões

**Dependências:** Sistema de arquivos, Git, Obsidian vault, Cross-Agent Intelligence

**Stack Tecnológico:** Claude Code + file system + YAML parsing + Obsidian integration

### Agent Memory System

**Responsabilidade:** Manutenção de memória contextual e personalidade consistente para todos os 5 agentes especializados.

**Interfaces Principais:**
- `carregar_memoria_agente()` - Recupera contexto e personalidade para qualquer dos 5 agentes
- `atualizar_interacao()` - Registra nova interação e aprendizados por agente
- `manter_personalidade()` - Garante consistência comportamental específica
- `identificar_padroes_referencias()` - Detecta padrões de uso de [[]]
- `reset_memoria_agente()` - Reset individual quando necessário
- `backup_memoria()` - Backup de contexto para recovery

**Dependências:** .assistant-core/memory/, histórico de interações, Knowledge-Base Manager

**Stack Tecnológico:** YAML configs + Claude Code + pattern recognition

### Cross-Agent Intelligence

**Responsabilidade:** Sistema de colaboração automática entre todos os 5 agentes para evitar duplicação.

**Interfaces Principais:**
- `compartilhar_insights()` - Troca automática de informações relevantes
- `detectar_duplicacao()` - Previne processamento redundante
- `roteamento_inteligente()` - Sugere agente mais apropriado
- `colaboracao_contextual()` - Facilita trabalho conjunto em tópicos
- `consolidar_informacoes()` - Merge de dados relacionados

**Dependências:** Todos os 5 agentes, Knowledge-Base Manager, Agent Memory System

**Stack Tecnológico:** Claude Code + YAML + sistema de messaging interno
