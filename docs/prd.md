# Assistente Pessoal IA - Documento de Requisitos de Produto (PRD)

## Objetivos e Contexto de Fundo

### Objetivos

• Criar um "segundo cérebro" pessoal composto por agentes especializados que compensa limitações de memória TDAH através de captura ultra-rápida e organização inteligente
• Implementar múltiplos agentes com personalidades confrontadoras distintas (`/organizador`, `/secretaria`, `/arquiteto`) via slash commands no Claude Code
• Estabelecer knowledge-base compartilhada inteligente que elimina duplicação e permite acesso cruzado contextual entre agentes
• Resolver problema crítico de "esquecimento" através de sistema reativo disponível 24/7 com especialização técnica
• Integrar completamente vida pessoal e profissional em ecossistema evolutivo único

### Contexto de Fundo

Profissionais com TDAH, especialmente arquitetos de software, enfrentam desafio fundamental: processamento rápido combinado com limitações significativas de memória. Isso resulta em esquecimento de decisões importantes, procrastinação em sistemas organizacionais complexos, e falta de continuidade contextual.

Soluções existentes falham porque assistentes genéricos não oferecem especialização técnica, sistemas de notas exigem organização manual excessiva, e terapeutas/coaches não têm disponibilidade 24/7 nem contexto técnico completo. O sistema proposto oferece "cérebro externo compartilhado" com agentes reativos especializados, personalidades confrontadoras, e otimização específica para TDAH.

### Log de Mudanças

| Data | Versão | Descrição | Autor |
|------|---------|-----------|-------|
| 2025-01-09 | 1.0 | Criação inicial do PRD baseado em brief e brainstorming | John (PM) |

## Requisitos

### Funcionais

1. **FR1:** Sistema deve implementar captura ultra-rápida via arquivo despejo único (`daily-dump.md`) sem estrutura obrigatória
2. **FR2:** Agente `/organizador` deve processar despejo através de perguntas específicas e categorizar automaticamente na knowledge-base
3. **FR3:** Agente `/secretaria` deve oferecer gestão executiva completa: agenda, status de projetos, lembretes, registro de reuniões
4. **FR4:** Agente `/arquiteto` deve funcionar como "braço direito" técnico com memória contextual profunda e questionamento confrontador
5. **FR5:** Sistema deve manter knowledge-base compartilhada única com acesso cruzado automático entre agentes
6. **FR6:** Cada agente deve ter personalidade confrontadora específica que questiona construtivamente ao invés de validar automaticamente
7. **FR7:** Sistema deve funcionar via slash commands no Claude Code seguindo padrão BMAD familiar
8. **FR8:** Agentes devem compartilhar contexto relevante automaticamente sem duplicação de informações
9. **FR9:** Sistema deve registrar e processar transcrições de reuniões gerando resumos estruturados e todos automáticos
10. **FR10:** Todos os dados devem ser human-readable em formato Markdown/YAML para transparência total

### Não-Funcionais

1. **NFR1:** Resposta de agentes deve ser inferior a 3 segundos para manter fluxo TDAH
2. **NFR2:** Sistema deve funcionar 100% localmente via Claude Code (privacidade total)
3. **NFR3:** Captura de informações deve ter ZERO fricção - sem preenchimento obrigatório
4. **NFR4:** Knowledge-base deve ser pesquisável e recuperável em menos de 1 segundo
5. **NFR5:** Sistema deve suportar uso diário por 365 dias sem degradação de performance
6. **NFR6:** Todos os arquivos devem ser versionáveis via Git para backup seguro
7. **NFR7:** Interface deve ser anti-procrastinação: modelo reativo (usuário chama quando quer)
8. **NFR8:** Agentes devem manter consistência de personalidade ao longo do tempo
9. **NFR9:** Sistema deve escalar knowledge-base sem impacto perceptível na velocidade
10. **NFR10:** Processamento de despejo diário deve completar em menos de 30 segundos

## Objetivos de Design de Interface do Usuário

### Visão Geral de UX

