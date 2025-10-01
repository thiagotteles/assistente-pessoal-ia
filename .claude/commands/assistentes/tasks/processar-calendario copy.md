# Task: Processar Calendário - Parser Inteligente em Português

## Objetivo
Processar informações de calendário e agendamento via texto natural em português, detectando datas, horários, participantes e conflitos automaticamente sem necessidade de APIs externas.

## Inputs
- Texto livre contendo informações de agenda/calendário
- Contexto opcional (tipo de evento, prioridade)
- Knowledge-base atual para verificar conflitos

## Processo de Execução

### 1. Parsing de Datas e Horários

#### Formatos de Data Suportados
- **Absolutos**: "15/03/2025", "15 de março", "março 15"
- **Relativos**: "amanhã", "próxima segunda", "daqui a 3 dias"
- **Contextuais**: "segunda que vem", "final de semana", "mês que vem"
- **Informais**: "depois do almoço", "início da manhã", "fim da tarde"

#### Formatos de Horário Suportados
- **Precisos**: "14:30", "2:30 PM", "14h30", "duas e meia"
- **Aproximados**: "manhã", "tarde", "início da manhã", "final da tarde"
- **Intervalos**: "das 9h às 11h", "entre 14:00 e 16:00"
- **Duração**: "reunião de 1 hora", "30 minutos", "sessão rápida"

### 2. Identificação de Componentes

#### Participantes
Detectar padrões:
- "reunião com João e Maria"
- "call com a equipe"
- "1:1 com o cliente"
- "apresentação para [pessoa/grupo]"

#### Tipo de Evento
Inferir automaticamente:
- **1:1**: "conversa com", "1:1 com", "bate-papo"
- **Reunião de Equipe**: "daily", "planning", "retro", "equipe"
- **Cliente**: "cliente", "apresentação", "proposta", "demo"
- **Interna**: "alinhamento", "sync", "status update"

#### Local/Formato
- **Presencial**: "no escritório", "sala de reunião", "presencial"
- **Virtual**: "zoom", "meet", "teams", "chamada", "online"
- **Híbrido**: "presencial + online", "alguns remotos"

### 3. Detecção de Conflitos

#### Verificação de Agenda
- Comparar com eventos já agendados na knowledge-base
- Identificar sobreposições de horário
- Detectar sobrecarga (>4 reuniões em um dia)

#### Análise de Disponibilidade
- Verificar padrões de preferência (manhã vs tarde)
- Considerar tempo de deslocamento entre eventos
- Respeitar bloqueios de tempo para trabalho focado

#### Alertas de Otimização
- Reuniões consecutivas muito longas
- Falta de intervalos entre compromissos
- Concentração excessiva de reuniões em um período

### 4. Processamento de Casos Especiais

#### Eventos Recorrentes
- "toda segunda às 10h"
- "quinzenalmente"
- "primeiro dia útil do mês"
- "final de cada sprint"

#### Eventos Condicionais
- "se o João estiver disponível"
- "dependendo do resultado da reunião anterior"
- "confirmar na véspera"

#### Preparação Necessária
- Detectar necessidade de preparação: "apresentação", "demo", "review"
- Sugerir tempo de preparo automaticamente
- Identificar materiais/documentos necessários

### 5. Geração de Output Estruturado

**Formato de Saída:**
```
📅 EVENTO PROCESSADO
===================

📋 DETALHES DO EVENTO
--------------------
• Título: [Título inferido ou extraído]
• Data: [Data processada e normalizada]
• Horário: [Horário início - fim]
• Duração: [X minutos/horas]
• Tipo: [1:1, reunião equipe, cliente, etc.]

👥 PARTICIPANTES
---------------
• [[pessoa-joao]] (organização)
• [[pessoa-maria]] (participante)
• Equipe de desenvolvimento (grupo)

🎯 CONTEXTO E OBJETIVOS
-----------------------
[Objetivo inferido ou extraído do texto]

⚠️ ALERTAS E CONFLITOS
---------------------
• ✅ Sem conflitos detectados
• ⚠️ Conflito com [evento] às [horário]
• 💡 Sugestão: considerar horário alternativo

📝 PREPARAÇÃO NECESSÁRIA
-----------------------
• Tempo sugerido: [X minutos antes]
• Materiais: [se identificados]
• Agenda: [se mencionada]

📍 LOCALIZAÇÃO/FORMATO
---------------------
• Formato: [Presencial/Virtual/Híbrido]
• Local: [se especificado]
• Link: [se fornecido]
```

### 6. Integração Automática

#### Knowledge-base
- Atualizar arquivos pessoa-*.md com o evento
- Adicionar ao projeto-*.md se relacionado a projeto específico
- Criar entrada em contexto-reunioes.md

#### Central de Todos
- Se evento requer preparação, criar todo automático
- Adicionar lembretes pré-evento se necessário
- Criar follow-ups pós-evento se apropriado

#### Memória da Secretária
- Aprender padrões de agendamento do usuário
- Registrar preferências de horário e formato
- Melhorar detecção de conflitos baseada no histórico

## Output
- Evento estruturado e validado
- Alertas sobre conflitos ou problemas
- Sugestões de otimização da agenda
- Integração automática com knowledge-base
- Todos de preparação criados automaticamente

## Tratamento de Ambiguidades
- Se data/horário ambíguo, apresentar opções para escolha
- Se participante não identificado claramente, pedir clarificação
- Se conflito detectado, sugerir alternativas automaticamente

## Configurações TDAH
- Sempre incluir estimativas de duração realistas
- Sugerir intervalos entre eventos consecutivos
- Alertar sobre sobrecarga de agenda (>6 compromissos/dia)
- Incluir lembretes de preparação automáticos
- Visual feedback claro sobre status do processamento