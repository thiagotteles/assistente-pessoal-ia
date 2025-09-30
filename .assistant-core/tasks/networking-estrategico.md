# Task: Networking Estratégico

## Configuração
```yaml
elicit: true
language: portuguese
interaction_style: strategic-relational
focus: quality-connections
```

## Propósito

Identificar pessoas-chave via análise de [[pessoas]], sugerir conexões estratégicas contextualizadas, determinar timing apropriado para networking baseado em projetos, e preparar para conversas de networking.

---

## Workflow

### Etapa 1: Mapeamento de Rede Atual

**Carregar dados de pessoas:**

1. Varrer `knowledge-base/pessoas/pessoa-*.md` para identificar todas as pessoas cadastradas
2. Extrair metadados de cada pessoa:
   - Nome e papel/empresa
   - Contexto de conhecimento (como se conhecem)
   - Áreas de expertise
   - Projetos compartilhados (via [[projeto-x]])
   - Última interação mencionada
   - Tipo de relação (colega, mentor, ex-colega, conexão fraca)

3. Carregar memória networking:
   - `.assistant-core/memory/mentor-memory.yaml` → `networking.pessoas_chave`
   - `networking.conexoes_estrategicas`
   - `networking.conversas_planejadas`

**Categorizar rede:**

```yaml
rede_categorizada:
  núcleo_ativo:  # Interage regularmente, relação forte
    - pessoa: [[pessoa-X]]
      força: 9/10
      última_interação: "2 semanas atrás"
      tipo: "Colega próximo"

  núcleo_passivo:  # Relação forte mas sem interação recente
    - pessoa: [[pessoa-Y]]
      força: 8/10
      última_interação: "6 meses atrás"
      tipo: "Ex-colega, amizade"
      nota: "⚠️ Reconectar?"

  conexões_fracas:  # Conhecidos, não relação profunda
    - pessoa: [[pessoa-Z]]
      força: 4/10
      última_interação: "1 ano atrás"
      tipo: "Conferência, contato superficial"

  aspiracionais:  # Gostaria de conectar mas ainda não
    - pessoa: [[pessoa-W]]
      força: 0/10
      contexto: "VP de Eng na Empresa X, admira trabalho"
```

### Etapa 2: Análise de Gaps de Networking

**Compare rede atual com necessidades de carreira:**

1. **Carregar metas de carreira:**
   - `knowledge-base/carreira/metas-{ano}.md`
   - Identificar habilidades necessárias
   - Identificar áreas de desenvolvimento

2. **Identificar gaps:**

```yaml
gaps_networking:
  gap_expertise:
    habilidade_alvo: "System Design"
    pessoas_com_expertise_na_rede: []  # Vazio = GAP
    sugestao: "Buscar mentor/conexão com expertise em arquitetura de sistemas"

  gap_industria:
    area_interesse: "Machine Learning"
    pessoas_nessa_area_na_rede: 1  # Baixo
    sugestao: "Expandir rede em ML - conferências, comunidades"

  gap_senioridade:
    nivel_alvo: "Staff Engineer"
    conexoes_nesse_nivel: 0  # GAP CRÍTICO
    sugestao: "Conectar com Staff/Principal Engineers para entender transição"

  gap_empresa_alvo:
    interesse: "Big Tech"
    conexoes_internas: 0
    sugestao: "Networking com pessoas em FAANG para referrals futuros"
```

### Etapa 3: Identificação de Pessoas-Chave Estratégicas

**Para cada gap, identificar pessoas específicas:**

#### Critérios de Pessoa-Chave:

✅ **Relevância para Metas:**
- Tem habilidade/experiência que você quer desenvolver?
- Está em empresa/área que te interessa?
- Pode acelerar objetivo específico?

✅ **Acessibilidade:**
- Já tem conexão (mesmo fraca)?
- Conexão mútua pode fazer introdução?
- Pessoa é conhecida por ser acessível?

✅ **Alinhamento de Valores:**
- Compatibilidade de estilo e valores profissionais
- Pessoa demonstra generosidade com mentoria/networking?

**Exemplo de identificação:**

