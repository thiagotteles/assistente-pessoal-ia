# Task: Tracking de Metas de Carreira

## Configuração
```yaml
elicit: true
language: portuguese
interaction_style: strategic-empathetic
focus: long-term-career-goals
```

## Propósito

Gerenciar objetivos de carreira de longo prazo através de definição clara, acompanhamento de progressão, e visualização de evolução ao longo do tempo.

---

## Workflow

### Etapa 1: Carregar Contexto Existente

1. Carregar `.assistant-core/memory/mentor-memory.yaml` para contexto de metas anteriores
2. Verificar se existem metas ativas em `career_tracking.metas_ativas`
3. Identificar ano corrente e arquivo correspondente em `knowledge-base/carreira/metas-{ano}.md`
4. Se arquivo não existe, preparar para criar novo

### Etapa 2: Elicitação de Objetivos (Se Primeira Vez)

Se não houver metas definidas, fazer elicitação conversacional:

**Perguntas estratégicas:**
- "Onde você se vê profissionalmente em 3-5 anos?"
- "Que tipo de trabalho te energiza e motiva?"
- "Quais habilidades gostaria de desenvolver?"
- "Que valores são inegociáveis na sua carreira?" (compensação, impacto, aprendizado, flexibilidade, cultura)
- "Há alguma transição de carreira que considera?" (mudança de área, liderança, IC track)

**Aprofundar com:**
- "Por que isso é importante para você?"
- "O que te impede de alcançar isso hoje?"
- "Como você saberá que alcançou esse objetivo?"

### Etapa 3: Estruturação de Metas (Framework SMART Adaptado)

Para cada objetivo identificado, estruturar como:

```yaml
meta:
  id: meta-{slug}
  titulo: "Título Claro do Objetivo"
  descricao: "Descrição detalhada"
  categoria: [tecnico|lideranca|transicao|compensacao|learning]
  prazo: "YYYY-MM"  # Data alvo
  prioridade: [alta|media|baixa]

  criterios_sucesso:
    - "Critério mensurável 1"
    - "Critério mensurável 2"

  marcos:
    - data: "YYYY-MM"
      descricao: "Marco intermediário"
      status: [pendente|em_progresso|concluido]

  habilidades_necessarias: []
  recursos_necessarios: []
  obstaculos_potenciais: []

  referencias_obsidian:
    projetos: []  # [[projeto-x]]
    pessoas: []   # [[pessoa-y]]

  status: ativa
  criada_em: "YYYY-MM-DD"
  atualizada_em: "YYYY-MM-DD"
```

### Etapa 4: Persistência

1. **Criar/atualizar arquivo** `knowledge-base/carreira/metas-{ano}.md`
2. **Estrutura do arquivo:**

```markdown
# Metas de Carreira - {Ano}

**Criado em:** {data}
**Última atualização:** {data}

---

## Visão Geral

**Tema do Ano:** {tema estratégico, se houver}

**Valores Profissionais Prioritários:**
- {valor 1}
- {valor 2}

---

## Metas Ativas

### 🎯 {Título da Meta}

**Categoria:** {categoria}
**Prazo:** {data}
**Prioridade:** {prioridade}

**Descrição:**
{descrição detalhada}

**Critérios de Sucesso:**
- [ ] {critério 1}
- [ ] {critério 2}

**Marcos:**
- [ ] **{Data}** - {descrição do marco}

**Habilidades Necessárias:**
- {habilidade 1}
- {habilidade 2}

**Recursos/Suporte Necessário:**
- {recurso 1}

**Obstáculos Potenciais:**
- {obstáculo 1} → Mitigação: {estratégia}

**Conexões:**
- Projetos: [[projeto-x]], [[projeto-y]]
- Pessoas: [[pessoa-a]]

**Progresso:**
{atualização sobre progresso atual}

---

{repetir para cada meta}

---

## Metas Completas

{metas concluídas no ano}

---

## Reflexões e Aprendizados

{insights sobre evolução, padrões, decisões}
```

3. **Atualizar memória** `.assistant-core/memory/mentor-memory.yaml`:
   - Adicionar meta a `career_tracking.metas_ativas`
   - Atualizar `user_career_profile.objetivos_longo_prazo`
   - Registrar `interaction_history.total_sessoes_metas++`

### Etapa 5: Acompanhamento de Progressão (Sessões Subsequentes)

Para metas existentes, perguntar:

**Check-in conversacional:**
- "Como está o progresso em {meta}?"
- "Alcançou algum marco desde nossa última conversa?"
- "Há novos obstáculos ou mudanças na prioridade?"
- "Essa meta ainda está alinhada aos seus valores?"

**Atualizar status:**
- Marcar marcos como concluídos
- Ajustar prazos se necessário (com justificativa)
- Identificar bloqueios e estratégias de mitigação
- Celebrar progressos

**Detectar necessidade de ajuste:**
- Meta não avançou em 3+ meses → Investigar por quê
- Contexto mudou → Reavaliar relevância
- Nova oportunidade surgiu → Priorização

### Etapa 6: Visualização de Evolução

Oferecer visualização do progresso:

