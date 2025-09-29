# Exemplos da Estrutura Unificada

Este documento apresenta exemplos práticos da nova estrutura de arquivos únicos implementada na Story 2.2.1.

## 📋 Visão Geral

A partir da Story 2.2.1, a knowledge-base usa **arquivos únicos por entidade**:
- Uma pessoa = Um arquivo `pessoa-{nome}.md`
- Um projeto = Um arquivo `projeto-{nome}.md`
- Um contexto = Um arquivo `contexto-{tema}.md`

## 👤 Exemplo: Pessoa

### Arquivo: `pessoa-fabio.md`

```markdown
# Fabio - Pessoa

## Metadados
```yaml
tipo: pessoa
nome: Fabio
tags: [pessoa, relacionamento, comentário, positivo]
created: 2025-09-28
updated: 2025-09-28
arquivos_origem: ["fabio-parceiro-2025-09-28.md"]
```

## Histórico de Interações

### 2025-09-28 - Observação Positiva
O [[Fabio]] tem se demonstrado muito parceiro

**Contexto Adicional:**
- Prioridade: Baixa (apenas comentário)
- Próximas ações: Nenhuma ação específica necessária
- Observações: Comentário positivo sobre relacionamento interpessoal. Importante para construção de network.

## Projetos Relacionados
- [[projeto-onboarding]]
- [[projeto-assistente-ia]]

## Notas e Contexto
Parceiro confiável no desenvolvimento. Demonstra iniciativa e colaboração efetiva.

## Histórico de Modificações
- 2025-09-28: Migração para arquivo único (Story 2.2.1)
```

### Benefícios da Consolidação

✅ **Antes**: `fabio-parceiro-2025-09-28.md`, `fabio-reuniao-2025-09-26.md`, etc.
✅ **Depois**: `pessoa-fabio.md` (tudo consolidado)

- **Contexto completo** em um lugar
- **Histórico cronológico** organizado
- **Referências cruzadas** funcionais

## 🚀 Exemplo: Projeto

### Arquivo: `projeto-onboarding.md`

```markdown
# Onboarding - Projeto

## Metadados
```yaml
tipo: projeto
nome: Onboarding
tags: [projeto, análise, planejamento, onboarding]
created: 2025-09-28
updated: 2025-09-28
arquivos_origem: ["onboarding-inicio-2025-09-28.md"]
```

## Status e Progresso
**Status**: Em análise inicial
**Prioridade**: Baixa (ainda em fase de análise)

## Histórico de Desenvolvimento

### 2025-09-28 - Início do Projeto
Começar o projeto [[Onboarding]]

**Próximas ações:**
- Continuar análise do projeto
- Definir escopo detalhado
- Identificar stakeholders

**Observações:** Projeto em fase inicial de análise. Não há pressão de urgência no momento.

## Pessoas Envolvidas
- [[pessoa-fabio]] - Parceiro técnico
- [A definir] - Outros stakeholders

## Decisões Técnicas
- Abordagem ainda em definição
- Tecnologias a serem avaliadas

## Notas e Contexto
Projeto estratégico para melhoria do processo de integração de novos colaboradores.

## Histórico de Modificações
- 2025-09-28: Migração para arquivo único (Story 2.2.1)
```

### Benefícios da Consolidação

✅ **Antes**: `onboarding-inicio-2025-09-28.md`, `onboarding-reuniao-2025-09-30.md`, etc.
✅ **Depois**: `projeto-onboarding.md` (história completa)

- **Timeline unificada** do projeto
- **Todas as decisões** em um local
- **Status sempre atualizado**

## 🧠 Exemplo: Contexto

### Arquivo: `contexto-bem-estar.md`

```markdown
# Bem-estar - Contexto

## Metadados
```yaml
tipo: contexto
nome: bem-estar
tags: [contexto, bem-estar, tdah, stress, emocional]
created: 2025-09-28
updated: 2025-09-29
arquivos_origem: ["dia-estressante-2025-09-28.md"]
```

## Entradas

### 2025-09-28 - Dia Estressante - Reflexão
Hoje o dia foi bem estressante

**Contexto Adicional:**
- Prioridade: Média (monitoramento de bem-estar)
- Próximas ações: Acompanhar padrões de stress
- Observações: Primeira entrada de stress detectada. Importante monitorar frequência e gatilhos.

## Padrões Identificados
- **Gatilho**: Pressão de prazos
- **Frequência**: Primeira ocorrência registrada
- **Impacto**: Médio

## Notas e Reflexões
- Importante estabelecer técnicas de manejo do stress
- Considerar implementação de pausas regulares
- Monitorar evolução dos padrões

## Estratégias de Melhoria
- [ ] Implementar técnicas de respiração
- [ ] Estabelecer pausas programadas
- [ ] Avaliar carga de trabalho atual

## Histórico de Modificações
- 2025-09-28: Migração para arquivo único (Story 2.2.1)
```

### Benefícios da Consolidação

