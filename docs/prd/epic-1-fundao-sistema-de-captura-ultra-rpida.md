# Epic 1: Fundação & Sistema de Captura Ultra-Rápida

**Objetivo do Épico:** Estabelecer infraestrutura Claude Code com slash commands para todos os 5 agentes, arquivo despejo único para captura sem fricção, e estrutura de knowledge-base compartilhada totalmente integrada com Obsidian, usando a foundation do Epic 0.

## Story 1.1: Estrutura de Arquivos Base

Como um usuário com TDAH,
Eu quero uma estrutura de arquivos simples e intuitiva,
Para que eu possa começar a usar o sistema imediatamente sem configuração complexa.

### Critérios de Aceitação

1. Usar estrutura criada pelo Epic 0 setup automático
2. Integração completa com Obsidian configurada automaticamente
3. Git hooks para backup automático ativados
4. Arquivo `daily-dump.txt` funcional com acesso direto
5. Sistema de [[referências]] Obsidian funcionando com cross-links automáticos

## Story 1.2: Sistema de Captura Ultra-Rápida

Como um profissional com processamento rápido mas memória limitada,
Eu quero jogar qualquer informação em um arquivo sem estrutura obrigatória,
Para que eu nunca perca insights importantes por falta de tempo para organizar.

### Critérios de Aceitação

1. Arquivo `despejo/daily-dump.txt` aceita qualquer formato de texto sem validação
2. Não há campos obrigatórios ou estrutura pré-definida necessária
3. Arquivo é acessível diretamente pelo Claude Code sem navegação complexa
4. Timestamps automáticos podem ser adicionados opcionalmente
5. Sistema suporta adição de múltiplas entradas por dia sem conflito

## Story 1.3: Comando Slash Base

Como um usuário familiarizado com BMAD,
Eu quero comandos slash funcionais que sigam o mesmo padrão,
Para que eu possa usar minha experiência existente sem curva de aprendizado.

### Critérios de Aceitação

1. Todos os 5 comandos `/organizador`, `/secretaria`, `/arquiteto`, `/psicologo`, `/mentor` funcionais
2. Sistema de roteamento inteligente entre agentes implementado
3. Personalidades carregadas automaticamente via Agent Memory System (Epic 0)
4. Comando `/status` mostra saúde de todo sistema e agentes disponíveis
5. Cross-referencing automático entre agentes para evitar duplicação

## Story 1.4: Knowledge-Base Compartilhada Básica

Como um usuário que precisa de contexto histórico,
Eu quero que informações sejam salvas de forma inteligente e pesquisável,
Para que agentes diferentes possam acessar contexto relevante automaticamente.

### Critérios de Aceitação

1. Usar Knowledge-Base Manager do Epic 0 para persistência automática
2. Sistema completo de [[referências]] Obsidian com auto-linking
3. Auto-splitting de arquivos grandes para manter performance
4. Cross-referencing automático entre informações relacionadas
5. Integração completa com Obsidian para visualização em graph view