**Resumo rápido:**
```
📊 Status de Metas - {Ano}

✅ {X} metas completas
🔄 {Y} metas em progresso (dentro do prazo)
⚠️  {Z} metas atrasadas
📅 {W} metas planejadas (ainda não iniciadas)

🎯 Próximos marcos:
- {data}: {marco 1}
- {data}: {marco 2}
```

**Timeline de progressão:**
```
Jan |==■==| Iniciou meta 1
Mar |====■| Completou marco A
Jun |======■| Meta 1 completa!
Jul |==■====| Iniciou meta 2
```

### Etapa 7: Conexão com Desenvolvimento Atual

**Relacionar metas com contexto atual:**
- "Vejo que você está trabalhando em [[projeto-x]]. Isso contribui para meta '{meta-y}' como?"
- "Identificou em [[pessoa-a]] alguém que pode ajudar com '{meta-z}'?"
- "O aprendizado de {habilidade} via [[projeto-b]] está alinhado com '{meta-w}'"

**Sugerir ações próximas:**
- "Para avançar em {meta}, próximo passo poderia ser {ação específica}"
- "Considerou conversar com [[pessoa-x]] sobre {aspecto da meta}?"

### Etapa 8: Revisão Estratégica (Trimestral/Anual)

**A cada 3 meses, oferecer revisão:**
- "Vamos revisar suas metas? Algo mudou em prioridades ou contexto?"
- Identificar padrões: Metas sempre atrasam? Muito ambiciosas? Pouco desafiadoras?
- Celebrar conquistas
- Ajustar estratégia

**Fim de ano:**
- Revisar ano completo
- Migrar metas não concluídas para próximo ano (com análise de por quê)
- Capturar aprendizados
- Preparar metas do próximo ano

---

## Outputs Esperados

1. **Arquivo de metas** criado/atualizado em `knowledge-base/carreira/metas-{ano}.md`
2. **Memória atualizada** com metas ativas e progressão
3. **Clareza para o usuário** sobre objetivos, próximos passos e progresso
4. **Conexões** com projetos e pessoas via [[referências]]

---

## Princípios para Conversação

✅ **Estratégico mas Prático**: Visão de longo prazo com ações de curto prazo
✅ **Provocar Reflexão**: "Por que isso importa?" "O que te impede?"
✅ **Celebrar Progressos**: Reconhecer avanços, não só cobrar resultados
✅ **Flexibilidade**: Metas podem mudar - o importante é a intenção, não rigidez
✅ **Alinhamento a Valores**: Sempre verificar se meta está alinhada a valores pessoais
✅ **Realismo Empático**: Desafiar, mas não pressionar irracionalmente

---

## Exemplos de Metas Bem Estruturadas

### Exemplo 1: Transição para Liderança
```yaml
meta:
  titulo: "Transição para Engineering Manager"
  categoria: lideranca
  prazo: "2026-06"

  criterios_sucesso:
    - "Liderar equipe de 3-5 engenheiros por 6+ meses"
    - "Completar 1-on-1s semanais consistentemente"
    - "Conduzir ciclo completo de performance review"

  marcos:
    - "2025-12: Mentorar 2 engenheiros júniors formalmente"
    - "2026-03: Liderar projeto com coordenação de 4+ pessoas"
    - "2026-06: Aplicar para posição EM internamente ou externamente"

  habilidades_necessarias:
    - "Gestão de pessoas e 1-on-1s efetivos"
    - "Delegação e feedback construtivo"
    - "Planejamento de roadmap de equipe"

  obstaculos_potenciais:
    - "Falta de posição EM disponível → Mitigação: Preparar para busca externa"
```

### Exemplo 2: Desenvolvimento Técnico
```yaml
meta:
  titulo: "Tornar-se Senior Staff Engineer"
  categoria: tecnico
  prazo: "2026-12"

  criterios_sucesso:
    - "Liderar design de sistema crítico end-to-end"
    - "Influenciar decisões arquiteturais da organização"
    - "Mentorar 3+ engenheiros em crescimento técnico"

  marcos:
    - "2025-09: Completar curso de System Design avançado"
    - "2026-03: Propor e aprovar RFC de arquitetura significativa"
    - "2026-09: Apresentar tech talk sobre arquitetura em conferência interna"
```

---

## Tratamento de Cenários Especiais

### Cenário: Meta Não Avançou em 3+ Meses

**Investigar empaticamente:**
- "Notei que {meta} não teve progresso recente. O que está acontecendo?"
- Possíveis causas: Prioridades mudaram, obstáculos não antecipados, meta não é realmente importante

**Ações:**
- Se ainda importante: Criar plano concreto de desbloqueio
- Se não: Remover ou pausar meta sem culpa

### Cenário: Usuário Overwhelmed com Muitas Metas

**Priorização forçada:**
- "Se tivesse que escolher apenas 1-2 metas para focar nos próximos 3 meses, quais seriam?"
- Mover outras para "Backlog" temporariamente

### Cenário: Nova Oportunidade Conflita com Meta Existente

**Facilitação de decisão:**
- "Como essa oportunidade se compara com {meta existente} em termos de {valores}?"
- Usar framework de decisão de carreira (em frameworks-conversas.md)

---

**Lembre-se**: Metas são ferramentas, não correntes. O objetivo é crescimento intencional, não checklist rígida.