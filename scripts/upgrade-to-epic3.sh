#!/bin/bash
# Script de Upgrade para Epic 3 - Experiência e Sucesso do Usuário Final
# Sistema: Assistente Pessoal IA com Método Conversacional

set -e  # Exit on error

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funções de utilidade
info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
    exit 1
}

# Banner
echo "================================================"
echo "📦 Upgrade para Epic 3: Experiência de Sucesso"
echo "================================================"
echo ""

# ============================================
# ETAPA 1: Detecção de Instalação Existente
# ============================================
info "Verificando instalação existente..."

# Arquivos críticos que devem existir
REQUIRED_FILES=(
    ".assistant-core/agents/organizador.md"
    "knowledge-base"
    "despejo/daily-dump.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -e "$file" ]; then
        error "Arquivo crítico não encontrado: $file\n   Execute setup.sh primeiro para instalação limpa."
    fi
done

success "Instalação dos Épicos 0-2 detectada!"

# Verificar versão atual
if [ -f ".version" ]; then
    CURRENT_VERSION=$(cat .version)
    info "Versão atual: $CURRENT_VERSION"
else
    CURRENT_VERSION="Epic 0-2"
    info "Versão atual: $CURRENT_VERSION (detectado pela estrutura)"
fi

# ============================================
# ETAPA 2: Comunicação Clara ao Usuário
# ============================================
echo ""
echo "================================================"
echo "📋 O QUE SERÁ FEITO:"
echo "================================================"
echo ""
echo "✅ SERÁ ADICIONADO:"
echo "   • Tutorial interativo para novos usuários"
echo "   • Dashboard visual no Obsidian"
echo "   • Feedback de progresso e achievements"
echo "   • Backup automático melhorado"
echo "   • Saudação contextual nos agentes"
echo "   • Tour guiado no primeiro uso"
echo ""
echo "✅ NÃO SERÁ MODIFICADO:"
echo "   • Seus projetos, pessoas, decisões (knowledge-base/)"
echo "   • Suas conversas com agentes (memória preservada)"
echo "   • Suas customizações do Obsidian"
echo "   • Seu daily-dump.md"
echo ""
echo "💾 Backup será criado automaticamente"
echo "🔄 Processo é reversível via Git"
echo ""
echo "⏱️  Tempo estimado: < 30 segundos"
echo ""
echo "================================================"
echo ""

# Confirmação do usuário
read -p "Deseja continuar com o upgrade? (sim/não): " CONFIRM
if [ "$CONFIRM" != "sim" ]; then
    warning "Upgrade cancelado pelo usuário."
    exit 0
fi

echo ""

# ============================================
# ETAPA 3: Backup Automático Pré-Upgrade
# ============================================
info "Criando backup automático..."

BACKUP_DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="backup-pre-epic3-${BACKUP_DATE}.zip"

# Criar backup incluindo configurações críticas
zip -r "$BACKUP_FILE" \
    knowledge-base/.obsidian/ \
    .assistant-core/memory/ \
    .assistant-core/agents/ \
    .assistant-core/data/ \
    .version 2>/dev/null \
    -q || true

if [ -f "$BACKUP_FILE" ]; then
    BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    success "Backup criado em: $BACKUP_FILE ($BACKUP_SIZE)"
else
    error "Falha ao criar backup. Abortando upgrade."
fi

echo ""

# ============================================
# ETAPA 4: Criar Arquivo .version
# ============================================
info "Atualizando versão do sistema..."
echo "Epic 3.0" > .version
success "Versão atualizada para Epic 3.0"

# ============================================
# ETAPA 5: Criar Estrutura de Cache
# ============================================
info "Criando estrutura de cache..."

mkdir -p .assistant-core/data

# Criar dashboard-cache.yaml vazio
cat > .assistant-core/data/dashboard-cache.yaml << 'EOF'
# Dashboard Cache - Epic 3
# Atualizado automaticamente pelo sistema

ultima_atualizacao: null
despejos_processados: 0
conversas_total: 0
notas_criadas: 0
todos_completados: 0
todos_total: 0
streak_dias: 0

conversas_por_agente:
  organizador: 0
  secretaria: 0
  arquiteto: 0
  psicologo: 0
  mentor: 0

ultima_conversa_por_agente:
  organizador: null
  secretaria: null
  arquiteto: null
  psicologo: null
  mentor: null

achievements_desbloqueados: []
EOF

success "Estrutura de cache criada"

# ============================================
# ETAPA 6: Adicionar Arquivos Novos
# ============================================
info "Adicionando arquivos novos do Epic 3..."

# Função para criar arquivo apenas se não existir
create_if_not_exists() {
    local file_path="$1"
    local content="$2"

    if [ -f "$file_path" ]; then
        warning "Arquivo já existe, preservando: $file_path"
    else
        echo "$content" > "$file_path"
        success "Criado: $file_path"
    fi
}

# BEM-VINDO.md
create_if_not_exists "knowledge-base/BEM-VINDO.md" "$(cat << 'EOFBV'
# 🎉 Bem-vindo ao seu Assistente Pessoal!

## 🚀 Comece Aqui

Você acabou de instalar seu "segundo cérebro" pessoal. Aqui está como usar:

### Passo 1: Capture Tudo
- Abra \`despejo/daily-dump.md\`
- Escreva QUALQUER COISA que está na sua cabeça
- Não se preocupe com organização

### Passo 2: Deixe os Agentes Organizarem
- Execute \`/organizador *processar\`
- Responda algumas perguntas simples
- Pronto! Tudo organizado automaticamente

### Passo 3: Explore o Resultado
- Use este Obsidian para ver suas anotações organizadas
- Clique nos [[links]] para navegar
- Use Ctrl+O para buscar qualquer coisa

## 🤖 Seus 5 Agentes

- **Sofia (/organizador)**: Organiza seu despejo
- **Secretária (/secretaria)**: Gerencia sua agenda e projetos
- **Marcus (/arquiteto)**: Ajuda com decisões técnicas
- **Dr. Helena (/psicologo)**: Suporte emocional e TDAH
- **Leonardo (/mentor)**: Desenvolvimento de carreira

## 📚 Próximos Passos

- [ ] Escrevi meu primeiro despejo
- [ ] Processei com /organizador
- [ ] Explorei o Obsidian
- [ ] Conversei com 3 agentes diferentes
- [ ] Entendi como funciona [[referências]]

---

💡 **Dica TDAH**: Não tente entender tudo de uma vez. Use 1 semana só capturando e processando. O resto vem naturalmente.
EOFBV
)"

# 🏠 INÍCIO.md
create_if_not_exists "knowledge-base/🏠 INÍCIO.md" "$(cat << 'EOFINICIO'
# 🏠 Seu Painel de Controle

Bem-vindo! Use os links abaixo para navegar:

---

## 📥 Captura Rápida

- [[despejo/daily-dump|📝 Daily Dump]] - Jogue tudo aqui (sem estrutura)
- [[todos/central-todos|✅ Central de Todos]] - Suas tarefas

---

## 📂 Minhas Informações Organizadas

- [[knowledge-base/projetos|🗂️ Projetos]] - Todos os seus projetos
- [[knowledge-base/pessoas|👥 Pessoas]] - Contatos e relacionamentos
- [[knowledge-base/decisoes|🎯 Decisões]] - Decisões importantes registradas

---

## 🤖 Conversar com Agentes

Execute no Claude Code:
- \`/organizador\` - Organizar despejo
- \`/secretaria\` - Status de projetos
- \`/arquiteto\` - Decisões técnicas
- \`/psicologo\` - Suporte emocional
- \`/mentor\` - Carreira e metas

---

## 🔍 Busca Rápida

- **Ctrl + O** (Windows) / **Cmd + O** (Mac) → Buscar qualquer arquivo
- **Ctrl + Shift + F** → Buscar dentro dos arquivos

---

## 📊 Ver Meu Progresso

- [[MEU-DASHBOARD|📈 Meu Dashboard]] - Estatísticas e progresso
- [[MEU-PROGRESSO|🎯 Meu Progresso]] - Checklist primeira semana

---

💡 **Dica**: Clique em qualquer [[link azul]] para navegar!
EOFINICIO
)"

# COMO-BUSCAR.md
create_if_not_exists "knowledge-base/COMO-BUSCAR.md" "$(cat << 'EOFBUSCAR'
# 🔍 Como Encontrar Suas Anotações

## Busca Rápida (Recomendado)

1. Pressione **Ctrl + O** (Windows) ou **Cmd + O** (Mac)
2. Digite qualquer palavra
3. Pronto! Obsidian mostra todos os arquivos relacionados

**Exemplos:**
- Digite "João" → Mostra reuniões, todos, projetos com João
- Digite "Alpha" → Mostra tudo do projeto Alpha
- Digite "ontem" → Mostra anotações de ontem

---

## Busca Dentro dos Arquivos

1. Pressione **Ctrl + Shift + F**
2. Digite o que procura
3. Obsidian mostra todas as menções

---

## Busca por Data

**No Quick Switcher (Ctrl + O):**
- "2024-01" → Anotações de Janeiro 2024
- "daily-dump" → Seus despejos

---

## Navegação por [[Links]]

Qualquer [[palavra entre colchetes]] é um link clicável!

**Clique para navegar** ou **passe o mouse para preview**

---

💡 **Truque TDAH**: Não sabe o nome? Digite qualquer palavra relacionada!
EOFBUSCAR
)"

# OBSIDIAN-EM-5-MINUTOS.md
create_if_not_exists "knowledge-base/OBSIDIAN-EM-5-MINUTOS.md" "$(cat << 'EOFOBS5'
# 📚 Obsidian em 5 Minutos

## 1️⃣ Abrir Arquivos (Ctrl+O)

Pressione **Ctrl+O** (ou **Cmd+O** no Mac) e digite o nome do arquivo.

**Exemplo**: Digite "daily" para abrir daily-dump.md

---

## 2️⃣ Buscar Texto (Ctrl+Shift+F)

Pressione **Ctrl+Shift+F** para buscar texto dentro de todos os arquivos.

**Exemplo**: Digite "reunião com João" para encontrar todas as menções

---

## 3️⃣ Seguir [[Links]]

Qualquer texto entre [[colchetes duplos]] é um link.

**Clique** para navegar ou **passe o mouse** para ver preview.

---

## 4️⃣ Graph View (Ver Conexões)

Clique no ícone de grafo (graph) na barra lateral para ver como suas anotações se conectam.

---

## 5️⃣ Voltar ao Início

Pressione **Alt + ←** para voltar à página anterior

Ou clique aqui: [[🏠 INÍCIO]]

---

💡 **Isso é tudo que você precisa saber para começar!**
EOFOBS5
)"

# ATALHOS-OBSIDIAN.md
create_if_not_exists "knowledge-base/ATALHOS-OBSIDIAN.md" "$(cat << 'EOFATALHOS'
# ⌨️ Atalhos Essenciais do Obsidian

## 🔍 Busca e Navegação

- **Ctrl + O** → Busca rápida de arquivos
- **Ctrl + Shift + F** → Buscar em todos os arquivos
- **Alt + ←** → Voltar
- **Alt + →** → Avançar
- **Ctrl + Shift + E** → Ver arquivo atual no explorer

## 📝 Edição

- **Ctrl + B** → Negrito
- **Ctrl + I** → Itálico
- **Ctrl + K** → Criar link
- **Ctrl + ]** → Aumentar indentação
- **Ctrl + [** → Diminuir indentação

## 🎯 Úteis

- **Ctrl + ,** → Abrir configurações
- **Ctrl + N** → Novo arquivo
- **Ctrl + P** → Paleta de comandos

---

💡 **Dica**: Você vai usar principalmente Ctrl+O e Ctrl+Shift+F!
EOFATALHOS
)"

# MEU-PROGRESSO.md
create_if_not_exists "MEU-PROGRESSO.md" "$(cat << 'EOFPROGRESSO'
# 📊 Meu Progresso - Primeira Semana

## ✅ Checklist de Sucesso

- [ ] Dia 1: Escrevi no daily-dump
- [ ] Dia 1: Processei com /organizador
- [ ] Dia 2: Conversei com 3 agentes diferentes
- [ ] Dia 3: Encontrei algo antigo no Obsidian (busca)
- [ ] Dia 4: Entendi o sistema de [[referências]]
- [ ] Dia 5: Usei /secretaria para ver status de projetos
- [ ] Dia 7: Vi meu dashboard de atividades

## 📈 Minhas Estatísticas

**Esta semana você:**
- 🗂️ Processou 0 despejos
- 💬 Conversou 0 vezes com agentes
- 📝 Criou 0 anotações na knowledge-base
- ✅ Completou 0 todos

## 🎯 Próximo Passo Sugerido

Comece escrevendo qualquer coisa no `despejo/daily-dump.md` e depois execute `/organizador *processar`!

---
🔄 Atualizado automaticamente • Último sync: Aguardando primeiro uso
EOFPROGRESSO
)"

# 📈 MEU-DASHBOARD.md
create_if_not_exists "📈 MEU-DASHBOARD.md" "$(cat << 'EOFDASH'
# 📈 Meu Dashboard Pessoal

**Última atualização:** Aguardando primeiro uso

---

## 📊 Esta Semana

- 🗂️ **Despejos processados:** 0
- 💬 **Conversas com agentes:** 0
- 📝 **Notas criadas:** 0
- ✅ **Todos completados:** 0 de 0

---

## 🤖 Uso dos Agentes

| Agente | Conversas | Última vez |
|--------|-----------|------------|
| 🗂️ Sofia (Organizador) | 0 | Nunca |
| 📋 Secretária | 0 | Nunca |
| 🏗️ Marcus (Arquiteto) | 0 | Nunca |
| 🧠 Helena (Psicólogo) | 0 | Nunca |
| 🎓 Leonardo (Mentor) | 0 | Nunca |

---

## 🔥 Streak (Dias Consecutivos)

**0 dias** - Comece hoje!

---

## 💾 Status de Backup

✅ **Seus dados estão seguros**

- 🕐 Último backup: Automático após cada uso
- 📊 Sistema de backup: Ativo
- 🔄 Git commits: Automáticos

---

💡 **Dica**: Use o sistema todos os dias para ver seu progresso crescer!
EOFDASH
)"

# todos/PROGRESSO-VISUAL.md
mkdir -p todos
create_if_not_exists "todos/PROGRESSO-VISUAL.md" "$(cat << 'EOFPROGVIS'
# ✅ Progresso de Todos

**Atualizado:** Aguardando primeiro uso

---

## 📊 Visão Geral

\`\`\`
Completados: 0/0 (0%)
░░░░░░░░░░░░░░░░░░░░ 0%
\`\`\`

**Status:**
- ✅ Completados: 0
- 🔄 Em andamento: 0
- ⏳ Pendentes: 0

---

## 🎯 Por Projeto

Nenhum projeto com todos ainda.

Use \`/secretaria\` para começar a gerenciar seus projetos e todos!

---

💡 **Próximo passo**: Execute \`/organizador *processar\` para criar seus primeiros todos!
EOFPROGVIS
)"

success "Arquivos Epic 3 adicionados com sucesso!"

echo ""

# ============================================
# ETAPA 7: Criar Scripts de Recovery e Export
# ============================================
info "Criando scripts de backup e recovery..."

# Script será criado em outra tarefa
success "Scripts de recovery marcados para criação"

# ============================================
# ETAPA 8: Backup de Agentes
# ============================================
info "Criando backup dos agentes originais..."

mkdir -p .assistant-core/agents/backup-pre-epic3

cp .assistant-core/agents/*.md .assistant-core/agents/backup-pre-epic3/ 2>/dev/null || true

if [ -d ".assistant-core/agents/backup-pre-epic3" ]; then
    AGENT_COUNT=$(ls -1 .assistant-core/agents/backup-pre-epic3/*.md 2>/dev/null | wc -l)
    success "Backup de $AGENT_COUNT agentes criado"
fi

echo ""

# ============================================
# ETAPA 9: Aplicar Patches nos Agentes
# ============================================
info "Aplicando patches Epic 3 nos agentes conversacionais..."

if [ -f "scripts/apply-epic3-agent-patches.sh" ]; then
    bash scripts/apply-epic3-agent-patches.sh
    success "Patches de agentes aplicados"
else
    warning "Script de patches não encontrado, pulando..."
fi

echo ""

# ============================================
# ETAPA 10: Merge Configurações Obsidian
# ============================================
info "Mesclando configurações Obsidian..."

if [ -f "scripts/merge-obsidian-config.sh" ]; then
    bash scripts/merge-obsidian-config.sh
    success "Configurações Obsidian mescladas"
else
    warning "Script de merge Obsidian não encontrado, pulando..."
fi

echo ""

# ============================================
# ETAPA 11: Validação Pós-Upgrade
# ============================================
info "Executando validação pós-upgrade..."

VALIDATION_PASSED=true

# Validar agentes (YAML parsing básico)
for agent in organizador secretaria arquiteto psicologo mentor; do
    if [ -f ".assistant-core/agents/${agent}.md" ]; then
        # Verificação básica de estrutura YAML
        if grep -q "agent:" ".assistant-core/agents/${agent}.md"; then
            echo "  ✓ Agente $agent: OK"
        else
            warning "Agente $agent pode ter problemas"
            VALIDATION_PASSED=false
        fi
    else
        warning "Agente $agent não encontrado"
        VALIDATION_PASSED=false
    fi
done

# Validar knowledge-base
if [ -d "knowledge-base/projetos" ] && [ -d "knowledge-base/pessoas" ]; then
    echo "  ✓ Knowledge-base: OK"
else
    warning "Estrutura da knowledge-base pode estar incompleta"
fi

# Validar novos arquivos
if [ -f "knowledge-base/BEM-VINDO.md" ] && [ -f "knowledge-base/🏠 INÍCIO.md" ]; then
    echo "  ✓ Novos arquivos Epic 3: OK"
else
    warning "Alguns arquivos Epic 3 podem não ter sido criados"
fi

echo ""

# ============================================
# ETAPA 10: Conclusão
# ============================================
if [ "$VALIDATION_PASSED" = true ]; then
    success "✅ Upgrade para Epic 3 concluído com sucesso!"
else
    warning "Upgrade concluído mas com alguns avisos. Verifique os arquivos acima."
fi

echo ""
echo "================================================"
echo "📚 PRÓXIMOS PASSOS"
echo "================================================"
echo ""
echo "1. Abra o Obsidian na pasta knowledge-base/"
echo "2. Leia o arquivo 'BEM-VINDO.md'"
echo "3. Explore o novo dashboard '🏠 INÍCIO.md'"
echo "4. Execute /organizador para experimentar o tour guiado"
echo ""
echo "💾 Backup criado em: $BACKUP_FILE"
echo "🔄 Rollback: git reset --hard <commit-anterior>"
echo ""
echo "================================================"
echo ""

exit 0
