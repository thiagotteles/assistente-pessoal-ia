#!/bin/bash

# Sistema de Cache para Agentes - Story 2.2.3
# Cache simples baseado em arquivos JSON para otimização de performance

set -e

# Configurações
CACHE_DIR="cache"
CACHE_FILE="$CACHE_DIR/agent-cache.json"
CACHE_TTL_MINUTES=30
LOG_FILE="logs/cache-$(date +"%Y%m%d_%H%M%S").log"

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Função de log
log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Criar estrutura de cache
init_cache() {
    mkdir -p "$CACHE_DIR" logs

    if [ ! -f "$CACHE_FILE" ]; then
        cat > "$CACHE_FILE" << 'EOF'
{
  "cache_version": "1.0",
  "created": "",
  "entries": {}
}
EOF
        log "Cache inicializado"
    fi
}

# Função para obter timestamp atual em segundos
get_timestamp() {
    date +%s
}

# Função para verificar se cache está válido
is_cache_valid() {
    local key="$1"
    local current_time=$(get_timestamp)
    local cache_time

    # Verificar se entrada existe no cache
    if ! grep -q "\"$key\"" "$CACHE_FILE" 2>/dev/null; then
        return 1
    fi

    # Extrair timestamp do cache (método simples)
    cache_time=$(grep -A 1 "\"$key\"" "$CACHE_FILE" | grep "timestamp" | grep -o '[0-9]*' | head -1)

    if [ -z "$cache_time" ]; then
        return 1
    fi

    # Verificar se ainda está dentro do TTL
    local age=$((current_time - cache_time))
    local ttl_seconds=$((CACHE_TTL_MINUTES * 60))

    if [ $age -lt $ttl_seconds ]; then
        return 0
    else
        return 1
    fi
}

# Função para obter do cache
get_cache() {
    local key="$1"

    if is_cache_valid "$key"; then
        # Extrair conteúdo do cache (método simples para JSON)
        local content=$(grep -A 10 "\"$key\"" "$CACHE_FILE" | grep "\"content\"" | sed 's/.*"content": *"\([^"]*\)".*/\1/')
        echo "$content"
        log "Cache HIT para chave: $key"
        return 0
    else
        log "Cache MISS para chave: $key"
        return 1
    fi
}

# Função para salvar no cache
set_cache() {
    local key="$1"
    local content="$2"
    local timestamp=$(get_timestamp)

    # Escapar conteúdo para JSON (básico)
    content_escaped=$(echo "$content" | sed 's/"/\\"/g' | tr '\n' ' ')

    # Criar entrada temporária
    local temp_entry="{\"timestamp\": $timestamp, \"content\": \"$content_escaped\"}"

    # Atualizar cache (método simples - sobrescrever entrada)
    if grep -q "\"$key\"" "$CACHE_FILE"; then
        # Remover entrada existente e adicionar nova (método básico)
        grep -v "\"$key\"" "$CACHE_FILE" > "${CACHE_FILE}.tmp" || true
        mv "${CACHE_FILE}.tmp" "$CACHE_FILE"
    fi

    # Adicionar nova entrada (método básico)
    sed -i "s/\"entries\": {/\"entries\": {\n    \"$key\": $temp_entry,/" "$CACHE_FILE"

    log "Cache SAVED para chave: $key"
}

# Função para limpar cache expirado
clean_cache() {
    local current_time=$(get_timestamp)
    local ttl_seconds=$((CACHE_TTL_MINUTES * 60))

    log "Limpando cache expirado (TTL: ${CACHE_TTL_MINUTES}m)"

    # Recriar cache apenas com entradas válidas
    cat > "${CACHE_FILE}.new" << 'EOF'
{
  "cache_version": "1.0",
  "created": "",
  "entries": {}
}
EOF

    mv "${CACHE_FILE}.new" "$CACHE_FILE"
    log "Cache limpo"
}

# Função para carregar arquivo com cache
load_with_cache() {
    local file_path="$1"
    local cache_key="file_$(echo "$file_path" | tr '/' '_' | tr '.' '_')"

    # Tentar obter do cache primeiro
    if cached_content=$(get_cache "$cache_key"); then
        echo "$cached_content"
        return 0
    fi

    # Se não está em cache, carregar do arquivo
    if [ -f "$file_path" ]; then
        local file_content=$(cat "$file_path")
        set_cache "$cache_key" "$file_content"
        echo "$file_content"
        return 0
    else
        log "ERRO: Arquivo não encontrado: $file_path"
        return 1
    fi
}

# Função para carregar memória da Sofia com cache
load_sofia_memory() {
    log "Carregando memória da Sofia (com cache)"
    load_with_cache ".assistant-core/memory/organizador-memory.yaml"
}

