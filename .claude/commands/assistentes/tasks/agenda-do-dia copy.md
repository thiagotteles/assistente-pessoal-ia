# Task: Agenda do Dia - Dashboard Executivo

## Objetivo
Gerar dashboard executivo com visão consolidada de compromissos, status de projetos ativos, alertas sobre deadlines e próximas ações prioritárias.

## Inputs
- `knowledge-base/projetos/projeto-*.md` - Arquivos de projetos para análise de status
- `todos/central-todos.md` - Central de todos para verificar pendências
- `diario/` - Diários para contexto de atividades recentes
- `.assistant-core/memory/secretaria-memory.yaml` - Memória da secretária para preferências

## Processo de Execução

### 1. Análise de Projetos Ativos
- Ler todos os arquivos `projeto-*.md` na knowledge-base
- Extrair status atual, prioridade e data de última atualização
- Identificar projetos que precisam de atenção (sem atividade > 7 dias)
- Classificar por urgência: alta/média/baixa

### 2. Verificação de Todos Pendentes
- Analisar `central-todos.md` para contar todos pendentes
- Identificar todos com prazo próximo ou em atraso
- Priorizar todos por projeto e pessoa responsável

### 3. Detecção de Conflitos e Alertas
- Verificar sobrecarga: > 5 projetos ativos simultaneamente
- Detectar projetos bloqueados ou parados
- Identificar deadlines próximos (próximos 3 dias)

### 4. Geração do Dashboard

**Formato de Saída:**
```
🏢 DASHBOARD EXECUTIVO - [Data/Hora]
=======================================

🎯 RESUMO EXECUTIVO
------------------
• Total de Projetos: [N]
• Projetos Ativos: [N]
• Alta Prioridade: [N]
• Precisam Atenção: [N]

🚨 ALERTAS IMPORTANTES
---------------------
[Lista de projetos urgentes/bloqueados]

⚡ PROJETOS ATIVOS
------------------
[Lista com status e próximas ações]

📋 TODOS PRIORITÁRIOS
--------------------
• Pendentes: [N] todos
• Próximos do prazo: [Lista]

📅 PRÓXIMAS AÇÕES SUGERIDAS
---------------------------
[Sugestões baseadas na análise]
```

### 5. Atualização da Memória
- Registrar timestamp da última análise
- Atualizar padrões observados na memória da secretária
- Salvar insights sobre carga de trabalho

## Output
- Dashboard formatado exibido ao usuário
- Atualização de `.assistant-core/memory/secretaria-memory.yaml`
- Log da análise executada

## Integração com Knowledge-Base
- Leitura de todos arquivos de projeto
- Cross-referencing automático com [[pessoas]] e [[projetos]]
- Preservação de links [[]] existentes

## Configurações TDAH
- Tempo máximo de execução: 3 segundos
- Informações priorizadas por importância
- Feedback visual claro sobre status
- Sugestões proativas para reduzir sobrecarga cognitiva