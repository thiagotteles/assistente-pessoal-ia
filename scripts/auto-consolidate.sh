#!/bin/bash

# Script de Consolidação Automática - Story 2.2.2
# Detecta entidades em texto livre e consolida automaticamente nos arquivos únicos

set -e

# Configurações
KNOWLEDGE_BASE="knowledge-base"
LOG_FILE="logs/auto-consolidate-$(date +"%Y%m%d_%H%M%S").log"
TEMP_DIR="temp/consolidation-$(date +"%Y%m%d_%H%M%S")"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função de log
log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

echo -e "${YELLOW}=== Sistema de Consolidação Automática - Story 2.2.2 ===${NC}"
echo "Log: $LOG_FILE"
echo ""

# Criar diretórios necessários
mkdir -p logs temp
mkdir -p "$TEMP_DIR"

# ===============================
# DETECTOR DE ENTIDADES
# ===============================

log "Iniciando sistema de consolidação automática"

# Função para extrair entidades conhecidas do knowledge-base
build_entity_database() {
    log "Construindo base de entidades conhecidas"

    # Pessoas conhecidas
    KNOWN_PEOPLE=()
    for file in "$KNOWLEDGE_BASE/pessoas/pessoa-"*.md; do
        if [ -f "$file" ]; then
            # Extrair nome do arquivo: pessoa-{nome}.md → {nome}
            basename_file=$(basename "$file" .md)
            entity_name=${basename_file#pessoa-}
            KNOWN_PEOPLE+=("$entity_name")
            log "Pessoa conhecida: $entity_name"
        fi
    done

    # Projetos conhecidos
    KNOWN_PROJECTS=()
    for file in "$KNOWLEDGE_BASE/projetos/projeto-"*.md; do
        if [ -f "$file" ]; then
            basename_file=$(basename "$file" .md)
            entity_name=${basename_file#projeto-}
            KNOWN_PROJECTS+=("$entity_name")
            log "Projeto conhecido: $entity_name"
        fi
    done

    # Contextos conhecidos
    KNOWN_CONTEXTS=()
    for file in "$KNOWLEDGE_BASE/contextos/contexto-"*.md; do
        if [ -f "$file" ]; then
            basename_file=$(basename "$file" .md)
            entity_name=${basename_file#contexto-}
            KNOWN_CONTEXTS+=("$entity_name")
            log "Contexto conhecido: $entity_name"
        fi
    done
}

# Função de fuzzy matching simples
fuzzy_match() {
    local input="$1"
    local type="$2"
    local best_match=""
    local best_score=0

    case "$type" in
        "pessoa")
            for entity in "${KNOWN_PEOPLE[@]}"; do
                score=$(calculate_similarity "$input" "$entity")
                if [ "$score" -gt "$best_score" ] && [ "$score" -gt 70 ]; then
                    best_score=$score
                    best_match="$entity"
                fi
            done
            ;;
        "projeto")
            for entity in "${KNOWN_PROJECTS[@]}"; do
                score=$(calculate_similarity "$input" "$entity")
                if [ "$score" -gt "$best_score" ] && [ "$score" -gt 70 ]; then
                    best_score=$score
                    best_match="$entity"
                fi
            done
            ;;
        "contexto")
            for entity in "${KNOWN_CONTEXTS[@]}"; do
                score=$(calculate_similarity "$input" "$entity")
                if [ "$score" -gt "$best_score" ] && [ "$score" -gt 70 ]; then
                    best_score=$score
                    best_match="$entity"
                fi
            done
            ;;
    esac

    echo "$best_match"
}

