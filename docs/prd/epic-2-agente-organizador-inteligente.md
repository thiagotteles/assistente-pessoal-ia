# Epic 2: Agente Organizador Inteligente

**Objetivo do Épico:** Implementar `/organizador` que processa o arquivo despejo através de perguntas específicas e inteligentes, categorizando automaticamente informações na knowledge-base compartilhada e eliminando a necessidade de organização manual.

## Story 2.1: Processamento do Despejo via Perguntas

Como um usuário com TDAH que esquece contexto,
Eu quero que o organizador faça perguntas específicas sobre meus despejos,
Para que informações sejam categorizadas sem esforço mental da minha parte.

### Critérios de Aceitação

1. Organizador lê `daily-dump.txt` e identifica entradas sem categorização
2. Faz perguntas específicas como "Bounded contexts te confundiu, qual sua dúvida específica?"
3. Cada resposta é imediatamente categorizada na knowledge-base apropriada
4. Não exige processamento de todo o arquivo de uma vez - funciona incrementalmente
5. Mantém histórico do que já foi processado para evitar repetição

## Story 2.2: Categorização Automática Inteligente

Como um usuário que odeia organização manual,
Eu quero que o organizador decida onde salvar informações baseado no contexto,
Para que eu nunca precise pensar em estrutura de pastas ou categorias.

### Critérios de Aceitação

1. Identifica automaticamente se informação é: decisão técnica, contexto de reunião, insight pessoal, ou projeto específico
2. Salva na estrutura correta da knowledge-base sem input adicional do usuário
3. Cria novas categorias automaticamente quando necessário
4. Adiciona tags e metadados relevantes para recuperação futura
5. Evita duplicação - detecta informações similares já existentes

## Story 2.3: Menu de Funcionalidades do Organizador

Como um usuário que precisa de diferentes tipos de processamento,
Eu quero opções específicas além do processamento automático,
Para que eu possa usar o organizador de formas variadas conforme a necessidade.

### Critérios de Aceitação

1. Menu inclui: "processar despejo", "organizar por projeto", "revisar pendências"
2. Cada opção tem comportamento específico e eficiente
3. Conversa livre sempre disponível para discussão sobre organização
4. Organizador mantém contexto da sessão para referências cruzadas
5. Pode processar inputs específicos fora do arquivo despejo quando solicitado

## Story 2.4: Integração com Central de Todos

Como um usuário que precisa acompanhar pendências,
Eu quero que o organizador identifique e extraia todos automaticamente,
Para que nada importante seja esquecido ou perdido.

### Critérios de Aceitação

1. Identifica automaticamente ações necessárias em texto livre
2. Adiciona todos extraídos em `central-todos.md` com contexto
3. Associa todos ao projeto ou contexto de origem automaticamente
4. Marca prioridade baseada em linguagem usada no despejo original
5. Permite validação rápida antes de salvar todos definitivamente
