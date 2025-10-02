#!/bin/bash
# atualizar-dashboard.sh - Atualiza MEU-DASHBOARD.md com estatísticas
# Sistema: Assistente Pessoal IA

set -e

CACHE_FILE=".assistant-core/data/dashboard-cache.yaml"
DASHBOARD_FILE="knowledge-base/📈 MEU-DASHBOARD.md"
CACHE_TTL=3600  # 1 hora em segundos

# Função para obter timestamp atual
get_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

# Função para verificar se cache é válido
is_cache_valid() {
    if [ ! -f "$CACHE_FILE" ]; then
        return 1
    fi

    local ultima_atualizacao=$(grep "^ultima_atualizacao:" "$CACHE_FILE" | sed 's/.*: "\(.*\)"/\1/')
    if [ -z "$ultima_atualizacao" ]; then
        return 1
    fi

    # Simplificado: sempre atualiza por enquanto (< 100ms)
    return 1
}

# Função para contar arquivos desde data
count_files_since() {
    local dir=$1
    local pattern=$2
    local since_date=$3

    if [ -d "$dir" ]; then
        find "$dir" -name "$pattern" -type f 2>/dev/null | wc -l
    else
        echo "0"
    fi
}

# Função para atualizar contadores
atualizar_contadores() {
    local despejos=$(count_files_since "despejo/processed" "*.md" "")
    local notas=$(count_files_since "knowledge-base" "*.md" "")
    local todos_comp=$(grep -r "- \[x\]" todos/ 2>/dev/null | wc -l || echo "0")
    local todos_total=$(grep -r "- \[" todos/ 2>/dev/null | wc -l || echo "0")

    # Contar conversas por agente (simplificado por agora)
    local conv_org=$(find .assistant-core/memory -name "*organizador*" -type f 2>/dev/null | wc -l || echo "0")
    local conv_sec=$(find .assistant-core/memory -name "*secretaria*" -type f 2>/dev/null | wc -l || echo "0")
    local conv_arq=$(find .assistant-core/memory -name "*arquiteto*" -type f 2>/dev/null | wc -l || echo "0")
    local conv_psi=$(find .assistant-core/memory -name "*psicologo*" -type f 2>/dev/null | wc -l || echo "0")
    local conv_men=$(find .assistant-core/memory -name "*mentor*" -type f 2>/dev/null | wc -l || echo "0")

    local total_conversas=$((conv_org + conv_sec + conv_arq + conv_psi + conv_men))

    # Calcular streak (simplificado: dias com commits)
    local streak=0
    if [ -d ".git" ]; then
        # Contar dias consecutivos com commits (últimos 30 dias)
        local hoje=$(date +%Y-%m-%d)
        streak=$(git log --since="30 days ago" --format="%cd" --date=short | sort -u | wc -l || echo "0")
    fi

    # Atualizar cache
    cat > "$CACHE_FILE" << EOF
# Dashboard Cache - Assistente Pessoal IA
ultima_atualizacao: "$(get_timestamp)"

# Estatísticas da semana atual
esta_semana:
  despejos_processados: $despejos
  conversas_total: $total_conversas
  notas_criadas: $notas
  todos_completados: $todos_comp
  todos_total: $todos_total

# Streak
streak_dias: $streak
ultimo_dia_ativo: "$(date -u +%Y-%m-%d)"

# Conversas por agente
conversas_por_agente:
  organizador: $conv_org
  secretaria: $conv_sec
  arquiteto: $conv_arq
  psicologo: $conv_psi
  mentor: $conv_men

# Achievements (calculados depois)
achievements_desbloqueados: []

# Contadores globais
contadores:
  total_despejos: $despejos
  total_conversas: $total_conversas
  total_notas: $notas
  total_todos: $todos_total
  dias_consecutivos_max: $streak
EOF
}

