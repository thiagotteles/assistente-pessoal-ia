# Task: Status de Projetos - Análise Completa

## Objetivo
Realizar análise completa de todos os projetos ativos, identificando status, progresso, pessoas envolvidas e próximas ações necessárias.

## Inputs
- `knowledge-base/projetos/projeto-*.md` - Todos os arquivos de projeto
- `knowledge-base/pessoas/pessoa-*.md` - Para identificar pessoas envolvidas
- `todos/por-projeto/` - Todos específicos por projeto
- `.assistant-core/memory/secretaria-memory.yaml` - Padrões aprendidos

## Processo de Execução

### 1. Descoberta e Catalogação
- Listar todos os arquivos `projeto-*.md`
- Extrair metadados de cada projeto:
  - Nome e tipo de projeto
  - Status atual (ativo, bloqueado, concluído, parado)
  - Prioridade (alta, média, baixa)
  - Data de criação e última atualização
  - Tags associadas

### 2. Análise de Status por Projeto
Para cada projeto identificado:
- **Status e Progresso**: Analisar seção "Status e Progresso"
- **Pessoas Envolvidas**: Identificar [[pessoa-*]] mencionadas
- **Decisões Técnicas**: Contar decisões importantes registradas
- **Atividade Recente**: Verificar entradas no "Histórico de Desenvolvimento"
- **Próximas Ações**: Extrair ações pendentes ou próximos passos

### 3. Categorização Inteligente
Classificar projetos em:
- **🚨 Críticos**: Alta prioridade ou bloqueados
- **⚡ Ativos**: Em progresso com atividade recente
- **⚠️ Atenção**: Sem atividade há > 5 dias
- **✅ Concluídos**: Status finalizado
- **❄️ Inativos**: Parados ou suspensos

### 4. Detecção de Padrões
- Projetos com sobrecarga de pessoas
- Gargalos ou dependências entre projetos
- Projetos órfãos (sem responsável definido)
- Tendências de prazo (atrasados/adiantados)

### 5. Geração do Relatório

**Formato de Saída:**
```
📊 RELATÓRIO DE STATUS - PROJETOS
=================================

📈 OVERVIEW EXECUTIVO
--------------------
• Total: [N] projetos catalogados
• Ativos: [N] | Críticos: [N] | Atenção: [N]
• Concluídos: [N] | Inativos: [N]

🚨 PROJETOS CRÍTICOS ([N])
--------------------------
[Para cada projeto crítico:]
• [Nome] - [Status] | Prioridade: [Alta] | [N] pessoas
  Próxima ação: [Descrição]
  Responsável: [[pessoa-nome]]

⚡ PROJETOS ATIVOS ([N])
-----------------------
[Para cada projeto ativo:]
• [Nome] - [Status] | Últ. atualização: [data]
  Pessoas: [Lista de [[pessoas]]]
  Progresso: [Resumo da situação]

⚠️ PRECISAM DE ATENÇÃO ([N])
---------------------------
• [Nome] - Sem atividade há [N] dias
• [Nome] - Status indefinido

📋 PRÓXIMAS AÇÕES CONSOLIDADAS
-----------------------------
[Ações prioritárias agregadas por urgência]
```

### 6. Insights e Recomendações
- Sugestões de reorganização se >10 projetos ativos
- Recomendações de delegação para projetos sobrecarregados
- Alertas sobre deadlines próximos
- Sugestões de arquivamento para projetos inativos

## Output
- Relatório estruturado de status
- Lista priorizada de próximas ações
- Insights sobre carga de trabalho
- Atualização da memória da secretária

## Integração com Outros Agentes
- Compartilhar insights com Organizador sobre projetos órfãos
- Alertar sobre sobrecarga para potencial intervenção do Psicólogo
- Disponibilizar dados para Relatórios Executivos

## Performance
- Execução em lote para eficiência
- Cache de resultados para 30 minutos
- Progressão visual se >15 projetos para analisar