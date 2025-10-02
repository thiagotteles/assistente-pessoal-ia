@echo off
REM atualizar-dashboard.bat - Atualiza MEU-DASHBOARD.md (Windows)
REM Sistema: Assistente Pessoal IA

setlocal enabledelayedexpansion

set CACHE_FILE=.assistant-core\data\dashboard-cache.yaml
set DASHBOARD_FILE=knowledge-base\📈 MEU-DASHBOARD.md

echo 🔄 Atualizando dashboard...

REM Contar arquivos (simplificado)
set /a DESPEJOS=0
set /a NOTAS=0
set /a TODOS_COMP=0
set /a TODOS_TOTAL=0
set /a CONVERSAS=0
set /a STREAK=1

if exist "despejo\processed" (
    for /f %%i in ('dir /b /a-d "despejo\processed\*.md" 2^>nul ^| find /c /v ""') do set DESPEJOS=%%i
)

if exist "knowledge-base" (
    for /f %%i in ('dir /b /a-d "knowledge-base\*.md" 2^>nul ^| find /c /v ""') do set NOTAS=%%i
)

if exist "todos" (
    for /f %%i in ('findstr /s /c:"- [x]" todos\*.md 2^>nul ^| find /c /v ""') do set TODOS_COMP=%%i
    for /f %%i in ('findstr /s /c:"- [" todos\*.md 2^>nul ^| find /c /v ""') do set TODOS_TOTAL=%%i
)

REM Contar conversas por agente
set /a CONV_ORG=0
set /a CONV_SEC=0
set /a CONV_ARQ=0
set /a CONV_PSI=0
set /a CONV_MEN=0

if exist ".assistant-core\memory" (
    for /f %%i in ('dir /b /a-d ".assistant-core\memory\*organizador*" 2^>nul ^| find /c /v ""') do set CONV_ORG=%%i
    for /f %%i in ('dir /b /a-d ".assistant-core\memory\*secretaria*" 2^>nul ^| find /c /v ""') do set CONV_SEC=%%i
    for /f %%i in ('dir /b /a-d ".assistant-core\memory\*arquiteto*" 2^>nul ^| find /c /v ""') do set CONV_ARQ=%%i
    for /f %%i in ('dir /b /a-d ".assistant-core\memory\*psicologo*" 2^>nul ^| find /c /v ""') do set CONV_PSI=%%i
    for /f %%i in ('dir /b /a-d ".assistant-core\memory\*mentor*" 2^>nul ^| find /c /v ""') do set CONV_MEN=%%i
)

set /a CONVERSAS=CONV_ORG + CONV_SEC + CONV_ARQ + CONV_PSI + CONV_MEN

REM Calcular progresso
set /a PERCENT=0
if !TODOS_TOTAL! GTR 0 (
    set /a PERCENT=TODOS_COMP * 100 / TODOS_TOTAL
)

REM Gerar barra de progresso
set /a FILLED=PERCENT / 10
set /a EMPTY=10 - FILLED
set BARRA=
for /l %%i in (1,1,!FILLED!) do set BARRA=!BARRA!█
for /l %%i in (1,1,!EMPTY!) do set BARRA=!BARRA!░

REM Determinar emoji de streak
set STREAK_EMOJI=🌱
if !STREAK! GEQ 7 (
    set STREAK_EMOJI=🔥🔥🔥
) else if !STREAK! GEQ 3 (
    set STREAK_EMOJI=🔥
)

REM Mensagem de streak
set STREAK_MSG=💪 Vamos começar um novo streak!
if !STREAK! GEQ 7 (
    set STREAK_MSG=🎉 Incrível! Você está em chamas!
) else if !STREAK! GEQ 3 (
    set STREAK_MSG=👏 Muito bem! Continue assim!
)

REM Criar diretório se não existir
if not exist "knowledge-base" mkdir "knowledge-base"

REM Gerar dashboard
(
echo # 📈 Meu Dashboard
echo.
echo **Última atualização**: %date% às %time:~0,5%
echo.
echo ---
echo.
echo ## 📊 Esta Semana
echo.
echo ^| Métrica ^| Valor ^|
echo ^|---------|-------^|
echo ^| 📝 Despejos processados ^| !DESPEJOS! ^|
echo ^| 💬 Conversas com agentes ^| !CONVERSAS! ^|
echo ^| 📄 Notas criadas ^| !NOTAS! ^|
echo ^| ✅ Todos completados ^| !TODOS_COMP! / !TODOS_TOTAL! ^|
echo.
echo ---
echo.
echo ## 🤖 Uso dos Agentes
echo.
echo ^| Agente ^| Conversas ^| Última vez ^|
echo ^|--------|-----------|------------^|
echo ^| 📋 Organizador (Sofia^) ^| !CONV_ORG! ^| - ^|
echo ^| 📅 Secretária ^| !CONV_SEC! ^| - ^|
echo ^| 🏗️ Arquiteto (Marcus^) ^| !CONV_ARQ! ^| - ^|
echo ^| 🧠 Psicólogo (Dr. Helena^) ^| !CONV_PSI! ^| - ^|
echo ^| 🎯 Mentor (Leonardo^) ^| !CONV_MEN! ^| - ^|
echo.
echo ---
echo.
echo ## !STREAK_EMOJI! Streak
echo.
echo **!STREAK! dias consecutivos** usando o sistema!
echo.
echo !STREAK_MSG!
echo.
echo ---
echo.
echo ## ✅ Progresso em Todos
echo.
echo **!PERCENT!%%** completo
echo.
echo !BARRA!
echo.
echo ---
echo.
echo ## 🏆 Achievements Desbloqueados
echo.
echo Em breve: sistema de achievements!
echo.
echo ---
echo.
echo ## 📝 Últimas Atividades
echo.
echo 1. Dashboard criado automaticamente
echo 2. Sistema de feedback visual ativo
echo 3. Pronto para uso!
echo.
echo ---
echo.
echo 💡 **Dica**: Este dashboard é atualizado automaticamente. Continue usando o sistema para ver seu progresso crescer!
) > "%DASHBOARD_FILE%"

echo ✅ Dashboard atualizado: %DASHBOARD_FILE%

endlocal
