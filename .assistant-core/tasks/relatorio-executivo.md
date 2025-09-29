# Task: Relatório Executivo - Geração Sob Demanda

## Objetivo
Gerar relatórios executivos personalizados baseados na knowledge-base, com análises de padrões, métricas de produtividade e recomendações estratégicas para tomada de decisão.

## Inputs
- `knowledge-base/` completa para análise de dados
- `todos/central-todos.md` para métricas de produtividade
- `.assistant-core/memory/secretaria-memory.yaml` para padrões históricos
- Tipo de relatório desejado
- Período de análise (semanal, mensal, trimestral)

## Tipos de Relatório Disponíveis

### 1. Relatório de Status de Projetos
**Foco**: Visão executiva de todos os projetos ativos
**Período**: Última semana/mês
**Métricas**:
- Projetos iniciados, concluídos, cancelados
- Tempo médio de conclusão por tipo de projeto
- Taxa de sucesso por categoria
- Gargalos mais frequentes identificados

### 2. Relatório de Produtividade Pessoal
**Foco**: Análise de padrões de trabalho e eficiência
**Período**: Configurável (1-12 semanas)
**Métricas**:
- Todos concluídos vs criados
- Distribuição de tempo por projeto/categoria
- Horários de maior produtividade
- Padrões de procrastinação identificados

### 3. Relatório de Relacionamentos e Network
**Foco**: Análise de interações com pessoas e equipes
**Período**: Últimas 4-12 semanas
**Métricas**:
- Frequência de interação por pessoa
- Projetos compartilhados e colaborações
- Reuniões por tipo e eficiência
- Rede de contatos mais ativa

### 4. Relatório de Decisões e Aprendizados
**Foco**: Decisões técnicas e estratégicas tomadas
**Período**: Configurável
**Métricas**:
- Decisões registradas por categoria
- Impacto das decisões (quando mensurável)
- Padrões de tomada de decisão
- Lições aprendidas documentadas

## Processo de Execução

### 1. Coleta e Agregação de Dados

#### Análise de Projetos
```bash
# Pseudo-algoritmo
FOR each projeto-*.md:
  - Extrair metadados (status, datas, pessoas)
  - Contar decisões técnicas registradas
  - Mapear evolução temporal
  - Identificar marcos importantes
```

#### Análise de Pessoas
```bash
# Pseudo-algoritmo
FOR each pessoa-*.md:
  - Contar interações por período
  - Mapear projetos compartilhados
  - Identificar colaborações frequentes
  - Analisar padrões de comunicação
```

#### Análise de Todos
```bash
# Análise de central-todos.md
- Todos criados vs concluídos por período
- Tempo médio de conclusão por categoria
- Taxa de abandono de todos
- Distribuição por prioridade
```

### 2. Processamento de Métricas

#### Métricas de Eficiência
- **Completion Rate**: % todos concluídos vs criados
- **Project Velocity**: Projetos concluídos por semana/mês
- **Decision Frequency**: Decisões registradas por período
- **Collaboration Index**: Número de pessoas com interação ativa

#### Métricas de Qualidade
- **Documentation Score**: Completude da documentação de projetos
- **Follow-through Rate**: % de ações definidas que são executadas
- **Strategic Alignment**: Projetos alinhados com objetivos declarados

#### Métricas de Bem-estar
- **Workload Distribution**: Distribuição de carga ao longo do tempo
- **Stress Indicators**: Padrões que sugerem sobrecarga
- **Balance Metrics**: Proporção trabalho vs vida pessoal (se detectável)

### 3. Análise de Padrões e Trends

#### Padrões Temporais
- Dias da semana mais/menos produtivos
- Horários de maior energia e foco
- Sazonalidade em tipos de projeto ou atividade

#### Padrões Comportamentais
- Tipos de projeto que geram mais procrastinação
- Categorias de todo que são mais/menos concluídas
- Pessoas/contextos que facilitam ou dificultam produtividade

#### Padrões de Crescimento
- Evolução da complexidade de projetos ao longo do tempo
- Desenvolvimento de novas habilidades ou áreas
- Expansão da rede de colaboradores

### 4. Geração de Insights e Recomendações

#### Insights Baseados em Dados
- Identificação de gargalos recorrentes
- Oportunidades de otimização baseadas em padrões
- Correlações interessantes entre variáveis

#### Recomendações Acionáveis
- Sugestões de reorganização baseadas em dados
- Oportunidades de automação identificadas
- Recomendações de delegação ou priorização

### 5. Formatação do Relatório

**Template Base:**
```markdown
# RELATÓRIO EXECUTIVO - [Tipo] | [Período]
═══════════════════════════════════════════

## 📊 RESUMO EXECUTIVO
- [3-4 bullets com principais findings]
- [Métricas chave destacadas]
- [Recomendação principal]

## 📈 MÉTRICAS PRINCIPAIS
┌─────────────────────┬─────────┬─────────┐
│ Métrica             │ Atual   │ Anterior│
├─────────────────────┼─────────┼─────────┤
│ [Métrica 1]         │ [Valor] │ [Valor] │
│ [Métrica 2]         │ [Valor] │ [Valor] │
└─────────────────────┴─────────┴─────────┘

## 🎯 ANÁLISE POR CATEGORIA
### Projetos
- [Análise específica]
- [Insights descobertos]

### Produtividade
- [Padrões identificados]
- [Recomendações]

### Relacionamentos
- [Análise de network]
- [Oportunidades]

## 💡 INSIGHTS E DESCOBERTAS
• [Insight 1 com dados de suporte]
• [Insight 2 com contexto]
• [Padrão interessante descoberto]

## 🎯 RECOMENDAÇÕES ESTRATÉGICAS
1. **[Recomendação Principal]**
   - Rationale: [Por que]
   - Impacto esperado: [Resultado]
   - Próximos passos: [Como implementar]

2. **[Recomendação Secundária]**
   - [Similar structure]

## 📋 AÇÕES SUGERIDAS
### Curto Prazo (1-2 semanas)
- [ ] [Ação específica]
- [ ] [Ação específica]

### Médio Prazo (1-2 meses)
- [ ] [Ação estratégica]
- [ ] [Ação estratégica]

## 📈 PRÓXIMO CICLO
- Métricas para acompanhar
- Experimentos para tentar
- Revisão sugerida em [X semanas]
```

## Output
- Relatório executivo formatado
- Visualizações de métricas (texto/tabelas)
- Lista priorizada de recomendações
- Ações específicas para implementar
- Agendamento automático para próxima revisão

## Personalização por Contexto
- **Executivo/CEO**: Foco em métricas estratégicas e ROI
- **Manager**: Foco em equipe e processos
- **Individual Contributor**: Foco em produtividade pessoal
- **Freelancer**: Foco em projetos e relacionamentos com clientes

## Integração TDAH
- Relatórios concisos (máximo 2 páginas)
- Visuals claros e priorizados
- Recomendações específicas e acionáveis
- Evitar overwhelm com excesso de métricas
- Destacar insights mais importantes claramente