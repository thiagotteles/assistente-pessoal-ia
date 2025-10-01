#!/bin/bash

# Assistente Pessoal IA - Script de Instalação Automática
# Para Linux/Mac - Versão 1.0

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_header() {
    echo -e "\n${BLUE}=================================${NC}"
    echo -e "${BLUE}  Assistente Pessoal IA - Setup${NC}"
    echo -e "${BLUE}=================================${NC}\n"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect platform
detect_platform() {
    case "$(uname -s)" in
        Darwin*)    echo "mac" ;;
        Linux*)     echo "linux" ;;
        *)          echo "unknown" ;;
    esac
}

# Check dependencies
check_dependencies() {
    print_info "Verificando dependências obrigatórias..."

    local deps_ok=true

    # Check Claude Code (assuming it's accessible)
    print_info "Verificando Claude Code..."
    print_success "Claude Code: Assumindo disponível (você está executando via Claude Code)"

    # Check Obsidian
    if command_exists obsidian; then
        print_success "Obsidian: Encontrado no PATH"
    else
        print_warning "Obsidian: Não encontrado no PATH"
        print_info "Por favor, certifique-se de que o Obsidian está instalado"
        print_info "Download: https://obsidian.md/"
    fi

    # Check Git
    if command_exists git; then
        print_success "Git: Encontrado"

        # Check Git configuration
        if git config user.name >/dev/null 2>&1 && git config user.email >/dev/null 2>&1; then
            print_success "Git: Configuração de usuário OK"
        else
            print_warning "Git: Configuração de usuário incompleta"
            print_info "Execute: git config --global user.name 'Seu Nome'"
            print_info "Execute: git config --global user.email 'seu@email.com'"
        fi
    else
        print_error "Git: Não encontrado - OBRIGATÓRIO"
        deps_ok=false
    fi

    if [ "$deps_ok" = false ]; then
        print_error "Dependências obrigatórias em falta. Instale e tente novamente."
        exit 1
    fi

    print_success "Verificação de dependências concluída!"
}

# Create directory structure
create_directory_structure() {
    print_info "Criando estrutura de diretórios..."

    # Assistant core directories
    mkdir -p .assistant-core/{agents,templates,tasks,data,memory}
    print_success "Criado: .assistant-core/ com subdiretórios"

    # Data directories
    mkdir -p despejo
    mkdir -p knowledge-base/{decisoes,contextos,projetos,pessoas}
    mkdir -p todos/{por-projeto,por-pessoa}
    mkdir -p diario/templates
    mkdir -p scripts
    print_success "Criada estrutura completa de diretórios"

    # Create Obsidian directory in knowledge-base
    mkdir -p knowledge-base/.obsidian
    print_success "Criado diretório Obsidian"
}

