# Task: Registro de Reunião - Processamento Inteligente

## Objetivo
Processar transcrições ou textos livres de reuniões, convertendo em resumos estruturados com extração automática de todos, identificação de participantes e criação de referências [[]] automáticas.

## Inputs
- Texto livre da reunião (transcrição, notas, áudio transcrito)
- Tipo de reunião (opcional): 1:1, team_meeting, client_meeting, brainstorm, status_update, planning
- Data da reunião (opcional, padrão: hoje)

## Processo de Execução

### 1. Pré-processamento do Texto
- Identificar estrutura narrativa vs pontos específicos
- Detectar padrões de diálogo ("João disse", "Maria mencionou")
- Separar conteúdo factual de opiniões/comentários
- Normalizar formatação e remover ruído desnecessário

### 2. Identificação Automática de Entidades

#### Participantes
- Detectar nomes próprios mencionados no texto
- Identificar padrões: "reunião com X", "X mencionou", "falei com X"
- Criar links automáticos: João → [[pessoa-joao]]
- Validar se pessoa já existe na knowledge-base

#### Projetos
- Identificar menções a projetos: "projeto X", "sistema Y", "iniciativa Z"
- Associar com projetos existentes em knowledge-base/projetos/
- Criar links: Projeto Alpha → [[projeto-alpha]]

#### Contextos
- Detectar temas recorrentes: "performance", "arquitetura", "planning"
- Associar com contextos existentes ou sugerir novos

### 3. Extração de Informações Estruturadas

#### Decisões Tomadas
Identificar padrões como:
- "Decidimos que..."
- "Vamos fazer X porque Y"
- "A decisão foi..."
- "Optamos por..."

Estruturar como: **Decisão** | **Rationale** | **Impacto**

#### Ações Necessárias (Todos)
Detectar ações através de keywords:
- "preciso fazer", "vou", "deve", "tem que"
- "action item", "próximo passo", "tarefa"
- "até [data]", "prazo", "deadline"

Extrair:
- **Ação**: O que fazer
- **Responsável**: Quem vai fazer
- **Prazo**: Quando (se mencionado)

### 4. Geração do Resumo Estruturado

Usar template `reuniao-resumo.yaml` para gerar:

```markdown
# Reunião: [Título extraído/sugerido]

**Data:** [Data]
**Participantes:** [[pessoa-joao]], [[pessoa-maria]]
**Duração:** [Se mencionada]
**Tipo:** [Detectado ou inferido]

## Resumo Executivo
[Síntese dos principais pontos em 2-3 frases]

## Contexto
[Contexto da reunião e background]

## Decisões Tomadas
• **Decisão:** [Descrição] | **Rationale:** [Por quê] | **Impacto:** [Consequências]

## Ações Necessárias
- [ ] [Ação] (Responsável: [[pessoa-nome]], Prazo: [data])
- [ ] [Ação] (Responsável: [[pessoa-nome]], Prazo: TBD)

## Próximos Passos
[Sequência lógica de próximas ações]

## Observações e Notas
[Informações adicionais, insights, preocupações]
```

### 5. Integração Automática com Knowledge-Base

#### Atualização de Pessoas
Para cada pessoa identificada:
- Verificar se existe arquivo `pessoa-[nome].md`
- Se não existir, criar com estrutura padrão
- Adicionar entrada na seção "Histórico de Interações"
- Referenciar a reunião na seção "Projetos Relacionados"

#### Atualização de Projetos
Para cada projeto mencionado:
- Adicionar entrada em "Histórico de Desenvolvimento"
- Atualizar "Pessoas Envolvidas"
- Registrar decisões em "Decisões Técnicas"

#### Central de Todos
- Adicionar todos extraídos em `todos/central-todos.md`
- Categorizar por prioridade baseada no contexto
- Criar todos específicos em `todos/por-projeto/` se aplicável

### 6. Validação e Confirmação

Antes de salvar:
- Mostrar resumo estruturado para validação
- Confirmar pessoas identificadas e links criados
- Validar todos extraídos e responsáveis
- Permitir edições de última hora

## Output
- Arquivo de reunião salvo em `knowledge-base/contextos/contexto-reunioes.md`
- Atualização automática de arquivos pessoa-*.md e projeto-*.md
- Todos adicionados em central-todos.md
- Referências [[]] criadas e validadas

## Configurações TDAH
- Processamento em chunks para evitar overwhelm
- Confirmações simples (sim/não) para validação
- Visual feedback sobre progresso
- Opção de processar "no modo automático" sem muitas perguntas

## Tratamento de Erros
- Se não conseguir identificar participantes, perguntar claramente
- Se texto muito confuso, sugerir re-processamento
- Backup do texto original antes de qualquer processamento