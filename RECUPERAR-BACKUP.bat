@echo off
REM RECUPERAR-BACKUP.bat - Recovery Simples para Usuários (Windows)
REM Sistema: Assistente Pessoal IA

setlocal enabledelayedexpansion

echo 🔄 Recuperador de Backup - Assistente Pessoal IA
echo.
echo Últimos 10 backups disponíveis:
echo.

REM Listar últimos 10 commits de forma amigável
git log -10 --pretty=format:"[%%h] %%ad - %%s" --date=format:"%%d/%%m/%%Y %%H:%%M" 2>nul

if %errorlevel% neq 0 (
    echo [ERRO] Git não está inicializado neste diretório.
    echo.
    echo Backups ZIP disponíveis:
    dir /B /O-D backup-pre-epic3-*.zip 2>nul | findstr /N "^" | findstr /R "^[1-9]:"
    if %errorlevel% neq 0 echo Nenhum backup ZIP encontrado
    exit /b 1
)

echo.
echo.
set /p backup_hash="Digite o código [XXXX] do backup que deseja recuperar: "

REM Validação
if "%backup_hash%"=="" (
    echo [ERRO] Nenhum código fornecido. Operação cancelada.
    exit /b 1
)

REM Confirmação
echo.
echo [ATENÇÃO] Isso vai restaurar seus arquivos para o estado do backup escolhido.
echo           Alterações não salvas desde esse backup serão perdidas.
echo.
set /p confirmacao="Tem certeza? (sim/nao): "

if not "%confirmacao%"=="sim" (
    echo [!] Operação cancelada.
    exit /b 0
)

REM Recovery
echo.
echo 🔄 Restaurando backup...
git reset --hard %backup_hash%

if %errorlevel% equ 0 (
    echo [OK] Backup restaurado com sucesso!
    echo 📂 Abra o Obsidian para ver seus arquivos restaurados.
) else (
    echo [ERRO] Erro ao restaurar backup. Entre em contato com suporte.
    exit /b 1
)

endlocal
exit /b 0