Interface exclusivamente via slash commands no Claude Code, otimizada para velocidade e ausência de fricção. Cada agente oferece menu de funcionalidades específicas + conversa livre sempre disponível. Design anti-procrastinação com modelo reativo - usuário chama agentes quando precisa, sem interrupções proativas.

### Paradigmas de Interação Principais

- **Slash Commands**: `/organizador`, `/secretaria`, `/arquiteto` como pontos de entrada
- **Menu + Conversa Livre**: Funcionalidades estruturadas + discussão aberta sempre disponível
- **Personalidades Confrontadoras**: Agentes questionam e desafiam construtivamente
- **Captura Ultra-Rápida**: Arquivo despejo sem estrutura obrigatória
- **Modelo Reativo**: Zero proatividade intrusiva do sistema

### Telas e Visualizações Principais

- **Claude Code Interface**: Único ponto de interação via chat
- **Arquivo Despejo**: `daily-dump.md` para captura rápida
- **Knowledge-base**: Estrutura de arquivos Markdown organizados automaticamente
- **Menu de Agentes**: Lista de funcionalidades específicas por comando
- **Conversação Contextual**: Histórico mantido por agente

### Acessibilidade: N/A

Sistema funciona via Claude Code - acessibilidade gerenciada pela plataforma host.

### Branding

Personalidades confrontadoras distintas por agente. Organizador = processador eficiente, Secretária = gestora proativa, Arquiteto = consultor técnico direto. Sem elementos visuais - foco total na personalidade conversacional e eficácia funcional.

### Plataformas-Alvo: Claude Code

Sistema funciona exclusivamente via Claude Code desktop, aproveitando subscription existente do usuário.

## Premissas Técnicas

### Estrutura do Repositório: Monorepo

Repositório único contendo:
- `.bmad-core/` para configurações de agentes
- `despejo/`, `knowledge-base/`, `todos/`, `diario/` como estrutura base
- Documentação e templates

### Arquitetura de Serviços

**DECISÃO CRÍTICA - Arquitetura Baseada em Slash Commands + Arquivos Locais**

Sistema composto por:
- **Claude Code** como plataforma de IA (subscription existente)
- **Slash Commands** como interface de agentes especializados
- **Arquivos locais** (Markdown/YAML/JSON) como persistência
- **Knowledge-base compartilhada** como camada inteligente central

### Requisitos de Testes

**DECISÃO CRÍTICA - Validação por Uso Real + Backup via Git**

Estratégia focada em:
- Uso diário como teste primário de funcionalidade
- Git para versionamento e recovery de dados
- Validação de personalidades através de interações reais

### Premissas e Solicitações Técnicas Adicionais

**Estrutura de Arquivos Completa:**
```
c:/repos/assistente-pessoal-ia/
├── .bmad-core/                    # Configurações dos Agentes
│   ├── agents/
│   │   ├── organizador.yaml       # Configuração do /organizador
│   │   ├── secretaria.yaml        # Configuração do /secretaria
│   │   └── arquiteto.yaml         # Configuração do /arquiteto
│   ├── templates/
│   └── core-config.yaml           # Config principal
├── despejo/
│   └── daily-dump.md             # Arquivo único para despejo rápido
├── knowledge-base/                # Base Inteligente Compartilhada
│   ├── decisoes/                  # Decisões técnicas e pessoais
│   ├── contextos/                 # Contextos de reuniões
│   ├── projetos/                  # Por projeto específico
│   └── pessoas/                   # Contexto sobre pessoas
├── todos/
│   └── central-todos.md           # Todos centralizados
└── diario/                        # Diários estruturados
    ├── 2025-09-25-diario.md
    └── ...
```

**Tecnologias:**
- **Claude Code** - Interface e processamento de IA
- **Markdown/YAML** - Armazenamento human-readable
- **Git** - Versionamento e backup
- **Sistema de arquivos local** - Persistência simples

## Lista de Épicos

### Épicos Propostos

**Epic 1: Fundação & Sistema de Captura Ultra-Rápida**
Estabelecer infraestrutura Claude Code com slash commands base, arquivo despejo único, e estrutura de knowledge-base compartilhada.

