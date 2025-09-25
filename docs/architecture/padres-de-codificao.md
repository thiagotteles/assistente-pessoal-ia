# Padrões de Codificação

## Regras Críticas

- **Arquivos sempre .md:** Todo conteúdo deve ser human-readable em Markdown
- **Referências [[]] obrigatórias:** Pessoas, projetos, conceitos devem usar [[Nome]]
- **Templates YAML consistentes:** Metadados seguem estrutura padronizada
- **Git commits descritivos:** "Tipo: descrição" (ex: "Organizador: processar despejo 3 items")
- **Encoding UTF-8:** Suporte completo a caracteres português
- **Timestamps ISO:** Sempre formato YYYY-MM-DDTHH:MM:SS

## Convenções de Nomes

| Elemento | Convenção | Exemplo |
|----------|-----------|---------|
| Arquivos | kebab-case.md | reuniao-projeto-alpha.md |
| Referências [[]] | Título Próprio | [[Fabio H]], [[Projeto Alpha]] |
| IDs YAML | kebab-case | reuniao-fabio-performance |
| Pastas | lowercase simples | conhecimento-base, pessoas |

## Regras Específicas para Agentes

- **Personalidade consistente:** Cada agente mantém tom e linguagem específicos
- **Memória contextual:** Sempre carregar histórico antes de responder
- **Referências automáticas:** Identificar pessoas/projetos e criar [[]] links
- **Confronto construtivo:** Questionar baseado em histórico real, não genérico
- **Transparência total:** Explicar decisões de categorização ao usuário
