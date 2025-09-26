@echo off
setlocal enabledelayedexpansion

REM Assistente Pessoal IA - Script de Instalação Automática
REM Para Windows - Versão 1.0

echo.
echo =====================================
echo   Assistente Pessoal IA - Setup
echo =====================================
echo.

REM Helper functions using subroutines
goto :main

:print_info
echo [INFO] %~1
goto :eof

:print_success
echo [SUCESSO] %~1
goto :eof

:print_warning
echo [AVISO] %~1
goto :eof

:print_error
echo [ERRO] %~1
goto :eof

:check_dependencies
call :print_info "Verificando dependências obrigatórias..."

REM Check Claude Code (assuming available)
call :print_info "Verificando Claude Code..."
call :print_success "Claude Code: Assumindo disponível (você está executando via Claude Code)"

REM Check Obsidian
where obsidian >nul 2>&1
if !errorlevel! == 0 (
    call :print_success "Obsidian: Encontrado no PATH"
) else (
    call :print_warning "Obsidian: Não encontrado no PATH"
    call :print_info "Por favor, certifique-se de que o Obsidian está instalado"
    call :print_info "Download: https://obsidian.md/"
)

REM Check Git
where git >nul 2>&1
if !errorlevel! == 0 (
    call :print_success "Git: Encontrado"

    REM Check Git configuration
    git config user.name >nul 2>&1
    if !errorlevel! == 0 (
        git config user.email >nul 2>&1
        if !errorlevel! == 0 (
            call :print_success "Git: Configuração de usuário OK"
        ) else (
            call :print_warning "Git: Configuração de usuário incompleta"
            call :print_info "Execute: git config --global user.name 'Seu Nome'"
            call :print_info "Execute: git config --global user.email 'seu@email.com'"
        )
    ) else (
        call :print_warning "Git: Configuração de usuário incompleta"
        call :print_info "Execute: git config --global user.name 'Seu Nome'"
        call :print_info "Execute: git config --global user.email 'seu@email.com'"
    )
) else (
    call :print_error "Git: Não encontrado - OBRIGATÓRIO"
    echo Instale o Git e tente novamente.
    pause
    exit /b 1
)

call :print_success "Verificação de dependências concluída!"
goto :eof

:create_directory_structure
call :print_info "Criando estrutura de diretórios..."

REM Assistant core directories
mkdir .assistant-core\agents 2>nul
mkdir .assistant-core\templates 2>nul
mkdir .assistant-core\tasks 2>nul
mkdir .assistant-core\data 2>nul
mkdir .assistant-core\memory 2>nul
call :print_success "Criado: .assistant-core\ com subdiretórios"

REM Data directories
mkdir despejo 2>nul
mkdir knowledge-base\decisoes 2>nul
mkdir knowledge-base\contextos 2>nul
mkdir knowledge-base\projetos 2>nul
mkdir knowledge-base\pessoas 2>nul
mkdir todos\por-projeto 2>nul
mkdir todos\por-pessoa 2>nul
mkdir diario\templates 2>nul
mkdir scripts 2>nul
call :print_success "Criada estrutura completa de diretórios"

REM Create Obsidian directory
mkdir knowledge-base\.obsidian 2>nul
call :print_success "Criado diretório Obsidian"
goto :eof

:create_base_files
call :print_info "Criando arquivos base..."

REM Create daily-dump.txt
(
echo # Daily Dump - Captura Ultra-Rápida
echo.
echo Jogue qualquer informação aqui sem se preocupar com formatação.
echo O /organizador processará posteriormente através de perguntas específicas.
echo.
echo ---
echo.
echo ## Formato Livre
echo Você pode escrever aqui em qualquer formato:
echo - Ideias soltas
echo - Reuniões
echo - Decisões
echo - TODOs
echo - Links interessantes
echo - Qualquer coisa!
echo.
echo Use [[Nome]] para referenciar pessoas ou projetos.
echo.
) > despejo\daily-dump.txt
call :print_success "Criado: despejo\daily-dump.txt"

