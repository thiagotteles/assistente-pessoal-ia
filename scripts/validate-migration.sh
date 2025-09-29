#!/bin/bash

# Script de Validação da Migração - Story 2.2.1
# Verifica integridade após migração para arquivos únicos

set -e

# Configurações
SOURCE_DIR="knowledge-base"
VALIDATION_LOG="logs/validation-2.2.1-$(date +"%Y%m%d_%H%M%S").log"
TEMP_DIR_PATTERN="temp/migration-*"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Contadores
ERRORS=0
WARNINGS=0
VALIDATIONS=0

# Função de log
log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$VALIDATION_LOG"
}

# Função de erro
error() {
    echo -e "${RED}❌ ERRO: $1${NC}" | tee -a "$VALIDATION_LOG"
    ((ERRORS++))
}

# Função de warning
warning() {
    echo -e "${YELLOW}⚠️  AVISO: $1${NC}" | tee -a "$VALIDATION_LOG"
    ((WARNINGS++))
}

# Função de sucesso
success() {
    echo -e "${GREEN}✅ $1${NC}" | tee -a "$VALIDATION_LOG"
    ((VALIDATIONS++))
}

echo -e "${YELLOW}=== Validação da Migração - Story 2.2.1 ===${NC}"
echo "Log: $VALIDATION_LOG"
echo ""

mkdir -p logs
log "Iniciando validação da migração"

# ===============================
# 1. VERIFICAR ESTRUTURA ESPERADA
# ===============================

echo -e "${BLUE}1. Verificando estrutura de arquivos...${NC}"
log "=== VALIDAÇÃO DE ESTRUTURA ==="

# Verificar se existem arquivos únicos esperados
expected_pessoas=("pessoa-fabio.md" "pessoa-joao-silva.md" "pessoa-maria-santos.md")
expected_projetos=("projeto-onboarding.md" "projeto-sistema-alpha.md")
expected_contextos=("contexto-bem-estar.md")

for pessoa in "${expected_pessoas[@]}"; do
    if [ -f "$SOURCE_DIR/pessoas/$pessoa" ]; then
        success "Pessoa encontrada: $pessoa"
    else
        error "Pessoa não encontrada: $pessoa"
    fi
done

for projeto in "${expected_projetos[@]}"; do
    if [ -f "$SOURCE_DIR/projetos/$projeto" ]; then
        success "Projeto encontrado: $projeto"
    else
        error "Projeto não encontrado: $projeto"
    fi
done

for contexto in "${expected_contextos[@]}"; do
    if [ -f "$SOURCE_DIR/contextos/$contexto" ]; then
        success "Contexto encontrado: $contexto"
    else
        error "Contexto não encontrado: $contexto"
    fi
done

# ===============================
# 2. VERIFICAR PADRÃO DE NOMEAÇÃO
# ===============================

echo -e "${BLUE}2. Verificando padrões de nomeação...${NC}"
log "=== VALIDAÇÃO DE NOMEAÇÃO ==="

# Verificar se todos os arquivos seguem o padrão
pessoas_files=$(find "$SOURCE_DIR/pessoas" -name "*.md" -type f)
for file in $pessoas_files; do
    basename_file=$(basename "$file")
    if [[ "$basename_file" =~ ^pessoa-[a-zA-Z-]+\.md$ ]]; then
        success "Padrão de nomeação correto: $basename_file"
    else
        error "Padrão de nomeação incorreto: $basename_file"
    fi
done

projetos_files=$(find "$SOURCE_DIR/projetos" -name "*.md" -type f)
for file in $projetos_files; do
    basename_file=$(basename "$file")
    if [[ "$basename_file" =~ ^projeto-[a-zA-Z-]+\.md$ ]]; then
        success "Padrão de nomeação correto: $basename_file"
    else
        error "Padrão de nomeação incorreto: $basename_file"
    fi
done

contextos_files=$(find "$SOURCE_DIR/contextos" -name "*.md" -type f)
for file in $contextos_files; do
    basename_file=$(basename "$file")
    if [[ "$basename_file" =~ ^contexto-[a-zA-Z-]+\.md$ ]]; then
        success "Padrão de nomeação correto: $basename_file"
    else
        error "Padrão de nomeação incorreto: $basename_file"
    fi
done

# ===============================
# 3. VALIDAR CONTEÚDO DOS ARQUIVOS
# ===============================

echo -e "${BLUE}3. Validando conteúdo dos arquivos...${NC}"
log "=== VALIDAÇÃO DE CONTEÚDO ==="

# Verificar se arquivos não estão vazios
total_files=$(find "$SOURCE_DIR" -name "*.md" -type f)
for file in $total_files; do
    if [ -s "$file" ]; then
        success "Arquivo não vazio: $(basename "$file")"
    else
        error "Arquivo vazio: $(basename "$file")"
    fi
done

# Verificar se arquivos têm conteúdo mínimo esperado
for file in $pessoas_files; do
    if grep -q "# .* - Pessoa" "$file"; then
        success "Cabeçalho de pessoa encontrado: $(basename "$file")"
    else
        error "Cabeçalho de pessoa não encontrado: $(basename "$file")"
    fi
