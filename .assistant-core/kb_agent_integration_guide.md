# Guia de Integração - Knowledge Base Manager para Agentes

Sistema de APIs internas documentado para todos os 5 agentes especializados utilizarem o Knowledge Base Manager de forma padronizada e eficiente.

**Autor:** James (Dev Agent)
**Data:** 2025-09-25
**História:** 0.2 - Knowledge-Base Manager Core

---

## 📋 Interface Padronizada

### Importação e Inicialização

```python
from .assistant-core.knowledge_base_manager import KnowledgeBaseManager, create_knowledge_manager

# Criar instância (recomendado)
kb = create_knowledge_manager()

# Ou instanciar diretamente
kb = KnowledgeBaseManager("knowledge-base")
```

### Validação de Entrada por Agente

```python
# Validar se agente é suportado
SUPPORTED_AGENTS = ['organizador', 'secretaria', 'arquiteto', 'psicologo', 'mentor']

def validate_agent(agent_name: str) -> bool:
    return agent_name in SUPPORTED_AGENTS
```

---

## 🗂️ Métodos Específicos por Agente

### 1. Organizador Agent
**Responsabilidade:** Processamento de daily-dump e categorização automática

#### Uso Recomendado:
```python
# Salvar informação categorizada do daily-dump
resultado = kb.salvar_entrada(
    titulo="Processamento Daily Dump 2025-09-25",
    conteudo="Reunião com [[João Silva]] sobre performance do [[Projeto Alpha]]...",
    entry_type="contexto",  # ou auto-detectado
    source_agent="organizador",
    project="Projeto Alpha",
    related_people=["João Silva"],
    tags=["daily-dump", "processado"]
)

# Gerar referências automáticas
conteudo_processado = kb.gerar_referencias_obsidian(
    content="Conversa com Fabio H sobre API performance",
    auto_link=True
)
```

#### Métodos Principais:
- `salvar_entrada()` - Para salvar informações categorizadas
- `gerar_referencias_obsidian()` - Para criar [[links]] automaticamente

---

### 2. Secretaria Agent
**Responsabilidade:** Gestão executiva e status de projetos

#### Uso Recomendado:
```python
# Buscar status de projetos
projetos_recentes = kb.timeline_automatico(
    project="Sistema Beta",
    period_days=7
)

# Busca inteligente para relatórios
resultados = kb.busca_semantica(
    query="reunião cliente requirements",
    entry_type="contexto",
    limit=5
)

# Salvar registro de reunião
kb.salvar_entrada(
    titulo="Reunião Semanal - Equipe Alpha",
    conteudo="## Participantes\n[[Maria Santos]], [[João Silva]]...",
    entry_type="contexto",
    source_agent="secretaria",
    project="Projeto Alpha",
    related_people=["Maria Santos", "João Silva"]
)
```

#### Métodos Principais:
- `busca_semantica()` - Para relatórios e status
- `timeline_automatico()` - Para cronologia de projetos

---

### 3. Arquiteto Agent
**Responsabilidade:** Decisões técnicas e contexto arquitetural

#### Uso Recomendado:
```python
# Recuperar decisões técnicas anteriores
decisao_anterior = kb.recuperar_entrada(
    entry_type="decisao",
    filters={"tags": ["arquitetura", "api"]}
)

# Salvar nova decisão técnica
kb.salvar_entrada(
    titulo="Decisão: Implementação Cache Redis",
    conteudo="## Contexto\nProblemas de performance identificados...\n\n## Decisão\nImplementar [[Cache Redis]]...",
    entry_type="decisao",
    source_agent="arquiteto",
    project="Sistema Performance",
    tags=["arquitetura", "cache", "performance"]
)

# Manter consistência de links após refatoração
kb.manter_consistencia_links(
    old_reference="API V1",
    new_reference="API V2"
)
```

#### Métodos Principais:
- `recuperar_entrada()` - Para contexto de decisões anteriores
- `manter_consistencia_links()` - Para consistência após mudanças

---

### 4. Psicólogo Agent
**Responsabilidade:** Suporte emocional e padrões TDAH

#### Uso Recomendado:
```python
# Salvar análise de humor/energia
kb.salvar_entrada(
    titulo="Análise Humor - Semana 39",
    conteudo="## Padrões Observados\nEnergia baixa após reuniões longas...",
    entry_type="contexto",
    source_agent="psicologo",
    tags=["humor", "energia", "tdah", "autoregulacao"]
)

# Buscar padrões anteriores
padroes = kb.busca_semantica(
    query="energia procrastinacao",
    entry_type="contexto",
    limit=10
)

# Timeline de padrões emocionais
timeline_humor = kb.timeline_automatico(period_days=30)
```

#### Métodos Principais:
- `salvar_entrada()` com type="contexto" - Para padrões emocionais
- `busca_semantica()` - Para identificar padrões
- `timeline_automatico()` - Para análise temporal

---

### 5. Mentor Agent
**Responsabilidade:** Desenvolvimento profissional de longo prazo

#### Uso Recomendado:
```python
# Tracking de metas de carreira
kb.salvar_entrada(
    titulo="Meta Q4: Certificação Cloud Architect",
    conteudo="## Objetivo\nObter certificação AWS Solutions Architect...",
    entry_type="projeto",
    source_agent="mentor",
    tags=["carreira", "certificacao", "aws", "q4-2025"]
)

# Timeline de crescimento
crescimento = kb.timeline_automatico(period_days=90)

# Análise de oportunidades
oportunidades = kb.busca_semantica(
    query="aprendizado networking projetos",
    limit=15
)
```

