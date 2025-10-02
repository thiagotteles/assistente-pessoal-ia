@echo off
REM EXPORTAR-TUDO.bat - Export Manual para Backup Externo (Windows)
REM Sistema: Assistente Pessoal IA

setlocal enabledelayedexpansion

echo 📦 Exportador de Backup Completo - Assistente Pessoal IA
echo.
echo Este script vai criar um arquivo ZIP com TODOS os seus dados:
echo   • Knowledge-Base (projetos, pessoas, decisões)
echo   • Despejo (capturas diárias)
echo   • Todos (tarefas)
echo   • Diário (entradas pessoais)
echo   • Memória dos agentes
echo.
echo [!] Recomendado: Execute isso 1x por mês e salve em local seguro
echo    (Dropbox, Google Drive, HD externo, email para si mesmo, etc.)
echo.

REM Nome do arquivo
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
set EXPORT_FILE=assistente-backup-completo-!mydate!_!mytime!.zip

echo 📂 Criando arquivo: %EXPORT_FILE%
echo.

REM Verificar pastas existentes
set FOLDERS_EXIST=0

if exist "knowledge-base" (
    echo   ✓ knowledge-base/ encontrado
    set FOLDERS_EXIST=1
)

if exist "despejo" (
    echo   ✓ despejo/ encontrado
    set FOLDERS_EXIST=1
)

if exist "todos" (
    echo   ✓ todos/ encontrado
    set FOLDERS_EXIST=1
)

if exist "diario" (
    echo   ✓ diario/ encontrado
    set FOLDERS_EXIST=1
)

if exist ".assistant-core\memory" (
    echo   ✓ .assistant-core\memory\ encontrado
    set FOLDERS_EXIST=1
)

if exist ".assistant-core\agents" (
    echo   ✓ .assistant-core\agents\ encontrado
    set FOLDERS_EXIST=1
)

if exist ".assistant-core\data" (
    echo   ✓ .assistant-core\data\ encontrado
    set FOLDERS_EXIST=1
)

if exist ".version" (
    echo   ✓ .version encontrado
    set FOLDERS_EXIST=1
)

echo.

if %FOLDERS_EXIST% equ 0 (
    echo [ERRO] Nenhuma pasta do sistema encontrada. Execute setup.bat primeiro.
    exit /b 1
)

REM Criar ZIP usando PowerShell
echo 🗜️  Comprimindo arquivos...

powershell -command "Compress-Archive -Path 'knowledge-base\*', 'despejo\*', 'todos\*', 'diario\*', '.assistant-core\memory\*', '.assistant-core\agents\*', '.assistant-core\data\*', '.version' -DestinationPath '%EXPORT_FILE%' -Force -CompressionLevel Fastest" 2>nul

if exist "%EXPORT_FILE%" (
    REM Calcular tamanho
    for %%A in ("%EXPORT_FILE%") do set SIZE=%%~zA
    set /a SIZE_MB=!SIZE! / 1048576

    echo.
    echo [OK] Export concluído com sucesso!
    echo.
    echo 📦 Arquivo criado: %EXPORT_FILE%
    echo 📏 Tamanho: !SIZE_MB! MB (aproximado)
    echo.
    echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    echo PRÓXIMOS PASSOS - SALVE SEU BACKUP EM LOCAL SEGURO:
    echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    echo.
    echo 1. 💾 Copie para HD externo ou pen drive
    echo 2. ☁️  Upload para nuvem (Dropbox, Google Drive, OneDrive)
    echo 3. 📧 Envie por email para você mesmo
    echo 4. 🖥️  Copie para outro computador
    echo.
    echo Para restaurar no futuro:
    echo   • Descompacte o ZIP
    echo   • Execute setup.bat se necessário
    echo   • Abra o Obsidian na pasta knowledge-base\
    echo.

    REM Salvar timestamp
    echo %mydate%_%mytime% > ULTIMA-EXPORTACAO.txt
    echo [OK] Timestamp salvo em ULTIMA-EXPORTACAO.txt
    echo.
) else (
    echo.
    echo [ERRO] Erro ao criar backup. Verifique se há espaço em disco.
    exit /b 1
)

endlocal
exit /b 0
