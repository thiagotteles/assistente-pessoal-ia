# Estratégia de Tratamento de Erros

## Abordagem Geral

**Modelo de Erro:** Graceful degradation com transparência total
- **Hierarquia de Exceções:** Erros de arquivo → Erros de IA → Erros de usuário
- **Propagação de Erro:** Falhas locais não quebram sistema global

## Padrões de Tratamento

### Erros de Arquivo/Sistema
- **Arquivo não encontrado:** Criar automaticamente com template padrão
- **Referência [[]] quebrada:** Notificar mas continuar operação
- **Git conflict:** Backup automático + resolução manual sugerida
- **Disk space:** Warning proativo quando <1GB disponível

### Erros de IA/Claude
- **Timeout de resposta:** Retry com backoff + fallback para operação manual
- **Rate limit:** Queue local + retry inteligente
- **Resposta malformada:** Log + solicitação de reformulação
- **Context overflow:** Auto-split de entrada grande + retry

### Erros de Usuário/Workflow
- **Input inválido:** Sugestão construtiva + exemplo correto
- **Workflow abandonado:** Salvar estado parcial automaticamente
- **Comando inexistente:** Sugestão de comando similar
- **Referência ambígua:** Perguntar esclarecimento com opções

## Padrões de Logging

**Biblioteca:** Sistema de arquivos simples (logs/*.md)
- **Formato:** Markdown estruturado com timestamps
- **Níveis:** ERROR, WARN, INFO, DEBUG
- **Contexto:** Sempre incluir agente, usuário, operação

**Exemplo de Log Entry:**
```markdown
# 2025-01-09 14:30:15 - ERROR - Organizador Agent

# Operação
Processamento de despejo daily-dump.md

# Erro
Referência [[Projeto Inexistente]] não encontrada

# Contexto
- Usuário: processamento automático
- Arquivo: knowledge-base/projetos/projeto-inexistente.md
- Ação: Criar automaticamente vs perguntar ao usuário

# Resolução
Perguntado ao usuário, criado projeto-inexistente.md com template básico
```