```yaml
pessoa_chave_identificada:
  nome: [[pessoa-senior-sre]]
  gap_que_endereça: "System Design + Staff Engineer"

  por_que_chave:
    - "Staff SRE com 10+ anos em sistemas distribuídos"
    - "Trabalha em [[empresa-X]] que te interessa"
    - "Mencionado em [[projeto-microservices]] como referência técnica"

  acessibilidade:
    conexao_direta: false
    conexao_mutua: [[pessoa-colega-comum]]
    viabilidade: "Alta - colega pode fazer intro warm"

  proximos_passos:
    - "Pedir a [[pessoa-colega-comum]] para introdução"
    - "Preparar contexto claro: 'Quero aprender sobre X'"
    - "Propor coffee chat de 30min"
```

### Etapa 4: Timing Apropriado para Networking

**Princípios de timing:**

🟢 **BOM TIMING** para reach out:

- **Você tem razão relevante:**
  - Trabalhando em [[projeto-X]] relacionado à expertise da pessoa
  - Leu artigo/talk da pessoa e tem insight genuíno para compartilhar
  - Conexão mútua sugeriu ("fulano mencionou que você poderia ajudar com Y")

- **Você pode oferecer valor:**
  - Não é só "pegar cérebro", mas troca
  - Tem contexto interessante para compartilhar
  - Pode ajudar com algo que pessoa precisa

- **Momento de carreira apropriado:**
  - Iniciando novo projeto onde expertise da pessoa é relevante
  - Considerando transição de carreira que pessoa já fez
  - Preparando para processo seletivo em empresa da pessoa

🔴 **MAU TIMING** para reach out:

- Pedido genérico sem contexto ("gostaria de conversar sobre carreira")
- Pessoa claramente sobrecarregada/em crise
- Você não tem clareza do que quer da conversa
- Abordagem puramente transacional ("preciso de referral")

**Análise contextual:**

Para cada pessoa identificada, verificar:
- Última menção em knowledge-base (projetos recentes)
- Existe "gancho" atual? (Novo projeto, artigo publicado, promoção)
- Você está em momento de vida/carreira apropriado para esse reach out?

### Etapa 5: Preparação para Conversas de Networking

**Para cada conversa planejada, preparar:**

#### 1. Pesquisa sobre a Pessoa

- **Background profissional:**
  - LinkedIn: Trajetória de carreira
  - GitHub/Blog: Trabalho técnico
  - Twitter/Social: Interesses e valores

- **Pontos de conexão:**
  - Projetos similares
  - Tecnologias em comum
  - Conexões mútuas
  - Interesses compartilhados

#### 2. Clareza de Objetivo

**Perguntar a si mesmo:**
- O que especificamente quero aprender/alcançar com essa conversa?
- Como posso fazer essa pessoa investir 30min comigo valer a pena para ela também?
- Qual é o outcome ideal? (Conselho, introdução, mentoria contínua)

**Exemplo de objetivo claro:**
- ❌ Vago: "Quero conversar sobre carreira"
- ✅ Específico: "Quero entender trade-offs de transição IC → EM, especificamente como você decidiu voltar para IC track após 2 anos em management"

#### 3. Estrutura da Conversa (Coffee Chat)

**Template de 30 minutos:**

```
0-5min: Rapport e contexto
- Agradecer o tempo
- Contexto breve de quem você é
- Por que especificamente essa pessoa

5-20min: Perguntas principais (máximo 3-4 perguntas preparadas)
- Perguntas abertas, não yes/no
- Baseadas em pesquisa prévia (mostra respeito)
- Deixe espaço para pessoa divagar (insights surgem aí)

20-28min: Exploração de oportunidades
- "Como posso ser útil para você?"
- Há projetos/áreas que pessoa precisa de ajuda?

28-30min: Próximos passos
- Agradecer especificamente o que foi valioso
- Follow-up claro: "Posso te atualizar sobre X em Y semanas?"
- Se apropriado: "Posso manter contato periodicamente?"
```

#### 4. Perguntas Poderosas para Networking

**Perguntas que geram conversas profundas:**

Sobre transições de carreira:
- "O que te fez decidir {mudança}? Como foi os primeiros 6 meses?"
- "Olhando para trás, o que você faria diferente?"
- "Que sinal te mostrou que era hora de {transição}?"