# Função para gerar dashboard markdown
gerar_dashboard() {
    # Ler valores do cache
    local despejos=$(grep "despejos_processados:" "$CACHE_FILE" | awk '{print $2}')
    local conversas=$(grep "conversas_total:" "$CACHE_FILE" | awk '{print $2}')
    local notas=$(grep "notas_criadas:" "$CACHE_FILE" | awk '{print $2}')
    local todos_comp=$(grep "todos_completados:" "$CACHE_FILE" | awk '{print $2}')
    local todos_total=$(grep "todos_total:" "$CACHE_FILE" | awk '{print $2}')
    local streak=$(grep "^streak_dias:" "$CACHE_FILE" | awk '{print $2}')

    # Ler conversas por agente
    local conv_org=$(grep "organizador:" "$CACHE_FILE" | tail -1 | awk '{print $2}')
    local conv_sec=$(grep "secretaria:" "$CACHE_FILE" | tail -1 | awk '{print $2}')
    local conv_arq=$(grep "arquiteto:" "$CACHE_FILE" | tail -1 | awk '{print $2}')
    local conv_psi=$(grep "psicologo:" "$CACHE_FILE" | tail -1 | awk '{print $2}')
    local conv_men=$(grep "mentor:" "$CACHE_FILE" | tail -1 | awk '{print $2}')

    # Calcular barra de progresso de todos
    local percent=0
    if [ "$todos_total" -gt 0 ]; then
        percent=$((todos_comp * 100 / todos_total))
    fi

    # Gerar barra visual
    local filled=$((percent / 10))
    local empty=$((10 - filled))
    local barra=""
    for ((i=0; i<filled; i++)); do barra="${barra}█"; done
    for ((i=0; i<empty; i++)); do barra="${barra}░"; done

    # Streak visual
    local streak_emoji="🔥"
    if [ "$streak" -lt 3 ]; then
        streak_emoji="🌱"
    elif [ "$streak" -ge 7 ]; then
        streak_emoji="🔥🔥🔥"
    fi

    # Criar diretório se não existir
    mkdir -p "knowledge-base"

    # Gerar dashboard
    local data_atual=$(date +"%d/%m/%Y às %H:%M")

    cat > "$DASHBOARD_FILE" << EOF
# 📈 Meu Dashboard

**Última atualização**: $data_atual

---

## 📊 Esta Semana

| Métrica | Valor |
|---------|-------|
| 📝 Despejos processados | DESPEJOS_COUNT |
| 💬 Conversas com agentes | CONVERSAS_COUNT |
| 📄 Notas criadas | NOTAS_COUNT |
| ✅ Todos completados | TODOS_COMP / TODOS_TOTAL |

---

## 🤖 Uso dos Agentes

| Agente | Conversas | Última vez |
|--------|-----------|------------|
| 📋 Organizador (Sofia) | CONV_ORG | - |
| 📅 Secretária | CONV_SEC | - |
| 🏗️ Arquiteto (Marcus) | CONV_ARQ | - |
| 🧠 Psicólogo (Dr. Helena) | CONV_PSI | - |
| 🎯 Mentor (Leonardo) | CONV_MEN | - |

---

## STREAK_EMOJI Streak

**STREAK_DIAS dias consecutivos** usando o sistema!

STREAK_MSG

---

## ✅ Progresso em Todos

**PERCENT%** completo

BARRA_PROGRESSO

---

## 🏆 Achievements Desbloqueados

ACHIEVEMENTS_LIST

---

## 💾 Status de Backup

**Último backup**: ULTIMO_BACKUP
**Total de backups**: TOTAL_BACKUPS

BACKUP_STATUS

**Próximas ações**:
- 📦 Export manual recomendado mensalmente: \`bash EXPORTAR-TUDO.sh\`
- 🔄 Recuperar backup: \`bash RECUPERAR-BACKUP.sh\`

---

## 📝 Últimas Atividades

1. Dashboard criado automaticamente
2. Sistema de feedback visual ativo
3. Pronto para uso!

---

💡 **Dica**: Este dashboard é atualizado automaticamente. Continue usando o sistema para ver seu progresso crescer!

EOF

    # Substituir placeholders
    sed -i "s/DESPEJOS_COUNT/$despejos/g" "$DASHBOARD_FILE"
    sed -i "s/CONVERSAS_COUNT/$conversas/g" "$DASHBOARD_FILE"
    sed -i "s/NOTAS_COUNT/$notas/g" "$DASHBOARD_FILE"
    sed -i "s/TODOS_COMP/$todos_comp/g" "$DASHBOARD_FILE"
    sed -i "s/TODOS_TOTAL/$todos_total/g" "$DASHBOARD_FILE"
    sed -i "s/CONV_ORG/$conv_org/g" "$DASHBOARD_FILE"
    sed -i "s/CONV_SEC/$conv_sec/g" "$DASHBOARD_FILE"
    sed -i "s/CONV_ARQ/$conv_arq/g" "$DASHBOARD_FILE"
    sed -i "s/CONV_PSI/$conv_psi/g" "$DASHBOARD_FILE"
    sed -i "s/CONV_MEN/$conv_men/g" "$DASHBOARD_FILE"
    sed -i "s/STREAK_DIAS/$streak/g" "$DASHBOARD_FILE"
    sed -i "s/STREAK_EMOJI/$streak_emoji/g" "$DASHBOARD_FILE"
    sed -i "s/PERCENT/$percent/g" "$DASHBOARD_FILE"
    sed -i "s/BARRA_PROGRESSO/$barra/g" "$DASHBOARD_FILE"

    # Mensagem de streak
    if [ "$streak" -ge 7 ]; then
        sed -i "s/STREAK_MSG/🎉 Incrível! Você está em chamas!/g" "$DASHBOARD_FILE"
    elif [ "$streak" -ge 3 ]; then
        sed -i "s/STREAK_MSG/👏 Muito bem! Continue assim!/g" "$DASHBOARD_FILE"
    else
        sed -i "s/STREAK_MSG/💪 Vamos começar um novo streak!/g" "$DASHBOARD_FILE"
    fi

    # Achievements (temporariamente vazio)
    sed -i "s/ACHIEVEMENTS_LIST/Em breve: sistema de achievements!/g" "$DASHBOARD_FILE"

    # Informações de backup
    local ultimo_backup="Nunca"
    local total_backups="0"
    local backup_status="✅ Backup ativo"

    if [ -d ".git" ]; then
        # Último backup (último commit)
        local ultimo_commit=$(git log -1 --format="%ar" 2>/dev/null || echo "nunca")
        ultimo_backup="$ultimo_commit"

        # Total de backups (total de commits)
        total_backups=$(git log --oneline 2>/dev/null | wc -l || echo "0")

        # Verificar status do backup
        if [ -f ".backup-status" ]; then
            local status_backup=$(grep "^status:" ".backup-status" 2>/dev/null | cut -d: -f2 | tr -d ' ' || echo "OK")
            if [ "$status_backup" = "PROBLEMAS" ]; then
                backup_status="⚠️  Problemas detectados - Execute validação"
            fi
        fi
    else
        backup_status="⚠️  Git não inicializado"
    fi

    sed -i "s/ULTIMO_BACKUP/$ultimo_backup/g" "$DASHBOARD_FILE"
    sed -i "s/TOTAL_BACKUPS/$total_backups/g" "$DASHBOARD_FILE"
    sed -i "s|BACKUP_STATUS|$backup_status|g" "$DASHBOARD_FILE"
}

# Execução principal
echo "🔄 Atualizando dashboard..."

# Atualizar contadores
atualizar_contadores

# Gerar dashboard
gerar_dashboard

echo "✅ Dashboard atualizado: $DASHBOARD_FILE"
