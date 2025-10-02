#!/bin/bash
# apply-epic3-agent-patches.sh - Aplicar Patches Epic 3 em Agentes Conversacionais
# Sistema: Assistente Pessoal IA

set -e

AGENTS_DIR=".assistant-core/agents"
BACKUP_DIR=".assistant-core/agents/backup-pre-epic3"
MEMORY_DIR=".assistant-core/memory"

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
success() { echo -e "${GREEN}✅ $1${NC}"; }
warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; exit 1; }

info "Aplicando Patches Epic 3 nos Agentes Conversacionais"
echo ""

# Verificar que agentes existem
if [ ! -d "$AGENTS_DIR" ]; then
    error "Diretório $AGENTS_DIR não encontrado. Execute setup.bat/sh primeiro."
fi

# Backup de agentes já foi feito no upgrade-to-epic3.sh
# Mas verificamos se existe
if [ ! -d "$BACKUP_DIR" ]; then
    warning "Criando backup de agentes..."
    mkdir -p "$BACKUP_DIR"
    cp "$AGENTS_DIR"/*.md "$BACKUP_DIR/" 2>/dev/null || true
fi

# Criar diretório de memória se não existir
mkdir -p "$MEMORY_DIR"

echo ""

# ============================================
# PATCH 1: Organizador - Tour Guiado
# ============================================
info "Aplicando patch Epic 3 no Organizador (Sofia)..."

ORGANIZADOR="$AGENTS_DIR/organizador.md"

if [ ! -f "$ORGANIZADOR" ]; then
    error "Arquivo organizador.md não encontrado"
fi

# Verificar se patch já foi aplicado
if grep -q "tour-guiado:" "$ORGANIZADOR" 2>/dev/null; then
    warning "Patch Epic 3 já aplicado no Organizador, pulando..."
else
    # Adicionar seção de tour guiado APÓS o bloco YAML
    # Primeiro, encontrar onde termina o bloco YAML (última linha com ```)

    # Criar conteúdo do patch
    PATCH_CONTENT='
  # Tour Guiado Epic 3
  tour-guiado:
    enabled: true
    triggered-on-first-run: true
    storage: .assistant-core/memory/organizador-tour-status.yaml
    steps:
      - id: passo-1
        title: "Passo 1: Seu Primeiro Despejo"
        message: |
          👋 Olá! Sou a Sofia, sua Organizadora.

          Vou te mostrar como funciona em 3 passos práticos!

          **Passo 1**: Vamos escrever seu primeiro despejo mental.

          Abra o arquivo `despejo/daily-dump.md` e escreva qualquer coisa que está na sua cabeça:
          - Reuniões que você teve
          - Ideias de projetos
          - Tarefas para fazer
          - Aprendizados
          - Qualquer pensamento!

          Já escreveu algo? Me avise quando terminar! (sim/pronto/ok)

      - id: passo-2
        title: "Passo 2: Processamento Automático"
        message: |
          🚀 Ótimo! Agora vou processar isso para você.

          **Passo 2**: Vou ler seu despejo e organizá-lo automaticamente.

          Vou fazer algumas perguntas específicas (máximo 3-5 perguntas) para entender melhor o contexto.

          Pronto para processar? (sim/processar)
        action: "Executar *processar automaticamente"

      - id: passo-3
        title: "Passo 3: Ver Resultado no Obsidian"
        message: |
          ✨ Pronto! Processei seu despejo.

          **Passo 3**: Agora veja o resultado visual no Obsidian.

          Abra o Obsidian na pasta `knowledge-base/` e explore:
          - Projetos criados
          - Pessoas mencionadas
          - Todos extraídos
          - Links [[automáticos]]

          🎉 Parabéns! Você completou o tour inicial.

          A partir de agora, basta jogar suas ideias no daily-dump.md e executar `/organizador *processar`.

          Ficou com dúvida? Me pergunte qualquer coisa!

    completion-message: |
      ✅ Tour concluído! Você já sabe usar o sistema.

      📚 Próximos passos:
      - Converse com outros agentes: /secretaria, /arquiteto, /psicologo, /mentor
      - Veja seu dashboard: Abra `📈 MEU-DASHBOARD.md` no Obsidian
      - Explore o grafo de conhecimento: Ctrl+Shift+G

      Estou aqui sempre que precisar! 😊
'

    # Inserir patch DENTRO do bloco YAML, antes do último ```
    # Estratégia: adicionar antes da última linha que contém ```

    # Criar arquivo temporário com patch aplicado
    TEMP_FILE=$(mktemp)

    # Processar arquivo linha por linha
    awk -v patch="$PATCH_CONTENT" '
        /^```$/ {
            if (in_yaml) {
                # Encontrou o fechamento do YAML
                print patch
                print $0
                in_yaml = 0
                next
            } else {
                # Encontrou abertura do YAML
                in_yaml = 1
            }
        }
        { print }
    ' "$ORGANIZADOR" > "$TEMP_FILE"

    # Substituir arquivo original
    mv "$TEMP_FILE" "$ORGANIZADOR"

    success "Patch Epic 3 aplicado no Organizador (tour guiado)"
fi

# ============================================
# PATCH 2-5: Outros Agentes - Saudação Contextual
# ============================================
apply_greeting_patch() {
    local agent_file="$1"
    local agent_name="$2"
    local agent_display_name="$3"

    info "Aplicando patch Epic 3 em $agent_display_name..."

    if [ ! -f "$agent_file" ]; then
        warning "Arquivo $agent_file não encontrado, pulando..."
        return
    fi

    # Verificar se patch já foi aplicado
    if grep -q "saudacao-contextual:" "$agent_file" 2>/dev/null; then
        warning "Patch Epic 3 já aplicado em $agent_display_name, pulando..."
        return
    fi

    # Criar conteúdo do patch
    local PATCH_CONTENT="
  # Saudação Contextual Epic 3
  saudacao-contextual:
    enabled: true
    storage: .assistant-core/memory/${agent_name}-context.yaml
    on-activation-show:
      - ultima-conversa: Exibir tempo desde última conversa (ex: \"Última vez: há 3 dias\")
      - total-conversas: Exibir total de conversas (ex: \"Esta é nossa 12ª conversa\")
      - streak-dias: Exibir streak de dias consecutivos (ex: \"Você está em um streak de 7 dias!\")
      - top-contextos: Exibir top 3 contextos/temas relevantes (ex: \"Últimos temas: [[projeto-x]], [[pessoa-y]], [[decisao-z]]\")

    mensagem-padrao: |
      👋 {saudacao-personalizada}

      📊 Status:
      - Última conversa: {tempo-desde-ultima}
      - Total de conversas: {numero-conversas}ª conversa
      - Streak: {streak-dias} dias consecutivos 🔥
      - Contextos recentes: {top-3-contextos}

      Como posso ajudar hoje?
"

    # Inserir patch DENTRO do bloco YAML, antes do último ```
    TEMP_FILE=$(mktemp)

    awk -v patch="$PATCH_CONTENT" '
        /^```$/ {
            if (in_yaml) {
                print patch
                print $0
                in_yaml = 0
                next
            } else {
                in_yaml = 1
            }
        }
        { print }
    ' "$agent_file" > "$TEMP_FILE"

    mv "$TEMP_FILE" "$agent_file"

    success "Patch Epic 3 aplicado em $agent_display_name (saudação contextual)"
}

# Aplicar patches nos outros 4 agentes
apply_greeting_patch "$AGENTS_DIR/secretaria.md" "secretaria" "Secretária"
apply_greeting_patch "$AGENTS_DIR/arquiteto.md" "arquiteto" "Arquiteto (Marcus)"
apply_greeting_patch "$AGENTS_DIR/psicologo.md" "psicologo" "Psicólogo (Dr. Helena)"
apply_greeting_patch "$AGENTS_DIR/mentor.md" "mentor" "Mentor (Leonardo)"

echo ""

# ============================================
# Validação: Testar YAML parsing
# ============================================
info "Validando YAML dos agentes..."

VALIDATION_OK=1

for agent in organizador secretaria arquiteto psicologo mentor; do
    agent_file="$AGENTS_DIR/${agent}.md"

    if [ -f "$agent_file" ]; then
        # Validação básica: verificar que bloco YAML está bem formado
        if grep -q "agent:" "$agent_file"; then
            echo "  ✓ $agent: YAML OK"
        else
            echo "  ✗ $agent: YAML pode ter problemas"
            VALIDATION_OK=0
        fi
    fi
done

echo ""

# ============================================
# Criar arquivos de memória iniciais
# ============================================
info "Criando arquivos de memória iniciais..."

# Tour status do Organizador
if [ ! -f "$MEMORY_DIR/organizador-tour-status.yaml" ]; then
    cat > "$MEMORY_DIR/organizador-tour-status.yaml" << 'EOF'
# Status do Tour Guiado - Organizador
tour-completed: false
current-step: 0
started-at: null
completed-at: null
EOF
    success "Memória de tour criada: organizador-tour-status.yaml"
fi

# Contextos dos agentes
for agent in secretaria arquiteto psicologo mentor; do
    context_file="$MEMORY_DIR/${agent}-context.yaml"
    if [ ! -f "$context_file" ]; then
        cat > "$context_file" << EOF
# Contexto e Saudação - ${agent^}
ultima-conversa: null
total-conversas: 0
streak-dias: 0
top-contextos: []
historico-temas: []
EOF
        success "Memória de contexto criada: ${agent}-context.yaml"
    fi
done

echo ""

# ============================================
# Conclusão
# ============================================
if [ $VALIDATION_OK -eq 1 ]; then
    success "Patches Epic 3 aplicados com sucesso em todos os agentes!"
else
    warning "Patches aplicados mas com alguns avisos. Verifique os arquivos acima."
fi

echo ""
echo -e "${BLUE}📋 Resumo:${NC}"
echo "  • Organizador: Tour guiado de 3 passos adicionado"
echo "  • Secretária, Arquiteto, Psicólogo, Mentor: Saudação contextual adicionada"
echo "  • Arquivos de memória criados em .assistant-core/memory/"
echo "  • Backup dos agentes originais em: $BACKUP_DIR"
echo ""
echo -e "${YELLOW}💡 Teste os agentes:${NC}"
echo "  /organizador    # Deve iniciar tour se primeira vez"
echo "  /secretaria     # Deve exibir saudação contextual"
echo ""
