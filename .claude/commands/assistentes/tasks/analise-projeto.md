# Task: Análise de Projeto - Review Técnico Crítico com Questionamento Ativo

## Objetivo
Realizar review técnico profundo de código, arquitetura ou projetos fornecidos via URLs/repositórios, com questionamento ativo do tipo "Por que não X?", "E se Y acontecer?" e identificação de padrões arquiteturais e desvios.

## Inputs
- URL de repositório (GitHub, GitLab, Bitbucket, etc.)
- Trecho de código específico
- Diagrama de arquitetura ou documentação técnica
- Contexto do projeto (opcional mas recomendado)

## Configuração
```yaml
elicit: true
max_questions_per_section: 4
language: portuguese
interaction_style: confrontador-construtivo-tecnico
analysis_depth: profundo
```

## Processo de Execução

### 1. Preparação e Contexto

#### Coletar Informações Iniciais
1. "Qual aspecto você quer que eu foque na análise?" (arquitetura, code quality, performance, segurança, escalabilidade)
2. "Há algum problema específico que você suspeita ou preocupações?"
3. "Este projeto se relaciona com algum [[projeto-*]] existente?"
4. "Qual o estágio do projeto?" (POC, MVP, produção, legacy)

#### Recuperar Contexto Histórico
- Buscar decisões técnicas relacionadas em `knowledge-base/decisoes/`
- Verificar padrões arquiteturais preferidos do usuário
- Identificar projetos similares anteriormente analisados
- Carregar memória de análises técnicas anteriores

### 2. Análise Estrutural de Arquitetura

#### Identificação de Padrões Arquiteturais
Detectar padrões utilizados:
- **Arquitetura em Camadas**: MVC, Clean Architecture, Hexagonal
- **Arquitetura de Microserviços**: Service mesh, API Gateway, Event-driven
- **Padrões de Design**: Repository, Factory, Strategy, Observer, etc.
- **Padrões de Integração**: REST, GraphQL, gRPC, Message Queue

#### Questionamento Ativo de Escolhas
Para cada padrão identificado:
```
"Por que foi escolhido [Padrão X] ao invés de [Alternativa Y comum no contexto]?"
"Como [Padrão X] resolve o problema específico de [contexto]?"
"Você considerou [Trade-off Z] ao escolher este padrão?"
```

### 3. Análise Crítica de Código

#### Code Quality
Analisar aspectos:
- **Legibilidade**: Nomes claros, estrutura compreensível
- **Complexidade**: Funções muito longas, aninhamento excessivo
- **Duplicação**: Código repetido, oportunidades de abstração
- **Testabilidade**: Facilidade de escrever testes, dependências injetáveis

#### Questionamento Técnico Profundo
```
"Por que esta função tem [X] responsabilidades? Considerou Single Responsibility Principle?"
"E se o volume de dados crescer 100x? Esta implementação escala?"
"Como você testaria este componente de forma isolada?"
"Por que não usar [padrão/biblioteca comum] que resolve este problema?"
```

### 4. Detecção de Problemas e Anti-Patterns

#### Anti-Patterns Comuns
Identificar e questionar:
- **God Object**: Classes com muitas responsabilidades
- **Spaghetti Code**: Fluxo difícil de seguir, alto acoplamento
- **Magic Numbers/Strings**: Valores hardcoded sem constantes
- **Premature Optimization**: Complexidade desnecessária
- **Leaky Abstractions**: Abstrações que vazam detalhes de implementação

#### Confronto Construtivo
Para cada problema detectado:
```
"Identifico [Anti-Pattern X] em [Local Y].
Isso pode causar [Problema Z] no futuro.
Por que não refatorar para [Solução Sugerida]?"
```

### 5. Exploração de Cenários "E se...?"

#### Cenários de Escalabilidade
- "E se o número de usuários crescer 10x?"
- "E se precisar processar 1M de requisições por segundo?"
- "E se o banco de dados ficar lento?"

#### Cenários de Manutenibilidade
- "E se um desenvolvedor novo precisar entender este código?"
- "E se precisar adicionar uma nova feature similar em 6 meses?"
- "E se a API externa mudar seu contrato?"

#### Cenários de Resiliência
- "E se o serviço externo cair?"
- "E se houver um pico de tráfego inesperado?"
- "E se os dados ficarem inconsistentes?"

### 6. Análise de Decisões vs Histórico do Usuário

#### Comparação com Decisões Anteriores
Se o usuário tem histórico:
```
"Em [[decisao-microservices-pattern]] você priorizou [X] pelo rationale [Y].
Aqui você está usando [Z] que contradiz aquela decisão.
Isso é intencional? O contexto é diferente o suficiente?"
```

