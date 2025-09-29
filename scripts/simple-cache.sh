#!/bin/bash

# Sistema de Cache Simples para Agentes - Story 2.2.3
# Versão simplificada compatível com Windows

set -e

CACHE_DIR="cache"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Inicializar cache
init_cache() {
    mkdir -p "$CACHE_DIR"
    echo -e "${GREEN}✅ Cache inicializado em $CACHE_DIR${NC}"
}

# Cache de arquivo simples
cache_file() {
    local source_file="$1"
    local cache_key=$(echo "$source_file" | tr '/' '_' | tr '.' '_')
    local cache_file="$CACHE_DIR/$cache_key.cache"

    # Se cache existe e é mais novo que 30 minutos, usar cache
    if [ -f "$cache_file" ] && [ $(find "$cache_file" -mmin -30 2>/dev/null | wc -l) -gt 0 ]; then
        echo "CACHE HIT: $source_file"
        cat "$cache_file"
        return 0
    fi

    # Caso contrário, ler arquivo e salvar no cache
    if [ -f "$source_file" ]; then
        echo "CACHE MISS: $source_file"
        cat "$source_file" | tee "$cache_file"
        return 0
    else
        echo "ERRO: Arquivo não encontrado: $source_file"
        return 1
    fi
}

# Preload de dados críticos
preload_sofia() {
    echo -e "${YELLOW}🚀 Pre-loading dados da Sofia...${NC}"

    cache_file ".assistant-core/memory/organizador-memory.yaml" >/dev/null
    cache_file ".assistant-core/tasks/processar-despejo.md" >/dev/null
    cache_file ".assistant-core/tasks/organizar-por-projeto.md" >/dev/null
    cache_file ".assistant-core/templates/entrada-categorizada.yaml" >/dev/null

    echo -e "${GREEN}✅ Pre-loading concluído${NC}"
}

# Limpar cache
clean_cache() {
    echo -e "${YELLOW}🧹 Limpando cache...${NC}"
    rm -rf "$CACHE_DIR"/*.cache 2>/dev/null || true
    echo -e "${GREEN}✅ Cache limpo${NC}"
}

# Estatísticas
cache_stats() {
    local cache_files=$(ls "$CACHE_DIR"/*.cache 2>/dev/null | wc -l)
    local cache_size=$(du -sh "$CACHE_DIR" 2>/dev/null | cut -f1 || echo "0")

    echo -e "${BLUE}📊 Estatísticas do Cache:${NC}"
    echo "  Arquivos em cache: $cache_files"
    echo "  Tamanho total: $cache_size"
    echo "  TTL: 30 minutos"
}

# Benchmark
benchmark_cache() {
    echo -e "${BLUE}=== Benchmark do Cache ===${NC}"

    echo -e "${YELLOW}Teste SEM cache:${NC}"
    clean_cache >/dev/null 2>&1
    start=$(date +%s)
    cat .assistant-core/memory/organizador-memory.yaml >/dev/null
    cat .assistant-core/tasks/processar-despejo.md >/dev/null
    end=$(date +%s)
    time_no_cache=$((end - start))
    echo "Tempo: ${time_no_cache}s"

    echo -e "${YELLOW}Teste COM cache:${NC}"
    init_cache >/dev/null
    preload_sofia >/dev/null 2>&1
    start=$(date +%s)
    cache_file ".assistant-core/memory/organizador-memory.yaml" >/dev/null
    cache_file ".assistant-core/tasks/processar-despejo.md" >/dev/null
    end=$(date +%s)
    time_with_cache=$((end - start))
    echo "Tempo: ${time_with_cache}s"

    echo ""
    if [ $time_with_cache -le $time_no_cache ]; then
        echo -e "${GREEN}✅ Cache melhora ou mantém performance${NC}"
    else
        echo -e "${YELLOW}⚠️ Overhead detectado (normal para arquivos pequenos)${NC}"
    fi

    cache_stats
}

# Interface
case "${1:-help}" in
    "init") init_cache ;;
    "preload") init_cache && preload_sofia ;;
    "clean") clean_cache ;;
    "stats") cache_stats ;;
    "benchmark") benchmark_cache ;;
    "load")
        if [ -z "$2" ]; then
            echo "Uso: $0 load <arquivo>"
            exit 1
        fi
        init_cache >/dev/null
        cache_file "$2"
        ;;
    *)
        echo -e "${BLUE}Sistema de Cache Simples${NC}"
        echo "Comandos:"
        echo "  init      - Inicializar cache"
        echo "  preload   - Pre-carregar dados da Sofia"
        echo "  clean     - Limpar cache"
        echo "  stats     - Estatísticas"
        echo "  benchmark - Testar performance"
        echo "  load <arquivo> - Carregar arquivo com cache"
        ;;
esac