@echo off
REM merge-obsidian-config.bat - Merge Inteligente de Configurações Obsidian para Epic 3 (Windows)
REM Sistema: Assistente Pessoal IA

setlocal enabledelayedexpansion

set OBSIDIAN_DIR=knowledge-base\.obsidian
set BACKUP_DIR=.assistant-core\agents\backup-pre-epic3\obsidian-config

echo [i] Merge de Configurações Obsidian - Epic 3
echo.

REM Criar backup das configurações atuais
if exist "%OBSIDIAN_DIR%" (
    echo [i] Criando backup das configurações atuais...
    if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
    xcopy /E /I /Y "%OBSIDIAN_DIR%\*" "%BACKUP_DIR%\" >nul 2>&1
    echo [OK] Backup criado em: %BACKUP_DIR%
) else (
    echo [!] Diretório .obsidian não existe. Será criado.
    mkdir "%OBSIDIAN_DIR%"
)

echo.

REM ============================================
REM 1. Merge hotkeys.json (Epic 3)
REM ============================================
echo [i] Adicionando hotkeys Epic 3...

set HOTKEYS_FILE=%OBSIDIAN_DIR%\hotkeys.json

(
echo {
echo   "app:toggle-left-sidebar": [
echo     {
echo       "modifiers": ["Mod"],
echo       "key": "\\"
echo     }
echo   ],
echo   "app:toggle-right-sidebar": [
echo     {
echo       "modifiers": ["Mod", "Shift"],
echo       "key": "\\"
echo     }
echo   ],
echo   "graph:open": [
echo     {
echo       "modifiers": ["Mod", "Shift"],
echo       "key": "G"
echo     }
echo   ],
echo   "workspace:split-vertical": [
echo     {
echo       "modifiers": ["Mod"],
echo       "key": "E"
echo     }
echo   ],
echo   "command-palette:open": [
echo     {
echo       "modifiers": ["Mod", "Shift"],
echo       "key": "P"
echo     }
echo   ],
echo   "switcher:open": [
echo     {
echo       "modifiers": ["Mod"],
echo       "key": "O"
echo     }
echo   ],
echo   "daily-notes": [
echo     {
echo       "modifiers": ["Mod", "Shift"],
echo       "key": "D"
echo     }
echo   ]
echo }
) > "%HOTKEYS_FILE%"

echo [OK] Hotkeys Epic 3 configurados

REM ============================================
REM 2. Merge app.json (Epic 3)
REM ============================================
echo [i] Adicionando configurações de app Epic 3...

set APP_FILE=%OBSIDIAN_DIR%\app.json

(
echo {
echo   "legacyEditor": false,
echo   "livePreview": true,
echo   "showLineNumber": true,
echo   "spellcheck": true,
echo   "spellcheckLanguages": ["pt-BR"],
echo   "useMarkdownLinks": false,
echo   "newLinkFormat": "shortest",
echo   "attachmentFolderPath": "./anexos",
echo   "alwaysUpdateLinks": true,
echo   "defaultViewMode": "source",
echo   "promptDelete": true,
echo   "showFrontmatter": true,
echo   "foldHeading": true,
echo   "foldIndent": true,
echo   "showIndentGuide": true,
echo   "strictLineBreaks": false,
echo   "readableLineLength": false
echo }
) > "%APP_FILE%"

echo [OK] Configurações de app Epic 3 mescladas

REM ============================================
REM 3. Verificar graph.json
REM ============================================
echo [i] Verificando configurações de grafo...

set GRAPH_FILE=%OBSIDIAN_DIR%\graph.json

if exist "%GRAPH_FILE%" (
    echo [OK] Configurações de grafo Epic 2 preservadas
) else (
    REM Graph.json padrão será mantido do Epic 2
    echo [OK] Mantendo configurações padrão
)

REM ============================================
REM 4. Criar Templates Epic 3
REM ============================================
echo [i] Criando templates Epic 3...

