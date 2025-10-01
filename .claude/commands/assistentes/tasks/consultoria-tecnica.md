# Task: Consultoria T Técnica - Discussão Aprofundada com Memória Contextual

## Objetivo
Fornecer consultoria técnica profunda sobre padrões arquiteturais e decisões técnicas, SEMPRE recuperando contexto histórico de decisões anteriores e questionando de forma construtiva baseado no histórico real do usuário.

## Inputs
- Tópico técnico para discussão (padrão arquitetural, escolha de tecnologia, design decision)
- Contexto atual do projeto (opcional)
- URL de repositório/código (opcional)

## Configuração
```yaml
elicit: true
max_questions_per_topic: 5
language: portuguese
interaction_style: confrontador-construtivo
memory_required: true
```

## Processo de Execução

### 1. Recuperação de Contexto Histórico (OBRIGATÓRIO)

Antes de qualquer discussão:

#### Buscar Decisões Anteriores
- Verificar `knowledge-base/decisoes/` para decisões relacionadas
- Carregar arquivos `decisao-*.md` que mencionam o tópico
- Identificar [[referências]] relacionadas ao contexto atual
- Recuperar rationale de decisões similares anteriores

#### Análise de Memória Contextual
- Carregar `.assistant-core/memory/arquiteto-memory.yaml`
- Revisar `user_patterns.preferencias_arquiteturais`
- Analisar `learned_patterns.decisoes_arquiteturais_comuns`
- Identificar `user_patterns.padroes_evitados`
- Recuperar `technical_context.decisoes_recentes`

#### Cross-referencing Automático
- Buscar projetos relacionados: `[[projeto-*]]`
- Identificar pessoas envolvidas historicamente: `[[pessoa-*]]`
- Recuperar contextos técnicos similares: `[[contexto-*]]`

**CRÍTICO**: NUNCA iniciar discussão sem recuperar contexto histórico completo.

### 2. Análise do Tópico Atual

#### Entendimento Profundo
Fazer perguntas específicas:
1. "Qual o problema específico que você está tentando resolver?"
2. "Quais são os constraints técnicos e de negócio?"
3. "Qual o contexto do sistema/projeto atual?"
4. "Quem mais está envolvido nesta decisão?" → criar [[pessoa-nome]]

#### Exploração de Alternativas Consideradas
- "Quais alternativas você já considerou?"
- "Por que descartou X, Y, Z?"
- "O que te levou a considerar esta abordagem específica?"

### 3. Confronto Construtivo Baseado em Histórico

**CRÍTICO**: Confronto DEVE ser fundamentado em decisões anteriores do usuário, não genérico.

#### Padrão de Questionamento Construtivo

**Se houver decisões similares anteriores:**
```
"Vejo que em [[decisao-bounded-context]] você optou por [X] pelo rationale [Y].
Por que desta vez você está considerando [Z] ao invés de [X]?
Algo mudou no contexto que invalida o rationale anterior?"
```

**Se houver inconsistência com padrões estabelecidos:**
```
"Percebo que historicamente você prioriza [padrão A] em projetos similares.
Esta decisão atual parece ir em direção diferente.
Isso é intencional? Há algum trade-off específico que justifica a mudança?"
```

#### Perguntas Desafiadoras do Tipo "Por que não X?"
- "Por que não usar [alternativa comum no contexto do usuário]?"
- "E se [cenário futuro relevante baseado em projetos anteriores] acontecer?"
- "Como isso se alinha com [objetivo arquitetural mencionado antes]?"
- "Considerou que [trade-off específico baseado em histórico]?"

### 4. Exploração de Trade-offs

Para cada alternativa discutida, explorar:

#### Vantagens
- Benefícios técnicos específicos para o contexto
- Alinhamento com decisões anteriores
- Facilitadores para objetivos futuros

#### Desvantagens
- Custos técnicos e de complexidade
- Conflitos com padrões estabelecidos
- Possíveis débitos técnicos futuros

#### Cenários "E se...?"
Baseado em padrões históricos:
- "E se o volume de dados crescer 10x como no [[projeto-X]]?"
- "E se precisar integrar com sistemas legados como em [[projeto-Y]]?"
- "E se a equipe mudar como aconteceu em [[projeto-Z]]?"

### 5. Discussão Técnica Aprofundada

#### Padrões Arquiteturais
- Discutir padrões relevantes: microservices, event-driven, CQRS, DDD, etc.
- Relacionar com experiências anteriores do usuário
- Questionar aplicabilidade ao contexto específico

#### Implicações de Longo Prazo
- "Como essa decisão afeta a manutenibilidade?"
- "Quais são os riscos técnicos nos próximos 6-12 meses?"
- "Isso facilita ou dificulta [objetivo de carreira do usuário]?" → colaborar com Mentor

#### Alinhamento Estratégico
- Verificar alinhamento com objetivos técnicos de longo prazo
- Considerar crescimento profissional e aprendizado
- Avaliar impacto em projetos relacionados

### 6. Síntese e Recomendações

Depois da discussão:

#### Resumo da Discussão
```markdown
## Tópico: [Nome do tópico]
**Contexto Histórico Relevante:** [[decisao-X]], [[decisao-Y]]
**Projetos Relacionados:** [[projeto-A]], [[projeto-B]]

### Alternativas Discutidas
1. **[Alternativa 1]**: Vantagens [...], Desvantagens [...], Trade-offs [...]
2. **[Alternativa 2]**: Vantagens [...], Desvantagens [...], Trade-offs [...]

### Recomendação Fundamentada
Baseado em [razões específicas relacionadas ao histórico], sugiro [recomendação].

**Rationale:** [Explicação técnica profunda ligando com decisões anteriores]

### Inconsistências Detectadas
[Se houver conflitos com decisões anteriores, listar aqui]

### Próximos Passos Sugeridos
1. [Ação técnica específica]
2. [Validação ou prova de conceito]
3. [Registro da decisão] → usar `*decisao`
```

#### Oferecer Registro Formal
"Quer que eu registre esta discussão e decisão formalmente? Use `*decisao` para criar um registro completo."

### 7. Atualização de Memória Contextual

Após cada consultoria:

#### Atualizar Memória do Arquiteto
- Incrementar `interaction_history.total_consultorias`
- Adicionar padrões identificados em `learned_patterns`
- Atualizar `user_patterns` com novas preferências
- Registrar `technical_context.areas_foco_atual`

#### Registrar Insights para Outros Agentes
- Compartilhar insights técnicos relevantes para carreira → Mentor
- Informar sobre deadlines técnicos → Secretária
- Organizar referências técnicas → Organizador

## Output
- Discussão técnica aprofundada com questionamento construtivo
- Síntese de alternativas e trade-offs
- Recomendação fundamentada baseada em contexto histórico
- Opção de registrar decisão formalmente
- Memória atualizada para próximas interações

## Configurações TDAH
- Perguntas focadas, uma de cada vez
- Síntese clara ao final de cada tópico
- Feedback visual sobre progresso da discussão
- Opção de pausar e retomar depois

## Tratamento de Erros
- Se não encontrar contexto histórico, informar explicitamente: "Primeira discussão sobre este tópico"
- Se usuário não souber responder, oferecer pesquisa colaborativa
- Se discussão ficar muito longa, oferecer síntese intermediária