Sobre habilidades/crescimento:
- "Como você desenvolveu {habilidade}? Curso formal ou projetos?"
- "Que habilidade você acha subestimada para {nível/papel}?"
- "Se você pudesse voltar e dar um conselho a si mesmo em {estágio anterior}, qual seria?"

Sobre decisões difíceis:
- "Como você pesa trade-offs quando {contexto}?"
- "Houve momento em que seguiu seu instinto contra conselhos? Como foi?"

Sobre networking/mentoria:
- "Quem foram mentores/pessoas-chave na sua trajetória?"
- "Como você decide onde investir tempo de mentoria/networking?"

### Etapa 6: Sugestões Contextualizadas

**Apresentar plano de networking:**

```markdown
## 🤝 Oportunidades de Networking Estratégico

### Prioridade Alta: {Nome da Pessoa}

**Por que essa pessoa agora?**

Você está trabalhando em [[projeto-microservices]] e mencionou desafio com service boundaries. {Pessoa} é Staff Engineer especializada exatamente nisso na {Empresa}, e você tem conexão mútua com [[pessoa-colega]].

**Como essa conexão ajuda suas metas:**

✅ Conecta com [[meta-staff-engineer]] - aprender system design com quem está no nível alvo
✅ Possível mentoria contínua
✅ Insights sobre trabalhar em {Empresa} (interesse futuro)

**Plano de abordagem:**

1. **Pedir introdução a [[pessoa-colega]]:**
   "Oi {Colega}, estou trabalhando em refactoring para microservices e tendo desafios com design de service boundaries. Você mencionou que {Pessoa} é expert nisso. Você se sentiria confortável fazendo uma intro warm? Gostaria de um coffee chat de 30min para aprender da experiência dele(a)."

2. **Quando colega fizer intro, responder:**
   "Oi {Pessoa}, obrigado por aceitar conversar! Estou lidando com [contexto específico] e {Colega} sugeriu que você seria perfeita para dar insights. Teria 30min para um coffee chat virtual na próxima semana?"

3. **Preparar 3-4 perguntas específicas:**
   - Como você decide boundaries em sistema com domínios ambíguos?
   - Há patterns de microservices que você vê sendo mal aplicados frequentemente?
   - Como transição para Staff mudou tipo de problema arquitetural que você resolve?

4. **Durante conversa, buscar:**
   - Insights técnicos específicos aplicáveis ao projeto
   - Entender trajetória para Staff
   - Se possível: Follow-up para mentoria pontual futura

5. **Após conversa (dentro de 24h):**
   - Email agradecendo especificamente o que foi útil
   - Compartilhar como aplicou o conselho (follow-up)
   - Manter porta aberta: "Posso te atualizar em X semanas sobre resultado?"

---

**Timing ideal:** Próximas 2 semanas (você está ativamente em projeto relevante)

**Probabilidade de sucesso:** Alta (intro via conexão mútua + contexto relevante)
```

### Etapa 7: Manutenção de Relacionamentos

**Para conexões existentes (núcleo passivo):**

Identificar relacionamentos valiosos que esfriaram:

```
⚠️ Conexão Esfriando: [[pessoa-ex-colega-senior]]

Última interação: 8 meses atrás
Valor da relação: Alta (mentor informal no passado)

Sugestão de reconexão:
- Gancho: Pessoa postou sobre {tópico} no LinkedIn recentemente
- Mensagem: "Oi {Nome}, vi seu post sobre {tópico} e lembrei de nossas conversas sobre {contexto relacionado}. Como você está? Gostaria de colocar papo em dia - {contexto breve do que você está fazendo}. Teria 30min para um café virtual?"

Timing: Agora (gancho atual + não deixe passar de 1 ano)
```

**Princípio: Give Before You Ask**

Antes de pedir algo significativo, ofereça valor:
- Compartilhe artigo/recurso relevante
- Faça introdução que ajuda a pessoa
- Comente/amplifique trabalho da pessoa
- Ofereça ajuda em área que você tem expertise

**Frequência de contato:**

- **Núcleo ativo**: Orgânico (colaboração em projetos)
- **Núcleo passivo**: Check-in a cada 3-6 meses (não forçado, com razão genuína)
- **Conexões fracas**: Anual ou quando há gancho específico
- **Aspiracionais**: Quando houver contexto apropriado (não force)