**Epic 2: Agente Organizador Inteligente**
Implementar `/organizador` que processa despejo através de perguntas específicas e categoriza automaticamente na knowledge-base inteligente.

**Epic 3: Agente Secretária Digital Executiva**
Desenvolver `/secretaria` para gestão completa: agenda, status de projetos, lembretes, e registro inteligente de reuniões com extração automática de todos.

**Epic 4: Agente Arquiteto Confrontador**
Criar `/arquiteto` como "braço direito" técnico com personalidade confrontadora, memória contextual profunda, e questionamento construtivo de decisões arquiteturais.

## Epic 1: Fundação & Sistema de Captura Ultra-Rápida

**Objetivo do Épico:** Estabelecer infraestrutura Claude Code com slash commands base, arquivo despejo único para captura sem fricção, e estrutura de knowledge-base compartilhada que serve como fundação para todos os agentes especializados.

### Story 1.1: Estrutura de Arquivos Base

Como um usuário com TDAH,
Eu quero uma estrutura de arquivos simples e intuitiva,
Para que eu possa começar a usar o sistema imediatamente sem configuração complexa.

#### Critérios de Aceitação

1. Criação automática da estrutura de pastas: `.bmad-core/`, `despejo/`, `knowledge-base/`, `todos/`, `diario/`
2. Arquivo `daily-dump.md` criado e acessível para escrita imediata
3. Arquivo de configuração `core-config.yaml` inicializado com settings padrão
4. Estrutura `knowledge-base/` com subpastas: `decisoes/`, `contextos/`, `projetos/`, `pessoas/`
5. Sistema funciona imediatamente após clone do repositório sem steps adicionais

### Story 1.2: Sistema de Captura Ultra-Rápida

Como um profissional com processamento rápido mas memória limitada,
Eu quero jogar qualquer informação em um arquivo sem estrutura obrigatória,
Para que eu nunca perca insights importantes por falta de tempo para organizar.

#### Critérios de Aceitação

1. Arquivo `despejo/daily-dump.md` aceita qualquer formato de texto sem validação
2. Não há campos obrigatórios ou estrutura pré-definida necessária
3. Arquivo é acessível diretamente pelo Claude Code sem navegação complexa
4. Timestamps automáticos podem ser adicionados opcionalmente
5. Sistema suporta adição de múltiplas entradas por dia sem conflito

### Story 1.3: Comando Slash Base

Como um usuário familiarizado com BMAD,
Eu quero comandos slash funcionais que sigam o mesmo padrão,
Para que eu possa usar minha experiência existente sem curva de aprendizado.

#### Critérios de Aceitação

1. Comando `/organizador` responde com menu de funcionalidades
2. Sistema reconhece comandos slash via configuração `.bmad-core/`
3. Cada comando mostra personalidade distinta já no primeiro uso
4. Menu de opções + conversa livre sempre disponível após carregar comando
5. Comandos funcionam independentemente uns dos outros

### Story 1.4: Knowledge-Base Compartilhada Básica

Como um usuário que precisa de contexto histórico,
Eu quero que informações sejam salvas de forma inteligente e pesquisável,
Para que agentes diferentes possam acessar contexto relevante automaticamente.

#### Critérios de Aceitação

1. Sistema cria arquivos `.md` organizados automaticamente por categoria
2. Informações são human-readable em formato Markdown padrão
3. Metadados básicos (data, fonte, categoria) são adicionados automaticamente
4. Arquivos podem ser lidos diretamente pelo Claude Code sem ferramentas especiais
5. Estrutura suporta crescimento orgânico sem reorganização manual

## Epic 2: Agente Organizador Inteligente

**Objetivo do Épico:** Implementar `/organizador` que processa o arquivo despejo através de perguntas específicas e inteligentes, categorizando automaticamente informações na knowledge-base compartilhada e eliminando a necessidade de organização manual.

### Story 2.1: Processamento do Despejo via Perguntas

Como um usuário com TDAH que esquece contexto,
Eu quero que o organizador faça perguntas específicas sobre meus despejos,
Para que informações sejam categorizadas sem esforço mental da minha parte.

#### Critérios de Aceitação

