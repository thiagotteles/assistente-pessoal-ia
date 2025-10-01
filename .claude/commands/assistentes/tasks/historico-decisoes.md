# Task: Histórico de Decisões - Visualização e Evolução de Padrões

## Objetivo
Visualizar histórico completo de decisões técnicas arquiteturais, analisar evolução de padrões ao longo do tempo, detectar inconsistências e identificar aprendizado acumulado.

## Inputs
- Filtro temporal (opcional): últimos N meses, ano específico, período
- Filtro por projeto (opcional): decisões de um projeto específico
- Filtro por tecnologia/padrão (opcional): decisões sobre tema específico
- Filtro por pessoa (opcional): decisões que pessoa participou

## Configuração
```yaml
elicit: false
language: portuguese
interaction_style: analítico-histórico
visualization: timeline-based
```

## Processo de Execução

### 1. Carregamento de Decisões

#### Buscar Todos os Arquivos de Decisões
- Ler todos os arquivos em `knowledge-base/decisoes/decisao-*.md`
- Carregar metadados de cada decisão:
  - Data
  - Projeto relacionado
  - Tecnologias/padrões
  - Pessoas envolvidas
  - Status (Ativa, Superada, Em Revisão)

#### Aplicar Filtros (se fornecidos)
```python
if filtro_temporal:
    decisoes = filtrar_por_data(decisoes, filtro_temporal)
if filtro_projeto:
    decisoes = filtrar_por_projeto(decisoes, filtro_projeto)
if filtro_tecnologia:
    decisoes = filtrar_por_tag(decisoes, filtro_tecnologia)
if filtro_pessoa:
    decisoes = filtrar_por_participante(decisoes, filtro_pessoa)
```

### 2. Análise Temporal - Timeline de Decisões

#### Gerar Timeline Cronológica
```markdown
# Timeline de Decisões Técnicas

## [Ano Atual]

### [Mês Recente]
📅 [Data] - [[decisao-kubernetes-adoption]]
  - **Projeto:** [[projeto-ecommerce]]
  - **Escolha:** Migração para Kubernetes
  - **Participantes:** [[pessoa-joao]], [[pessoa-maria]]
  - **Status:** ✅ Ativa
  - **Tags:** #infraestrutura #containers #escalabilidade

📅 [Data] - [[decisao-graphql-api]]
  - **Projeto:** [[projeto-mobile-app]]
  - **Escolha:** GraphQL ao invés de REST
  - **Participantes:** [[pessoa-carlos]], [[pessoa-ana]]
  - **Status:** ✅ Ativa
  - **Tags:** #api #graphql #performance

### [Mês Anterior]
[Decisões do mês anterior]

## [Ano Anterior]
[Decisões agrupadas por mês]
```

### 3. Detecção de Padrões Recorrentes

#### Análise de Frequência
Identificar padrões técnicos mais frequentes:

```markdown
## Padrões Arquiteturais Mais Utilizados

1. **Microserviços** - Usado em 8 decisões
   - [[decisao-A]], [[decisao-B]], [[decisao-C]]...
   - Projetos: [[projeto-X]], [[projeto-Y]]
   - Rationale comum: Escalabilidade e independência de deploy

2. **Event-Driven Architecture** - Usado em 5 decisões
   - [[decisao-D]], [[decisao-E]]...
   - Projetos: [[projeto-Z]]
   - Rationale comum: Desacoplamento e processamento assíncrono

3. **Domain-Driven Design** - Usado em 4 decisões
   - [[decisao-F]], [[decisao-G]]...
   - Rationale comum: Alinhamento com domínio do negócio
```

#### Tecnologias Favoritas
```markdown
## Tecnologias Mais Escolhidas

| Tecnologia | Frequência | Projetos | Rationale Principal |
|------------|------------|----------|---------------------|
| PostgreSQL | 6x | [[projeto-A]], [[projeto-B]] | Confiabilidade e features SQL |
| React | 5x | [[projeto-C]], [[projeto-D]] | Ecossistema e produtividade |
| Kubernetes | 4x | [[projeto-E]], [[projeto-F]] | Orquestração e escalabilidade |
```

### 4. Análise de Evolução de Preferências