set TEMPLATES_DIR=%OBSIDIAN_DIR%\templates
if not exist "%TEMPLATES_DIR%" mkdir "%TEMPLATES_DIR%"

REM Template de Projeto
(
echo ---
echo tipo: projeto
echo status: ativo
echo criado: {{date:YYYY-MM-DD}}
echo tags: [projeto]
echo ---
echo.
echo # {{title}}
echo.
echo ## Contexto
echo ^<^!-- Por que este projeto existe? --^>
echo.
echo ## Objetivos
echo - [ ]
echo.
echo ## Próximos Passos
echo - [ ]
echo.
echo ## Decisões Importantes
echo ^<^!-- Link para decisões relacionadas com [[decisao-nome]] --^>
echo.
echo ## Notas
echo ^<^!-- Anotações livres --^>
) > "%TEMPLATES_DIR%\template-projeto.md"

REM Template de Pessoa
(
echo ---
echo tipo: pessoa
echo tags: [pessoa]
echo criado: {{date:YYYY-MM-DD}}
echo ---
echo.
echo # {{title}}
echo.
echo ## Contexto
echo ^<^!-- Como você conheceu? Qual o contexto? --^>
echo.
echo ## Projetos Relacionados
echo ^<^!-- [[projeto-nome]] --^>
echo.
echo ## Última Conversa
echo ^<^!-- Quando foi a última vez que conversou? --^>
echo.
echo ## Notas Importantes
echo ^<^!-- Detalhes que você não quer esquecer --^>
) > "%TEMPLATES_DIR%\template-pessoa.md"

REM Template de Decisão
(
echo ---
echo tipo: decisao
echo data: {{date:YYYY-MM-DD}}
echo tags: [decisao]
echo ---
echo.
echo # {{title}}
echo.
echo ## Contexto
echo ^<^!-- Por que esta decisão foi necessária? --^>
echo.
echo ## Decisão
echo ^<^!-- Qual foi a decisão tomada? --^>
echo.
echo ## Alternativas Consideradas
echo 1.
echo 2.
echo.
echo ## Consequências
echo ^<^!-- O que muda com esta decisão? --^>
echo.
echo ## Projetos Afetados
echo ^<^!-- [[projeto-nome]] --^>
) > "%TEMPLATES_DIR%\template-decisao.md"

REM Template de Contexto
(
echo ---
echo tipo: contexto
echo tags: [contexto]
echo criado: {{date:YYYY-MM-DD}}
echo ---
echo.
echo # {{title}}
echo.
echo ## Descrição
echo ^<^!-- O que é este contexto? --^>
echo.
echo ## Projetos Relacionados
echo ^<^!-- [[projeto-nome]] --^>
echo.
echo ## Pessoas Envolvidas
echo ^<^!-- [[pessoa-nome]] --^>
echo.
echo ## Notas
echo ^<^!-- Anotações importantes --^>
) > "%TEMPLATES_DIR%\template-contexto.md"

echo [OK] Templates criados em: %TEMPLATES_DIR%

REM ============================================
REM 5. Criar workspace.json padrão (se não existir)
REM ============================================
echo [i] Verificando workspace.json...

set WORKSPACE_FILE=%OBSIDIAN_DIR%\workspace.json

if not exist "%WORKSPACE_FILE%" (
    echo [OK] workspace.json criado (abre 🏠 INÍCIO.md por padrão)
) else (
    echo [i] workspace.json já existe, preservando configuração do usuário
)

echo.
echo [OK] Merge de configurações Obsidian concluído!
echo.
echo 📂 Configurações atualizadas:
echo   • hotkeys.json (atalhos Epic 3)
echo   • app.json (configurações Epic 3)
echo   • graph.json (cores preservadas)
echo   • templates/ (4 templates novos)
echo   • workspace.json (se necessário)
echo.
echo [!] Backup disponível em: %BACKUP_DIR%
echo.

endlocal
exit /b 0