1. Organizador lê `daily-dump.md` e identifica entradas sem categorização
2. Faz perguntas específicas como "Bounded contexts te confundiu, qual sua dúvida específica?"
3. Cada resposta é imediatamente categorizada na knowledge-base apropriada
4. Não exige processamento de todo o arquivo de uma vez - funciona incrementalmente
5. Mantém histórico do que já foi processado para evitar repetição

### Story 2.2: Categorização Automática Inteligente

Como um usuário que odeia organização manual,
Eu quero que o organizador decida onde salvar informações baseado no contexto,
Para que eu nunca precise pensar em estrutura de pastas ou categorias.

#### Critérios de Aceitação

1. Identifica automaticamente se informação é: decisão técnica, contexto de reunião, insight pessoal, ou projeto específico
2. Salva na estrutura correta da knowledge-base sem input adicional do usuário
3. Cria novas categorias automaticamente quando necessário
4. Adiciona tags e metadados relevantes para recuperação futura
5. Evita duplicação - detecta informações similares já existentes

### Story 2.3: Menu de Funcionalidades do Organizador

Como um usuário que precisa de diferentes tipos de processamento,
Eu quero opções específicas além do processamento automático,
Para que eu possa usar o organizador de formas variadas conforme a necessidade.

#### Critérios de Aceitação

1. Menu inclui: "processar despejo", "organizar por projeto", "revisar pendências"
2. Cada opção tem comportamento específico e eficiente
3. Conversa livre sempre disponível para discussão sobre organização
4. Organizador mantém contexto da sessão para referências cruzadas
5. Pode processar inputs específicos fora do arquivo despejo quando solicitado

### Story 2.4: Integração com Central de Todos

Como um usuário que precisa acompanhar pendências,
Eu quero que o organizador identifique e extraia todos automaticamente,
Para que nada importante seja esquecido ou perdido.

#### Critérios de Aceitação

1. Identifica automaticamente ações necessárias em texto livre
2. Adiciona todos extraídos em `central-todos.md` com contexto
3. Associa todos ao projeto ou contexto de origem automaticamente
4. Marca prioridade baseada em linguagem usada no despejo original
5. Permite validação rápida antes de salvar todos definitivamente

## Epic 3: Agente Secretária Digital Executiva

**Objetivo do Épico:** Desenvolver `/secretaria` para gestão executiva completa incluindo agenda do dia, status de projetos, lembretes pendentes, e registro inteligente de reuniões com processamento automático de transcrições para resumos estruturados e extração de todos.

### Story 3.1: Gestão de Agenda e Status Diário

Como um profissional que esquece compromissos e perde contexto,
Eu quero uma visão executiva do meu dia e projetos ativos,
Para que eu sempre saiba o que precisa da minha atenção imediata.

#### Critérios de Aceitação

1. Comando "agenda do dia" mostra compromissos, deadlines e prioridades
2. "Status de projetos" apresenta situação atual de todos os projetos ativos
3. "Lembretes pendentes" lista ações que precisam ser tomadas
4. Informações são atualizadas automaticamente baseadas na knowledge-base
5. Interface permite atualização rápida de status sem navegação complexa

### Story 3.2: Cadastro Ativo de Projetos

Como um arquiteto de software com múltiplos projetos,
Eu quero que a secretária mantenha contexto atualizado de cada projeto,
Para que eu nunca perca informações críticas sobre status e próximos passos.

#### Critérios de Aceitação

1. Permite cadastro rápido de novos projetos com contexto mínimo necessário
2. Mantém status tracking automático baseado em atividades registradas
3. Identifica projetos inativos e questiona sobre continuidade
4. Associa automaticamente novas informações aos projetos relevantes
5. Gera resumos de projeto sob demanda para recuperação de contexto

### Story 3.3: Registro Inteligente de Reuniões

Como um profissional que participa de muitas reuniões,
Eu quero colar transcrição e receber resumo estruturado com todos extraídos,
Para que eu nunca perca decisões importantes ou ações definidas.

#### Critérios de Aceitação

