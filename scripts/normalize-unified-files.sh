#!/bin/bash

# Script de Normalização dos Arquivos Únicos - Story 2.2.2
# Converte arquivos únicos para estrutura padrão esperada pelo sistema de consolidação

set -e

# Configurações
KNOWLEDGE_BASE="knowledge-base"
LOG_FILE="logs/normalize-$(date +"%Y%m%d_%H%M%S").log"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função de log
log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

echo -e "${YELLOW}=== Normalização dos Arquivos Únicos - Story 2.2.2 ===${NC}"
echo "Log: $LOG_FILE"
echo ""

mkdir -p logs

log "Iniciando normalização dos arquivos únicos"

# ===============================
# NORMALIZAÇÃO DE PESSOAS
# ===============================

echo -e "${YELLOW}1. Normalizando arquivos de pessoas...${NC}"

for file in "$KNOWLEDGE_BASE/pessoas/pessoa-"*.md; do
    if [ -f "$file" ]; then
        basename_file=$(basename "$file" .md)
        entity_name=${basename_file#pessoa-}

        log "Normalizando pessoa: $entity_name"

        # Backup do arquivo original
        cp "$file" "${file}.backup-$(date +%H%M%S)"

        # Extrair informações do arquivo atual
        title=$(grep "^# " "$file" | head -n1 | sed 's/^# //')

        # Ler conteúdo existente (ignorar frontmatter YAML)
        existing_content=$(awk '
            BEGIN { in_yaml = 0; content_started = 0 }
            /^---$/ && NR == 1 { in_yaml = 1; next }
            /^---$/ && in_yaml { in_yaml = 0; next }
            !in_yaml {
                if (!content_started && /^$/) next
                content_started = 1
                print
            }
        ' "$file")

        # Criar novo arquivo normalizado
        cat > "$file" << EOF
# $entity_name - Pessoa

## Metadados
\`\`\`yaml
tipo: pessoa
nome: $entity_name
tags: [pessoa]
created: $(date +"%Y-%m-%d")
updated: $(date +"%Y-%m-%d")
\`\`\`

## Histórico de Interações

### $(date +"%Y-%m-%d") - Migração da Story 2.2.1
$existing_content

## Projetos Relacionados

## Notas e Contexto

## Histórico de Modificações
- $(date +"%Y-%m-%d"): Arquivo normalizado para Story 2.2.2
EOF

        log "Pessoa $entity_name normalizada com sucesso"
    fi
done

# ===============================
# NORMALIZAÇÃO DE PROJETOS
# ===============================

echo -e "${YELLOW}2. Normalizando arquivos de projetos...${NC}"

for file in "$KNOWLEDGE_BASE/projetos/projeto-"*.md; do
    if [ -f "$file" ]; then
        basename_file=$(basename "$file" .md)
        entity_name=${basename_file#projeto-}

        log "Normalizando projeto: $entity_name"

        # Backup do arquivo original
        cp "$file" "${file}.backup-$(date +%H%M%S)"

        # Extrair informações do arquivo atual
        title=$(grep "^# " "$file" | head -n1 | sed 's/^# //' || echo "$entity_name")

        # Ler conteúdo existente (ignorar frontmatter YAML se existir)
        existing_content=$(awk '
            BEGIN { in_yaml = 0; content_started = 0 }
            /^---$/ && NR == 1 { in_yaml = 1; next }
            /^---$/ && in_yaml { in_yaml = 0; next }
            !in_yaml {
                if (!content_started && /^$/) next
                content_started = 1
                print
            }
        ' "$file")

        # Criar novo arquivo normalizado
        cat > "$file" << EOF
# $entity_name - Projeto

## Metadados
\`\`\`yaml
tipo: projeto
nome: $entity_name
tags: [projeto]
created: $(date +"%Y-%m-%d")
updated: $(date +"%Y-%m-%d")
\`\`\`

## Status e Progresso
**Status**: Em andamento

## Histórico de Desenvolvimento

### $(date +"%Y-%m-%d") - Migração da Story 2.2.1
$existing_content

## Pessoas Envolvidas

## Decisões Técnicas

## Notas e Contexto

## Histórico de Modificações
- $(date +"%Y-%m-%d"): Arquivo normalizado para Story 2.2.2
EOF

        log "Projeto $entity_name normalizado com sucesso"
    fi
done

# ===============================
# NORMALIZAÇÃO DE CONTEXTOS
# ===============================

echo -e "${YELLOW}3. Normalizando arquivos de contextos...${NC}"

for file in "$KNOWLEDGE_BASE/contextos/contexto-"*.md; do
    if [ -f "$file" ]; then
        basename_file=$(basename "$file" .md)
        entity_name=${basename_file#contexto-}

        log "Normalizando contexto: $entity_name"

        # Backup do arquivo original
        cp "$file" "${file}.backup-$(date +%H%M%S)"

        # Extrair informações do arquivo atual
        title=$(grep "^# " "$file" | head -n1 | sed 's/^# //' || echo "$entity_name")

        # Ler conteúdo existente (ignorar frontmatter YAML se existir)
        existing_content=$(awk '
            BEGIN { in_yaml = 0; content_started = 0 }
            /^---$/ && NR == 1 { in_yaml = 1; next }
            /^---$/ && in_yaml { in_yaml = 0; next }
            !in_yaml {
                if (!content_started && /^$/) next
                content_started = 1
                print
            }
        ' "$file")

        # Criar novo arquivo normalizado
        cat > "$file" << EOF
# $entity_name - Contexto

## Metadados
\`\`\`yaml
tipo: contexto
nome: $entity_name
tags: [contexto]
created: $(date +"%Y-%m-%d")
updated: $(date +"%Y-%m-%d")
\`\`\`

## Entradas

### $(date +"%Y-%m-%d") - Migração da Story 2.2.1
$existing_content

## Padrões Identificados

## Notas e Reflexões

## Histórico de Modificações
- $(date +"%Y-%m-%d"): Arquivo normalizado para Story 2.2.2
EOF

        log "Contexto $entity_name normalizado com sucesso"
    fi
done

echo -e "${GREEN}4. Normalização concluída!${NC}"

# Contar arquivos normalizados
pessoas_count=$(find "$KNOWLEDGE_BASE/pessoas" -name "pessoa-*.md" | wc -l)
projetos_count=$(find "$KNOWLEDGE_BASE/projetos" -name "projeto-*.md" | wc -l)
contextos_count=$(find "$KNOWLEDGE_BASE/contextos" -name "contexto-*.md" | wc -l)

echo -e "${GREEN}✅ Pessoas normalizadas: $pessoas_count${NC}"
echo -e "${GREEN}✅ Projetos normalizados: $projetos_count${NC}"
echo -e "${GREEN}✅ Contextos normalizados: $contextos_count${NC}"

log "Normalização concluída: $pessoas_count pessoas, $projetos_count projetos, $contextos_count contextos"

echo ""
echo -e "${YELLOW}Log detalhado: $LOG_FILE${NC}"
echo -e "${YELLOW}Backups criados com sufixo .backup-HHMMSS${NC}"