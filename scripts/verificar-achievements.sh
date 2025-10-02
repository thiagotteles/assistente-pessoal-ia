#!/bin/bash
# verificar-achievements.sh - Sistema de Achievements Gamificado
# Sistema: Assistente Pessoal IA

set -e

CACHE_FILE=".assistant-core/data/dashboard-cache.yaml"
ACHIEVEMENTS_FILE=".assistant-core/data/achievements.yaml"

# Função para verificar se achievement foi desbloqueado
achievement_desbloqueado() {
    local achievement=$1
    if [ -f "$ACHIEVEMENTS_FILE" ]; then
        grep -q "- $achievement" "$ACHIEVEMENTS_FILE" 2>/dev/null && return 0
    fi
    return 1
}

# Função para desbloquear achievement
desbloquear_achievement() {
    local achievement=$1
    local nome=$2
    local descricao=$3

    if ! achievement_desbloqueado "$achievement"; then
        echo "🏆 Achievement Desbloqueado: $nome!"
        echo "   $descricao"
        echo ""

        # Adicionar ao arquivo
        if [ ! -f "$ACHIEVEMENTS_FILE" ]; then
            echo "# Achievements Desbloqueados" > "$ACHIEVEMENTS_FILE"
            echo "desbloqueados:" >> "$ACHIEVEMENTS_FILE"
        fi

        echo "  - id: $achievement" >> "$ACHIEVEMENTS_FILE"
        echo "    nome: \"$nome\"" >> "$ACHIEVEMENTS_FILE"
        echo "    descricao: \"$descricao\"" >> "$ACHIEVEMENTS_FILE"
        echo "    data: \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"" >> "$ACHIEVEMENTS_FILE"

        return 0
    fi
    return 1
}

# Ler contadores do cache
if [ ! -f "$CACHE_FILE" ]; then
    echo "⚠️  Cache não encontrado. Execute atualizar-dashboard.sh primeiro."
    exit 0
fi

total_despejos=$(grep "total_despejos:" "$CACHE_FILE" | awk '{print $2}')
total_conversas=$(grep "total_conversas:" "$CACHE_FILE" | awk '{print $2}')
total_notas=$(grep "total_notas:" "$CACHE_FILE" | awk '{print $2}')
total_todos=$(grep "total_todos:" "$CACHE_FILE" | awk '{print $2}')
streak_dias=$(grep "^streak_dias:" "$CACHE_FILE" | awk '{print $2}')

# Contar agentes conversados
agentes_conversados=0
for agente in organizador secretaria arquiteto psicologo mentor; do
    conversas=$(grep "$agente:" "$CACHE_FILE" | tail -1 | awk '{print $2}' || echo "0")
    if [ "$conversas" -gt 0 ] 2>/dev/null; then
        agentes_conversados=$((agentes_conversados + 1))
    fi
done

# Verificar achievements
novos=0

# Achievement: Primeira Semana (7 dias consecutivos)
if [ "$streak_dias" -ge 7 ]; then
    if desbloquear_achievement "primeira_semana" "Primeira Semana" "Usou o sistema por 7 dias consecutivos"; then
        ((novos++))
    fi
fi

# Achievement: Em Chamas (streak 14+ dias)
if [ "$streak_dias" -ge 14 ]; then
    if desbloquear_achievement "em_chamas" "Em Chamas 🔥" "Streak de 14+ dias consecutivos"; then
        ((novos++))
    fi
fi

# Achievement: Explorador (conversou com 5 agentes)
if [ "$agentes_conversados" -ge 5 ]; then
    if desbloquear_achievement "explorador" "Explorador" "Conversou com todos os 5 agentes"; then
        ((novos++))
    fi
fi

# Achievement: Colecionador (50+ notas)
if [ "$total_notas" -ge 50 ]; then
    if desbloquear_achievement "colecionador" "Colecionador" "Criou 50+ notas na knowledge-base"; then
        ((novos++))
    fi
fi

# Achievement: Produtivo (100+ todos)
if [ "$total_todos" -ge 100 ]; then
    if desbloquear_achievement "produtivo" "Produtivo" "Gerenciou 100+ todos"; then
        ((novos++))
    fi
fi

# Achievement: Conversador (50+ conversas)
if [ "$total_conversas" -ge 50 ]; then
    if desbloquear_achievement "conversador" "Conversador" "Teve 50+ conversas com agentes"; then
        ((novos++))
    fi
fi

# Achievement: Organizado (20+ despejos)
if [ "$total_despejos" -ge 20 ]; then
    if desbloquear_achievement "organizado" "Organizado" "Processou 20+ despejos"; then
        ((novos++))
    fi
fi

# Achievement: Primeiros Passos (primeira conversa)
if [ "$total_conversas" -ge 1 ]; then
    if desbloquear_achievement "primeiros_passos" "Primeiros Passos" "Teve sua primeira conversa com um agente"; then
        ((novos++))
    fi
fi

if [ "$novos" -eq 0 ]; then
    echo "✓ Nenhum novo achievement desbloqueado"
else
    echo ""
    echo "🎉 $novos novo(s) achievement(s) desbloqueado(s)!"
fi

exit 0  # Sempre retorna sucesso
