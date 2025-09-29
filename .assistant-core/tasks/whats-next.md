# Task: What's Next - Sugestões Inteligentes

## Objetivo
Analisar contexto atual do usuário (projetos, todos, agenda) e fornecer sugestões inteligentes priorizadas sobre próximas ações baseadas em urgência, impacto e energia disponível.

## Inputs
- `knowledge-base/projetos/projeto-*.md` - Status de todos os projetos
- `todos/central-todos.md` - Lista de todos pendentes
- `diario/` - Últimas entradas para contexto emocional/energia
- `.assistant-core/memory/secretaria-memory.yaml` - Padrões de produtividade aprendidos
- Hora atual e dia da semana (para contexto temporal)

## Processo de Execução

### 1. Análise de Contexto Atual

#### Estado dos Projetos
- Identificar projetos com deadlines próximos (< 3 dias)
- Encontrar projetos bloqueados aguardando ação do usuário
- Detectar projetos sem atividade recente que precisam de atenção
- Mapear dependências entre projetos

#### Carga de Trabalho
- Contar todos pendentes por categoria de urgência
- Avaliar distribuição de todos por projeto/pessoa
- Identificar sobrecarga (>10 todos pendentes ou >5 projetos ativos)

#### Contexto Temporal
- Considerar hora do dia para sugestões apropriadas:
  - Manhã: tarefas complexas, planejamento
  - Tarde: reuniões, comunicação
  - Final do dia: organização, preparação para amanhã
- Ajustar sugestões baseadas no dia da semana

### 2. Sistema de Priorização Matriz 2x2

#### Alta Urgência + Alto Impacto (Fazer Agora)
- Todos com deadline hoje/amanhã
- Projetos críticos bloqueados
- Emergências identificadas nos projetos

#### Baixa Urgência + Alto Impacto (Agendar)
- Projetos estratégicos importantes
- Planejamento de longo prazo
- Desenvolvimento de relacionamentos importantes

#### Alta Urgência + Baixo Impacto (Delegar/Simplificar)
- Todos administrativos urgentes
- Reuniões que podem ser emails
- Tarefas que podem ser automatizadas

#### Baixa Urgência + Baixo Impacto (Eliminar)
- Projetos sem valor claro
- Reuniões sem agenda clara
- Atividades procrastinatórias

### 3. Detecção de Padrões Comportamentais

#### Análise de Energia
- Correlacionar horário com tipo de tarefa mais eficiente
- Identificar padrões de procrastinação em projetos específicos
- Adaptar sugestões ao nível de energia detectado

#### Preferências Aprendidas
- Tipos de tarefa preferidos em diferentes horários
- Duração ideal de sessões de trabalho
- Intervalos necessários entre tarefas complexas

### 4. Geração de Sugestões Contextuais

**Formato de Saída:**
```
🎯 WHAT'S NEXT? - [Hora] | [Energia: Alta/Média/Baixa]
===============================================

🚨 FAZER AGORA (Urgente + Importante)
------------------------------------
• [Ação específica] - [Projeto] | Prazo: [quando] | ⏱️ [tempo estimado]
• [Ação específica] - [Projeto] | Prazo: [quando] | ⏱️ [tempo estimado]

📋 PRÓXIMAS 3 PRIORIDADES
--------------------------
1. [Ação] ([Projeto]) - [Rationale por que é importante agora]
2. [Ação] ([Projeto]) - [Rationale]
3. [Ação] ([Projeto]) - [Rationale]

⚡ GANHOS RÁPIDOS (< 15 min)
---------------------------
• [Ação simples que desbloquearia algo maior]
• [Comunicação pendente importante]

📅 PARA ESTA SEMANA
-------------------
• [Ação estratégica importante mas não urgente]
• [Planejamento ou preparação]

💡 SUGESTÕES PERSONALIZADAS
---------------------------
• Baseado nos seus padrões, [recomendação específica]
• Considerando sua energia [atual], sugiro [tipo de tarefa]
```

### 5. Detecção e Alertas Especiais

#### Alertas de Sobrecarga
- Se >10 todos pendentes: sugerir sessão de priorização
- Se >5 projetos ativos: recomendar arquivamento ou delegação
- Se padrão de procrastinação: sugerir quebra em tarefas menores

#### Oportunidades de Otimização
- Tarefas similares que podem ser agrupadas
- Reuniões que podem ser combinadas
- Processos que podem ser automatizados

#### Sugestões de Bem-estar
- Pausas necessárias baseadas na intensidade de trabalho
- Lembretes sobre deadlines para reduzir ansiedade
- Sugestões de delegação quando apropriado

## Output
- Lista priorizada de próximas ações
- Rationale claro para cada sugestão
- Estimativas de tempo para facilitar planejamento
- Alertas sobre possíveis problemas
- Atualização da memória com padrões observados

## Integração TDAH
- Máximo 5 sugestões simultâneas para evitar overwhelm
- Quebrar grandes tarefas em passos específicos de 15-30 min
- Incluir sempre estimativas de tempo realistas
- Destacar visualmente prioridades críticas
- Oferecer rationale claro para cada sugestão

## Personalização Contínua
- Aprender com feedback sobre sugestões aceitas/rejeitadas
- Adaptar horários ideais baseados em padrões observados
- Refinar algoritmo de priorização baseado em resultados
- Considerar contexto sazonal e ciclos pessoais