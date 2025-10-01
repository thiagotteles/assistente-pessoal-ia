# Métodos de Elicitação para Processamento de Despejo

## Visão Geral
Este documento define os 9 métodos de elicitação utilizados pelo Agente Organizador para extrair informações específicas do daily-dump.md através de perguntas inteligentes.

## Método 1: Detecção de Contexto de Pessoas
**Objetivo**: Identificar pessoas mencionadas e suas relações
**Padrões detectados**: Nomes próprios, referências a colegas, contatos
**Perguntas tipo**:
- "Você mencionou [[Nome]]. Essa pessoa está relacionada a que projeto?"
- "Qual é o contexto da sua interação com [[Nome]]?"
- "Essa informação sobre [[Nome]] deve ser registrada como decisão, reunião ou contexto?"

## Método 2: Identificação de Projetos e Iniciativas
**Objetivo**: Categorizar informações por projeto
**Padrões detectados**: Nomes de projetos, sistemas, iniciativas
**Perguntas tipo**:
- "O item sobre [[Projeto]] é uma nova informação ou atualização?"
- "Essa decisão afeta outros projetos além do [[Projeto]]?"
- "Qual o status atual do [[Projeto]] após essa informação?"

## Método 3: Extração de Tarefas e Ações
**Objetivo**: Identificar todos pendentes e ações necessárias
**Padrões detectados**: Verbos de ação, palavras como "fazer", "implementar", "conversar"
**Perguntas tipo**:
- "A ação '{ação}' tem prazo específico?"
- "Essa tarefa depende de outra pessoa ou você pode fazer sozinho?"
- "Qual a prioridade desta ação: alta, média ou baixa?"

## Método 4: Classificação de Decisões Técnicas
**Objetivo**: Identificar e categorizar decisões arquiteturais/técnicas
**Padrões detectados**: Linguagem técnica, menções a tecnologias, arquitetura
**Perguntas tipo**:
- "Essa decisão técnica afeta a arquitetura geral do sistema?"
- "Há alternativas consideradas que devemos documentar?"
- "Essa decisão precisa ser comunicada para outros membros da equipe?"

## Método 5: Detecção de Estados Emocionais (TDAH-específico)
**Objetivo**: Identificar padrões de humor, energia e overwhelm
**Padrões detectados**: Linguagem emocional, sinais de stress, procrastinação
**Perguntas tipo**:
- "Você está se sentindo sobrecarregado com essa situação?"
- "Essa informação indica alguma dificuldade que precisa de suporte?"
- "Há padrões aqui que eu deveria ajudar você a monitorar?"

## Método 6: Categorização por Urgência e Impacto
**Objetivo**: Priorizar informações por urgência e impacto
**Padrões detectados**: Palavras de urgência, deadlines, consequências
**Perguntas tipo**:
- "Isso precisa de ação imediata ou pode ser agendado?"
- "Qual o impacto se essa informação não for processada rapidamente?"
- "Há dependências que tornam isso mais urgente?"

## Método 7: Identificação de Padrões Recorrentes
**Objetivo**: Detectar informações repetitivas ou padrões comportamentais
**Padrões detectados**: Temas recorrentes, problemas similares
**Perguntas tipo**:
- "Isso parece similar ao que discutimos sobre [[item anterior]]?"
- "Esse tipo de situação está se repetindo? Devemos criar um processo?"
- "Há uma decisão padrão que podemos aplicar aqui?"

## Método 8: Extração de Contexto Temporal
**Objetivo**: Estabelecer timeline e sequência de eventos
**Padrões detectados**: Referências temporais, sequências, deadlines
**Perguntas tipo**:
- "Quando isso precisa estar completo?"
- "Essa informação se refere a algo que já aconteceu ou vai acontecer?"
- "Há uma sequência específica que devemos seguir?"

## Método 9: Validação de Completude
**Objetivo**: Garantir que todas as informações foram capturadas
**Padrões detectados**: Informações incompletas, referências vagas
**Perguntas tipo**:
- "Há mais detalhes sobre isso que devemos capturar?"
- "Essa informação está completa ou há partes em falta?"
- "Preciso de mais contexto para categorizar isso adequadamente?"

## Configuração de Aplicação

### Ordem de Aplicação
1. Método 5 (Estados Emocionais) - Prioridade para bem-estar TDAH
2. Método 6 (Urgência/Impacto) - Identificar itens críticos
3. Método 2 (Projetos) - Contextualização
4. Método 1 (Pessoas) - Relacionamentos
5. Método 3 (Tarefas) - Ações específicas
6. Método 4 (Decisões Técnicas) - Documentação
7. Método 8 (Contexto Temporal) - Timeline
8. Método 7 (Padrões) - Otimização
9. Método 9 (Completude) - Validação final

### Limites de Perguntas
- Máximo 3 perguntas por entrada de despejo
- Priorizar perguntas que afetam categorização
- Evitar perguntas redundantes se informação já está clara

### Personalização por Usuário
- Adaptar linguagem com base no histórico
- Reduzir perguntas sobre padrões já estabelecidos
- Aumentar detalhamento em áreas de dificuldade do usuário