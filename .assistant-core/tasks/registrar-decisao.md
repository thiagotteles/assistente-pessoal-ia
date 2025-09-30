# Task: Registrar Decisão - Persistência de Decisões Técnicas com Cross-referencing

## Objetivo
Registrar decisões técnicas arquiteturais de forma estruturada na knowledge-base, com cross-referencing automático para [[pessoas]], [[projetos]] e [[contextos]], e consolidação em arquivos únicos `decisao-*.md`.

## Inputs
- Decisão técnica a ser registrada
- Contexto da decisão
- Alternativas consideradas
- Rationale da escolha
- Pessoas envolvidas (opcional)
- Projeto relacionado (opcional)

## Configuração
```yaml
elicit: true
max_questions: 6
language: portuguese
interaction_style: estruturado-profissional
template: decisao-tecnica.yaml
```

## Processo de Execução

### 1. Coleta de Informações da Decisão

#### Informações Essenciais
Perguntas estruturadas:

1. **Título da Decisão**
   "Qual é o nome/título desta decisão técnica?"
   Formato sugerido: "Decisão: [Tecnologia/Padrão escolhido] para [Propósito]"
   Exemplo: "Decisão: Microserviços com Event Sourcing para Sistema de Pedidos"

2. **Contexto da Decisão**
   "Qual era o problema/situação que levou a esta decisão?"
   - Contexto do negócio
   - Constraints técnicos
   - Limitações existentes
   - Motivação para mudança

3. **Projeto Relacionado**
   "Esta decisão está relacionada a qual projeto?"
   - Buscar em `knowledge-base/projetos/`
   - Sugerir projetos existentes
   - Se novo, criar [[projeto-nome]]

4. **Pessoas Envolvidas**
   "Quem participou desta decisão?"
   - Identificar stakeholders técnicos
   - Criar [[pessoa-nome]] para cada um
   - Registrar papel de cada pessoa (decisor, consultor, implementador)

### 2. Levantamento de Alternativas Consideradas

#### Exploração de Opções
"Quais alternativas você considerou antes desta decisão?"

Para cada alternativa:
- **Nome da alternativa**
- **Por que foi considerada**: Vantagens percebidas
- **Por que foi descartada**: Desvantagens que pesaram mais
- **Trade-offs identificados**: O que você ganharia vs perderia

Formato estruturado:
```markdown
## Alternativas Consideradas

### Alternativa 1: [Nome]
- **Vantagens:** [Lista]
- **Desvantagens:** [Lista]
- **Por que foi descartada:** [Razão específica]

### Alternativa 2: [Nome]
- **Vantagens:** [Lista]
- **Desvantagens:** [Lista]
- **Por que foi descartada:** [Razão específica]
```

### 3. Captura do Rationale (Mais Importante)

**CRÍTICO**: Rationale é o coração da decisão para confrontos futuros.

#### Perguntas para Rationale Completo
"Por que você escolheu esta opção especificamente?"

Explorar:
1. **Benefícios Técnicos**
   - Quais problemas esta solução resolve melhor?
   - Quais capacidades técnicas são habilitadas?

2. **Alinhamento Estratégico**
   - Como se alinha com arquitetura existente?
   - Como suporta objetivos de longo prazo?

3. **Trade-offs Aceitos**
   - Quais desvantagens você está conscientemente aceitando?
   - Por que estes trade-offs são aceitáveis neste contexto?

4. **Fatores Decisivos**
   - Qual foi o fator que "desempatou" as alternativas?
   - Houve alguma experiência anterior que influenciou?

Formato do Rationale:
```markdown
## Rationale da Decisão

### Por que [Decisão Escolhida]?

**Benefícios Técnicos:**
- [Benefício 1] - [Por que isso importa no contexto]
- [Benefício 2] - [Impacto específico]

**Alinhamento Estratégico:**
- [Como se alinha com [[projeto-X]]]
- [Como suporta objetivos de longo prazo]

**Trade-offs Conscientemente Aceitos:**
- **Aceito:** [Desvantagem Y]
- **Porque:** [Contexto justifica este trade-off]
- **Mitigação:** [Como planejo lidar com isso]

**Fator Decisivo:**
[O que realmente fez escolher esta opção sobre as outras]

**Experiências Anteriores Relevantes:**
- Baseado em [[decisao-anterior]] que mostrou [insight]
- Evitando problemas de [[projeto-Y]] onde [problema aconteceu]
```

### 4. Análise de Consequências e Impactos

#### Consequências Imediatas
"Quais são os impactos imediatos desta decisão?"
- Mudanças no código/arquitetura necessárias
- Equipe precisa aprender algo novo?
- Dependências adicionais introduzidas

#### Consequências de Médio/Longo Prazo
"Como você espera que esta decisão afete o projeto daqui 6-12 meses?"
- Evolução arquitetural futura
- Manutenibilidade
- Escalabilidade
- Débito técnico previsto

#### Riscos Identificados
"Quais riscos técnicos você antecipa?"
- Riscos técnicos
- Riscos de equipe/conhecimento
- Riscos de integração
- Plano de mitigação para cada risco

### 5. Cross-referencing Automático

#### Identificar Entidades para Linking

**Pessoas:**
- Detectar nomes mencionados
- Criar links: João Silva → [[pessoa-joao-silva]]
- Validar se arquivo pessoa-*.md já existe
- Se não, criar arquivo básico

**Projetos:**
- Identificar projetos mencionados
- Criar links: Projeto Alpha → [[projeto-alpha]]
- Adicionar decisão ao histórico do projeto

**Decisões Relacionadas:**
- Buscar decisões técnicas similares anteriores
- Criar links: [[decisao-microservices-2024]]
- Documentar como esta decisão se relaciona/evolui/contradiz anteriores

