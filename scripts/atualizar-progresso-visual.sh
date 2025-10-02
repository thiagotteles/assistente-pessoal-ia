#!/bin/bash
# atualizar-progresso-visual.sh - Atualiza PROGRESSO-VISUAL.md
# Sistema: Assistente Pessoal IA

set -e

PROGRESSO_FILE="todos/PROGRESSO-VISUAL.md"

# Função para criar barra de progresso Unicode
criar_barra() {
    local completados=$1
    local total=$2
    local percent=0

    if [ "$total" -gt 0 ]; then
        percent=$((completados * 100 / total))
    fi

    local filled=$((percent / 10))
    local empty=$((10 - filled))
    local barra=""

    for ((i=0; i<filled; i++)); do barra="${barra}█"; done
    for ((i=0; i<empty; i++)); do barra="${barra}░"; done

    echo "$barra $percent%"
}

# Criar diretório se não existir
mkdir -p "todos"

# Contar todos
total_todos=0
completados_todos=0

if [ -d "todos" ]; then
    total_todos=$(grep -r "- \[" todos/ 2>/dev/null | wc -l || echo "0")
    completados_todos=$(grep -r "- \[x\]" todos/ 2>/dev/null | wc -l || echo "0")
fi

# Calcular barra geral
barra_geral=$(criar_barra "$completados_todos" "$total_todos")

# Gerar arquivo
cat > "$PROGRESSO_FILE" << EOF
# ✅ Progresso Visual de Todos

**Última atualização**: $(date +"%d/%m/%Y às %H:%M")

---

## 📊 Visão Geral

**$completados_todos de $total_todos** todos completados

$barra_geral

---

## 📋 Por Projeto

EOF

# Listar todos por arquivo (simplificado)
if [ -d "todos" ]; then
    for arquivo in todos/*.md; do
        if [ -f "$arquivo" ] && [ "$(basename "$arquivo")" != "PROGRESSO-VISUAL.md" ]; then
            nome=$(basename "$arquivo" .md)
            total=$(grep "- \[" "$arquivo" 2>/dev/null | wc -l || echo "0")
            comp=$(grep "- \[x\]" "$arquivo" 2>/dev/null | wc -l || echo "0")

            if [ "$total" -gt 0 ]; then
                barra=$(criar_barra "$comp" "$total")
                echo "### $nome" >> "$PROGRESSO_FILE"
                echo "" >> "$PROGRESSO_FILE"
                echo "$barra" >> "$PROGRESSO_FILE"
                echo "" >> "$PROGRESSO_FILE"
                echo "**Todos ($comp/$total)**:" >> "$PROGRESSO_FILE"
                echo "" >> "$PROGRESSO_FILE"

                # Listar todos (primeiros 5)
                grep "- \[" "$arquivo" 2>/dev/null | head -5 | while read -r linha; do
                    echo "$linha" >> "$PROGRESSO_FILE"
                done

                if [ "$total" -gt 5 ]; then
                    echo "- ..." >> "$PROGRESSO_FILE"
                    echo "" >> "$PROGRESSO_FILE"
                    echo "*(e mais $((total - 5)) todos)*" >> "$PROGRESSO_FILE"
                fi

                echo "" >> "$PROGRESSO_FILE"
                echo "---" >> "$PROGRESSO_FILE"
                echo "" >> "$PROGRESSO_FILE"
            fi
        fi
    done
fi

# Adicionar seção de metas (se existir)
cat >> "$PROGRESSO_FILE" << 'EOF'

## 🎯 Metas de Carreira

*(Configure suas metas conversando com o Mentor - Leonardo)*

Use `/mentor` para definir e acompanhar suas metas de carreira.

---

## 💡 Próximo Passo Sugerido

EOF

# Sugerir próximo passo baseado em progresso
if [ "$completados_todos" -eq 0 ] && [ "$total_todos" -gt 0 ]; then
    echo "🚀 Comece completando seu primeiro todo!" >> "$PROGRESSO_FILE"
elif [ "$total_todos" -eq 0 ]; then
    echo "📝 Crie seus primeiros todos conversando com a Secretária: \`/secretaria\`" >> "$PROGRESSO_FILE"
else
    percent=$((completados_todos * 100 / total_todos))
    if [ "$percent" -ge 80 ]; then
        echo "🎉 Parabéns! Você está quase lá. Complete os últimos todos!" >> "$PROGRESSO_FILE"
    elif [ "$percent" -ge 50 ]; then
        echo "💪 Metade do caminho! Continue assim!" >> "$PROGRESSO_FILE"
    else
        echo "🌟 Foco no próximo todo da lista!" >> "$PROGRESSO_FILE"
    fi
fi

echo "" >> "$PROGRESSO_FILE"
echo "---" >> "$PROGRESSO_FILE"
echo "" >> "$PROGRESSO_FILE"
echo "💡 **Dica**: Este progresso é atualizado automaticamente quando você completa todos." >> "$PROGRESSO_FILE"

echo "✅ Progresso visual atualizado: $PROGRESSO_FILE"
