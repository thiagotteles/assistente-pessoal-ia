# Task: Detectar Procrastinação e Overwhelm

## Configuração
```yaml
elicit: false
proactive: true
language: portuguese
```

## Propósito
Identificar proativamente padrões de procrastinação e sinais de overwhelm antes de crises.

## Workflow

### Etapa 1: Análise de Linguagem no Daily-Dump

**Frases indicativas de procrastinação:**
- "deveria fazer mas...", "preciso fazer mas não consigo"
- "amanhã eu faço", "depois eu vejo"
- "está há dias/semanas parado"
- "não sei por onde começar"
- "é muito grande/complexo/difícil"

**Frases indicativas de overwhelm:**
- "não dou conta", "é demais", "não aguento mais"
- "mil coisas ao mesmo tempo", "tudo urgente"
- "sem tempo para nada", "afogado em tarefas"

### Etapa 2: Análise de central-todos.md

**Sinais de sobrecarga:**
- > 20 todos ativos
- Múltiplos todos sem data de conclusão
- Todos com idade > 2 semanas
- Múltiplos projetos em paralelo (> 5)

### Etapa 3: Cross-Check com Secretária

Se disponível, verificar:
- Densidade de agenda (reuniões excessivas)
- Deadlines conflitantes
- Sobrecarga de comprometimentos

### Etapa 4: Classificação de Risco

**Nível 1 - Leve:** Procrastinação pontual, poucos sinais
→ Oferecer técnica micro-passo gentilmente

**Nível 2 - Moderado:** Múltiplos sinais, padrão de dias
→ Sugerir análise de humor + técnicas específicas

**Nível 3 - Severo:** Overwhelm intenso, paralisia, múltiplos sinais
→ Intervenção proativa empática + colaboração cross-agent

### Etapa 5: Intervenção Baseada em Risco

**Nível 1:**
"Percebo que [tarefa X] está te travando um pouco. Quer que eu te ajude a encontrar o menor próximo passo?"

**Nível 2:**
"Notei alguns sinais de procrastinação nos últimos dias. Como está sua energia? Talvez possamos olhar juntos o que está pesando."

**Nível 3:**
"Estou percebendo sinais de sobrecarga significativa ([evidências específicas]). Isso ressoa com você? Vamos conversar sobre como aliviar um pouco essa carga?"

### Etapa 6: Atualizar Memória e Alertas

Registrar em `psicologo-memory.yaml`:
- Padrões de procrastinação detectados
- Tipos de tarefas frequentemente evitadas
- Contextos de overwhelm
- Intervenções tentadas e efetividade

Atualizar alertas se necessário.

## Outputs
- Detecção proativa de padrões
- Intervenção empática calibrada ao risco
- Memória atualizada
- Colaboração cross-agent quando severo