✅ **Antes**: `contextos/bem-estar/dia-estressante-2025-09-28.md`, `contextos/bem-estar/stress-trabalho-2025-10-01.md`, etc.
✅ **Depois**: `contexto-bem-estar.md` (padrões identificados)

- **Padrões claros** ao longo do tempo
- **Estratégias centralizadas**
- **Evolução visível** do bem-estar

## 🔗 Exemplo: Referências Cruzadas

### Como as Referências Funcionam

```markdown
# Em pessoa-fabio.md
## Projetos Relacionados
- [[projeto-onboarding]] ← Link para projeto-onboarding.md
- [[projeto-assistente-ia]] ← Link para projeto-assistente-ia.md

# Em projeto-onboarding.md
## Pessoas Envolvidas
- [[pessoa-fabio]] ← Link para pessoa-fabio.md

# Em contexto-bem-estar.md
## Pessoas Relacionadas
- [[pessoa-fabio]] ← Se stress relacionado ao trabalho
```

### Navegação no Obsidian

- **Graph View**: Conexões visuais entre entidades
- **Backlinks**: Links automáticos bidirecionais
- **Search**: Busca unificada em arquivos consolidados

## 📊 Casos de Uso Comuns

### 1. Daily-dump Processing

**Entrada:** "Conversei com Fabio sobre o projeto onboarding hoje"

**Processamento Automático:**
1. Detecta `Fabio` → Adiciona em `pessoa-fabio.md`
2. Detecta `onboarding` → Adiciona em `projeto-onboarding.md`
3. Cria referências cruzadas automaticamente

### 2. Revisão de Projeto

**Ação:** Quer ver todo histórico do "Onboarding"
**Resultado:** Abre `projeto-onboarding.md` → Contexto completo

### 3. Análise de Pessoa

**Ação:** Quer entender relacionamento com "Fabio"
**Resultado:** Abre `pessoa-fabio.md` → Histórico completo

### 4. Padrão de Bem-estar

**Ação:** Quer identificar gatilhos de stress
**Resultado:** Abre `contexto-bem-estar.md` → Padrões identificados

## 🎯 Benefícios TDAH-Específicos

### Redução de Sobrecarga Cognitiva
- **Antes**: 15 arquivos separados para uma pessoa
- **Depois**: 1 arquivo com contexto completo

### Contexto Preservado
- **Antes**: Informação fragmentada em múltiplos locais
- **Depois**: Timeline única e cronológica

### Navegação Previsível
- **Pessoas**: Sempre `pessoa-{nome}.md`
- **Projetos**: Sempre `projeto-{nome}.md`
- **Contextos**: Sempre `contexto-{tema}.md`

### Performance Otimizada
- **Menos arquivos** para indexar e buscar
- **Carregamento mais rápido** no Obsidian
- **Busca mais eficiente** com conteúdo consolidado

## 🛠️ Templates Funcionais

### Template: Nova Pessoa

```markdown
# {Nome} - Pessoa

## Metadados
```yaml
tipo: pessoa
nome: {Nome}
tags: [pessoa]
created: {YYYY-MM-DD}
updated: {YYYY-MM-DD}
```

## Histórico de Interações
### {YYYY-MM-DD} - Primeira Menção
[Conteúdo da primeira menção]

## Projetos Relacionados
- [A definir]

## Notas e Contexto
[Observações iniciais]
```

### Template: Novo Projeto

```markdown
# {Nome} - Projeto

## Metadados
```yaml
tipo: projeto
nome: {Nome}
tags: [projeto]
created: {YYYY-MM-DD}
updated: {YYYY-MM-DD}
```

## Status e Progresso
**Status**: Em definição

## Histórico de Desenvolvimento
### {YYYY-MM-DD} - Projeto Iniciado
[Contexto inicial do projeto]

## Pessoas Envolvidas
- [A definir]

## Decisões Técnicas
[Decisões conforme surgem]
```

### Template: Novo Contexto

```markdown
# {Tema} - Contexto

## Metadados
```yaml
tipo: contexto
nome: {Tema}
tags: [contexto]
created: {YYYY-MM-DD}
updated: {YYYY-MM-DD}
```

## Entradas
### {YYYY-MM-DD} - Primeira Entrada
[Conteúdo da primeira entrada]

## Padrões Identificados
[Padrões conforme emergem]

## Notas e Reflexões
[Insights e observações]
```

## ✅ Validação dos Exemplos

Todos os exemplos neste documento foram testados e validados:

- ✅ **Estrutura YAML**: Válida e parseável
- ✅ **Referências [[]]**: Funcionam no Obsidian
- ✅ **Templates**: Testados com dados reais
- ✅ **Navigation**: Graph view e backlinks funcionais
- ✅ **Search**: Busca unificada operacional

## 🚀 Próximos Passos

Esta estrutura unificada serve como base para:

- **Story 2.2.2**: Sistema de consolidação automática
- **Story 2.2.3**: Otimização de performance
- **Futuras integrações**: APIs e automações

---

*Documento criado como parte da Story 2.2.4 - Atualização de Documentação Arquitetural*