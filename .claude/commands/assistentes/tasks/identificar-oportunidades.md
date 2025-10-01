# Task: Identificar Oportunidades de Aprendizado

## Configuração
```yaml
elicit: true
language: portuguese
interaction_style: strategic-contextual
focus: skill-gaps-and-growth
```

## Propósito

Detectar gaps de conhecimento baseados em projetos atuais e sugerir oportunidades de aprendizado contextualizadas que conectam trabalho real com objetivos de carreira.

---

## Workflow

### Etapa 1: Carregar Contexto de Carreira e Projetos

1. Carregar `.assistant-core/memory/mentor-memory.yaml` para:
   - `user_career_profile.objetivos_longo_prazo`
   - `user_career_profile.habilidades_atuais`
   - `user_career_profile.gaps_identificados` (histórico)
   - `career_tracking.oportunidades_identificadas`

2. Buscar projetos atuais:
   - Varrer `knowledge-base/projetos/projeto-*.md` para projetos ativos
   - Identificar tecnologias, desafios, escopo mencionados

3. Verificar metas de carreira:
   - Ler `knowledge-base/carreira/metas-{ano}.md` para habilidades necessárias

### Etapa 2: Análise de Projetos Atuais

Para cada projeto ativo identificado:

**Extrair informações-chave:**
- Tecnologias utilizadas
- Complexidade e escopo
- Desafios mencionados
- Papel do usuário no projeto
- Colaboradores envolvidos

**Perguntas de elicitação:**
- "Me conte sobre [[projeto-x]]. Que desafios técnicos você está enfrentando?"
- "Que partes desse projeto te interessam mais? E menos?"
- "Há habilidades que sente falta para executar melhor?"
- "O que gostaria de aprender através desse projeto?"

### Etapa 3: Detecção de Gaps de Conhecimento

**Análise cruzada:**

Compare:
1. **Habilidades necessárias para metas** (do tracking-metas)
2. **Habilidades demonstradas em projetos** (atuais)
3. **Habilidades mencionadas como gaps** pelo usuário

**Identificar 3 tipos de gaps:**

#### Gap Tipo 1: **Bloqueio Imediato**
- Habilidade necessária AGORA para projeto atual
- Impacto: Alto - está atrapalhando trabalho
- Exemplo: "Precisa de Kubernetes mas não sabe configurar"

#### Gap Tipo 2: **Crescimento Estratégico**
- Habilidade alinhada com meta de carreira
- Impacto: Médio - acelera objetivo de longo prazo
- Exemplo: "Quer ser Staff Engineer, precisa de System Design avançado"

#### Gap Tipo 3: **Interesse Emergente**
- Habilidade que surgiu em contexto recente
- Impacto: Baixo/Médio - exploração de nova área
- Exemplo: "Projeto usa ML, curiosidade sobre aplicações"

**Priorização:**
1. Bloqueios imediatos primeiro
2. Crescimento estratégico se não houver bloqueios
3. Interesse emergente se capacidade disponível

### Etapa 4: Contextualização de Oportunidades

Para cada gap identificado, estruturar oportunidade:

```yaml
oportunidade:
  id: oport-{slug}
  habilidade_alvo: "Nome da Habilidade/Tecnologia"
  tipo_gap: [bloqueio|estrategico|interesse]
  prioridade: [alta|media|baixa]

  contexto_atual:
    projetos_relacionados: ["[[projeto-x]]"]
    meta_alinhada: "[[meta-y]]" # se aplicável
    urgencia: "Por que é relevante agora?"

  sugestoes_aprendizado:
    - tipo: [curso|documentacao|mentoria|projeto-pratico|leitura]
      recurso: "Nome/Link do recurso"
      tempo_estimado: "X horas/semanas"
      custo: [gratuito|pago]
      adequacao: "Por que é boa opção para este contexto"

  aplicacao_pratica:
    - "Como aplicar em [[projeto-atual]]"
    - "Mini-projeto para praticar"

  pessoas_mentoria: ["[[pessoa-expert]]"] # se identificadas

  criterio_progresso:
    - "Como saber que aprendeu suficiente"

  criada_em: "YYYY-MM-DD"
```

### Etapa 5: Sugestões Contextualizadas

**Princípios para sugestões:**

✅ **Baseadas em Contexto Real**, não genéricas
- ❌ "Aprenda React" (genérico)
- ✅ "Aprenda React Hooks para refatorar componentes de [[projeto-dashboard]]" (contextual)

