# Task: Confronto Técnico - Questionamento Construtivo Baseado em Histórico

## Objetivo
Realizar questionamento construtivo e fundamentado de decisões técnicas, SEMPRE baseado no contexto histórico real do usuário e suas decisões anteriores. NUNCA confronto genérico.

## Inputs
- Decisão técnica atual a ser confrontada
- Contexto da decisão (projeto, problema, constraints)
- Alternativas já consideradas (opcional)

## Configuração
```yaml
elicit: true
confrontation_style: construtivo-fundamentado
max_questions: 7
language: portuguese
require_historical_context: true
```

## Processo de Execução

### 1. Recuperação OBRIGATÓRIA de Contexto Histórico

**CRÍTICO**: NUNCA realizar confronto sem contexto histórico completo.

#### Buscar Decisões Similares Anteriores
- Verificar todas as decisões em `knowledge-base/decisoes/`
- Identificar decisões sobre tópicos relacionados
- Recuperar rationale completo de decisões similares
- Mapear [[referências]] conectadas ao tema

#### Análise de Padrões do Usuário
Carregar de `.assistant-core/memory/arquiteto-memory.yaml`:
- `user_patterns.preferencias_arquiteturais`
- `user_patterns.decisoes_recorrentes`
- `user_patterns.tecnologias_favoritas`
- `user_patterns.padroes_evitados`
- `user_patterns.trade_offs_priorizados`

#### Identificar Projetos Relacionados
- Buscar projetos similares em `knowledge-base/projetos/`
- Identificar decisões técnicas tomadas nesses projetos
- Recuperar lições aprendidas e outcomes

### 2. Análise da Decisão Atual

#### Entendimento Completo
Perguntas iniciais:
1. "Qual é exatamente a decisão que você está considerando?"
2. "Qual problema específico você está tentando resolver?"
3. "Quais são os constraints técnicos, de negócio e de tempo?"
4. "Quais alternativas você já avaliou?"

#### Contexto do Sistema
- "Como isso se encaixa na arquitetura atual?"
- "Quais componentes são afetados por esta decisão?"
- "Há dependências ou integrações críticas?"

### 3. Confronto Fundamentado em Histórico

**CRÍTICO**: Confronto DEVE referenciar decisões específicas anteriores do usuário.

#### Padrão de Confronto Contextualizado

**Cenário 1: Contradição com Decisão Anterior**
```
"Em [[decisao-{nome}]] de {data}, você decidiu usar {tecnologia/padrão X}
pelo seguinte rationale:
  - {razão 1}
  - {razão 2}
  - {razão 3}

Agora você está considerando {tecnologia/padrão Y} que segue direção oposta.

❓ Perguntas Desafiadoras:
1. O que mudou no contexto que invalida o rationale anterior?
2. As razões que levaram à decisão anterior ainda são válidas?
3. Esta mudança é pontual para este projeto ou uma evolução de preferência?
4. Você está resolvendo problemas criados pela decisão anterior?
```

**Cenário 2: Desvio de Padrão Estabelecido**
```
"Analisando seu histórico, identifico um padrão consistente:
  - Em [[projeto-A]]: Você usou {abordagem X}
  - Em [[projeto-B]]: Você usou {abordagem X}
  - Em [[projeto-C]]: Você usou {abordagem X}

A decisão atual propõe {abordagem Y} que quebra este padrão.

❓ Perguntas Desafiadoras:
1. Por que você foi consistente com {abordagem X} anteriormente?
2. O que faz este projeto diferente o suficiente para justificar a mudança?
3. Há algum problema com {abordagem X} que você descobriu recentemente?
4. Esta mudança poderia ser aplicada retroativamente aos projetos anteriores?
```

**Cenário 3: Ignora Lição Aprendida Anterior**
```
"Em [[decisao-{nome}]], você documentou explicitamente:
  'Evitar {padrão Z} porque {problema específico que aconteceu}'

A decisão atual parece ir em direção a {padrão Z} novamente.

❓ Perguntas Desafiadoras:
1. Você está ciente da experiência anterior com {padrão Z}?
2. O contexto atual é diferente o suficiente para evitar {problema específico}?
3. Há mitigações planejadas para os problemas anteriores?
4. Por que revisitar algo que foi explicitamente evitado antes?
```

### 4. Exploração de Trade-offs com Contexto Histórico

#### Baseado em Preferências Estabelecidas
```
"Seu histórico mostra que você tipicamente prioriza:
  1. {trade-off A} sobre {trade-off B}
  2. {trade-off C} sobre {trade-off D}

Esta decisão parece priorizar {trade-off B} sobre {trade-off A},
o que é oposto ao seu padrão usual.

❓ Perguntas:
- Isso é intencional?
- O contexto justifica inverter suas prioridades habituais?
- Quais consequências você antecipa desta inversão?
```

### 5. Perguntas "Por que não X?" Contextualizadas

