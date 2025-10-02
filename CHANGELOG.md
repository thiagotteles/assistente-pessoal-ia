# Changelog - Assistente Pessoal IA

Todas as mudanças importantes do projeto serão documentadas aqui.

## [3.0.0] - Epic 3: Experiência de Sucesso - 2025-10-01

### Epic 3.0: Upgrade Path para Usuários Existentes ✅

#### Adicionado
- **Sistema de Upgrade Não-Destrutivo**
  - Script `scripts/upgrade-to-epic3.sh` para Linux/Mac/Git Bash
  - Script `scripts/upgrade-to-epic3.bat` para Windows
  - Backup automático pré-upgrade (ZIP + Git)
  - Validação pós-upgrade com checklist automático
  - Tempo de upgrade: < 30 segundos

- **Novos Arquivos Epic 3**
  - `knowledge-base/BEM-VINDO.md` - Tutorial interativo completo
  - `knowledge-base/🏠 INÍCIO.md` - Dashboard visual com links principais
  - `knowledge-base/COMO-BUSCAR.md` - Guia de busca no Obsidian
  - `knowledge-base/OBSIDIAN-EM-5-MINUTOS.md` - Tutorial Obsidian rápido
  - `knowledge-base/ATALHOS-OBSIDIAN.md` - Referência de atalhos
  - `MEU-PROGRESSO.md` - Checklist primeira semana
  - `📈 MEU-DASHBOARD.md` - Dashboard executivo pessoal
  - `todos/PROGRESSO-VISUAL.md` - Barras de progresso Unicode
  - `.version` - Arquivo de versão (Epic 3.0)

- **Sistema de Cache e Dados**
  - `.assistant-core/data/dashboard-cache.yaml` - Cache de estatísticas
  - Estrutura de contadores para performance
  - Event-driven updates (não polling)

- **Scripts de Backup e Recovery**
  - `RECUPERAR-BACKUP.sh` / `.bat` - Recovery Git com 1 clique
  - `EXPORTAR-TUDO.sh` / `.bat` - Export manual para backup externo
  - `ULTIMA-EXPORTACAO.txt` - Timestamp de último export

- **Configurações Obsidian Epic 3**
  - Script `scripts/merge-obsidian-config.sh` / `.bat`
  - Novos hotkeys (Ctrl+O, Ctrl+Shift+G, Ctrl+E, etc.)
  - Templates de projeto, pessoa, decisão, contexto
  - Workspace padrão (abre 🏠 INÍCIO.md por padrão)
  - Backup automático de configs antigas

- **Patches de Agentes Epic 3**
  - Script `scripts/apply-epic3-agent-patches.sh` / `.bat`
  - **Organizador (Sofia)**: Tour guiado de 3 passos para primeira execução
  - **Todos os agentes**: Saudação contextual com estatísticas
    - Última conversa (tempo atrás)
    - Total de conversas (#ª conversa)
    - Streak de dias consecutivos 🔥
    - Top 3 contextos/temas recentes
  - Arquivos de memória em `.assistant-core/memory/`

- **Documentação Completa**
  - `UPGRADE-EPIC3.md` - Guia detalhado de upgrade
  - README.md atualizado com seção de upgrade
  - CHANGELOG.md com seção Epic 3

#### Modificado
- **Agentes Conversacionais (Patches Aditivos)**
  - Organizador: Adicionado tour guiado YAML
  - Secretária, Arquiteto, Psicólogo, Mentor: Adicionada saudação contextual YAML
  - **CRÍTICO**: Patches não removem nada, apenas adicionam funcionalidades

- **Script de Upgrade Principal**
  - `scripts/upgrade-to-epic3.sh` integra todos os sub-scripts
  - Validação pré e pós-upgrade
  - Mensagens claras sobre o que será/não será modificado

#### Preservado (Zero Perda de Dados)
- ✅ `knowledge-base/` - Todos projetos, pessoas, decisões, contextos
- ✅ `.assistant-core/memory/` - Toda memória dos agentes
- ✅ `despejo/daily-dump.md` - Capturas diárias
- ✅ `todos/` - Todas as tarefas
- ✅ Customizações Obsidian (backups criados automaticamente)

#### Performance
- Upgrade completo: < 30 segundos
- Backup ZIP: ~2-5 segundos
- Aplicação de patches: ~5-10 segundos
- Merge Obsidian: ~2-3 segundos
- Validação pós-upgrade: < 2 segundos

#### Rollback e Recovery
- 3 métodos de rollback disponíveis:
  1. Backup ZIP automático
  2. Git reset --hard (recomendado)
  3. Script `RECUPERAR-BACKUP.sh` interativo

#### Notas Técnicas
- Compatibilidade total com Epic 0-2
- Instalações novas já incluem Epic 3
- Patches aplicados via AWK (cross-platform)
- Validação YAML pós-patch
- Sistema não-destrutivo (apenas adições)

---

## [1.0.0] - 2025-09-25

### Adicionado
- Setup automático multiplataforma
- Estrutura completa de diretórios
- Configuração básica dos 5 agentes especializados
- Integração com Obsidian
- Sistema de backup via Git
- Documentação inicial completa

### Características
- Sistema 100% local
- Captura ultra-rápida via daily-dump.md
- Knowledge-base organizada
- Agentes: /organizador, /secretaria, /arquiteto, /psicologo, /mentor

---

Formato baseado em [Keep a Changelog](https://keepachangelog.com/)