✅ **Acionáveis e Específicas**
- ❌ "Estude algoritmos" (vago)
- ✅ "Complete curso 'Grokking Algorithms' focando em grafos para implementar feature de recomendações" (específico)

✅ **Conectadas a Objetivos**
- Sempre mencionar "Isso te aproxima de {meta}" quando aplicável

✅ **Realistas em Tempo**
- Considerar carga atual de trabalho
- Sugerir micro-aprendizados se usuário overwhelmed

**Formato de apresentação:**

```markdown
## 🚀 Oportunidades de Aprendizado Identificadas

### Prioridade Alta: {Habilidade}

**Por que agora?**
Você está trabalhando em [[projeto-x]] e mencionou desafio com {problema}. Aprender {habilidade} desbloquearia esse projeto.

**Alinhamento com metas:**
Conecta-se com sua meta de [[meta-y]] - uma das habilidades necessárias.

**Sugestões de recursos:**
1. **{Curso/Documentação}** (~{tempo})
   - {Link/Nome}
   - Por que: {adequação ao contexto}

2. **Aplicação prática:**
   - Implementar {feature específica} em [[projeto-x]]
   - Criar mini-projeto: {descrição}

**Mentoria disponível:**
[[pessoa-expert]] tem experiência profunda em {habilidade} - considere conversar.

**Como saber que progrediu:**
- [ ] {critério 1}
- [ ] {critério 2}

---
```

### Etapa 6: Conexão com Projetos Técnicos Alinhados

**Sugerir projetos que desenvolvem skills desejadas:**

Se gap identificado + sem projeto prático imediato:

"Para desenvolver {habilidade}, considere:
- Propor {feature/refactoring} em [[projeto-atual]] que usa essa skill
- Iniciar side-project: {ideia específica relevante}
- Voluntariar-se para {tipo de projeto} na empresa"

**Colaboração com Arquiteto:**
- "Vou colaborar com Marcus (Arquiteto) para alinhar escolhas técnicas de [[projeto-x]] com seu desenvolvimento de {habilidade}"

### Etapa 7: Tracking de Aprendizado

**Persistir oportunidades:**
1. Adicionar a `knowledge-base/carreira/oportunidades-{ano}.md`
2. Atualizar memória `.assistant-core/memory/mentor-memory.yaml`:
   - `career_tracking.oportunidades_identificadas`
   - `user_career_profile.gaps_identificados`

**Check-in periódico:**
- "Conseguiu avançar no aprendizado de {habilidade}?"
- "O recurso sugerido ({curso}) está sendo útil?"
- "Aplicou {habilidade} em algum contexto real?"

**Atualizar quando:**
- Gap foi fechado (habilidade adquirida)
- Prioridade mudou (não é mais relevante)
- Novo gap surge

### Etapa 8: Análise de Habilidades Emergentes

**Detectar trends:**
- Analisar projetos recentes: Quais tecnologias estão aparecendo mais?
- Verificar pessoas conectadas: Que habilidades elas têm que você não tem?
- Observar progressão: Gaps de 6 meses atrás foram fechados?

**Provocar reflexão:**
- "Notei que você tem trabalhado com {tecnologia A, B, C} recentemente. Está desenvolvendo especialização em {área}?"
- "Vejo padrão de interesse em {tema}. Isso é intencional ou orgânico?"
- "Há habilidade que você evita desenvolver? Por quê?"

---

## Outputs Esperados

1. **Lista priorizada** de oportunidades de aprendizado contextualizadas
2. **Arquivo de tracking** em `knowledge-base/carreira/oportunidades-{ano}.md`
3. **Memória atualizada** com gaps identificados e oportunidades
4. **Ações concretas** para cada oportunidade (recursos, aplicação prática, mentoria)
5. **Conexões** com projetos [[]] e pessoas [[]]

---

## Princípios para Conversação

✅ **Contextual Sempre**: Conectar aprendizado com trabalho real
✅ **Alinhado a Metas**: Referenciar como contribui para objetivos
✅ **Prático sobre Teórico**: Preferir "aprenda fazendo" a cursos longos
✅ **Realisticamente Acionável**: Considerar tempo e energia disponíveis
✅ **Celebrar Progressos**: Reconhecer gaps fechados
✅ **Curiosidade como Guia**: Seguir interesses genuínos, não só "deveria aprender"

---

## Exemplo de Identificação Completa

### Cenário:
- **Projeto atual**: Refactoring de sistema legado para microserviços
- **Meta de carreira**: Tornar-se Staff Engineer em 2 anos
- **Gap percebido**: Usuário menciona dificuldade em decidir boundaries de serviços