**Não genéricas, mas baseadas no histórico do usuário:**

```
"Por que não usar {solução X} que você utilizou com sucesso em [[projeto-Y]]?
Aquele contexto tinha constraints similares:
  - {constraint 1}
  - {constraint 2}

E funcionou bem porque {outcomes positivos}.

O que nesta situação atual torna {solução X} inadequada?"
```

### 6. Exploração de Cenários "E se...?" Personalizados

**Baseados em experiências reais do usuário:**

```
"Em [[projeto-{nome}]], você enfrentou {problema Z} quando {situação aconteceu}.

Se você adotar {decisão atual} e {situação similar} acontecer novamente:
  - Como você evitaria repetir {problema Z}?
  - Quais safeguards você colocaria desta vez?
  - O que você aprendeu daquela experiência que aplicaria aqui?
```

### 7. Detecção de Inconsistências Técnicas

#### Inconsistência Interna
"Esta decisão propõe {abordagem A} mas o código atual usa {abordagem B}.
Você planeja:
  a) Migrar todo código para {abordagem A}? (Custo: {estimativa})
  b) Conviver com inconsistência? (Risco: {problemas})
  c) Outra estratégia?"

#### Inconsistência com Arquitetura Estabelecida
"A arquitetura atual em [[projeto-{nome}]] segue princípios de {padrão X}.
Esta decisão introduz {padrão Y} que tem filosofia diferente.

Como você planeja reconciliar estas abordagens?
Há risco de criar 'ilhas arquiteturais' inconsistentes?"

### 8. Síntese do Confronto Construtivo

Depois de todas as perguntas:

```markdown
## Síntese do Confronto Técnico

### Decisão Confrontada
{Descrição da decisão atual}

### Contexto Histórico Relevante
- **Decisões Relacionadas:** [[decisao-A]], [[decisao-B]], [[decisao-C]]
- **Projetos Similares:** [[projeto-X]], [[projeto-Y]]
- **Padrões Estabelecidos:** {lista de padrões consistentes do usuário}

### Inconsistências Identificadas
1. **Contradição com [[decisao-{nome}]]**
   - {Explicação detalhada}
   - Pergunta chave: {questão}

2. **Desvio de Padrão em [[projeto-X]], [[projeto-Y]]**
   - {Explicação detalhada}
   - Pergunta chave: {questão}

### Perguntas Desafiadoras Fundamentadas
1. {Pergunta baseada em histórico específico}
2. {Pergunta baseada em lição aprendida anterior}
3. {Pergunta baseada em padrão estabelecido}
4. {Pergunta sobre trade-off invertido}
5. {Cenário "E se...?" baseado em experiência real}

### Cenários de Risco Baseados em Experiências Anteriores
- **Cenário 1:** {Situação que já aconteceu antes} → Como evitar desta vez?
- **Cenário 2:** {Problema conhecido do histórico} → Mitigação planejada?

### Recomendação Fundamentada
Baseado no seu histórico técnico e contexto atual:

**Opção A:** {Manter consistência com histórico}
- Vantagens: {baseadas em sucessos anteriores}
- Desvantagens: {contextualizadas}

**Opção B:** {Mudança justificada pela evolução}
- Vantagens: {benefícios específicos}
- Desvantagens: {custos de inconsistência}

**Opção C:** {Abordagem híbrida}
- Como reconciliar histórico com nova direção

### Próxima Ação Sugerida
{Ação específica baseada na discussão}
- Usar `*consultoria` para discutir profundamente um aspecto específico
- Usar `*decisao` para registrar decisão final com rationale completo
```

### 9. Registro e Aprendizado

#### Atualizar Memória do Arquiteto
- Incrementar `interaction_history.total_confrontos`
- Registrar `interaction_history.total_inconsistencias_detectadas`
- Adicionar insights em `learned_patterns.inconsistencias_historicas`
- Atualizar `user_patterns` com evolução de preferências

#### Se Decisão Mudou Padrão Estabelecido
Documentar explicitamente:
```yaml
evolucao_preferencias:
  - data: {data}
    mudanca: "De {padrão antigo} para {padrão novo}"
    rationale: "{Por que mudou}"
    contexto: "[[projeto-{nome}]]"
```

## Output
- Confronto construtivo FUNDAMENTADO em histórico real
- Perguntas desafiadoras contextualizadas
- Identificação de inconsistências específicas
- Síntese clara com opções fundamentadas
- Atualização de memória para evoluir entendimento

## Configurações TDAH
- Confronto estruturado e focado
- Uma inconsistência por vez
- Síntese clara ao final
- Próximos passos explícitos

## Tratamento de Erros
- Se não houver histórico suficiente, informar: "Primeira vez discutindo este tema - confronto será baseado em princípios gerais"
- Se usuário não tiver resposta, oferecer pesquisa colaborativa
- Se confronto ficar muito intenso, oferecer pausa e resumo