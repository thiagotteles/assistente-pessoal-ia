# Padrões de Codificação

## Regras Críticas

- **Arquivos sempre .md:** Todo conteúdo deve ser human-readable em Markdown
- **Referências [[]] obrigatórias:** Pessoas, projetos, conceitos devem usar [[Nome]]
- **Templates YAML consistentes:** Metadados seguem estrutura padronizada
- **Git commits descritivos:** "Tipo: descrição" (ex: "Organizador: processar despejo 3 items")
- **Encoding UTF-8:** Suporte completo a caracteres português
- **Timestamps ISO:** Sempre formato YYYY-MM-DDTHH:MM:SS

## Convenções de Nomes

### 📁 Padrões Gerais
| Elemento | Convenção | Exemplo |
|----------|-----------|---------|
| Arquivos | kebab-case.md | reuniao-projeto-alpha.md |
| Referências [[]] | Título Próprio | [[Fabio]], [[Projeto Alpha]] |
| IDs YAML | kebab-case | reuniao-fabio-performance |
| Pastas | lowercase simples | knowledge-base, pessoas |

### 🎯 Padrões de Arquivos Únicos (Story 2.2.1)

**IMPORTANTE**: A partir da Story 2.2.1, a knowledge-base usa arquivos únicos por entidade.

| Tipo | Formato | Exemplo | Descrição |
|------|---------|---------|-----------|
| **Pessoas** | `pessoa-{nome}.md` | `pessoa-fabio.md` | UM arquivo por pessoa com todo histórico |
| **Projetos** | `projeto-{nome}.md` | `projeto-onboarding.md` | UM arquivo por projeto com todo contexto |
| **Contextos** | `contexto-{tema}.md` | `contexto-bem-estar.md` | UM arquivo por tema com todas entradas |

### 🔗 Referências entre Arquivos Únicos
- **Pessoa**: `[[pessoa-fabio]]` → `pessoa-fabio.md`
- **Projeto**: `[[projeto-onboarding]]` → `projeto-onboarding.md`
- **Contexto**: `[[contexto-bem-estar]]` → `contexto-bem-estar.md`

## Regras para Arquivos Únicos (Story 2.2.1)

### 📝 Estrutura Obrigatória dos Metadados

Todos os arquivos únicos devem ter metadados YAML no início:

```yaml
tipo: pessoa|projeto|contexto
nome: NomeEntidade
tags: [tag1, tag2, tag3]
created: YYYY-MM-DD
updated: YYYY-MM-DD
arquivos_origem: [lista-se-aplicavel]
```

### 📋 Seções Obrigatórias por Tipo

#### Pessoas (pessoa-*.md)
1. `# {Nome} - Pessoa`
2. `## Metadados` (YAML)
3. `## Histórico de Interações`
4. `## Projetos Relacionados`
5. `## Notas e Contexto`

#### Projetos (projeto-*.md)
1. `# {Nome} - Projeto`
2. `## Metadados` (YAML)
3. `## Status e Progresso`
4. `## Histórico de Desenvolvimento`
5. `## Pessoas Envolvidas`
6. `## Decisões Técnicas`

#### Contextos (contexto-*.md)
1. `# {Tema} - Contexto`
2. `## Metadados` (YAML)
3. `## Entradas`
4. `## Padrões Identificados`
5. `## Notas e Reflexões`

### 🔄 Regras de Consolidação

- **NUNCA duplicar arquivos**: Uma entidade = Um arquivo
- **Preservar timestamps**: Organizar cronologicamente dentro do arquivo
- **Manter referências**: Atualizar [[]] links após consolidação
- **Backup obrigatório**: Sempre backup antes de consolidar

## Regras Específicas para Agentes

- **Personalidade consistente:** Cada agente mantém tom e linguagem específicos
- **Memória contextual:** Sempre carregar histórico antes de responder
- **Referências automáticas:** Identificar pessoas/projetos e criar [[]] links
- **Consolidação inteligente:** Sempre usar arquivos únicos por entidade
- **Confronto construtivo:** Questionar baseado em histórico real, não genérico
- **Transparência total:** Explicar decisões de categorização ao usuário
