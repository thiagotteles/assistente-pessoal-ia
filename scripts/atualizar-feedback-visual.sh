#!/bin/bash
# atualizar-feedback-visual.sh - Atualiza todos os componentes de feedback visual
# Sistema: Assistente Pessoal IA
# Story: 3.3 - Feedback Visual e Progresso Contínuo

set -e

echo "🎨 Atualizando Feedback Visual..."
echo ""

# 1. Atualizar dashboard
echo "📈 Atualizando MEU-DASHBOARD.md..."
bash "$(dirname "$0")/atualizar-dashboard.sh" 2>/dev/null || echo "⚠️  Falha ao atualizar dashboard"

# 2. Atualizar progresso visual
echo "✅ Atualizando PROGRESSO-VISUAL.md..."
bash "$(dirname "$0")/atualizar-progresso-visual.sh" 2>/dev/null || echo "⚠️  Falha ao atualizar progresso"

# 3. Verificar achievements
echo "🏆 Verificando achievements..."
bash "$(dirname "$0")/verificar-achievements.sh" 2>/dev/null || echo "⚠️  Falha ao verificar achievements"

echo ""
echo "✨ Feedback visual atualizado com sucesso!"