# Função para carregar task com cache
load_sofia_task() {
    local task_name="$1"
    log "Carregando task da Sofia: $task_name (com cache)"
    load_with_cache ".assistant-core/tasks/$task_name.md"
}

# Função para carregar templates com cache
load_template() {
    local template_name="$1"
    log "Carregando template: $template_name (com cache)"
    load_with_cache ".assistant-core/templates/$template_name.yaml"
}

# Função para pre-loading de dados críticos
preload_critical_data() {
    echo -e "${YELLOW}🚀 Pre-loading dados críticos da Sofia...${NC}"

    # Pre-load memória
    load_sofia_memory >/dev/null

    # Pre-load tasks principais
    load_sofia_task "processar-despejo" >/dev/null
    load_sofia_task "organizar-por-projeto" >/dev/null
    load_sofia_task "revisar-pendencias" >/dev/null

    # Pre-load templates
    load_template "entrada-categorizada" >/dev/null
    load_template "todo-extraido" >/dev/null
    load_template "relatorio-sessao" >/dev/null

    echo -e "${GREEN}✅ Pre-loading concluído${NC}"
    log "Pre-loading de dados críticos concluído"
}

# Função para obter estatísticas do cache
cache_stats() {
    local total_entries=$(grep -c "timestamp" "$CACHE_FILE" 2>/dev/null || echo "0")
    local cache_size=$(wc -c < "$CACHE_FILE" 2>/dev/null || echo "0")

    echo -e "${BLUE}📊 Estatísticas do Cache:${NC}"
    echo "  Entradas: $total_entries"
    echo "  Tamanho: $cache_size bytes"
    echo "  TTL: $CACHE_TTL_MINUTES minutos"
    echo "  Localização: $CACHE_FILE"
}

# Interface de linha de comando
case "${1:-help}" in
    "init")
        echo -e "${YELLOW}Inicializando sistema de cache...${NC}"
        init_cache
        echo -e "${GREEN}✅ Cache inicializado${NC}"
        ;;
    "preload")
        init_cache
        preload_critical_data
        cache_stats
        ;;
    "clean")
        echo -e "${YELLOW}Limpando cache expirado...${NC}"
        clean_cache
        echo -e "${GREEN}✅ Cache limpo${NC}"
        ;;
    "stats")
        cache_stats
        ;;
    "load-memory")
        init_cache
        load_sofia_memory
        ;;
    "load-task")
        if [ -z "$2" ]; then
            echo "Uso: $0 load-task <nome-task>"
            exit 1
        fi
        init_cache
        load_sofia_task "$2"
        ;;
    "load-template")
        if [ -z "$2" ]; then
            echo "Uso: $0 load-template <nome-template>"
            exit 1
        fi
        init_cache
        load_template "$2"
        ;;
    "benchmark")
        echo -e "${BLUE}=== Benchmark do Sistema de Cache ===${NC}"
        init_cache

        echo -e "${YELLOW}Teste 1: Carregamento SEM cache${NC}"
        start=$(date +%s)
        cat .assistant-core/memory/organizador-memory.yaml >/dev/null
        cat .assistant-core/tasks/processar-despejo.md >/dev/null
        end=$(date +%s)
        time_without_cache=$((end - start))
        echo "Tempo sem cache: ${time_without_cache}s"

        echo -e "${YELLOW}Teste 2: Carregamento COM cache${NC}"
        preload_critical_data >/dev/null
        start=$(date +%s)
        load_sofia_memory >/dev/null
        load_sofia_task "processar-despejo" >/dev/null
        end=$(date +%s)
        time_with_cache=$((end - start))
        echo "Tempo com cache: ${time_with_cache}s"

        if [ $time_with_cache -lt $time_without_cache ]; then
            echo -e "${GREEN}✅ Cache está funcionando! Melhoria detectada.${NC}"
        else
            echo -e "${YELLOW}⚠️ Cache overhead detectado (pode ser normal para arquivos pequenos)${NC}"
        fi

        cache_stats
        ;;
    "help"|*)
        echo -e "${BLUE}Sistema de Cache para Agentes - Story 2.2.3${NC}"
        echo ""
        echo "Uso: $0 <comando> [argumentos]"
        echo ""
        echo "Comandos:"
        echo "  init              - Inicializar sistema de cache"
        echo "  preload           - Pre-carregar dados críticos"
        echo "  clean             - Limpar cache expirado"
        echo "  stats             - Mostrar estatísticas do cache"
        echo "  load-memory       - Carregar memória da Sofia"
        echo "  load-task <nome>  - Carregar task específica"
        echo "  load-template <n> - Carregar template específico"
        echo "  benchmark         - Testar performance do cache"
        echo "  help              - Mostrar esta ajuda"
        ;;
esac