# Modelos de Dados

## Daily Dump

**Propósito:** Captura ultra-rápida de informações sem estrutura obrigatória - o ponto de entrada para todo o sistema.

**Estrutura do Arquivo:** `despejo/daily-dump.md`
```
Qualquer texto livre aqui...
Reunião com [[Fabio H]] sobre API performance do [[Projeto Alpha]]
Bug no sistema de login - investigar
Ideia: automatizar backup dos configs
Lembrar de call com [[Cliente XYZ]] às 15h
```

## Knowledge Entry

**Propósito:** Unidade básica de conhecimento organizado na knowledge-base compartilhada.

**Estrutura Padrão:**
```yaml
---
id: unique-identifier
type: decisao|contexto|projeto|pessoa
created: 2025-01-09T10:30:00
updated: 2025-01-09T15:45:00
source_agent: organizador|secretaria|arquiteto|psicologo|mentor
tags: [tag1, tag2, tag3]
project: [[Nome do Projeto]] (se aplicável)
related_people: [[[Pessoa 1]], [[Pessoa 2]]]
---

# Título da Entrada

Conteúdo em Markdown livre...

# Contexto
Discussão com [[Fabio H]] sobre performance do [[Projeto Alpha]].

# Decisões
- Implementar [[Cache Redis]] para queries frequentes
- [[Fabio H]] vai medir métricas baseline
```

## Project Context

**Propósito:** Agregação de todo contexto relacionado a um projeto específico.

**Estrutura:** `knowledge-base/projetos/[[Nome Projeto]]/overview.md`
```yaml
---
id: projeto-alpha
name: "[[Projeto Alpha]]"
status: ativo|pausado|concluido
priority: alta|media|baixa
created: 2025-01-09
team_members: [[[Fabio H]], [[Maria Santos]]]
key_decisions: [[[Decisão Arquitetura API]], [[Escolha Tech Stack]]]
---

# [[Projeto Alpha]]

# Visão Geral
Descrição do projeto...

# Equipe
- [[Fabio H]] - Tech Lead
- [[Maria Santos]] - Frontend Developer

# Status Atual
Última atualização automática pelo /secretaria...
```