#### Métodos Principais:
- `timeline_automatico()` - Para tracking de crescimento
- `busca_semantica()` - Para identificar oportunidades
- `salvar_entrada()` com type="projeto" - Para metas de longo prazo

---

## 🔧 Exemplos Práticos de Integração

### Exemplo 1: Organizador processando Daily Dump

```python
def processar_daily_dump(organizador_agent, raw_content: str):
    kb = create_knowledge_manager()

    # Gerar links automáticos
    processed_content = kb.gerar_referencias_obsidian(raw_content)

    # Salvar processamento
    resultado = kb.salvar_entrada(
        titulo=f"Daily Dump Processado - {datetime.now().strftime('%Y-%m-%d')}",
        conteudo=processed_content,
        source_agent="organizador",
        tags=["daily-dump", "processado"]
    )

    return resultado
```

### Exemplo 2: Secretaria gerando relatório de status

```python
def gerar_relatorio_projetos(secretaria_agent, project_name: str = None):
    kb = create_knowledge_manager()

    # Timeline de atividades
    timeline = kb.timeline_automatico(
        project=project_name,
        period_days=14
    )

    # Buscar reuniões recentes
    reunioes = kb.busca_semantica(
        query="reunião call discussão",
        entry_type="contexto"
    )

    return {
        'timeline': timeline,
        'reunioes_recentes': reunioes
    }
```

### Exemplo 3: Arquiteto consultando decisões anteriores

```python
def consultar_decisoes_arquiteturais(arquiteto_agent, topic: str):
    kb = create_knowledge_manager()

    # Buscar decisões relacionadas
    decisoes = kb.busca_semantica(
        query=topic,
        entry_type="decisao"
    )

    # Recuperar decisões específicas por tag
    decisoes_tech = kb.recuperar_entrada(
        entry_type="decisao",
        filters={"tags": ["arquitetura"]}
    )

    return decisoes
```

---

## ⚠️ Validação e Tratamento de Erros

### Sistema de Validação de Entrada

```python
def validate_agent_input(agent_name: str, entry_data: dict) -> bool:
    # Validar agente
    if agent_name not in SUPPORTED_AGENTS:
        raise ValueError(f"Agente não suportado: {agent_name}")

    # Validar campos obrigatórios
    required_fields = ['titulo', 'conteudo']
    for field in required_fields:
        if field not in entry_data or not entry_data[field]:
            raise ValueError(f"Campo obrigatório faltando: {field}")

    return True

# Exemplo de uso com tratamento de erro
def safe_save_entry(agent_name: str, **entry_data):
    try:
        validate_agent_input(agent_name, entry_data)
        kb = create_knowledge_manager()
        return kb.salvar_entrada(source_agent=agent_name, **entry_data)
    except Exception as e:
        logger.error(f"Erro ao salvar entrada para {agent_name}: {e}")
        return None
```

---

## 📊 Monitoramento e Logging

### Logs por Agente
O sistema automaticamente registra todas as operações por agente nos logs:

```
2025-09-25T10:30:00 - KnowledgeBaseManager - INFO - Entrada salva: reuniao-projeto-alpha.md (tipo: contexto) [organizador]
2025-09-25T10:32:15 - KnowledgeBaseManager - INFO - Busca semântica: 5 resultados para 'performance api' [secretaria]
2025-09-25T10:35:42 - KnowledgeBaseManager - INFO - Timeline gerado: 12 entradas nos últimos 7 dias [mentor]
```

### Métricas Recomendadas (futura implementação)
- Número de entradas por agente
- Tipos mais utilizados por agente
- Frequência de uso dos métodos
- Qualidade dos links [[]] gerados

---

## 🚀 Preparação para Cross-Agent Intelligence

O sistema já está preparado com hooks básicos para integração futura:

```python
# Hooks preparados (épicos futuros)
hooks_config = kb.prepare_cross_agent_hooks()

# Configuração salva em .assistant-core/cross_agent_hooks.json
# Interfaces preparadas:
# - compartilhar_insights
# - detectar_duplicacao
# - roteamento_inteligente
# - colaboracao_contextual
# - consolidar_informacoes
```

---

## ✅ Checklist de Integração para Desenvolvedores

### Para cada Agente:

- [ ] Importar KnowledgeBaseManager corretamente
- [ ] Usar `source_agent` adequado em todas as operações
- [ ] Implementar tratamento de erros
- [ ] Validar entradas antes de salvar
- [ ] Usar métodos apropriados conforme responsabilidade do agente
- [ ] Implementar logging adequado
- [ ] Testar integração básica

### Testes Recomendados:

- [ ] Teste de salvar/recuperar entrada
- [ ] Teste de geração de referências [[]]
- [ ] Teste de busca semântica
- [ ] Teste de timeline
- [ ] Teste de tratamento de erros
- [ ] Teste de validação de entrada

---

Este guia garante que todos os 5 agentes utilizem o Knowledge Base Manager de forma consistente e eficiente, seguindo as melhores práticas e padrões estabelecidos na arquitetura do sistema.