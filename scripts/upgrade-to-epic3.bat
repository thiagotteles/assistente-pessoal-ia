@echo off
REM Script de Upgrade para Epic 3 - Windows
REM Sistema: Assistente Pessoal IA com Método Conversacional

setlocal enabledelayedexpansion

echo ================================================
echo Upgrade para Epic 3: Experiencia de Sucesso
echo ================================================
echo.

REM ============================================
REM ETAPA 1: Deteccao de Instalacao Existente
REM ============================================
echo [i] Verificando instalacao existente...

if not exist ".assistant-core\agents\organizador.md" (
    echo [ERRO] Arquivo critico nao encontrado: .assistant-core\agents\organizador.md
    echo        Execute setup.bat primeiro para instalacao limpa.
    exit /b 1
)

if not exist "knowledge-base" (
    echo [ERRO] Pasta knowledge-base nao encontrada
    echo        Execute setup.bat primeiro para instalacao limpa.
    exit /b 1
)

if not exist "despejo\daily-dump.md" (
    echo [ERRO] Arquivo critico nao encontrado: despejo\daily-dump.md
    echo        Execute setup.bat primeiro para instalacao limpa.
    exit /b 1
)

echo [OK] Instalacao dos Epicos 0-2 detectada!

REM Versao atual
if exist ".version" (
    set /p CURRENT_VERSION=<.version
    echo [i] Versao atual: !CURRENT_VERSION!
) else (
    set CURRENT_VERSION=Epic 0-2
    echo [i] Versao atual: Epic 0-2 (detectado pela estrutura)
)

REM ============================================
REM ETAPA 2: Comunicacao Clara ao Usuario
REM ============================================
echo.
echo ================================================
echo O QUE SERA FEITO:
echo ================================================
echo.
echo [+] SERA ADICIONADO:
echo    * Tutorial interativo para novos usuarios
echo    * Dashboard visual no Obsidian
echo    * Feedback de progresso e achievements
echo    * Backup automatico melhorado
echo    * Saudacao contextual nos agentes
echo    * Tour guiado no primeiro uso
echo.
echo [+] NAO SERA MODIFICADO:
echo    * Seus projetos, pessoas, decisoes (knowledge-base/)
echo    * Suas conversas com agentes (memoria preservada)
echo    * Suas customizacoes do Obsidian
echo    * Seu daily-dump.md
echo.
echo [!] Backup sera criado automaticamente
echo [!] Processo e reversivel via Git
echo.
echo Tempo estimado: ^< 30 segundos
echo.
echo ================================================
echo.

set /p CONFIRM="Deseja continuar com o upgrade? (sim/nao): "
if not "%CONFIRM%"=="sim" (
    echo [!] Upgrade cancelado pelo usuario.
    exit /b 0
)

echo.

REM ============================================
REM ETAPA 3: Backup Automatico Pre-Upgrade
REM ============================================
echo [i] Criando backup automatico...

for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
set BACKUP_FILE=backup-pre-epic3-!mydate!_!mytime!.zip

REM Criar backup usando PowerShell (disponivel no Windows 7+)
powershell -command "Compress-Archive -Path 'knowledge-base\.obsidian\*', '.assistant-core\memory\*', '.assistant-core\agents\*', '.assistant-core\data\*' -DestinationPath '%BACKUP_FILE%' -Force" 2>nul

if exist "%BACKUP_FILE%" (
    echo [OK] Backup criado em: %BACKUP_FILE%
) else (
    echo [ERRO] Falha ao criar backup. Abortando upgrade.
    exit /b 1
)

echo.

REM ============================================
REM ETAPA 4: Criar Arquivo .version
REM ============================================
echo [i] Atualizando versao do sistema...
echo Epic 3.0 > .version
echo [OK] Versao atualizada para Epic 3.0

REM ============================================
REM ETAPA 5: Criar Estrutura de Cache
REM ============================================
echo [i] Criando estrutura de cache...

if not exist ".assistant-core\data" mkdir ".assistant-core\data"

REM Criar dashboard-cache.yaml
(
echo # Dashboard Cache - Epic 3
echo # Atualizado automaticamente pelo sistema
echo.
echo ultima_atualizacao: null
echo despejos_processados: 0
echo conversas_total: 0
echo notas_criadas: 0
echo todos_completados: 0
echo todos_total: 0
echo streak_dias: 0
echo.
echo conversas_por_agente:
echo   organizador: 0
echo   secretaria: 0
echo   arquiteto: 0
echo   psicologo: 0
echo   mentor: 0
echo.
echo ultima_conversa_por_agente:
echo   organizador: null
echo   secretaria: null
echo   arquiteto: null
echo   psicologo: null
echo   mentor: null
echo.
echo achievements_desbloqueados: []
) > ".assistant-core\data\dashboard-cache.yaml"

echo [OK] Estrutura de cache criada

REM ============================================
REM ETAPA 6: Backup de Agentes
REM ============================================
echo [i] Criando backup dos agentes originais...

if not exist ".assistant-core\agents\backup-pre-epic3" mkdir ".assistant-core\agents\backup-pre-epic3"

copy ".assistant-core\agents\*.md" ".assistant-core\agents\backup-pre-epic3\" >nul 2>&1

if exist ".assistant-core\agents\backup-pre-epic3" (
    echo [OK] Backup de agentes criado
)

echo.

REM ============================================
REM ETAPA 7: Nota sobre Arquivos Epic 3
REM ============================================
echo [i] Arquivos Epic 3 serao criados pelo script Bash
echo [i] Execute 'bash scripts/upgrade-to-epic3.sh' para instalacao completa
echo     ou os arquivos serao criados automaticamente no primeiro uso

echo.

REM ============================================
REM ETAPA 8: Validacao Pos-Upgrade
REM ============================================
echo [i] Executando validacao pos-upgrade...

set VALIDATION_OK=1

for %%a in (organizador secretaria arquiteto psicologo mentor) do (
    if exist ".assistant-core\agents\%%a.md" (
        findstr /C:"agent:" ".assistant-core\agents\%%a.md" >nul
        if !errorlevel! equ 0 (
            echo   [OK] Agente %%a: OK
        ) else (
            echo   [!] Agente %%a pode ter problemas
            set VALIDATION_OK=0
        )
    ) else (
        echo   [!] Agente %%a nao encontrado
        set VALIDATION_OK=0
    )
)

if exist "knowledge-base\projetos" if exist "knowledge-base\pessoas" (
    echo   [OK] Knowledge-base: OK
) else (
    echo   [!] Estrutura da knowledge-base pode estar incompleta
)

echo.

REM ============================================
REM ETAPA 9: Conclusao
REM ============================================
if %VALIDATION_OK% equ 1 (
    echo [OK] Upgrade para Epic 3 concluido com sucesso!
) else (
    echo [!] Upgrade concluido mas com alguns avisos. Verifique os arquivos acima.
)

echo.
echo ================================================
echo PROXIMOS PASSOS
echo ================================================
echo.
echo 1. Abra o Obsidian na pasta knowledge-base/
echo 2. Execute: bash scripts/upgrade-to-epic3.sh (para arquivos completos)
echo 3. Explore o novo dashboard no Obsidian
echo 4. Execute /organizador para experimentar o tour guiado
echo.
echo [!] Backup criado em: %BACKUP_FILE%
echo [!] Rollback: git reset --hard ^<commit-anterior^>
echo.
echo ================================================
echo.

endlocal
exit /b 0
