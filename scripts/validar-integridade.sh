#!/bin/bash
# validar-integridade.sh - Validação Automática de Integridade do Backup
# Sistema: Assistente Pessoal IA
# Story: 3.4 - Backup Automático Invisível

STATUS_FILE=".backup-status"

# Função para verificar integridade
validar_integridade() {
    local problemas=0
    local warnings=()
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    echo "🔍 Validando integridade do backup..."

    # 1. Verificar se Git está inicializado
    if [ ! -d ".git" ]; then
        warnings+=("❌ CRÍTICO: Git não inicializado (.git não existe)")
        ((problemas++))
    else
        echo "✅ Git inicializado"
    fi

    # 2. Verificar commits recentes (< 7 dias)
    if [ -d ".git" ]; then
        local ultimo_commit=$(git log -1 --format=%ct 2>/dev/null || echo "0")
        local agora=$(date +%s)
        local dias_desde=$(( (agora - ultimo_commit) / 86400 ))

        if [ "$dias_desde" -gt 7 ]; then
            warnings+=("⚠️  Último commit há $dias_desde dias (recomendado < 7)")
            ((problemas++))
        else
            echo "✅ Commits recentes (último há $dias_desde dias)"
        fi
    fi

    # 3. Verificar integridade do repositório (git fsck)
    if [ -d ".git" ]; then
        local fsck_output=$(git fsck --no-progress 2>&1)
        if echo "$fsck_output" | grep -qi "error\|fatal"; then
            warnings+=("❌ CRÍTICO: Git fsck detectou erros")
            ((problemas++))
        else
            echo "✅ Integridade do repositório OK (git fsck)"
        fi
    fi

    # 4. Verificar arquivos críticos
    local arquivos_criticos=(
        "knowledge-base"
        ".assistant-core"
        "scripts"
    )

    for arquivo in "${arquivos_criticos[@]}"; do
        if [ ! -e "$arquivo" ]; then
            warnings+=("⚠️  Arquivo/diretório crítico faltando: $arquivo")
            ((problemas++))
        fi
    done

    if [ ${#arquivos_criticos[@]} -eq 3 ]; then
        echo "✅ Arquivos críticos presentes"
    fi

    # Salvar status
    cat > "$STATUS_FILE" << EOF
# Status de Backup - Assistente Pessoal IA
ultima_verificacao: "$timestamp"
problemas_encontrados: $problemas
status: $([ $problemas -eq 0 ] && echo "OK" || echo "PROBLEMAS")

EOF

    if [ $problemas -gt 0 ]; then
        echo "warnings:" >> "$STATUS_FILE"
        for warning in "${warnings[@]}"; do
            echo "  - \"$warning\"" >> "$STATUS_FILE"
        done
    fi

    # Resultado
    echo ""
    if [ $problemas -eq 0 ]; then
        echo "✅ Validação concluída: Nenhum problema encontrado"
        echo "📅 Próxima verificação: Amanhã"
        return 0
    else
        echo "⚠️  Validação concluída: $problemas problema(s) encontrado(s)"
        echo ""
        echo "Problemas:"
        for warning in "${warnings[@]}"; do
            echo "  $warning"
        done
        echo ""
        echo "💡 Recomendação: Execute backup manual ou verifique configuração"
        return 1
    fi
}

# Executar validação
if [ "$1" = "--silent" ]; then
    validar_integridade > /dev/null 2>&1
else
    validar_integridade
fi
