# Epic 0: Environment Setup & Foundation

**Objetivo do Épico:** Criar toda a infraestrutura necessária ANTES de implementar os agentes. Instalação automática, Knowledge-Base Manager, Agent Memory System, testes essenciais, e documentação completa para tornar sistema imediatamente usável após clone.

## Story 0.1: Instalação e Configuração Automática

Como um usuário que quer começar a usar o sistema imediatamente,
Eu quero instalar tudo com um comando simples,
Para que eu não precise configurar manualmente dependências complexas.

### Critérios de Aceitação

1. Script `setup.sh` (Linux/Mac) e `setup.bat` (Windows) criam toda estrutura automaticamente
2. Verificação automática de dependências: Claude Code instalado, Obsidian disponível, Git configurado
3. Configuração automática do Obsidian vault com settings otimizados para o sistema
4. Criação de todos os arquivos base com conteúdo inicial funcional
5. Execução de teste básico para validar que instalação funcionou corretamente

## Story 0.2: Knowledge-Base Manager Core

Como um desenvolvedor implementando os agentes,
Eu quero um sistema de persistência funcional disponível,
Para que os agentes possam salvar e recuperar informações desde o primeiro épico.

### Critérios de Aceitação

1. Classe/módulo `KnowledgeBaseManager` implementado com API limpa
2. Métodos essenciais: `salvar_entrada()`, `recuperar_entrada()`, `gerar_referencias_obsidian()`
3. Sistema de metadados YAML automático adicionado a todas as entradas
4. Validação e correção automática de consistência de links [[]]
5. API interna documentada para todos os 5 agentes salvarem dados uniformemente

## Story 0.3: Agent Memory System Foundation

Como um sistema que precisa de agentes com personalidades consistentes,
Eu quero que cada agente mantenha memória e contexto entre interações,
Para que a experiência seja coerente e evolutiva.

### Critérios de Aceitação

1. Templates YAML funcionais para memória de cada um dos 5 agentes específicos
2. Métodos implementados: `carregar_memoria_agente()`, `atualizar_memoria_agente()`
3. Persistência automática de contexto, personalidade, e padrões aprendidos
4. Sistema de reset e backup de memória individual por agente
5. Carregamento automático de memória quando agente é ativado via slash command

## Story 0.4: Framework de Testes Essenciais

Como um desenvolvedor que quer validar que o sistema funciona,
Eu quero testes básicos automatizados sem complexidade excessiva,
Para que eu possa verificar funcionalidade sem overhead desnecessário.

### Critérios de Aceitação

1. Teste básico: cada um dos 5 agentes responde corretamente quando chamado
2. Teste de persistência: knowledge-base salva e recupera dados corretamente
3. Teste de estrutura: todos os arquivos e pastas necessários são criados
4. Script `test-basic.sh` executável que valida instalação completa
5. Testes focados em funcionalidade essencial - sem logs, métricas, ou analytics

## Story 0.5: Documentação Operacional Completa

Como um usuário real que nunca viu o sistema antes,
Eu quero documentação clara e completa,
Para que eu possa instalar, configurar e usar sem suporte técnico.

### Critérios de Aceitação

1. `README.md` com instalação passo-a-passo detalhada e clara
2. Manual de usuário (`USAGE.md`) com exemplos práticos de cada agente
3. Troubleshooting (`TROUBLESHOOTING.md`) cobrindo problemas comuns
4. Guia de backup e recovery (`BACKUP.md`) para proteger dados
5. FAQ sobre integração com Obsidian e configurações recomendadas