#### Mudanças ao Longo do Tempo
Detectar quando preferências mudaram:

```markdown
## Evolução de Preferências Arquiteturais

### Bancos de Dados

**2023 (Início):**
- Preferência: MongoDB (NoSQL)
- Rationale: Flexibilidade de schema
- Decisões: [[decisao-mongodb-2023-01]], [[decisao-mongodb-2023-05]]

**2023 (Meio/Fim):**
- Mudança para: PostgreSQL (SQL)
- Rationale: Necessidade de transações ACID e queries complexas
- Decisões: [[decisao-postgres-2023-08]], [[decisao-postgres-2023-11]]

**2024:**
- Consolidação: PostgreSQL predominante
- Aprendizado: "ACID e queries SQL são mais importantes que flexibilidade de schema para nossos casos"
- Decisões: 6 decisões consecutivas usando PostgreSQL

**📊 Insight:** Houve uma mudança clara de NoSQL para SQL ao longo de 2023
```

### 5. Detecção de Inconsistências Históricas

#### Inconsistências Intra-Projeto
Identificar decisões contraditórias no mesmo projeto:

```markdown
## ⚠️ Inconsistências Detectadas

### Projeto: [[projeto-ecommerce]]

**Inconsistência 1: Padrão de Comunicação**
- [[decisao-rest-api-2023]] (Mar/2023): Escolha de REST para APIs
- [[decisao-graphql-2024]] (Jan/2024): Mudança para GraphQL
- **Status:** Conflito - Existem APIs REST e GraphQL no mesmo projeto
- **Sugestão:** Consolidar em um padrão ou documentar quando usar cada um

**Inconsistência 2: Estratégia de Cache**
- [[decisao-redis-cache-2023]] (Ago/2023): Redis para cache distribuído
- [[decisao-local-cache-2024]] (Fev/2024): Cache local em memória
- **Status:** Potencial duplicação - Dois sistemas de cache
- **Sugestão:** Definir claramente quando usar cada tipo de cache
```

#### Inconsistências Inter-Projetos
Decisões similares com escolhas diferentes:

```markdown
### Comparação: [[projeto-A]] vs [[projeto-B]]

**Contexto Similar:**
- Ambos são APIs REST com alto volume
- Ambos requerem autenticação e autorização
- Ambos integram com sistemas legados

**Decisões Divergentes:**
- **[[projeto-A]]**: JWT para autenticação ([[decisao-jwt-projeto-a]])
- **[[projeto-B]]**: OAuth2 para autenticação ([[decisao-oauth2-projeto-b]])

**Questionamento:**
Por que escolhas diferentes para contextos similares?
Há aprendizado de um projeto aplicável ao outro?
```

### 6. Análise de Rationales e Lições Aprendidas

#### Rationales Mais Efetivos
Identificar rationales que levaram a decisões bem-sucedidas:

```markdown
## 📈 Rationales que Funcionaram Bem

### "Priorizar simplicidade sobre otimização prematura"
- Usado em: [[decisao-A]], [[decisao-B]], [[decisao-C]]
- Resultado: Implementações rápidas, código manutenível
- Lição: Otimizar depois quando necessário, não antes

### "Escolher tecnologia com suporte ativo da comunidade"
- Usado em: [[decisao-D]], [[decisao-E]]
- Resultado: Problemas resolvidos rapidamente, atualizações frequentes
- Lição: Ecossistema ativo é mais importante que features avançadas
```

#### Rationales que Não Funcionaram
```markdown
## 📉 Rationales que Levaram a Problemas

### "Usar tecnologia de ponta para estar na vanguarda"
- Usado em: [[decisao-F]]
- Problema: Falta de documentação, bugs não resolvidos, mudanças breaking
- Lição Aprendida: "Esperar tecnologia amadurecer antes de adotar em produção"
- Registrado em: [[decisao-F]] seção "Lições Aprendidas"
```

### 7. Análise de Trade-offs Priorizados