#### Detecção de Inconsistências
- Comparar com `user_patterns.preferencias_arquiteturais`
- Identificar desvios de `user_patterns.padroes_evitados`
- Relacionar com `learned_patterns.decisoes_arquiteturais_comuns`

### 7. Identificação de Oportunidades de Melhoria

#### Priorização de Melhorias
Categorizar por impacto:
- **Crítico**: Problemas de segurança, escalabilidade, bugs graves
- **Alto**: Code smells significativos, débito técnico importante
- **Médio**: Oportunidades de refatoração, melhorias de performance
- **Baixo**: Otimizações estéticas, padronização de estilo

#### Sugestões Fundamentadas
Para cada melhoria:
```markdown
**Problema:** [Descrição técnica precisa]
**Impacto:** [Por que isso importa - baseado no contexto do projeto]
**Solução Sugerida:** [Abordagem específica com exemplos]
**Trade-offs:** [Custos e benefícios da mudança]
**Prioridade:** [Crítico/Alto/Médio/Baixo]
**Referência Histórica:** [[decisao-*]] (se aplicável)
```

### 8. Geração do Report de Análise

Estrutura completa:

```markdown
# Análise Técnica: [Nome do Projeto/Código]

**Data:** [Data]
**Analisado por:** Marcus (Arquiteto)
**Contexto:** [Breve contexto do projeto]
**Projetos Relacionados:** [[projeto-A]], [[projeto-B]]
**Decisões Históricas Relevantes:** [[decisao-X]], [[decisao-Y]]

## Resumo Executivo
[Visão geral em 3-4 frases sobre estado do projeto e principais achados]

## Padrões Arquiteturais Identificados
1. **[Padrão 1]**: [Descrição] - **Questionamento:** [Por que este vs alternativas?]
2. **[Padrão 2]**: [Descrição] - **Questionamento:** [Justificativa adequada?]

## Problemas Críticos Detectados
### 1. [Nome do Problema]
- **Local:** [Onde está o problema]
- **Descrição:** [O que está errado tecnicamente]
- **Impacto:** [Consequências possíveis]
- **Cenário "E se...?":** [Situação que expõe o problema]
- **Sugestão:** [Como resolver]

## Inconsistências com Decisões Anteriores
[Se houver desvios do histórico do usuário]
- **Decisão Anterior:** [[decisao-X]] priorizava [Y]
- **Código Atual:** Usa [Z] que contradiz
- **Questionamento:** [Por que a mudança?]

## Oportunidades de Melhoria

### Críticas
- [ ] [Melhoria 1] - Impacto: [Alto/Médio/Baixo]
- [ ] [Melhoria 2] - Impacto: [Alto/Médio/Baixo]

### Altas
- [ ] [Melhoria 3]
- [ ] [Melhoria 4]

### Médias e Baixas
- [ ] [Melhorias menos prioritárias]

## Perguntas Desafiadoras para Reflexão
1. "Por que não [Alternativa X]?"
2. "E se [Cenário Y] acontecer?"
3. "Como isso se alinha com [Objetivo Z]?"
4. "Considerou [Trade-off W]?"

## Recomendações Priorizadas
1. **[Recomendação 1]** - Rationale: [Explicação técnica]
2. **[Recomendação 2]** - Rationale: [Explicação técnica]

## Próximos Passos
1. [Ação técnica específica]
2. [Refatoração recomendada]
3. [Discussão técnica sugerida] → usar `*consultoria`
4. [Registrar decisões tomadas] → usar `*decisao`
```

### 9. Follow-up e Persistência

#### Oferecer Discussão Aprofundada
"Quer discutir algum ponto específico desta análise em profundidade? Use `*consultoria [tópico]`"

#### Registrar Insights
- Salvar análise em `knowledge-base/projetos/projeto-[nome].md`
- Criar/atualizar `knowledge-base/decisoes/` se decisões foram discutidas
- Atualizar memória do arquiteto com padrões identificados

#### Colaboração Cross-Agent
- Informar Mentor sobre habilidades técnicas demonstradas/faltantes
- Informar Secretária sobre tempo estimado para refatorações
- Compartilhar contexto técnico com Organizador

## Output
- Report de análise técnica completo e estruturado
- Questionamento ativo e construtivo de decisões
- Priorização clara de melhorias
- Conexão com contexto histórico do usuário
- Sugestões acionáveis e fundamentadas

## Configurações TDAH
- Análise em seções digestíveis
- Priorização clara (Crítico > Alto > Médio > Baixo)
- Próximos passos acionáveis
- Visual indicators de progresso

## Tratamento de Erros
- Se URL não acessível, pedir trecho de código direto
- Se código muito extenso, focar em áreas críticas primeiro
- Se linguagem desconhecida, informar limitações e focar em arquitetura geral