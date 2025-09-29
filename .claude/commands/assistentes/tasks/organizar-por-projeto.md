# Task: Organizar Por Projeto

## Objetivo
Visualizar todas as informações organizadas por contexto de projeto, mostrando decisões, contextos e pessoas relacionadas a cada projeto de forma clara e estruturada.

## Configuração
```yaml
elicit: false
output_format: conversational
language: portuguese
show_timeline: true
```

## Workflow

### Etapa 1: Varredura da Knowledge-Base

1. **Buscar em todas as categorias**:
   - `knowledge-base/projetos/` - informações específicas de projetos
   - `knowledge-base/decisoes/` - decisões técnicas com tag de projeto
   - `knowledge-base/contextos/` - contextos relacionados a projetos
   - `knowledge-base/pessoas/` - pessoas envolvidas em projetos

2. **Identificar projetos ativos**:
   - Extrair nomes de projetos dos metadados YAML
   - Agrupar entradas por projeto
   - Ordenar por última atividade

### Etapa 2: Organização Conversacional

Para cada projeto encontrado, apresentar:

```
## 📁 [Nome do Projeto]

### 📊 Resumo Rápido
- **Última atividade**: [data]
- **Total de entradas**: [X decisões, Y contextos, Z pessoas]
- **Status percebido**: [baseado nos indicadores emocionais das entradas]

### 👥 Pessoas Envolvidas
- [[Pessoa 1]] - [contexto da participação]
- [[Pessoa 2]] - [contexto da participação]

### 🎯 Decisões Importantes
- [Data] - [Título da decisão] → [[link]]
- [Data] - [Título da decisão] → [[link]]

### 💭 Contextos Recentes
- [Data] - [Resumo do contexto] → [[link]]
- [Data] - [Resumo do contexto] → [[link]]

### 📋 Todos Relacionados
- [ ] [Ação pendente] (prioridade: [alta/média/baixa])
- [x] [Ação completada]

### 🧠 Insights do Organizador
[Observações automáticas baseadas nos padrões detectados]
```

### Etapa 3: Insights Inteligentes

Para cada projeto, gerar automaticamente:

1. **Padrões temporais**:
   - Frequência de atividade
   - Períodos de maior/menor atividade
   - Tendências de urgência

2. **Padrões emocionais**:
   - Projetos que geram mais stress
   - Projetos com maior satisfação
   - Indicadores de procrastinação

3. **Padrões de colaboração**:
   - Pessoas mais frequentes
   - Tipo de interações (decisões vs contextos)
   - Necessidades de comunicação

### Etapa 4: Recomendações Personalizadas

Baseado na análise, sugerir:

```
💡 **Recomendações para este projeto**:
- [Sugestão baseada nos padrões]
- [Sugestão de organização]
- [Sugestão de priorização]
```

### Etapa 5: Menu de Ações

Ao final, oferecer opções:

```
O que você gostaria de fazer agora?

1. 🔍 Ver detalhes de um projeto específico
2. 📊 Mostrar estatísticas comparativas
3. 📋 Ver todos pendentes por projeto
4. 🗂️ Reorganizar prioridades
5. ✨ Processar novo despejo
6. 🏠 Voltar ao menu principal
```

## Casos Especiais

### Se não houver projetos
```
"Ainda não identifiquei projetos específicos na sua knowledge-base.

Isso pode acontecer se:
- Você ainda não processou nenhum despejo
- As informações estão todas categorizadas como contextos gerais
- Os projetos estão com nomes que eu não reconheci

Quer que eu:
1. 📝 Processe o daily-dump.txt primeiro
2. 🔍 Busque por padrões de projeto nos contextos existentes
3. 🛠️ Te ajude a definir nomes de projetos manualmente
```

### Se um projeto específico for solicitado
Focar apenas nesse projeto e mostrar:
- Timeline completa de atividades
- Todos os arquivos relacionados
- Pessoas envolvidas com detalhes
- Próximas ações sugeridas

### Para muitos projetos (>10)
- Agrupar por status (ativo, pausado, arquivado)
- Mostrar apenas os 5 mais ativos
- Oferecer filtros por período ou pessoa

## Output Format

Sempre em formato conversacional empático:
- Usar emojis para tornar mais visual
- Linguagem natural em português
- Destacar insights importantes
- Oferecer ações práticas
- Manter tom positivo e organizador