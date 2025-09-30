# Task: Análise de Humor e Energia

## Configuração
```yaml
elicit: true
language: portuguese
interaction_style: empathetic
requires_daily_dump: true
```

## Propósito
Analisar indicadores emocionais no daily-dump.txt para tracking de humor, energia e padrões emocionais ao longo do tempo.

## Workflow

### Etapa 1: Carregar Contexto
1. Ler `despejo/daily-dump.txt`
2. Carregar `.assistant-core/memory/psicologo-memory.yaml` para padrões históricos
3. Verificar `knowledge-base/contextos/contexto-bem-estar.md` para histórico emocional

### Etapa 2: Análise de Indicadores Emocionais

Detectar palavras e frases indicativas de:

**Estresse:**
- "estressado", "tenso", "pressionado", "sobrecarregado"
- "não aguento", "é demais", "não consigo"

**Ansiedade:**
- "preocupado", "ansioso", "nervoso", "inquieto"
- "e se", "medo de", "apreensivo"

**Cansaço/Exaustão:**
- "cansado", "exausto", "sem energia", "esgotado"
- "não durmo", "insônia", "acordei cedo demais"

**Sobrecarga:**
- "muito trabalho", "mil coisas", "não dou conta"
- Múltiplas menções de projetos/tarefas diferentes

**Positividade:**
- "animado", "motivado", "bem", "feliz"
- "consegui", "funcionou", "orgulhoso"

### Etapa 3: Identificação de Padrões

1. **Energia:** 1-10 (inferir do tom geral e palavras-chave)
2. **Humor:** 1-10 (inferir do sentimento predominante)
3. **Gatilhos:** Situações/pessoas/eventos mencionados junto com indicadores negativos
4. **Ciclos:** Comparar com análises anteriores para detectar tendências

### Etapa 4: Apresentar Insights

Formato conversacional empático:

```
Olá [nome]! Analisei seu daily-dump de hoje. Aqui está o que percebo:

**Humor atual:** [descrição empática]
**Energia:** [nível] - [contexto]
**Padrões detectados:** [se houver]
**Gatilhos identificados:** [se houver]

[Validação emocional específica ao contexto]

[Se apropriado: sugestão de técnica ou micro-passo]

Como está se sentindo sobre isso?
```

### Etapa 5: Atualizar Memória

Adicionar à `psicologo-memory.yaml`:
- Palavras-chave detectadas
- Níveis de humor/energia
- Gatilhos identificados
- Data da análise

### Etapa 6: Cross-Agent Intelligence

Se detectar:
- **Sobrecarga severa:** Compartilhar com Secretária (agenda) e Organizador (todos)
- **Estresse técnico:** Compartilhar com Arquiteto
- **Padrões crônicos:** Registrar em contexto-bem-estar.md

## Outputs
- Análise conversacional empática apresentada ao usuário
- Memória atualizada com novos padrões
- Knowledge-base atualizada se necessário
- Alertas cross-agent se apropriado