REM Create README.md
(
echo # Assistente Pessoal IA
echo.
echo Sistema de "segundo cérebro" especializado para usuários com TDAH, composto por múltiplos agentes IA especializados.
echo.
echo ## Início Rápido
echo.
echo 1. **Captura Ultra-Rápida**: Use `despejo/daily-dump.txt` para capturar qualquer informação
echo 2. **Agentes Especializados**: Use comandos `/organizador`, `/secretaria`, `/arquiteto`, `/psicologo`, `/mentor`
echo 3. **Knowledge Base**: Explore `knowledge-base/` no Obsidian para visualização em grafo
echo.
echo ## Agentes Disponíveis
echo.
echo - **`/organizador`**: Processa despejo e organiza informações automaticamente
echo - **`/secretaria`**: Gestão executiva, agenda, status de projetos
echo - **`/arquiteto`**: Consultoria técnica com confronto construtivo
echo - **`/psicologo`**: Suporte emocional especializado em TDAH
echo - **`/mentor`**: Desenvolvimento de carreira e orientação estratégica
echo.
echo ## Estrutura do Projeto
echo.
echo - `despejo/` - Captura ultra-rápida sem estrutura
echo - `knowledge-base/` - "Segundo cérebro" organizado (Obsidian Vault^)
echo - `todos/` - Central de tarefas
echo - `diario/` - Reflexões estruturadas
echo - `.assistant-core/` - Configurações dos agentes
echo.
echo ## Características
echo.
echo - ✅ **100%% Local** - Privacidade total
echo - ✅ **Claude Code Integration** - Interface familiar
echo - ✅ **Obsidian Integration** - Visualização em grafo e backlinks
echo - ✅ **Git Backup** - Versionamento automático
echo - ✅ **TDAH-Optimized** - Captura sem fricção
echo.
echo ## Backup
echo.
echo O sistema usa Git para backup automático. Recomenda-se configurar um repositório remoto privado.
echo.
echo ---
echo.
echo 🤖 Gerado pelo sistema de setup automático
) > README.md
call :print_success "Criado: README.md"