done

for file in $projetos_files; do
    if grep -q "# .* - Projeto" "$file" 2>/dev/null; then
        success "Cabeçalho de projeto encontrado: $(basename "$file")"
    else
        warning "Cabeçalho de projeto não encontrado ou arquivo não migrado: $(basename "$file")"
    fi
done

for file in $contextos_files; do
    if grep -q "# .* - Contexto" "$file"; then
        success "Cabeçalho de contexto encontrado: $(basename "$file")"
    else
        error "Cabeçalho de contexto não encontrado: $(basename "$file")"
    fi
done

# ===============================
# 4. VERIFICAR REFERÊNCIAS [[]]
# ===============================

echo -e "${BLUE}4. Verificando referências [[]]...${NC}"
log "=== VALIDAÇÃO DE REFERÊNCIAS ==="

# Extrair todas as referências [[]] dos arquivos
all_references=$(grep -ho '\[\[[^]]*\]\]' "$SOURCE_DIR"/**/*.md 2>/dev/null | sort | uniq || true)

if [ -n "$all_references" ]; then
    success "Referências [[]] encontradas:"
    echo "$all_references" | while read -r ref; do
        log "  Referência: $ref"
    done
else
    warning "Nenhuma referência [[]] encontrada"
fi

# ===============================
# 5. VERIFICAR INTEGRIDADE DOS BACKUPS
# ===============================

echo -e "${BLUE}5. Verificando backups e arquivos temporários...${NC}"
log "=== VALIDAÇÃO DE BACKUPS ==="

# Verificar se backup foi criado
if ls backups/knowledge-base/kb_backup_* 1> /dev/null 2>&1; then
    success "Backup da knowledge-base encontrado"
    latest_backup=$(ls -t backups/knowledge-base/kb_backup_* | head -n1)
    log "Último backup: $latest_backup"
else
    error "Nenhum backup encontrado"
fi

# Verificar se arquivos temporários existem
if ls $TEMP_DIR_PATTERN 1> /dev/null 2>&1; then
    success "Arquivos temporários da migração encontrados"
    for temp_dir in $TEMP_DIR_PATTERN; do
        if [ -d "$temp_dir" ]; then
            temp_count=$(find "$temp_dir" -name "*.md" | wc -l)
            log "Arquivos em $temp_dir: $temp_count"
        fi
    done
else
    warning "Nenhum arquivo temporário encontrado (pode ser normal)"
fi

# ===============================
# 6. CONTAGEM FINAL
# ===============================

echo -e "${BLUE}6. Estatísticas finais...${NC}"
log "=== ESTATÍSTICAS FINAIS ==="

final_pessoas=$(find "$SOURCE_DIR/pessoas" -name "pessoa-*.md" | wc -l)
final_projetos=$(find "$SOURCE_DIR/projetos" -name "projeto-*.md" | wc -l)
final_contextos=$(find "$SOURCE_DIR/contextos" -name "contexto-*.md" | wc -l)
final_total=$(find "$SOURCE_DIR" -name "*.md" | wc -l)

log "Pessoas: $final_pessoas arquivos"
log "Projetos: $final_projetos arquivos"
log "Contextos: $final_contextos arquivos"
log "Total: $final_total arquivos"

echo -e "${GREEN}  📊 Pessoas: $final_pessoas${NC}"
echo -e "${GREEN}  📊 Projetos: $final_projetos${NC}"
echo -e "${GREEN}  📊 Contextos: $final_contextos${NC}"
echo -e "${GREEN}  📊 Total: $final_total${NC}"

# ===============================
# RELATÓRIO FINAL
# ===============================

echo ""
echo -e "${BLUE}=== RELATÓRIO DE VALIDAÇÃO ===${NC}"
log "=== RELATÓRIO FINAL ==="

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}🎉 MIGRAÇÃO VALIDADA COM SUCESSO!${NC}"
    log "RESULTADO: SUCESSO COMPLETO"
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  MIGRAÇÃO CONCLUÍDA COM AVISOS${NC}"
    log "RESULTADO: SUCESSO COM AVISOS"
else
    echo -e "${RED}❌ MIGRAÇÃO TEM PROBLEMAS${NC}"
    log "RESULTADO: FALHAS DETECTADAS"
fi

echo -e "${GREEN}  ✅ Validações bem-sucedidas: $VALIDATIONS${NC}"
if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}  ⚠️  Avisos: $WARNINGS${NC}"
fi
if [ $ERRORS -gt 0 ]; then
    echo -e "${RED}  ❌ Erros: $ERRORS${NC}"
fi

log "Validações: $VALIDATIONS | Avisos: $WARNINGS | Erros: $ERRORS"

echo ""
echo -e "${YELLOW}Log detalhado: $VALIDATION_LOG${NC}"

# Exit code baseado nos erros
if [ $ERRORS -eq 0 ]; then
    exit 0
else
    exit 1
fi