### Oportunidade Identificada:

```markdown
## 🎯 Oportunidade: System Design e Service Boundaries

### Por que agora?
Você está liderando refactoring para microserviços em [[projeto-modernizacao]]. Dominar princípios de service boundaries e domain-driven design (DDD) é crucial para sucesso desse projeto e evita retrabalho futuro.

### Alinhamento com metas:
✅ Conecta diretamente com [[meta-staff-engineer]] - "Liderar design de sistema crítico end-to-end"
✅ Habilidade core para nível Staff: Arquitetura de sistemas distribuídos

### Sugestões de recursos:

**1. Curso: "System Design Interview" (Alex Xu)** (~20h)
- Por que: Foco prático em trade-offs de design, não apenas teoria
- Gratuito: Primeiros capítulos online
- Aplicação: Capítulo sobre microservices diretamente aplicável ao seu refactoring

**2. Livro: "Domain-Driven Design Distilled" (Vaughn Vernon)** (~15h leitura)
- Por que: Versão condensada do DDD clássico, foca em bounded contexts
- Aplicável: Use para definir boundaries dos seus serviços

**3. Documentação: Martin Fowler - Microservices Guide**
- Por que: Referência rápida para patterns e anti-patterns
- Link: martinfowler.com/microservices/

### Aplicação prática imediata:

**No [[projeto-modernizacao]]:**
1. Mapear domínios usando Event Storming (técnica DDD)
2. Definir bounded contexts baseado em análise
3. Propor arquitetura de serviços em RFC para review

**Mini-projeto:**
Criar diagrama C4 do sistema atual → sistema alvo, documentando decisões de boundaries

### Mentoria disponível:
- [[pessoa-marcus]] (Arquiteto) - Experiência profunda em microservices, pode revisar proposta de arquitetura
- [[pessoa-senior-sre]] - Perspectiva de operações sobre service boundaries

### Como saber que progrediu:
- [ ] Consegue articular 3+ estratégias para definir service boundaries
- [ ] Aplicou pelo menos 1 pattern DDD no refactoring
- [ ] Proposta de arquitetura foi aprovada pelo time
- [ ] Outros devs consideram você referência em system design do projeto

### Próxima revisão: 2025-11-15
```

---

## Tratamento de Cenários Especiais

### Cenário: Muitos Gaps Identificados (Overwhelm)

**Priorização forçada:**
- "Identifiquei 8 oportunidades. Qual desses gaps te impacta MAIS no dia-a-dia?"
- Focar em 1-2 máximo
- Colocar outros em backlog visível

### Cenário: Usuário Não Sabe o Que Quer Aprender

**Exploração guiada:**
- "Que projeto recente te deixou mais animado? Por quê?"
- "Se pudesse dedicar 10h para aprender algo novo, sem pressão de ser útil imediatamente, seria o quê?"
- "Há alguém no seu time cujo trabalho você admira? O que eles fazem que você gostaria de fazer?"

### Cenário: Gap Identificado Não é Prioritário mas Usuário Insiste

**Validação empática + realidade:**
- "Entendo o interesse em {habilidade}. Como isso se conecta com {meta primária}?"
- Se não conecta: "Está ok explorar por curiosidade. Só esteja ciente que pode competir com tempo para {habilidade prioritária}"
- Respeitar autonomia final do usuário

### Cenário: Mesma Habilidade Aparece como Gap Há Meses

**Investigação de bloqueio:**
- "Notei que {habilidade} está na lista há X meses. O que está impedindo progresso?"
- Possíveis causas:
  - Não é realmente importante (remover)
  - Recurso sugerido não adequado (trocar abordagem)
  - Falta de tempo (realisticamente, quando teria tempo?)
  - Medo/insegurança (endereçar emocional)

---

## Integração com Outros Agentes

**Arquiteto (Marcus):**
- Compartilhar decisões técnicas que revelam gaps
- Alinhar projetos técnicos com desenvolvimento de habilidades

**Secretária (Ana):**
- Contexto de projetos ativos e carga de trabalho
- Identificar tempo disponível realista para aprendizado

**Organizador (Sofia):**
- Padrões históricos de que tipos de projeto usuário prefere
- Temas recorrentes em despejos que indicam interesses

---

**Lembre-se**: Oportunidades de aprendizado são pontes entre onde você está e onde quer chegar. Devem ser motivadoras, não obrigações pesadas.