### Etapa 8: Tracking e Follow-up

**Persistir plano de networking:**

Arquivo: `knowledge-base/carreira/networking-{ano}.md`

```markdown
# Plano de Networking - {Ano}

## Conexões Planejadas

### {Pessoa} - {Status}

**Objetivo:** {para que essa conexão}
**Prazo:** {quando fazer reach out}
**Approach:** {como abordar}
**Status:** [planejado|aguardando_intro|agendado|realizado]

**Data da conversa:** {se realizada}
**Notas-chave:**
- {insight 1}
- {insight 2}

**Follow-ups:**
- [ ] {ação 1}
- [ ] {ação 2}

---

## Relacionamentos em Manutenção

{check-ins periódicos}

---

## Networking Realizado

{conversas completas, outcomes}
```

**Atualizar memória:**
- `.assistant-core/memory/mentor-memory.yaml` → `networking.*`
- Registrar conversas planejadas e realizadas
- Atualizar `pessoas_chave` baseado em interações

**Lembrete proativo:**

"Leonardo (mentor) aqui. Notei que você planejou conversar com [[pessoa-X]] há 3 semanas. Conseguiu? Como foi?"

### Etapa 9: Análise de Efetividade de Networking

**Periodicamente (trimestral), analisar:**

📊 **Métricas qualitativas:**
- Quantas conversas resultaram em aprendizado concreto aplicado?
- Quantas levaram a mentoria contínua?
- Quantas abriram portas inesperadas?

📈 **Evolução da rede:**
- Rede está crescendo em áreas estratégicas?
- Diversidade de perspectivas aumentou?
- Conexões de alta qualidade vs quantidade?

🎯 **Conexão com metas:**
- Networking contribuiu para progresso de metas?
- Há gaps de networking que impedem metas?

---

## Outputs Esperados

1. **Análise da rede atual** (núcleo ativo/passivo, gaps)
2. **Lista priorizada** de pessoas-chave para conectar
3. **Plano concreto** de abordagem para cada conexão
4. **Preparação específica** para conversas (perguntas, contexto)
5. **Sugestões de manutenção** de relacionamentos existentes
6. **Arquivo de tracking** em `knowledge-base/carreira/networking-{ano}.md`
7. **Memória atualizada** com plano de networking

---

## Princípios para Conversação

✅ **Qualidade sobre Quantidade**: 5 conexões profundas > 50 superficiais
✅ **Genuinidade**: Networking é construção de relacionamentos, não transação
✅ **Give Before Ask**: Sempre buscar como ser útil, não só extrair valor
✅ **Timing Apropriado**: Respeitar contexto e momento
✅ **Follow-up Consistente**: Networking não é evento único, é processo
✅ **Respeito ao Tempo**: Ser específico, preparado e conciso

---

## Tratamento de Cenários Especiais

### Cenário: Usuário é Introvertido/Desconfortável com Networking

**Abordagem adaptada:**
- "Networking não precisa ser eventos grandes. Coffee chats 1-1 são igualmente (ou mais) valiosos"
- Focar em aprofundar conexões existentes primeiro
- Networking via projetos colaborativos (menos "forçado")
- Networking assíncrono: Comentar em posts, emails bem pensados

### Cenário: Reach Out Não Foi Respondido

**Não levar para o pessoal:**
- Pessoa pode estar ocupada (não é rejeição pessoal)
- Tentar novamente uma vez após 2-3 semanas (gentlemente)
- Se ainda não responder: Mover para "backlog" e tentar em contexto futuro diferente
- Há outras pessoas que podem ajudar com o mesmo gap

### Cenário: Conversa de Networking Não Foi Útil

**Aprendizado:**
- Analisar por quê (perguntas vagas? Pessoa não era fit? Timing errado?)
- Nem toda conexão será valiosa - isso é ok e normal
- Ainda assim, agradecer e manter porta aberta (nunca sabe)

---

**Lembre-se**: Networking estratégico não é sobre "usar" pessoas, mas construir relações mutuamente benéficas onde ambos crescem. Quando feito com autenticidade, é uma das ferramentas mais poderosas de crescimento de carreira.