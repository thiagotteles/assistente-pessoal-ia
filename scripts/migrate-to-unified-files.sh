#!/bin/bash

# Script de Migração para Arquivos Únicos - Story 2.2.1
# Migra pessoas, projetos e contextos para arquivos únicos por entidade

set -e  # Sair imediatamente se qualquer comando falhar

# Configurações
SOURCE_DIR="knowledge-base"
MIGRATION_LOG="logs/migration-2.2.1-$(date +"%Y%m%d_%H%M%S").log"
TEMP_DIR="temp/migration-$(date +"%Y%m%d_%H%M%S")"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função de log
log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$MIGRATION_LOG"
}

echo -e "${YELLOW}=== Migração para Arquivos Únicos - Story 2.2.1 ===${NC}"
echo "Log: $MIGRATION_LOG"
echo ""

# Criar diretórios necessários
mkdir -p logs temp
mkdir -p "$TEMP_DIR"

log "Iniciando migração para arquivos únicos"

# ===============================
# MIGRAÇÃO DE PESSOAS
# ===============================

echo -e "${BLUE}1. Migrando Pessoas...${NC}"
log "=== MIGRAÇÃO DE PESSOAS ==="

# Função para extrair nome base de pessoa
extract_person_name() {
    local filename="$1"
    # Remove extensão e data timestamp
    local basename=$(basename "$filename" .md)

    # Padrões conhecidos:
    # fabio-parceiro-2025-09-28 → fabio
    # joao-silva → joao-silva
    if [[ "$basename" =~ ^([a-zA-Z-]+)-[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "${BASH_REMATCH[1]}"
    elif [[ "$basename" =~ ^([a-zA-Z-]+)$ ]]; then
        echo "$basename"
    else
        # Caso complexo - pegar primeira parte antes do hífen
        echo "${basename%%-*}"
    fi
}

# Mapear arquivos de pessoas por nome base
declare -A person_files
for file in "$SOURCE_DIR/pessoas"/*.md; do
    if [ -f "$file" ]; then
        person_name=$(extract_person_name "$file")
        if [ -n "${person_files[$person_name]}" ]; then
            person_files[$person_name]="${person_files[$person_name]} $file"
        else
            person_files[$person_name]="$file"
        fi
        log "Pessoa detectada: $person_name -> $file"
    fi
done

# Migrar cada pessoa
for person in "${!person_files[@]}"; do
    echo -e "${YELLOW}  Migrando pessoa: $person${NC}"
    log "Processando pessoa: $person"

    files_array=(${person_files[$person]})
    unified_file="$SOURCE_DIR/pessoas/pessoa-$person.md"

    if [ ${#files_array[@]} -eq 1 ]; then
        # Apenas renomear
        original_file="${files_array[0]}"
        if [ "$original_file" != "$unified_file" ]; then
            log "Renomeando: $original_file -> $unified_file"
            mv "$original_file" "$unified_file"
        fi
    else
        # Consolidar múltiplos arquivos
        log "Consolidando ${#files_array[@]} arquivos para $person"

        # Criar arquivo consolidado
        cat > "$unified_file" << EOF
# $person - Pessoa

## Metadados
\`\`\`yaml
tipo: pessoa
nome: $person
tags: [pessoa]
created: $(date -r "${files_array[0]}" +"%Y-%m-%d" 2>/dev/null || date +"%Y-%m-%d")
updated: $(date +"%Y-%m-%d")
arquivos_origem: [$(printf '"%s", ' "${files_array[@]##*/}" | sed 's/, $//' )]
\`\`\`

## Histórico de Interações

EOF

        # Processar cada arquivo original
        for file in "${files_array[@]}"; do
            log "Consolidando arquivo: $file"
            filename=$(basename "$file")

            # Extrair data do filename se possível
            if [[ "$filename" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
                date_str="${BASH_REMATCH[1]}"
            else
                date_str=$(date -r "$file" +"%Y-%m-%d" 2>/dev/null || date +"%Y-%m-%d")
            fi

            echo "### $date_str - $(basename "$file" .md)" >> "$unified_file"
            echo "" >> "$unified_file"

            # Copiar conteúdo, ignorando frontmatter YAML
            awk '
                BEGIN { in_yaml = 0; content_started = 0 }
                /^---$/ && NR == 1 { in_yaml = 1; next }
                /^---$/ && in_yaml { in_yaml = 0; next }
                !in_yaml {
                    if (!content_started && /^$/) next
                    content_started = 1
                    print
                }
            ' "$file" >> "$unified_file"

            echo "" >> "$unified_file"
            echo "" >> "$unified_file"

            # Mover arquivo original para temp
            mv "$file" "$TEMP_DIR/"
        done

        # Adicionar seções padrão
        cat >> "$unified_file" << EOF
## Projetos Relacionados
<!-- Links para projetos serão adicionados automaticamente -->

## Notas e Contexto
<!-- Informações consolidadas -->

## Histórico de Modificações
- $date_str: Migração para arquivo único (Story 2.2.1)
EOF
    fi

    log "Pessoa $person migrada com sucesso"
done

# ===============================
# MIGRAÇÃO DE PROJETOS
# ===============================

echo -e "${BLUE}2. Migrando Projetos...${NC}"
log "=== MIGRAÇÃO DE PROJETOS ==="

# Função para extrair nome base de projeto
extract_project_name() {
    local filename="$1"
    local basename=$(basename "$filename" .md)

    # Padrões conhecidos:
    # onboarding-inicio-2025-09-28 → onboarding
    # sistema-alpha → sistema-alpha
    if [[ "$basename" =~ ^([a-zA-Z-]+)-[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        echo "$basename"
    fi
}

# Mapear arquivos de projetos por nome base
declare -A project_files
for file in "$SOURCE_DIR/projetos"/*.md; do
    if [ -f "$file" ]; then
        project_name=$(extract_project_name "$file")
        if [ -n "${project_files[$project_name]}" ]; then
            project_files[$project_name]="${project_files[$project_name]} $file"
        else
            project_files[$project_name]="$file"
        fi
        log "Projeto detectado: $project_name -> $file"
    fi
done

# Migrar cada projeto
for project in "${!project_files[@]}"; do
    echo -e "${YELLOW}  Migrando projeto: $project${NC}"
    log "Processando projeto: $project"

    files_array=(${project_files[$project]})
    unified_file="$SOURCE_DIR/projetos/projeto-$project.md"

    if [ ${#files_array[@]} -eq 1 ]; then
        # Apenas renomear se necessário
        original_file="${files_array[0]}"
        if [ "$original_file" != "$unified_file" ]; then
            log "Renomeando: $original_file -> $unified_file"
            mv "$original_file" "$unified_file"
        fi
    else
        # Consolidar múltiplos arquivos
        log "Consolidando ${#files_array[@]} arquivos para $project"

        # Criar arquivo consolidado
        cat > "$unified_file" << EOF
# $project - Projeto

## Metadados
\`\`\`yaml
tipo: projeto
nome: $project
tags: [projeto]
created: $(date -r "${files_array[0]}" +"%Y-%m-%d" 2>/dev/null || date +"%Y-%m-%d")
updated: $(date +"%Y-%m-%d")
arquivos_origem: [$(printf '"%s", ' "${files_array[@]##*/}" | sed 's/, $//' )]
\`\`\`

## Status e Progresso
<!-- Status atual do projeto -->

## Histórico de Desenvolvimento

EOF

        # Processar cada arquivo original
        for file in "${files_array[@]}"; do
            log "Consolidando arquivo: $file"
            filename=$(basename "$file")

            # Extrair data do filename se possível
            if [[ "$filename" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
                date_str="${BASH_REMATCH[1]}"
            else
                date_str=$(date -r "$file" +"%Y-%m-%d" 2>/dev/null || date +"%Y-%m-%d")
            fi

            echo "### $date_str - $(basename "$file" .md)" >> "$unified_file"
            echo "" >> "$unified_file"

            # Copiar conteúdo, ignorando frontmatter YAML
            awk '
                BEGIN { in_yaml = 0; content_started = 0 }
                /^---$/ && NR == 1 { in_yaml = 1; next }
                /^---$/ && in_yaml { in_yaml = 0; next }
                !in_yaml {
                    if (!content_started && /^$/) next
                    content_started = 1
                    print
                }
            ' "$file" >> "$unified_file"

            echo "" >> "$unified_file"
            echo "" >> "$unified_file"

            # Mover arquivo original para temp
            mv "$file" "$TEMP_DIR/"
        done

        # Adicionar seções padrão
        cat >> "$unified_file" << EOF
## Pessoas Envolvidas
<!-- Links para pessoas serão adicionados automaticamente -->

## Decisões Técnicas
<!-- Decisões importantes do projeto -->

## Notas e Contexto
<!-- Informações consolidadas -->

## Histórico de Modificações
- $date_str: Migração para arquivo único (Story 2.2.1)
EOF
    fi

    log "Projeto $project migrado com sucesso"
done

# ===============================
# MIGRAÇÃO DE CONTEXTOS
# ===============================

echo -e "${BLUE}3. Migrando Contextos...${NC}"
log "=== MIGRAÇÃO DE CONTEXTOS ==="

# Função para extrair nome base de contexto
extract_context_name() {
    local filepath="$1"
    local dirname=$(dirname "$filepath")
    local filename="$1"
    local basename=$(basename "$filename" .md)

    # Se está em subdiretório, usar nome do subdiretório
    if [[ "$dirname" == *"/contextos/"* ]]; then
        local subdir=$(basename "$dirname")
        echo "$subdir"
    else
        # Extrair de filename com timestamp
        if [[ "$basename" =~ ^([a-zA-Z-]+)-[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            echo "${BASH_REMATCH[1]}"
        else
            echo "$basename"
        fi
    fi
}

# Mapear arquivos de contextos por nome base
declare -A context_files
for file in $(find "$SOURCE_DIR/contextos" -name "*.md" -type f); do
    if [ -f "$file" ]; then
        context_name=$(extract_context_name "$file")
        if [ -n "${context_files[$context_name]}" ]; then
            context_files[$context_name]="${context_files[$context_name]} $file"
        else
            context_files[$context_name]="$file"
        fi
        log "Contexto detectado: $context_name -> $file"
    fi
done

# Migrar cada contexto
for context in "${!context_files[@]}"; do
    echo -e "${YELLOW}  Migrando contexto: $context${NC}"
    log "Processando contexto: $context"

    files_array=(${context_files[$context]})
    unified_file="$SOURCE_DIR/contextos/contexto-$context.md"

    if [ ${#files_array[@]} -eq 1 ]; then
        # Mover e renomear
        original_file="${files_array[0]}"
        log "Movendo: $original_file -> $unified_file"

        # Criar conteúdo no novo local
        cat > "$unified_file" << EOF
# $context - Contexto

## Metadados
\`\`\`yaml
tipo: contexto
nome: $context
tags: [contexto]
created: $(date -r "$original_file" +"%Y-%m-%d" 2>/dev/null || date +"%Y-%m-%d")
updated: $(date +"%Y-%m-%d")
arquivos_origem: ["$(basename "$original_file")"]
\`\`\`

## Entradas

### $(date -r "$original_file" +"%Y-%m-%d" 2>/dev/null || date +"%Y-%m-%d") - $(basename "$original_file" .md)

EOF

        # Copiar conteúdo original
        awk '
            BEGIN { in_yaml = 0; content_started = 0 }
            /^---$/ && NR == 1 { in_yaml = 1; next }
            /^---$/ && in_yaml { in_yaml = 0; next }
            !in_yaml {
                if (!content_started && /^$/) next
                content_started = 1
                print
            }
        ' "$original_file" >> "$unified_file"

        # Remover arquivo original
        rm -rf "$(dirname "$original_file")"
    else
        # Consolidar múltiplos arquivos
        log "Consolidando ${#files_array[@]} arquivos para $context"

        # Criar arquivo consolidado
        cat > "$unified_file" << EOF
# $context - Contexto

## Metadados
\`\`\`yaml
tipo: contexto
nome: $context
tags: [contexto]
created: $(date -r "${files_array[0]}" +"%Y-%m-%d" 2>/dev/null || date +"%Y-%m-%d")
updated: $(date +"%Y-%m-%d")
arquivos_origem: [$(printf '"%s", ' "${files_array[@]##*/}" | sed 's/, $//' )]
\`\`\`

## Entradas

EOF

        # Processar cada arquivo original
        for file in "${files_array[@]}"; do
            log "Consolidando arquivo: $file"
            filename=$(basename "$file")

            # Extrair data do filename se possível
            if [[ "$filename" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
                date_str="${BASH_REMATCH[1]}"
            else
                date_str=$(date -r "$file" +"%Y-%m-%d" 2>/dev/null || date +"%Y-%m-%d")
            fi

            echo "### $date_str - $(basename "$file" .md)" >> "$unified_file"
            echo "" >> "$unified_file"

            # Copiar conteúdo, ignorando frontmatter YAML
            awk '
                BEGIN { in_yaml = 0; content_started = 0 }
                /^---$/ && NR == 1 { in_yaml = 1; next }
                /^---$/ && in_yaml { in_yaml = 0; next }
                !in_yaml {
                    if (!content_started && /^$/) next
                    content_started = 1
                    print
                }
            ' "$file" >> "$unified_file"

            echo "" >> "$unified_file"
            echo "" >> "$unified_file"

            # Remover subdiretório original
            rm -rf "$(dirname "$file")"
        done

        # Adicionar seções padrão
        cat >> "$unified_file" << EOF

## Padrões Identificados
<!-- Padrões observados neste contexto -->

## Notas e Reflexões
<!-- Insights e observações -->

## Histórico de Modificações
- $(date +"%Y-%m-%d"): Migração para arquivo único (Story 2.2.1)
EOF
    fi

    log "Contexto $context migrado com sucesso"
done

# ===============================
# RELATÓRIO FINAL
# ===============================

echo -e "${GREEN}4. Migração Concluída!${NC}"
log "=== MIGRAÇÃO CONCLUÍDA ==="

# Contar arquivos finais
final_pessoas=$(find "$SOURCE_DIR/pessoas" -name "pessoa-*.md" | wc -l)
final_projetos=$(find "$SOURCE_DIR/projetos" -name "projeto-*.md" | wc -l)
final_contextos=$(find "$SOURCE_DIR/contextos" -name "contexto-*.md" | wc -l)

echo -e "${GREEN}  ✅ Pessoas migradas: $final_pessoas${NC}"
echo -e "${GREEN}  ✅ Projetos migrados: $final_projetos${NC}"
echo -e "${GREEN}  ✅ Contextos migrados: $final_contextos${NC}"

log "Pessoas migradas: $final_pessoas"
log "Projetos migrados: $final_projetos"
log "Contextos migrados: $final_contextos"
log "Arquivos originais movidos para: $TEMP_DIR"

echo ""
echo -e "${YELLOW}Log completo: $MIGRATION_LOG${NC}"
echo -e "${YELLOW}Arquivos originais: $TEMP_DIR${NC}"
echo ""