#### Trade-offs Consistentes
```markdown
## Priorização de Trade-offs

### Performance vs Simplicidade
**Padrão identificado:** 7 de 10 decisões priorizaram Simplicidade
- [[decisao-A]]: Escolheu arquitetura simples mesmo com overhead
- [[decisao-B]]: Preferiu biblioteca conhecida vs biblioteca mais rápida
- **Insight:** Você consistentemente valoriza simplicidade sobre performance

### Flexibilidade vs Consistência
**Padrão identificado:** 8 de 10 decisões priorizaram Consistência
- [[decisao-C]]: Padronização de tecnologias ao invés de "melhor tool for the job"
- [[decisao-D]]: Estrutura consistente entre projetos
- **Insight:** Você valoriza consistência cross-project
```

### 8. Recomendações Baseadas em Histórico

#### Sugestões de Consolidação
```markdown
## 💡 Recomendações

### 1. Consolidar Padrões de Autenticação
**Observação:** 3 projetos usam 3 sistemas diferentes (JWT, OAuth2, Session)
**Sugestão:** Definir padrão único ou critérios claros para cada tipo
**Benefício:** Redução de complexidade operacional

### 2. Documentar Evolução MongoDB → PostgreSQL
**Observação:** Mudança clara de preferência em 2023
**Sugestão:** Criar [[decisao-database-strategy]] consolidando rationale
**Benefício:** Evitar re-discussão desta decisão em novos projetos

### 3. Revisar Decisões "Superadas"
**Observação:** 4 decisões marcadas como "Superadas" nunca foram arquivadas
**Sugestão:** Criar seção "Decisões Históricas" ou atualizar status
**Benefício:** Manter knowledge-base limpa e relevante
```

### 9. Geração do Report Completo

```markdown
# Histórico de Decisões Técnicas - Report Completo

**Período Analisado:** [Data início] a [Data fim]
**Total de Decisões:** [N]
**Projetos Envolvidos:** [Lista de projetos]
**Pessoas Participantes:** [Lista de pessoas]

## 📊 Estatísticas Gerais

- **Decisões Ativas:** X
- **Decisões Superadas:** Y
- **Decisões Em Revisão:** Z
- **Frequência Média:** X decisões por mês
- **Projeto com mais decisões:** [[projeto-nome]] (N decisões)

## 📅 Timeline Completa
[Timeline gerada na etapa 2]

## 🔄 Padrões Recorrentes
[Análise de padrões da etapa 3]

## 📈 Evolução de Preferências
[Análise de evolução da etapa 4]

## ⚠️ Inconsistências Detectadas
[Análise de inconsistências da etapa 5]

## 🎓 Lições Aprendidas
[Rationales efetivos e não efetivos da etapa 6]

## ⚖️ Trade-offs Priorizados
[Análise de trade-offs da etapa 7]

## 💡 Recomendações
[Recomendações da etapa 8]

## 🔍 Insights Principais

1. **[Insight 1]**: [Descrição e evidências]
2. **[Insight 2]**: [Descrição e evidências]
3. **[Insight 3]**: [Descrição e evidências]

## Próximos Passos Sugeridos

1. **Revisar inconsistências:** Use `*confronto` para discutir decisões conflitantes
2. **Consolidar padrões:** Use `*decisao` para registrar estratégias consolidadas
3. **Atualizar decisões superadas:** Arquivar ou atualizar status
4. **Discussão de evolução:** Use `*consultoria` para discutir mudanças de preferência
```

### 10. Interatividade e Drill-down

#### Oferecer Exploração Detalhada
"Quer explorar algum aspecto específico?"

Opções:
1. Ver detalhes de uma decisão específica
2. Comparar duas decisões lado a lado
3. Analisar decisões de um projeto específico
4. Discutir uma inconsistência detectada → `*confronto`
5. Registrar nova decisão baseada em aprendizados → `*decisao`

## Output
- Report completo de histórico de decisões
- Timeline cronológica
- Análise de padrões e evolução
- Detecção de inconsistências
- Recomendações acionáveis
- Insights para próximas decisões

## Configurações TDAH
- Report estruturado com seções claras
- Visual indicators (emojis) para fácil escaneamento
- Estatísticas numéricas para contexto rápido
- Recomendações priorizadas e acionáveis

## Tratamento de Erros
- Se nenhuma decisão encontrada, sugerir registrar primeira decisão
- Se filtros muito restritivos, sugerir ampliar busca
- Se arquivos corrompidos, reportar e pular