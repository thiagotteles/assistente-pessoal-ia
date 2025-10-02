@echo off
REM apply-epic3-agent-patches.bat - Aplicar Patches Epic 3 em Agentes (Windows)
REM Sistema: Assistente Pessoal IA

setlocal enabledelayedexpansion

set AGENTS_DIR=.assistant-core\agents
set BACKUP_DIR=.assistant-core\agents\backup-pre-epic3
set MEMORY_DIR=.assistant-core\memory

echo [i] Aplicando Patches Epic 3 nos Agentes Conversacionais
echo.

REM Verificar que agentes existem
if not exist "%AGENTS_DIR%" (
    echo [ERRO] Diretório %AGENTS_DIR% não encontrado. Execute setup.bat primeiro.
    exit /b 1
)

REM Backup já foi feito no upgrade, mas verificar
if not exist "%BACKUP_DIR%" (
    echo [!] Criando backup de agentes...
    mkdir "%BACKUP_DIR%"
    copy "%AGENTS_DIR%\*.md" "%BACKUP_DIR%\" >nul 2>&1
)

REM Criar diretório de memória
if not exist "%MEMORY_DIR%" mkdir "%MEMORY_DIR%"

echo.

echo [i] NOTA: Patches complexos de YAML são melhor aplicados via Bash
echo [i] Para Windows, recomendamos: bash scripts/apply-epic3-agent-patches.sh
echo.
echo [i] Criando apenas arquivos de memória iniciais...
echo.

REM ============================================
REM Criar arquivos de memória iniciais
REM ============================================

REM Tour status do Organizador
if not exist "%MEMORY_DIR%\organizador-tour-status.yaml" (
    (
    echo # Status do Tour Guiado - Organizador
    echo tour-completed: false
    echo current-step: 0
    echo started-at: null
    echo completed-at: null
    ) > "%MEMORY_DIR%\organizador-tour-status.yaml"
    echo [OK] Memória de tour criada: organizador-tour-status.yaml
)

REM Contextos dos agentes
for %%a in (secretaria arquiteto psicologo mentor) do (
    if not exist "%MEMORY_DIR%\%%a-context.yaml" (
        (
        echo # Contexto e Saudação - %%a
        echo ultima-conversa: null
        echo total-conversas: 0
        echo streak-dias: 0
        echo top-contextos: []
        echo historico-temas: []
        ) > "%MEMORY_DIR%\%%a-context.yaml"
        echo [OK] Memória de contexto criada: %%a-context.yaml
    )
)

echo.
echo [OK] Arquivos de memória criados!
echo.
echo [!] Para aplicar patches nos agentes, execute:
echo     bash scripts/apply-epic3-agent-patches.sh
echo.
echo     Ou edite manualmente os arquivos em %AGENTS_DIR%
echo.

endlocal
exit /b 0