# Create base files
create_base_files() {
    print_info "Criando arquivos base..."

    # Create daily-dump.md
    cat > despejo/daily-dump.md << 'EOF'
# Daily Dump - Captura Ultra-Rápida

Jogue qualquer informação aqui sem se preocupar com formatação.
O /organizador processará posteriormente através de perguntas específicas.

---

## Formato Livre
Você pode escrever aqui em qualquer formato:
- Ideias soltas
- Reuniões
- Decisões
- TODOs
- Links interessantes
- Qualquer coisa!

Use [[Nome]] para referenciar pessoas ou projetos.

EOF
    print_success "Criado: despejo/daily-dump.md"

    # Create README.md
    cat > README.md << 'EOF'
# Assistente Pessoal IA

Sistema de "segundo cérebro" especializado para usuários com TDAH, composto por múltiplos agentes IA especializados.

## Início Rápido

1. **Captura Ultra-Rápida**: Use `despejo/daily-dump.md` para capturar qualquer informação
2. **Agentes Especializados**: Use comandos `/organizador`, `/secretaria`, `/arquiteto`, `/psicologo`, `/mentor`
3. **Knowledge Base**: Explore `knowledge-base/` no Obsidian para visualização em grafo

## Agentes Disponíveis

- **`/organizador`**: Processa despejo e organiza informações automaticamente
- **`/secretaria`**: Gestão executiva, agenda, status de projetos
- **`/arquiteto`**: Consultoria técnica com confronto construtivo
- **`/psicologo`**: Suporte emocional especializado em TDAH
- **`/mentor`**: Desenvolvimento de carreira e orientação estratégica

## Estrutura do Projeto

- `despejo/` - Captura ultra-rápida sem estrutura
- `knowledge-base/` - "Segundo cérebro" organizado (Obsidian Vault)
- `todos/` - Central de tarefas
- `diario/` - Reflexões estruturadas
- `.assistant-core/` - Configurações dos agentes

## Características

- ✅ **100% Local** - Privacidade total
- ✅ **Claude Code Integration** - Interface familiar
- ✅ **Obsidian Integration** - Visualização em grafo e backlinks
- ✅ **Git Backup** - Versionamento automático
- ✅ **TDAH-Optimized** - Captura sem fricção

## Backup

O sistema usa Git para backup automático. Recomenda-se configurar um repositório remoto privado.

---

🤖 Gerado pelo sistema de setup automático
EOF
    print_success "Criado: README.md"

    # Create .gitignore
    cat > .gitignore << 'EOF'
# Logs
*.log

# Temporary files
.tmp/
temp/

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE
.vscode/
.idea/

# Claude Code specific (if any)
.claude/temp/

# Keep knowledge base but ignore potential sensitive files
knowledge-base/.obsidian/workspace*
knowledge-base/.obsidian/cache/

# Ignore processed dumps but keep the folder structure
despejo/processed/*
!despejo/processed/.gitkeep
EOF
    print_success "Criado: .gitignore"

    # Create CHANGELOG.md
    cat > CHANGELOG.md << EOF
# Changelog - Assistente Pessoal IA

Todas as mudanças importantes do projeto serão documentadas aqui.

## [1.0.0] - $(date +%Y-%m-%d)

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
EOF
    print_success "Criado: CHANGELOG.md"

    # Create .gitkeep files for empty directories
    touch despejo/processed/.gitkeep
    touch todos/por-projeto/.gitkeep
    touch todos/por-pessoa/.gitkeep
    print_success "Criados arquivos .gitkeep para estrutura"
}

# Configure Obsidian vault
configure_obsidian() {
    print_info "Configurando Obsidian vault..."

    # Obsidian core settings
    cat > knowledge-base/.obsidian/app.json << 'EOF'
{
  "legacyEditor": false,
  "livePreview": true,
  "showLineNumber": true,
  "spellcheck": true,
  "spellcheckLanguages": [
    "pt-BR"
  ],
  "useMarkdownLinks": false,
  "newLinkFormat": "shortest",
  "attachmentFolderPath": "./anexos"
}
EOF

    # Graph view configuration
    cat > knowledge-base/.obsidian/graph.json << 'EOF'
{
  "collapse-filter": true,
  "search": "",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": false,
  "showOrphans": true,
  "collapse-color-groups": false,
  "colorGroups": [
    {
      "query": "path:decisoes",
      "color": {
        "a": 1,
        "rgb": 11657298
      }
    },
    {
      "query": "path:projetos",
      "color": {
        "a": 1,
        "rgb": 5431378
      }
    },
    {
      "query": "path:pessoas",
      "color": {
        "a": 1,
        "rgb": 5419488
      }
    },
    {
      "query": "path:contextos",
      "color": {
        "a": 1,
        "rgb": 11621088
      }
    }
  ],
  "collapse-display": false,
  "showArrow": false,
  "textFadeMultiplier": 0,
  "nodeSizeMultiplier": 1,
  "lineSizeMultiplier": 1,
  "collapse-forces": false,
  "centerStrength": 0.518713248970312,
  "repelStrength": 10,
  "linkStrength": 1,
  "linkDistance": 250,
  "scale": 1
}
EOF

    # Hotkeys configuration
    cat > knowledge-base/.obsidian/hotkeys.json << 'EOF'
{
  "app:toggle-left-sidebar": [
    {
      "modifiers": [
        "Mod"
      ],
      "key": "\\"
    }
  ],
  "app:toggle-right-sidebar": [
    {
      "modifiers": [
        "Mod",
        "Shift"
      ],
      "key": "\\"
    }
  ],
  "graph:open": [
    {
      "modifiers": [
        "Mod",
        "Shift"
      ],
      "key": "G"
    }
  ]
}
EOF

    print_success "Configuração Obsidian criada"
}

# Create configuration files
create_configuration_files() {
    print_info "Criando arquivos de configuração..."

    # Create core-config.yaml
    cat > .assistant-core/core-config.yaml << 'EOF'
# Assistente Pessoal IA - Configuração Central
# Versão: 1.0

# Configurações do projeto
markdownExploder: true
qa:
  qaLocation: docs/qa

# PRD Configuration
prd:
  prdFile: docs/prd.md
  prdVersion: v4
  prdSharded: true
  prdShardedLocation: docs/prd
  epicFilePattern: epic-{n}*.md

# Architecture Configuration
architecture:
  architectureFile: docs/architecture.md
  architectureVersion: v4
  architectureSharded: true
  architectureShardedLocation: docs/architecture

# Development Configuration
customTechnicalDocuments: null
devLoadAlwaysFiles:
  - docs/architecture/padres-de-codificao.md
  - docs/architecture/tech-stack.md
  - docs/architecture/estrutura-de-arquivos-source-tree.md
devDebugLog: .ai/debug-log.md
devStoryLocation: docs/stories

# System Configuration
slashPrefix: BMad

# Agentes Configuration
agentes:
  organizador:
    enabled: true
    personality: "confrontador-construtivo"
    memory_file: ".assistant-core/memory/organizador-memory.yaml"
  secretaria:
    enabled: true
    personality: "executiva-eficiente"
    memory_file: ".assistant-core/memory/secretaria-memory.yaml"
  arquiteto:
    enabled: true
    personality: "tecnico-confrontador"
    memory_file: ".assistant-core/memory/arquiteto-memory.yaml"
  psicologo:
    enabled: true
    personality: "empatico-supportivo"
    memory_file: ".assistant-core/memory/psicologo-memory.yaml"
  mentor:
    enabled: true
    personality: "estrategico-orientador"
    memory_file: ".assistant-core/memory/mentor-memory.yaml"
EOF
    print_success "Criado: .assistant-core/core-config.yaml"

    # Create agent configuration templates
    create_agent_configs
    create_agent_memory_files
    create_template_files

    print_success "Arquivos de configuração criados"
}

# Create agent configuration files
create_agent_configs() {
    print_info "Criando configurações dos agentes..."

    # Organizador Agent
    cat > .assistant-core/agents/organizador.yaml << 'EOF'
name: "Organizador Inteligente"
command: "/organizador"
version: "1.0"
personality:
  type: "confrontador-construtivo"
  traits:
    - "Questiona decisões de organização"
    - "Força categorização específica"
    - "Confronta procrastinação organizacional"
    - "Especialista em detectar padrões"

functions:
  - name: "processar_despejo"
    description: "Processa daily-dump.md via perguntas específicas"
  - name: "categorizar_automaticamente"
    description: "Salva informações na knowledge-base"
  - name: "extrair_todos"
    description: "Identifica ações necessárias"
  - name: "criar_referencias"
    description: "Gera links [[]] automáticos"

prompts:
  greeting: "Sou seu Organizador. Que despejo você quer que eu processe hoje? Vou fazer perguntas específicas para categorizar tudo corretamente."
  processing: "Baseado no seu despejo, preciso esclarecer algumas coisas antes de organizar..."
EOF

    # Secretaria Agent
    cat > .assistant-core/agents/secretaria.yaml << 'EOF'
name: "Secretária Digital Executiva"
command: "/secretaria"
version: "1.0"
personality:
  type: "executiva-eficiente"
  traits:
    - "Proativa em gestão de tempo"
    - "Detecta sobrecarga automaticamente"
    - "Organiza prioridades claramente"
    - "Registra tudo detalhadamente"

functions:
  - name: "agenda_do_dia"
    description: "Dashboard executivo de compromissos"
  - name: "status_projetos"
    description: "Visão consolidada de projetos ativos"
  - name: "registro_reuniao"
    description: "Processa transcrições gerando resumos + todos"
  - name: "whats_next"
    description: "Sugestões baseadas em contexto atual"

prompts:
  greeting: "Boa! Sou sua Secretária Executiva. Quer ver a agenda do dia, status dos projetos ou processar uma reunião?"
  scheduling: "Vou organizar isso na sua agenda e identificar possíveis conflitos..."
EOF

    # Arquiteto Agent
    cat > .assistant-core/agents/arquiteto.yaml << 'EOF'
name: "Arquiteto Confrontador"
command: "/arquiteto"
version: "1.0"
personality:
  type: "tecnico-confrontador"
  traits:
    - "Questiona decisões técnicas baseado em histórico"
    - "Confronta arquiteturalmente com dados"
    - "Especialista em padrões e anti-padrões"
    - "Memória técnica profunda"

functions:
  - name: "analise_projeto"
    description: "Review técnico de URLs/repositórios"
  - name: "discussao_tecnica"
    description: "Consultoria sobre padrões e decisões"
  - name: "contexto_decisoes"
    description: "Recupera rationale histórico"
  - name: "confronto_tecnico"
    description: "Questionamento construtivo baseado em histórico"

prompts:
  greeting: "Arquiteto aqui. Me mostre o que você está construindo. Vou questionar suas decisões baseado no que já discutimos antes."
  analysis: "Analisando sua arquitetura... Algumas inconsistências com decisões anteriores..."
EOF

    # Psicologo Agent
    cat > .assistant-core/agents/psicologo.yaml << 'EOF'
name: "Psicólogo Supportivo"
command: "/psicologo"
version: "1.0"
personality:
  type: "empatico-supportivo"
  traits:
    - "Empático mas confronta quando necessário"
    - "Especialista em manejo de TDAH"
    - "Detecta padrões emocionais"
    - "Oferece técnicas práticas"

functions:
  - name: "analise_humor_energia"
    description: "Tracking via daily-dump e padrões"
  - name: "detectar_procrastinacao"
    description: "Identificação de padrões problemáticos"
  - name: "sugerir_autorregulacao"
    description: "Técnicas específicas para TDAH"
  - name: "suporte_confrontador"
    description: "Confronto empático quando necessário"

prompts:
  greeting: "Oi! Sou seu Psicólogo especialista em TDAH. Como você está se sentindo hoje? Posso ajudar com autorregulação."
  support: "Percebo alguns padrões aqui que podem estar afetando você..."
EOF

    # Mentor Agent
    cat > .assistant-core/agents/mentor.yaml << 'EOF'
name: "Mentor de Carreira"
command: "/mentor"
version: "1.0"
personality:
  type: "estrategico-orientador"
  traits:
    - "Visão de longo prazo"
    - "Conecta decisões técnicas com carreira"
    - "Identifica oportunidades de crescimento"
    - "Prepara para conversas difíceis"

functions:
  - name: "tracking_metas_carreira"
    description: "Acompanhamento de objetivos de longo prazo"
  - name: "identificar_oportunidades"
    description: "Aprendizado baseado em projetos atuais"
  - name: "networking_estrategico"
    description: "Sugestões baseadas em contexto"
  - name: "preparacao_conversas"
    description: "Negociações e decisões de carreira"

prompts:
  greeting: "Mentor aqui! Vamos conversar sobre sua carreira. Que objetivos você está perseguindo?"
  guidance: "Baseado no seu histórico, vejo algumas oportunidades de crescimento..."
EOF

    print_success "Configurações dos 5 agentes criadas"
}

# Create agent memory files
create_agent_memory_files() {
    print_info "Criando arquivos de memória dos agentes..."

    # Organizador Memory
    cat > .assistant-core/memory/organizador-memory.yaml << EOF
# Memória do Organizador - Atualizada automaticamente
agent: "organizador"
last_updated: "$(date -Iseconds)"
version: "1.0"

# Padrões de organização aprendidos
organization_patterns:
  user_preferences: []
  frequent_categories: []
  rejected_suggestions: []

# Histórico de interações
interaction_history:
  total_sessions: 0
  last_session: null
  successful_categorizations: 0

# Contexto de personalidade
personality_context:
  confrontation_level: "medium"
  question_style: "specific-direct"
  follow_up_tendency: "persistent"

# Aprendizados específicos
learned_patterns:
  procrastination_triggers: []
  preferred_categorization: []
  time_patterns: []
EOF

    # Secretaria Memory
    cat > .assistant-core/memory/secretaria-memory.yaml << EOF
# Memória da Secretária - Atualizada automaticamente
agent: "secretaria"
last_updated: "$(date -Iseconds)"
version: "1.0"

# Padrões executivos
executive_patterns:
  meeting_frequency: {}
  project_priorities: []
  workload_indicators: []

# Histórico de gestão
management_history:
  meetings_processed: 0
  todos_extracted: 0
  overload_warnings: 0

# Contexto de personalidade
personality_context:
  proactivity_level: "high"
  detail_orientation: "comprehensive"
  urgency_detection: "sensitive"

# Aprendizados específicos
learned_patterns:
  stress_indicators: []
  productivity_peaks: []
  meeting_patterns: []
EOF

    # Arquiteto Memory
    cat > .assistant-core/memory/arquiteto-memory.yaml << EOF
# Memória do Arquiteto - Atualizada automaticamente
agent: "arquiteto"
last_updated: "$(date -Iseconds)"
version: "1.0"

# Decisões técnicas históricas
technical_decisions:
  patterns_used: []
  technologies_chosen: []
  anti_patterns_avoided: []

# Histórico técnico
technical_history:
  projects_reviewed: 0
  confrontations_made: 0
  patterns_suggested: 0

# Contexto de personalidade
personality_context:
  confrontation_level: "high"
  technical_depth: "expert"
  memory_persistence: "long-term"

# Aprendizados específicos
learned_patterns:
  user_tech_preferences: []
  successful_patterns: []
  avoided_mistakes: []
EOF

    # Psicologo Memory
    cat > .assistant-core/memory/psicologo-memory.yaml << EOF
# Memória do Psicólogo - Atualizada automaticamente
agent: "psicologo"
last_updated: "$(date -Iseconds)"
version: "1.0"

# Padrões emocionais e TDAH
emotional_patterns:
  energy_cycles: []
  stress_triggers: []
  coping_strategies_effective: []

# Histórico de suporte
support_history:
  sessions_provided: 0
  techniques_suggested: 0
  improvement_tracking: []

# Contexto de personalidade
personality_context:
  empathy_level: "high"
  confrontation_timing: "strategic"
  support_style: "practical-evidence-based"

# Aprendizados específicos
learned_patterns:
  adhd_manifestations: []
  successful_interventions: []
  environmental_factors: []
EOF

    # Mentor Memory
    cat > .assistant-core/memory/mentor-memory.yaml << EOF
# Memória do Mentor - Atualizada automaticamente
agent: "mentor"
last_updated: "$(date -Iseconds)"
version: "1.0"

# Objetivos de carreira
career_goals:
  short_term: []
  long_term: []
  skill_development: []

# Histórico de mentoria
mentoring_history:
  guidance_sessions: 0
  opportunities_identified: 0
  career_moves_supported: 0

# Contexto de personalidade
personality_context:
  strategic_thinking: "long-term"
  networking_focus: "quality-over-quantity"
  challenge_approach: "growth-oriented"

# Aprendizados específicos
learned_patterns:
  career_aspirations: []
  growth_areas: []
  networking_preferences: []
EOF

    print_success "Arquivos de memória dos 5 agentes criados"
}

# Create template files
create_template_files() {
    print_info "Criando templates..."

    # Meeting summary template
    cat > .assistant-core/templates/reuniao-resumo.yaml << 'EOF'
# Template para Resumo de Reunião
template:
  id: "meeting-summary"
  version: "1.0"

structure:
  header:
    title: "Reunião: {{meeting_title}}"
    date: "{{date}}"
    participants: "{{participants}}"
    duration: "{{duration}}"

  sections:
    - name: "context"
      title: "Contexto"
      content: "{{meeting_context}}"

    - name: "decisions"
      title: "Decisões"
      format: "bullet_list"
      content: "{{decisions_made}}"

    - name: "action_items"
      title: "Action Items"
      format: "todo_list"
      content: "{{action_items}}"

    - name: "next_steps"
      title: "Próximos Passos"
      content: "{{next_steps}}"

references:
  auto_link_people: true
  auto_link_projects: true
  create_todos: true
EOF

    # Person profile template
    cat > .assistant-core/templates/pessoa-profile.yaml << 'EOF'
# Template para Perfil de Pessoa
template:
  id: "person-profile"
  version: "1.0"

structure:
  header:
    name: "[[{{person_name}}]]"
    role: "{{role}}"
    company: "{{company}}"

  sections:
    - name: "contact"
      title: "Contato"
      content: "{{contact_info}}"

    - name: "projects"
      title: "Projetos Relacionados"
      format: "link_list"
      content: "{{related_projects}}"

    - name: "interactions"
      title: "Histórico de Interações"
      format: "chronological"
      content: "{{interaction_history}}"

    - name: "notes"
      title: "Notas"
      content: "{{personal_notes}}"

references:
  auto_link_projects: true
  auto_link_meetings: true
EOF

    # Technical decision template
    cat > .assistant-core/templates/decisao-tecnica.yaml << 'EOF'
# Template para Decisão Técnica
template:
  id: "technical-decision"
  version: "1.0"

structure:
  header:
    title: "Decisão: {{decision_title}}"
    date: "{{date}}"
    project: "[[{{project_name}}]]"
    architect: "[[{{architect_name}}]]"

  sections:
    - name: "context"
      title: "Contexto"
      content: "{{decision_context}}"

    - name: "options"
      title: "Opções Consideradas"
      format: "numbered_list"
      content: "{{options_considered}}"

    - name: "decision"
      title: "Decisão"
      content: "{{final_decision}}"

    - name: "rationale"
      title: "Rationale"
      content: "{{decision_rationale}}"

    - name: "consequences"
      title: "Consequências"
      content: "{{consequences}}"

references:
  auto_link_people: true
  auto_link_projects: true
  auto_link_technologies: true
EOF

    # Project analysis template
    cat > .assistant-core/templates/projeto-analise.yaml << 'EOF'
# Template para Análise de Projeto
template:
  id: "project-analysis"
  version: "1.0"

structure:
  header:
    name: "[[{{project_name}}]]"
    status: "{{project_status}}"
    priority: "{{priority}}"
    owner: "[[{{project_owner}}]]"

  sections:
    - name: "overview"
      title: "Visão Geral"
      content: "{{project_overview}}"

    - name: "objectives"
      title: "Objetivos"
      format: "bullet_list"
      content: "{{objectives}}"

    - name: "team"
      title: "Equipe"
      format: "link_list"
      content: "{{team_members}}"

    - name: "timeline"
      title: "Timeline"
      content: "{{project_timeline}}"

    - name: "decisions"
      title: "Decisões Técnicas"
      format: "link_list"
      content: "{{technical_decisions}}"

references:
  auto_link_people: true
  auto_link_decisions: true
EOF

    print_success "Templates criados"
}

# Run basic validation test
run_basic_test() {
    print_info "Executando teste básico de validação..."

    local test_passed=true

    # Test directory structure
    print_info "Testando estrutura de diretórios..."

    local required_dirs=(
        ".assistant-core"
        ".assistant-core/agents"
        ".assistant-core/templates"
        ".assistant-core/tasks"
        ".assistant-core/data"
        ".assistant-core/memory"
        "despejo"
        "knowledge-base"
        "knowledge-base/decisoes"
        "knowledge-base/contextos"
        "knowledge-base/projetos"
        "knowledge-base/pessoas"
        "todos"
        "diario"
        "scripts"
    )

    for dir in "${required_dirs[@]}"; do
        if [ -d "$dir" ]; then
            print_success "Diretório OK: $dir"
        else
            print_error "Diretório FALTANDO: $dir"
            test_passed=false
        fi
    done

    # Test key files
    print_info "Testando arquivos base..."

    local required_files=(
        "despejo/daily-dump.md"
        "README.md"
        ".gitignore"
        "CHANGELOG.md"
        ".assistant-core/core-config.yaml"
    )

    for file in "${required_files[@]}"; do
        if [ -f "$file" ]; then
            print_success "Arquivo OK: $file"
        else
            print_error "Arquivo FALTANDO: $file"
            test_passed=false
        fi
    done

    # Test agent configuration files
    print_info "Testando configurações dos agentes..."

    local agent_configs=(
        ".assistant-core/agents/organizador.yaml"
        ".assistant-core/agents/secretaria.yaml"
        ".assistant-core/agents/arquiteto.yaml"
        ".assistant-core/agents/psicologo.yaml"
        ".assistant-core/agents/mentor.yaml"
    )

    for config in "${agent_configs[@]}"; do
        if [ -f "$config" ]; then
            print_success "Config OK: $config"
        else
            print_error "Config FALTANDO: $config"
            test_passed=false
        fi
    done

    # Test Obsidian configuration
    print_info "Testando configuração Obsidian..."
    if [ -f "knowledge-base/.obsidian/app.json" ] && [ -f "knowledge-base/.obsidian/graph.json" ]; then
        print_success "Configuração Obsidian OK"
    else
        print_error "Configuração Obsidian incompleta"
        test_passed=false
    fi

    # Final test result
    if [ "$test_passed" = true ]; then
        print_success "✅ TODOS OS TESTES PASSARAM!"
        print_success "Sistema instalado com sucesso!"
        return 0
    else
        print_error "❌ ALGUNS TESTES FALHARAM!"
        print_error "Verifique os problemas acima"
        return 1
    fi
}

# Main setup function
main() {
    print_header

    print_info "Iniciando instalação do Assistente Pessoal IA..."
    print_info "Plataforma detectada: $(detect_platform)"

    check_dependencies
    create_directory_structure
    create_base_files
    configure_obsidian
    create_configuration_files

    if run_basic_test; then
        print_header
        print_success "🎉 INSTALAÇÃO CONCLUÍDA COM SUCESSO!"
        print_info ""
        print_info "Próximos passos:"
        print_info "1. Abra knowledge-base/ no Obsidian"
        print_info "2. Use despejo/daily-dump.md para captura rápida"
        print_info "3. Experimente os agentes: /organizador, /secretaria, /arquiteto, /psicologo, /mentor"
        print_info ""
        print_info "Para backup automático, configure um repositório Git remoto:"
        print_info "  git remote add origin <seu-repositorio-privado>"
        print_info "  git push -u origin main"
        print_info ""
        print_success "Seu segundo cérebro está pronto! 🧠✨"
    else
        print_error "Instalação falhou. Verifique os erros acima."
        exit 1
    fi
}

# Execute main function
main "$@"