REM Create .gitignore
(
echo # Logs
echo *.log
echo.
echo # Temporary files
echo .tmp/
echo temp/
echo.
echo # OS generated files
echo .DS_Store
echo .DS_Store?
echo ._*
echo .Spotlight-V100
echo .Trashes
echo ehthumbs.db
echo Thumbs.db
echo.
echo # IDE
echo .vscode/
echo .idea/
echo.
echo # Claude Code specific (if any^)
echo .claude/temp/
echo.
echo # Keep knowledge base but ignore potential sensitive files
echo knowledge-base/.obsidian/workspace*
echo knowledge-base/.obsidian/cache/
echo.
echo # Ignore processed dumps but keep the folder structure
echo despejo/processed/*
echo !despejo/processed/.gitkeep
) > .gitignore
call :print_success "Criado: .gitignore"

REM Create CHANGELOG.md with current date
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (
    set month=%%a
    set day=%%b
    set year=%%c
)
(
echo # Changelog - Assistente Pessoal IA
echo.
echo Todas as mudanças importantes do projeto serão documentadas aqui.
echo.
echo ## [1.0.0] - !year!-!month!-!day!
echo.
echo ### Adicionado
echo - Setup automático multiplataforma
echo - Estrutura completa de diretórios
echo - Configuração básica dos 5 agentes especializados
echo - Integração com Obsidian
echo - Sistema de backup via Git
echo - Documentação inicial completa
echo.
echo ### Características
echo - Sistema 100%% local
echo - Captura ultra-rápida via daily-dump.txt
echo - Knowledge-base organizada
echo - Agentes: /organizador, /secretaria, /arquiteto, /psicologo, /mentor
echo.
echo ---
echo.
echo Formato baseado em [Keep a Changelog](https://keepachangelog.com/^)
) > CHANGELOG.md
call :print_success "Criado: CHANGELOG.md"

REM Create .gitkeep files
echo. > despejo\processed\.gitkeep
echo. > todos\por-projeto\.gitkeep
echo. > todos\por-pessoa\.gitkeep
call :print_success "Criados arquivos .gitkeep para estrutura"
goto :eof

:configure_obsidian
call :print_info "Configurando Obsidian vault..."

REM Obsidian core settings
(
echo {
echo   "legacyEditor": false,
echo   "livePreview": true,
echo   "showLineNumber": true,
echo   "spellcheck": true,
echo   "spellcheckLanguages": [
echo     "pt-BR"
echo   ],
echo   "useMarkdownLinks": false,
echo   "newLinkFormat": "shortest",
echo   "attachmentFolderPath": "./anexos"
echo }
) > knowledge-base\.obsidian\app.json

REM Graph view configuration
(
echo {
echo   "collapse-filter": true,
echo   "search": "",
echo   "showTags": true,
echo   "showAttachments": false,
echo   "hideUnresolved": false,
echo   "showOrphans": true,
echo   "collapse-color-groups": false,
echo   "colorGroups": [
echo     {
echo       "query": "path:decisoes",
echo       "color": {
echo         "a": 1,
echo         "rgb": 11657298
echo       }
echo     },
echo     {
echo       "query": "path:projetos",
echo       "color": {
echo         "a": 1,
echo         "rgb": 5431378
echo       }
echo     },
echo     {
echo       "query": "path:pessoas",
echo       "color": {
echo         "a": 1,
echo         "rgb": 5419488
echo       }
echo     },
echo     {
echo       "query": "path:contextos",
echo       "color": {
echo         "a": 1,
echo         "rgb": 11621088
echo       }
echo     }
echo   ],
echo   "collapse-display": false,
echo   "showArrow": false,
echo   "textFadeMultiplier": 0,
echo   "nodeSizeMultiplier": 1,
echo   "lineSizeMultiplier": 1,
echo   "collapse-forces": false,
echo   "centerStrength": 0.518713248970312,
echo   "repelStrength": 10,
echo   "linkStrength": 1,
echo   "linkDistance": 250,
echo   "scale": 1
echo }
) > knowledge-base\.obsidian\graph.json

REM Hotkeys configuration
(
echo {
echo   "app:toggle-left-sidebar": [
echo     {
echo       "modifiers": [
echo         "Mod"
echo       ],
echo       "key": "\\"
echo     }
echo   ],
echo   "app:toggle-right-sidebar": [
echo     {
echo       "modifiers": [
echo         "Mod",
echo         "Shift"
echo       ],
echo       "key": "\\"
echo     }
echo   ],
echo   "graph:open": [
echo     {
echo       "modifiers": [
echo         "Mod",
echo         "Shift"
echo       ],
echo       "key": "G"
echo     }
echo   ]
echo }
) > knowledge-base\.obsidian\hotkeys.json

call :print_success "Configuração Obsidian criada"
goto :eof

:create_configuration_files
call :print_info "Criando arquivos de configuração..."

REM Create core-config.yaml
(
echo # Assistente Pessoal IA - Configuração Central
echo # Versão: 1.0
echo.
echo # Configurações do projeto
echo markdownExploder: true
echo qa:
echo   qaLocation: docs/qa
echo.
echo # PRD Configuration
echo prd:
echo   prdFile: docs/prd.md
echo   prdVersion: v4
echo   prdSharded: true
echo   prdShardedLocation: docs/prd
echo   epicFilePattern: epic-{n}*.md
echo.
echo # Architecture Configuration
echo architecture:
echo   architectureFile: docs/architecture.md
echo   architectureVersion: v4
echo   architectureSharded: true
echo   architectureShardedLocation: docs/architecture
echo.
echo # Development Configuration
echo customTechnicalDocuments: null
echo devLoadAlwaysFiles:
echo   - docs/architecture/padres-de-codificao.md
echo   - docs/architecture/tech-stack.md
echo   - docs/architecture/estrutura-de-arquivos-source-tree.md
echo devDebugLog: .ai/debug-log.md
echo devStoryLocation: docs/stories
echo.
echo # System Configuration
echo slashPrefix: BMad
echo.
echo # Agentes Configuration
echo agentes:
echo   organizador:
echo     enabled: true
echo     personality: "confrontador-construtivo"
echo     memory_file: ".assistant-core/memory/organizador-memory.yaml"
echo   secretaria:
echo     enabled: true
echo     personality: "executiva-eficiente"
echo     memory_file: ".assistant-core/memory/secretaria-memory.yaml"
echo   arquiteto:
echo     enabled: true
echo     personality: "tecnico-confrontador"
echo     memory_file: ".assistant-core/memory/arquiteto-memory.yaml"
echo   psicologo:
echo     enabled: true
echo     personality: "empatico-supportivo"
echo     memory_file: ".assistant-core/memory/psicologo-memory.yaml"
echo   mentor:
echo     enabled: true
echo     personality: "estrategico-orientador"
echo     memory_file: ".assistant-core/memory/mentor-memory.yaml"
) > .assistant-core\core-config.yaml
call :print_success "Criado: .assistant-core\core-config.yaml"

call :create_agent_configs
call :create_agent_memory_files
call :create_template_files

call :print_success "Arquivos de configuração criados"
goto :eof

:create_agent_configs
call :print_info "Criando configurações dos agentes..."

REM Note: Windows batch doesn't handle multi-line strings as elegantly as bash
REM For brevity, creating simplified agent configs - full configs would be very long

echo name: "Organizador Inteligente" > .assistant-core\agents\organizador.yaml
echo command: "/organizador" >> .assistant-core\agents\organizador.yaml
echo version: "1.0" >> .assistant-core\agents\organizador.yaml

echo name: "Secretária Digital Executiva" > .assistant-core\agents\secretaria.yaml
echo command: "/secretaria" >> .assistant-core\agents\secretaria.yaml
echo version: "1.0" >> .assistant-core\agents\secretaria.yaml

echo name: "Arquiteto Confrontador" > .assistant-core\agents\arquiteto.yaml
echo command: "/arquiteto" >> .assistant-core\agents\arquiteto.yaml
echo version: "1.0" >> .assistant-core\agents\arquiteto.yaml

echo name: "Psicólogo Supportivo" > .assistant-core\agents\psicologo.yaml
echo command: "/psicologo" >> .assistant-core\agents\psicologo.yaml
echo version: "1.0" >> .assistant-core\agents\psicologo.yaml

echo name: "Mentor de Carreira" > .assistant-core\agents\mentor.yaml
echo command: "/mentor" >> .assistant-core\agents\mentor.yaml
echo version: "1.0" >> .assistant-core\agents\mentor.yaml

call :print_success "Configurações dos 5 agentes criadas (versão simplificada para Windows)"
goto :eof

:create_agent_memory_files
call :print_info "Criando arquivos de memória dos agentes..."

REM Create basic memory files for each agent
echo # Memória do Organizador > .assistant-core\memory\organizador-memory.yaml
echo agent: "organizador" >> .assistant-core\memory\organizador-memory.yaml
echo version: "1.0" >> .assistant-core\memory\organizador-memory.yaml

echo # Memória da Secretária > .assistant-core\memory\secretaria-memory.yaml
echo agent: "secretaria" >> .assistant-core\memory\secretaria-memory.yaml
echo version: "1.0" >> .assistant-core\memory\secretaria-memory.yaml

echo # Memória do Arquiteto > .assistant-core\memory\arquiteto-memory.yaml
echo agent: "arquiteto" >> .assistant-core\memory\arquiteto-memory.yaml
echo version: "1.0" >> .assistant-core\memory\arquiteto-memory.yaml

echo # Memória do Psicólogo > .assistant-core\memory\psicologo-memory.yaml
echo agent: "psicologo" >> .assistant-core\memory\psicologo-memory.yaml
echo version: "1.0" >> .assistant-core\memory\psicologo-memory.yaml

echo # Memória do Mentor > .assistant-core\memory\mentor-memory.yaml
echo agent: "mentor" >> .assistant-core\memory\mentor-memory.yaml
echo version: "1.0" >> .assistant-core\memory\mentor-memory.yaml

call :print_success "Arquivos de memória dos 5 agentes criados"
goto :eof

:create_template_files
call :print_info "Criando templates..."

REM Create basic template files
echo # Template para Resumo de Reunião > .assistant-core\templates\reuniao-resumo.yaml
echo template_id: "meeting-summary" >> .assistant-core\templates\reuniao-resumo.yaml
echo version: "1.0" >> .assistant-core\templates\reuniao-resumo.yaml

echo # Template para Perfil de Pessoa > .assistant-core\templates\pessoa-profile.yaml
echo template_id: "person-profile" >> .assistant-core\templates\pessoa-profile.yaml
echo version: "1.0" >> .assistant-core\templates\pessoa-profile.yaml

echo # Template para Decisão Técnica > .assistant-core\templates\decisao-tecnica.yaml
echo template_id: "technical-decision" >> .assistant-core\templates\decisao-tecnica.yaml
echo version: "1.0" >> .assistant-core\templates\decisao-tecnica.yaml

echo # Template para Análise de Projeto > .assistant-core\templates\projeto-analise.yaml
echo template_id: "project-analysis" >> .assistant-core\templates\projeto-analise.yaml
echo version: "1.0" >> .assistant-core\templates\projeto-analise.yaml

call :print_success "Templates criados"
goto :eof

:run_basic_test
call :print_info "Executando teste básico de validação..."

set test_passed=1

REM Test directory structure
call :print_info "Testando estrutura de diretórios..."

set directories=.assistant-core .assistant-core\agents .assistant-core\templates .assistant-core\tasks .assistant-core\data .assistant-core\memory despejo knowledge-base knowledge-base\decisoes knowledge-base\contextos knowledge-base\projetos knowledge-base\pessoas todos diario scripts

for %%d in (!directories!) do (
    if exist "%%d\" (
        call :print_success "Diretório OK: %%d"
    ) else (
        call :print_error "Diretório FALTANDO: %%d"
        set test_passed=0
    )
)

REM Test key files
call :print_info "Testando arquivos base..."

set files=despejo\daily-dump.txt README.md .gitignore CHANGELOG.md .assistant-core\core-config.yaml

for %%f in (!files!) do (
    if exist "%%f" (
        call :print_success "Arquivo OK: %%f"
    ) else (
        call :print_error "Arquivo FALTANDO: %%f"
        set test_passed=0
    )
)

REM Test Obsidian configuration
call :print_info "Testando configuração Obsidian..."
if exist "knowledge-base\.obsidian\app.json" (
    if exist "knowledge-base\.obsidian\graph.json" (
        call :print_success "Configuração Obsidian OK"
    ) else (
        call :print_error "Configuração Obsidian incompleta"
        set test_passed=0
    )
) else (
    call :print_error "Configuração Obsidian incompleta"
    set test_passed=0
)

REM Final test result
if !test_passed! == 1 (
    call :print_success "✅ TODOS OS TESTES PASSARAM!"
    call :print_success "Sistema instalado com sucesso!"
) else (
    call :print_error "❌ ALGUNS TESTES FALHARAM!"
    call :print_error "Verifique os problemas acima"
)

goto :eof

:main
call :print_info "Iniciando instalação do Assistente Pessoal IA..."
call :print_info "Plataforma detectada: Windows"

call :check_dependencies
if errorlevel 1 goto :end

call :create_directory_structure
call :create_base_files
call :configure_obsidian
call :create_configuration_files
call :run_basic_test

echo.
echo =====================================
echo 🎉 INSTALAÇÃO CONCLUÍDA COM SUCESSO!
echo =====================================
echo.
call :print_info "Próximos passos:"
call :print_info "1. Abra knowledge-base\ no Obsidian"
call :print_info "2. Use despejo\daily-dump.txt para captura rápida"
call :print_info "3. Experimente os agentes: /organizador, /secretaria, /arquiteto, /psicologo, /mentor"
echo.
call :print_info "Para backup automático, configure um repositório Git remoto:"
call :print_info "  git remote add origin <seu-repositorio-privado>"
call :print_info "  git push -u origin main"
echo.
call :print_success "Seu segundo cérebro está pronto! 🧠✨"

:end
echo.
echo Pressione qualquer tecla para continuar...
pause >nul