# Função de cálculo de similaridade simples (percentual de caracteres comuns)
calculate_similarity() {
    local str1="$1"
    local str2="$2"

    # Converter para lowercase para comparação
    str1=$(echo "$str1" | tr '[:upper:]' '[:lower:]')
    str2=$(echo "$str2" | tr '[:upper:]' '[:lower:]')

    # Cálculo simples: caracteres em comum / total de caracteres
    local len1=${#str1}
    local len2=${#str2}
    local max_len=$((len1 > len2 ? len1 : len2))

    # Se strings são idênticas
    if [ "$str1" = "$str2" ]; then
        echo 100
        return
    fi

    # Se uma contém a outra
    if [[ "$str1" == *"$str2"* ]] || [[ "$str2" == *"$str1"* ]]; then
        echo 85
        return
    fi

    # Similaridade baseada em substring comum
    local common=0
    for ((i=0; i<len1; i++)); do
        char="${str1:$i:1}"
        if [[ "$str2" == *"$char"* ]]; then
            ((common++))
        fi
    done

    local similarity=$((common * 100 / max_len))
    echo "$similarity"
}

# Função para detectar entidades em texto
detect_entities() {
    local text="$1"
    local detected_people=()
    local detected_projects=()
    local detected_contexts=()

    log "Detectando entidades em: ${text:0:50}..."

    # Palavras em maiúscula (possíveis nomes próprios)
    local words=($(echo "$text" | grep -oE '\b[A-Z][a-zA-Z-]+\b' | sort -u))

    for word in "${words[@]}"; do
        # Tentar match com pessoas conhecidas
        matched_person=$(fuzzy_match "$word" "pessoa")
        if [ -n "$matched_person" ]; then
            detected_people+=("$matched_person")
            log "Pessoa detectada: $word → $matched_person"
        fi

        # Tentar match com projetos conhecidos
        matched_project=$(fuzzy_match "$word" "projeto")
        if [ -n "$matched_project" ]; then
            detected_projects+=("$matched_project")
            log "Projeto detectado: $word → $matched_project"
        fi
    done

    # Detectar contextos por palavras-chave
    if echo "$text" | grep -qi -E "(stress|estressante|cansado|bem.*estar|saúde|emocional)"; then
        matched_context=$(fuzzy_match "bem-estar" "contexto")
        if [ -n "$matched_context" ]; then
            detected_contexts+=("$matched_context")
            log "Contexto detectado: bem-estar"
        fi
    fi

    # Detectar novos projetos por palavras-chave
    if echo "$text" | grep -qi -E "(projeto|development|sistema|aplicação)"; then
        local project_keywords=($(echo "$text" | grep -oiE '\b(projeto|sistema|aplicação|app)\s+[a-zA-Z-]+\b' | sed 's/projeto\s\+//i' | sed 's/sistema\s\+//i'))
        for keyword in "${project_keywords[@]}"; do
            matched_project=$(fuzzy_match "$keyword" "projeto")
            if [ -z "$matched_project" ]; then
                log "Novo projeto potencial detectado: $keyword"
                # Criar novo projeto se não existe
                create_new_project "$keyword"
                detected_projects+=("$keyword")
            fi
        done
    fi

    # Retornar entidades detectadas via variáveis globais
    DETECTED_PEOPLE=("${detected_people[@]}")
    DETECTED_PROJECTS=("${detected_projects[@]}")
    DETECTED_CONTEXTS=("${detected_contexts[@]}")
}

# ===============================
# SISTEMA DE MERGE INTELIGENTE
# ===============================

# Função para criar nova entidade
create_new_person() {
    local person_name="$1"
    local file_path="$KNOWLEDGE_BASE/pessoas/pessoa-$person_name.md"

    log "Criando nova pessoa: $person_name"

    cat > "$file_path" << EOF
# $person_name - Pessoa

## Metadados
\`\`\`yaml
tipo: pessoa
nome: $person_name
tags: [pessoa]
created: $(date +"%Y-%m-%d")
updated: $(date +"%Y-%m-%d")
\`\`\`

## Histórico de Interações

## Projetos Relacionados

## Notas e Contexto

## Histórico de Modificações
- $(date +"%Y-%m-%d"): Criado automaticamente (Story 2.2.2)
EOF

    KNOWN_PEOPLE+=("$person_name")
}

create_new_project() {
    local project_name="$1"
    local file_path="$KNOWLEDGE_BASE/projetos/projeto-$project_name.md"

    log "Criando novo projeto: $project_name"

    cat > "$file_path" << EOF
# $project_name - Projeto

## Metadados
\`\`\`yaml
tipo: projeto
nome: $project_name
tags: [projeto]
created: $(date +"%Y-%m-%d")
updated: $(date +"%Y-%m-%d")
\`\`\`

## Status e Progresso
**Status**: Em definição

## Histórico de Desenvolvimento

## Pessoas Envolvidas

## Decisões Técnicas

## Notas e Contexto

## Histórico de Modificações
- $(date +"%Y-%m-%d"): Criado automaticamente (Story 2.2.2)
EOF

    KNOWN_PROJECTS+=("$project_name")
}

create_new_context() {
    local context_name="$1"
    local file_path="$KNOWLEDGE_BASE/contextos/contexto-$context_name.md"

    log "Criando novo contexto: $context_name"

    cat > "$file_path" << EOF
# $context_name - Contexto

## Metadados
\`\`\`yaml
tipo: contexto
nome: $context_name
tags: [contexto]
created: $(date +"%Y-%m-%d")
updated: $(date +"%Y-%m-%d")
\`\`\`

## Entradas

## Padrões Identificados

## Notas e Reflexões

## Histórico de Modificações
- $(date +"%Y-%m-%d"): Criado automaticamente (Story 2.2.2)
EOF

    KNOWN_CONTEXTS+=("$context_name")
}

# Função para consolidar informação em arquivo existente
consolidate_to_entity() {
    local entity_type="$1"
    local entity_name="$2"
    local information="$3"
    local source_context="${4:-daily-dump}"

    local file_path="$KNOWLEDGE_BASE/${entity_type}s/${entity_type}-$entity_name.md"
    local timestamp=$(date +"%Y-%m-%d")

    log "Consolidando informação em $entity_type: $entity_name"

    # Backup do arquivo atual
    cp "$file_path" "$TEMP_DIR/backup-$(basename "$file_path")-$(date +%H%M%S)"

    # Criar arquivo temporário com nova informação
    local temp_file="$TEMP_DIR/temp-$(basename "$file_path")"
    cp "$file_path" "$temp_file"

    # Adicionar nova entrada na seção apropriada
    case "$entity_type" in
        "pessoa")
            # Adicionar na seção "Histórico de Interações"
            add_to_section "$temp_file" "Histórico de Interações" "$timestamp - $source_context" "$information"
            ;;
        "projeto")
            # Adicionar na seção "Histórico de Desenvolvimento"
            add_to_section "$temp_file" "Histórico de Desenvolvimento" "$timestamp - $source_context" "$information"
            ;;
        "contexto")
            # Adicionar na seção "Entradas"
            add_to_section "$temp_file" "Entradas" "$timestamp - $source_context" "$information"
            ;;
    esac

    # Atualizar timestamp de modificação nos metadados
    sed -i "s/updated: .*/updated: $timestamp/" "$temp_file"

    # Substituir arquivo original
    mv "$temp_file" "$file_path"

    log "Informação consolidada com sucesso em $file_path"
}

# Função para adicionar conteúdo em seção específica
add_to_section() {
    local file="$1"
    local section="$2"
    local subsection_title="$3"
    local content="$4"

    # Encontrar linha da seção
    local section_line=$(grep -n "^## $section" "$file" | cut -d: -f1)

    if [ -z "$section_line" ]; then
        log "AVISO: Seção '$section' não encontrada em $file"
        return 1
    fi

    # Encontrar próxima seção (linha que começa com ##)
    local next_section_line=$(tail -n +$((section_line + 1)) "$file" | grep -n "^## " | head -n1 | cut -d: -f1)

    if [ -n "$next_section_line" ]; then
        next_section_line=$((section_line + next_section_line))
    else
        next_section_line=$(wc -l < "$file")
        next_section_line=$((next_section_line + 1))
    fi

    # Inserir nova subsecção antes da próxima seção
    local insert_line=$((next_section_line - 1))

    # Criar conteúdo a inserir
    local new_content="### $subsection_title\n$content\n\n"

    # Inserir no arquivo
    sed -i "${insert_line}i\\
\\
### $subsection_title\\
$content\\
" "$file"
}

# ===============================
# INTERFACE DE CONSOLIDAÇÃO
# ===============================

# Função principal de consolidação
consolidate_text() {
    local text="$1"
    local source_context="${2:-daily-dump}"

    echo -e "${BLUE}Processando texto para consolidação...${NC}"
    log "Iniciando consolidação de texto: ${text:0:100}..."

    # 1. Construir base de entidades
    build_entity_database

    # 2. Detectar entidades no texto
    detect_entities "$text"

    # 3. Consolidar em cada entidade detectada
    for person in "${DETECTED_PEOPLE[@]}"; do
        consolidate_to_entity "pessoa" "$person" "$text" "$source_context"
        echo -e "${GREEN}✅ Consolidado em pessoa: $person${NC}"
    done

    for project in "${DETECTED_PROJECTS[@]}"; do
        consolidate_to_entity "projeto" "$project" "$text" "$source_context"
        echo -e "${GREEN}✅ Consolidado em projeto: $project${NC}"
    done

    for context in "${DETECTED_CONTEXTS[@]}"; do
        consolidate_to_entity "contexto" "$context" "$text" "$source_context"
        echo -e "${GREEN}✅ Consolidado em contexto: $context${NC}"
    done

    # 4. Relatório final
    local total_entities=$((${#DETECTED_PEOPLE[@]} + ${#DETECTED_PROJECTS[@]} + ${#DETECTED_CONTEXTS[@]}))
    echo -e "${YELLOW}📊 Consolidação concluída:${NC}"
    echo -e "${YELLOW}   Pessoas: ${#DETECTED_PEOPLE[@]}${NC}"
    echo -e "${YELLOW}   Projetos: ${#DETECTED_PROJECTS[@]}${NC}"
    echo -e "${YELLOW}   Contextos: ${#DETECTED_CONTEXTS[@]}${NC}"
    echo -e "${YELLOW}   Total: $total_entities entidades${NC}"

    log "Consolidação concluída: $total_entities entidades processadas"
}

# ===============================
# INTERFACE DE LINHA DE COMANDO
# ===============================

# Verificar argumentos
if [ $# -eq 0 ]; then
    echo -e "${YELLOW}Uso: $0 \"texto para consolidar\" [contexto]${NC}"
    echo -e "${YELLOW}Exemplo: $0 \"Conversei com Fabio sobre o projeto onboarding hoje\" \"reunião\"${NC}"
    echo ""
    echo -e "${YELLOW}Ou para teste interativo:${NC}"
    echo -e "${YELLOW}$0 --interactive${NC}"
    exit 1
fi

# Modo interativo
if [ "$1" = "--interactive" ]; then
    echo -e "${YELLOW}=== Modo Interativo de Consolidação ===${NC}"
    echo "Digite o texto para consolidar (ou 'quit' para sair):"

    while true; do
        echo -n "> "
        read -r input_text

        if [ "$input_text" = "quit" ]; then
            echo "Saindo..."
            break
        fi

        if [ -n "$input_text" ]; then
            consolidate_text "$input_text" "interactive"
            echo ""
        fi
    done

    exit 0
fi

# Modo comando direto
TEXT_TO_CONSOLIDATE="$1"
SOURCE_CONTEXT="${2:-daily-dump}"

consolidate_text "$TEXT_TO_CONSOLIDATE" "$SOURCE_CONTEXT"

echo -e "${GREEN}✅ Sistema de consolidação automática executado com sucesso!${NC}"
echo -e "${YELLOW}Log detalhado: $LOG_FILE${NC}"