1. Aceita transcrição completa de reunião sem formatação prévia
2. Gera automaticamente resumo estruturado com decisões, participantes, tópicos
3. Extrai todos automáticos identificando responsáveis e prazos quando mencionados
4. Salva contexto na knowledge-base associado aos projetos e pessoas relevantes
5. Adiciona todos extraídos no sistema central com referência à reunião origem

### Story 3.4: Funcionalidades Executivas Avançadas

Como um usuário que precisa de suporte executivo completo,
Eu quero funcionalidades que me ajudem a ser mais eficiente e organizado,
Para que a secretária funcione como verdadeira assistente executiva.

#### Critérios de Aceitação

1. "What's next?" sugere próximas ações baseadas em contexto atual
2. Detecta conflitos de agenda e deadlines automaticamente
3. Sugere priorização quando há sobrecarga de tarefas
4. Mantém histórico de decisões para evitar re-trabalho
5. Personalidade proativa mas não intrusiva - responde quando chamada

## Epic 4: Agente Arquiteto Confrontador

**Objetivo do Épico:** Criar `/arquiteto` como "braço direito" técnico especializado com personalidade confrontadora direta, memória contextual profunda de projetos e decisões, e capacidade de questionamento construtivo que acelera qualidade de decisões arquiteturais.

### Story 4.1: Consultoria Técnica com Memória Contextual

Como um arquiteto de software que toma muitas decisões técnicas,
Eu quero um consultor que conheça meu histórico e questione minhas escolhas,
Para que eu tome decisões arquiteturais mais consistentes e bem fundamentadas.

#### Critérios de Aceitação

1. Mantém memória de todas as decisões arquiteturais anteriores do usuário
2. Contextualiza novas discussões com decisões passadas relevantes
3. Questiona inconsistências: "Você escolheu X antes por Y, por que Z agora?"
4. Acessa automaticamente contexto de projetos para discussões técnicas
5. Personalidade direta que confronta tecnicamente sem ser pessoal

### Story 4.2: Análise de Projetos com Confronto Construtivo

Como um desenvolvedor que às vezes toma decisões apressadas,
Eu quero um arquiteto que desafie minhas escolhas tecnicamente,
Para que eu considere aspectos que posso ter negligenciado.

#### Critérios de Aceitação

1. Analisa URLs de projetos e código fornecido com olhar crítico técnico
2. Identifica possíveis problemas de performance, escalabilidade, manutenção
3. Questiona ativamente: "Por que não considerou X?", "E se Y acontecer?"
4. Oferece alternativas técnicas com pros/cons claramente explicados
5. Mantém foco em qualidade arquitetural sem ser condescendente

### Story 4.3: Discussão Técnica Especializada

Como um arquiteto que precisa de discussão técnica de alto nível,
Eu quero conversar sobre padrões, tecnologias e decisões arquiteturais,
Para que eu tenha um par técnico disponível 24/7 para validação de ideias.

#### Critérios de Aceitação

1. Demonstra conhecimento profundo de padrões arquiteturais modernos
2. Discussões técnicas referenciam automaticamente contexto de projetos do usuário
3. Sugere recursos, artigos, e ferramentas relevantes para problemas específicos
4. Questiona premissas técnicas: "Você tem certeza que microserviços são necessários aqui?"
5. Personalidade que desafia construtivamente para elevar nível técnico

### Story 4.4: Integração com Knowledge-Base Técnica

Como um usuário que acumula conhecimento técnico ao longo do tempo,
Eu quero que o arquiteto use todo meu histórico para dar conselhos melhores,
Para que as consultorias sejam cada vez mais personalizadas e eficazes.

#### Critérios de Aceitação

1. Acessa automaticamente decisões técnicas passadas para contexto
2. Identifica padrões nas escolhas arquiteturais do usuário
3. Sugere melhorias baseadas em aprendizados de projetos anteriores
4. Mantém lista de preferências técnicas do usuário (ex: "Performance é crítico")
5. Evolui recomendações baseadas em feedback e resultados de decisões passadas

## Resultados do Checklist

<function_calls>
<invoke name="Read">
<parameter name="file_path">c:\repos\assistente-pessoal-ia\.bmad-core\checklists\pm-checklist.md