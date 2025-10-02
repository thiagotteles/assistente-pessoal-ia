@echo off
REM atualizar-progresso-visual.bat - Atualiza PROGRESSO-VISUAL.md (Windows)
REM Sistema: Assistente Pessoal IA

setlocal enabledelayedexpansion

set PROGRESSO_FILE=todos\PROGRESSO-VISUAL.md

REM Criar diretório se não existir
if not exist "todos" mkdir "todos"

REM Contar todos
set /a TOTAL_TODOS=0
set /a COMPLETADOS_TODOS=0

if exist "todos" (
    for /f %%i in ('findstr /s /c:"- [" todos\*.md 2^>nul ^| find /c /v ""') do set TOTAL_TODOS=%%i
    for /f %%i in ('findstr /s /c:"- [x]" todos\*.md 2^>nul ^| find /c /v ""') do set COMPLETADOS_TODOS=%%i
)

REM Calcular progresso
set /a PERCENT=0
if !TOTAL_TODOS! GTR 0 (
    set /a PERCENT=COMPLETADOS_TODOS * 100 / TOTAL_TODOS
)

REM Gerar barra de progresso
set /a FILLED=PERCENT / 10
set /a EMPTY=10 - FILLED
set BARRA=
for /l %%i in (1,1,!FILLED!) do set BARRA=!BARRA!█
for /l %%i in (1,1,!EMPTY!) do set BARRA=!BARRA!░

REM Gerar arquivo
(
echo # ✅ Progresso Visual de Todos
echo.
echo **Última atualização**: %date% às %time:~0,5%
echo.
echo ---
echo.
echo ## 📊 Visão Geral
echo.
echo **!COMPLETADOS_TODOS! de !TOTAL_TODOS!** todos completados
echo.
echo !BARRA! !PERCENT!%%
echo.
echo ---
echo.
echo ## 📋 Por Projeto
echo.
echo *(Liste seus projetos aqui)*
echo.
echo ---
echo.
echo ## 🎯 Metas de Carreira
echo.
echo *(Configure suas metas conversando com o Mentor - Leonardo)*
echo.
echo Use `/mentor` para definir e acompanhar suas metas de carreira.
echo.
echo ---
echo.
echo ## 💡 Próximo Passo Sugerido
echo.
if !COMPLETADOS_TODOS! EQU 0 if !TOTAL_TODOS! GTR 0 (
    echo 🚀 Comece completando seu primeiro todo!
) else if !TOTAL_TODOS! EQU 0 (
    echo 📝 Crie seus primeiros todos conversando com a Secretária: `/secretaria`
) else (
    if !PERCENT! GEQ 80 (
        echo 🎉 Parabéns! Você está quase lá. Complete os últimos todos!
    ) else if !PERCENT! GEQ 50 (
        echo 💪 Metade do caminho! Continue assim!
    ) else (
        echo 🌟 Foco no próximo todo da lista!
    )
)
echo.
echo ---
echo.
echo 💡 **Dica**: Este progresso é atualizado automaticamente quando você completa todos.
) > "%PROGRESSO_FILE%"

echo ✅ Progresso visual atualizado: %PROGRESSO_FILE%

endlocal
