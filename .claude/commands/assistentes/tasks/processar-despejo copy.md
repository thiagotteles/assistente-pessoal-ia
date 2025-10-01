# Task: Processar Despejo

## Objetivo
Processar inteligentemente o daily-dump.md através de perguntas específicas, categorizando automaticamente as informações e extraindo todos sem sobrecarga mental para usuários com TDAH.

## Configuração
```yaml
elicit: true
max_questions_per_entry: 3
tdah_sensitivity: high
language: portuguese
interaction_style: empathetic
```

## Workflow

### Etapa 1: Verificação Inicial
1. **Verificar se daily-dump.md existe** em `despejo/daily-dump.md`
   - Se não existe: "Ainda não há nenhum despejo para processar. Quer que eu te ajude a criar o primeiro?"
   - Se vazio: "O arquivo está vazio. Tudo certo, às vezes a mente já está organizada! 😊"

2. **Carregar memória pessoal** do organizador
   - Ler `.assistant-core/memory/organizador-memory.yaml`
   - Aplicar padrões pessoais aprendidos
   - Ajustar sensibilidade baseada no histórico

### Etapa 2: Análise de Entradas
Para cada entrada não processada no daily-dump.md:

1. **Detectar padrões automaticamente**:
   - Pessoas mencionadas
   - Projetos/contextos de trabalho
   - Indicadores emocionais (stress, overwhelm, procrastinação)
   - Urgência aparente vs real
   - Ações implícitas

2. **Priorizar tipos de pergunta** (máximo 3):
   - **Prioridade 1**: Bem-estar emocional (se detectado)
   - **Prioridade 2**: Calibração de urgência
   - **Prioridade 3**: Contextualização (pessoas/projetos)

### Etapa 3: Elicitação Conversacional

**REGRA DE OURO**: Nunca mais de 3 perguntas por entrada!

Para cada entrada, perguntar em ordem de prioridade:

1. **Se detectar indicadores emocionais**:
   ```
   "Percebo que você menciona [indicador emocional].
   Está precisando de uma pausa ou quer que eu organize isso de um jeito que não sobrecarregue?"

   Opções:
   1. Sim, preciso de estratégias específicas
   2. Não, só quero organizar mesmo
   3. Talvez, vamos monitorar
   ```

2. **Se detectar urgência**:
   ```
   "Você indica que isso é [urgente/importante].
   Qual a prioridade real desta situação?"

   Opções:
   1. Realmente urgente - precisa de ação hoje
   2. Importante - esta semana
   3. Pode esperar - quando der
   ```

3. **Se detectar pessoas/projetos**:
   ```
   "Sobre [pessoa/projeto] que você mencionou:
   Isso é uma informação nova ou atualização de algo que já estamos acompanhando?"

   Opções:
   1. Informação nova
   2. Atualização
   3. Só um comentário
   ```

### Etapa 4: Categorização Automática

Baseado nas respostas e padrões detectados, categorizar automaticamente:

- **Estados emocionais** → `knowledge-base/contextos/bem-estar/`
- **Decisões técnicas** → `knowledge-base/decisoes/`
- **Contextos de projeto** → `knowledge-base/projetos/{projeto}/`
- **Informações de pessoas** → `knowledge-base/pessoas/`
- **Contextos gerais** → `knowledge-base/contextos/`

**Formato da entrada categorizada**:
```yaml
---
id: auto-generated
type: [contexto|decisao|projeto|pessoa]
created: ISO-8601
source_agent: organizador
priority: [alta|media|baixa]
emotional_indicators: [stress|overwhelm|normal]
related_people: ["[[pessoa]]"]
related_projects: ["[[projeto]]"]
tags: [bem-estar, tdah, urgent, etc]
---

# Título Gerado Automaticamente

Conteúdo original processado com [[links]] automáticos.

## Contexto Adicional
- Prioridade: [baseada nas respostas]
- Próximas ações: [se detectadas]
- Observações: [insights do agente]
```

### Etapa 5: Extração de Todos

Para cada entrada processada, detectar automaticamente:

1. **Ações explícitas**: "preciso fazer", "tenho que", "devo"
2. **Ações implícitas**: "conversar com X", "resolver Y"
3. **Follow-ups**: compromissos mencionados

**Atualizar central-todos.md automaticamente**:
```markdown
### Alta Prioridade
- [ ] [ação] (prazo: [se detectado]) [[projeto]] @[pessoa]

### Média Prioridade
- [ ] [ação] [[projeto]]

### Baixa Prioridade
- [ ] [ação]
```

### Etapa 6: Aprendizado Contínuo

1. **Atualizar memória pessoal**:
   - Padrões de categorização preferidos
   - Pessoas e projetos frequentes
   - Indicadores TDAH específicos do usuário
   - Efetividade das perguntas

2. **Adaptar comportamento futuro**:
   - Reduzir perguntas sobre padrões estabelecidos
   - Personalizar detecção de urgência
   - Ajustar sensibilidade emocional

### Etapa 7: Finalização Empática

```
"Pronto! Processei [X] entradas e organizei tudo automaticamente.

📊 Resumo desta sessão:
- [X] informações categorizadas
- [Y] todos extraídos
- [Z] padrões aprendidos

Está tudo na knowledge-base e na central de todos.
Quer que eu mostre um resumo ou tem mais alguma coisa que posso ajudar? 😊"
```

## Tratamento de Casos Especiais

### Se usuário estiver overwhelmed
- Processar apenas 1 entrada por vez
- Fazer perguntas extra sobre bem-estar
- Sugerir pausas
- Focar em redução de ansiedade

### Se detectar procrastinação
- Questionar se a tarefa é realmente necessária
- Quebrar ações grandes em pequenas
- Sugerir estratégias específicas TDAH

### Se não conseguir categorizar
- Sempre usar categoria "contextos/geral"
- Não forçar pergunta adicional
- Marcar para revisão manual futura

## Output Files
- Entries categorizadas: `knowledge-base/{categoria}/{arquivo}.md`
- Todos extraídos: atualizações em `todos/central-todos.md`
- Session log: `.assistant-core/logs/organizador-{date}.md`
- Memory updates: `.assistant-core/memory/organizador-memory.yaml`