**Tecnologias:**
- Identificar tecnologias/frameworks mencionados
- Criar tags: #kubernetes #event-sourcing #postgres

### 6. Geração do Arquivo de Decisão

Usando template `decisao-tecnica.yaml`, gerar arquivo:

**Nome do arquivo:** `knowledge-base/decisoes/decisao-{slug-da-decisao}.md`

Formato:
```markdown
# Decisão: [Título da Decisão]

**Data:** {data}
**Projeto:** [[projeto-nome]]
**Participantes:** [[pessoa-1]], [[pessoa-2]], [[pessoa-3]]
**Status:** Ativa | Superada | Em Revisão

## Tags
#arquitetura #[tecnologia] #[padrão] #[contexto]

## Contexto

[Descrição do contexto que levou à decisão]

**Problema a resolver:**
[Problema específico]

**Constraints:**
- [Constraint técnico]
- [Constraint de negócio]
- [Constraint de tempo/recursos]

## Alternativas Consideradas

### Alternativa 1: [Nome]
**Vantagens:**
- [Vantagem 1]
- [Vantagem 2]

**Desvantagens:**
- [Desvantagem 1]
- [Desvantagem 2]

**Por que descartada:** [Razão]

### Alternativa 2: [Nome]
[Mesma estrutura]

## Decisão Final

**Escolha:** [Tecnologia/Padrão/Abordagem escolhida]

**Resumo:** [Descrição em 1-2 frases da decisão]

## Rationale

[Rationale completo conforme capturado na etapa 3]

## Consequências

### Imediatas
- [Consequência 1]
- [Consequência 2]

### Médio/Longo Prazo
- [Impacto 1]
- [Impacto 2]

## Riscos e Mitigações

| Risco | Probabilidade | Impacto | Mitigação |
|-------|---------------|---------|-----------|
| [Risco 1] | Alta/Média/Baixa | Alto/Médio/Baixo | [Como mitigar] |
| [Risco 2] | ... | ... | ... |

## Decisões Relacionadas

- **Evolui:** [[decisao-anterior]] - [Como evolui/melhora]
- **Conflita com:** [[decisao-X]] - [Por que escolheu direção diferente]
- **Complementa:** [[decisao-Y]] - [Como trabalham juntas]

## Lições Aprendidas (Atualizar com o tempo)

[Espaço para registrar o que foi aprendido após implementação]

**Atualizado em:** [Data] - [O que foi aprendido]

## Revisão Futura

**Data prevista de revisão:** [Data]
**Critérios para revisão:**
- [Critério 1: ex: se usuários > 1M]
- [Critério 2: ex: se performance < 100ms]
```

### 7. Integração com Knowledge-Base

#### Atualizar Projeto Relacionado
Adicionar entrada em `knowledge-base/projetos/projeto-{nome}.md`:

```markdown
## Decisões Técnicas
- [Data] - [[decisao-{slug}]] - [Breve descrição]
```

#### Atualizar Perfis de Pessoas
Para cada pessoa envolvida, adicionar em `knowledge-base/pessoas/pessoa-{nome}.md`:

```markdown
## Decisões Técnicas Participadas
- [Data] - [[decisao-{slug}]] - Papel: [decisor/consultor/implementador]
```

#### Atualizar Índice de Decisões
Se existir `knowledge-base/decisoes/index.md`, adicionar:

```markdown
## [Ano] - [Mês]
- [[decisao-{slug}]] - [Breve resumo] - Status: [Ativa]
```

### 8. Atualização de Memória do Arquiteto

Atualizar `.assistant-core/memory/arquiteto-memory.yaml`:

```yaml
interaction_history:
  total_decisoes_registradas: [incrementar]
  ultima_decisao_registrada: "decisao-{slug}"

technical_context:
  decisoes_recentes:
    - nome: "decisao-{slug}"
      data: "{data}"
      tecnologia: "{tecnologia principal}"

learned_patterns:
  decisoes_arquiteturais_comuns:
    - padrao: "{padrão identificado}"
      projeto: "[[projeto-nome]]"
      rationale: "{rationale chave}"
```

### 9. Confirmação e Follow-up

#### Mostrar Resumo para Validação
```
✅ Decisão registrada: [[decisao-{slug}]]

📍 Localização: knowledge-base/decisoes/decisao-{slug}.md

🔗 Cross-references criados:
  - [[projeto-{nome}]] atualizado
  - [[pessoa-X]], [[pessoa-Y]] vinculados
  - Relacionado com [[decisao-anterior]]

📊 Tags: #tag1 #tag2 #tag3

💡 Próximos passos sugeridos:
  1. Implementar decisão no projeto
  2. Revisar em [prazo] para validar se está funcionando
  3. Atualizar "Lições Aprendidas" após implementação
```

#### Sugerir Ações Relacionadas
- "Quer analisar o código atual para ver como implementar? Use `*analise`"
- "Quer discutir detalhes técnicos da implementação? Use `*consultoria`"
- "Quer confrontar esta decisão antes de finalizar? Use `*confronto`"

## Output
- Arquivo `decisao-{slug}.md` criado em knowledge-base/decisoes/
- Cross-references automáticos criados e validados
- Projetos e pessoas atualizados
- Memória do arquiteto atualizada
- Decisão indexada e pesquisável

## Configurações TDAH
- Coleta estruturada, uma informação por vez
- Possibilidade de salvar parcialmente e continuar depois
- Confirmação visual clara de progresso
- Resumo final claro e acionável

## Tratamento de Erros
- Se informação essencial faltando, marcar como "Em Desenvolvimento"
- Permitir edição posterior do arquivo gerado
- Backup antes de qualquer operação
- Validação de links [[]] antes de criar