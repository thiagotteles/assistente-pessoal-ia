# Guia de Backup e Recovery - Assistente Pessoal IA

**Versão**: 1.0
**Data**: 2025-09-26

---

## 🎯 Visão Geral

Este guia ensina como proteger completamente seus dados do Assistente Pessoal IA através de estratégias de backup robustas e procedimentos de recovery testados. Como todos os seus dados pessoais e profissionais estarão no sistema, a proteção é fundamental.

## 📋 Índice

1. [Estratégias de Backup](#estratégias-de-backup)
2. [Configuração Inicial do Git](#configuração-inicial-do-git)
3. [Backup Automático](#backup-automático)
4. [Backup Manual](#backup-manual)
5. [Recovery Completo](#recovery-completo)
6. [Migração entre Dispositivos](#migração-entre-dispositivos)
7. [Backup de Emergência](#backup-de-emergência)
8. [Versionamento da Knowledge Base](#versionamento-da-knowledge-base)

---

## 💾 Estratégias de Backup

### Abordagem de 3-2-1

O sistema implementa a estratégia **3-2-1** de backup:
- **3 cópias** dos dados (original + 2 backups)
- **2 mídias diferentes** (local + remoto)
- **1 cópia off-site** (repositório Git remoto)

### Níveis de Proteção

#### Nível 1: Git Local (Automático)
- **Frequência**: A cada mudança
- **Localização**: `.git/` no projeto
- **Proteção**: Contra alterações acidentais
- **Recovery**: Instantâneo

#### Nível 2: Repositório Remoto (Semi-automático)
- **Frequência**: Diária ou semanal
- **Localização**: GitHub/GitLab privado
- **Proteção**: Contra perda do dispositivo
- **Recovery**: 5-10 minutos

#### Nível 3: Backup Físico (Manual)
- **Frequência**: Mensal
- **Localização**: HD externo/Nuvem
- **Proteção**: Contra catástrofes
- **Recovery**: 30-60 minutos

---

## ⚙️ Configuração Inicial do Git

### 1. Configuração Básica

```bash
# Configure suas credenciais (executar uma vez)
git config --global user.name "Seu Nome Completo"
git config --global user.email "seu.email@exemplo.com"

# Configure editor padrão (opcional)
git config --global core.editor "code"  # VS Code
# ou
git config --global core.editor "nano"  # Editor simples
```

### 2. Configuração do Projeto

```bash
# No diretório do projeto
cd assistente-pessoal-ia

# Verificar status do repositório
git status

# Se não for repositório Git ainda
git init
git add .
git commit -m "Configuração inicial do Assistente Pessoal IA"
```

### 3. Configuração de Repositório Remoto Privado

#### GitHub (Recomendado)

1. **Criar repositório privado no GitHub:**
   - Vá para github.com
   - Clique em "New repository"
   - Nome: `assistente-pessoal-ia`
   - **Marque "Private"** ⚠️ **IMPORTANTE**
   - Não inicialize com README (já temos)

2. **Conectar repositório local:**
   ```bash
   git remote add origin https://github.com/SEU_USUARIO/assistente-pessoal-ia.git
   git branch -M main
   git push -u origin main
   ```

#### GitLab (Alternativa)
```bash
git remote add origin https://gitlab.com/SEU_USUARIO/assistente-pessoal-ia.git
git push -u origin main
```

#### Bitbucket (Alternativa)
```bash
git remote add origin https://bitbucket.org/SEU_USUARIO/assistente-pessoal-ia.git
git push -u origin main
```

### 4. Configurar Credenciais Seguras

#### Token de Acesso Pessoal (Recomendado)

**GitHub:**
1. Settings → Developer settings → Personal access tokens
2. Generate new token (classic)
3. Scope: `repo` (acesso total a repositórios privados)
4. Copie o token

**Usar token:**
```bash
# Primeira vez (vai pedir usuário e senha)
git push
# Usuário: seu_usuario_github
# Senha: cole_o_token_aqui

# Salvar credenciais
git config credential.helper store
```

---

## 🤖 Backup Automático

### Script de Backup Automático

Crie o arquivo `scripts/auto-backup.sh`:

```bash
#!/bin/bash
# Script de backup automático

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Função principal de backup
perform_backup() {
    echo "🚀 Iniciando backup automático..."

    # 1. Verificar se há mudanças
    if git diff --quiet && git diff --staged --quiet; then
        print_status "Nenhuma mudança detectada, backup desnecessário"
        return 0
    fi

    # 2. Adicionar todas as mudanças
    git add .

    # 3. Commit com timestamp
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    git commit -m "Auto-backup: $timestamp

📊 Mudanças incluídas:
- Knowledge base atualizada
- Configurações dos agentes
- Dados de memória persistente
- Despejo processado

🤖 Backup automático via script"

    # 4. Push para remoto (se configurado)
    if git remote get-url origin >/dev/null 2>&1; then
        if git push; then
            print_status "Backup enviado para repositório remoto"
        else
            print_warning "Falha no push remoto (verificar conexão)"
        fi
    else
        print_warning "Repositório remoto não configurado"
    fi

    print_status "Backup local concluído"
}

# Executar backup
perform_backup
```

### Automatização por Plataforma

#### Windows (Task Scheduler)

1. **Criar arquivo batch `scripts/auto-backup.bat`:**
   ```batch
   @echo off
   cd /d "C:\caminho\para\assistente-pessoal-ia"
   bash scripts/auto-backup.sh
   pause
   ```

2. **Configurar Task Scheduler:**
   - Abra "Task Scheduler"
   - Create Basic Task
   - Name: "Assistente IA Backup"
   - Trigger: Daily (ou sua preferência)
   - Action: Start a program
   - Program: `C:\caminho\para\assistente-pessoal-ia\scripts\auto-backup.bat`

#### macOS/Linux (Cron)

```bash
# Editar crontab
crontab -e

# Adicionar linha (backup diário às 18h)
0 18 * * * cd /caminho/para/assistente-pessoal-ia && bash scripts/auto-backup.sh

# Ou backup a cada 6 horas
0 */6 * * * cd /caminho/para/assistente-pessoal-ia && bash scripts/auto-backup.sh
```

### Notificações de Backup

#### Windows
```batch
# Adicionar no final de auto-backup.bat
echo Backup concluído às %time% > backup-status.txt
msg %username% "Backup do Assistente IA concluído!"
```

#### macOS
```bash
# Adicionar no final de auto-backup.sh
osascript -e 'display notification "Backup concluído!" with title "Assistente IA"'
```

#### Linux (Ubuntu/GNOME)
```bash
# Adicionar no final de auto-backup.sh
notify-send "Assistente IA" "Backup concluído!"
```

---

## 📝 Backup Manual

### Backup Rápido Diário

```bash
# Comando rápido para backup manual
git add . && git commit -m "Backup manual $(date '+%Y-%m-%d %H:%M')" && git push
```

### Backup com Descrição Detalhada

```bash
# Verificar o que mudou
git status
git diff --name-only

# Backup descritivo
git add .
git commit -m "Backup manual: [descreva as mudanças]

Principais alterações:
- Novos projetos na knowledge base
- Memória dos agentes atualizada
- Processamento de despejo da semana

Data: $(date '+%Y-%m-%d %H:%M:%S')"

git push
```

### Backup de Emergência (Arquivo)

Para situações onde Git não está disponível:

```bash
# Criar backup compactado
tar -czf "backup-assistente-$(date +%Y%m%d-%H%M).tar.gz" \
    --exclude='.git' \
    --exclude='*.log' \
    --exclude='temp*' \
    .

# Ou apenas dados críticos
tar -czf "backup-dados-criticos-$(date +%Y%m%d).tar.gz" \
    knowledge-base/ \
    despejo/ \
    todos/ \
    diario/ \
    .assistant-core/agents/ \
    .assistant-core/memory/
```

---

## 🔄 Recovery Completo

### Cenário 1: Recovery em Novo Dispositivo

```bash
# 1. Instalar dependências básicas (Git, Python3)
# 2. Clonar repositório
git clone https://github.com/SEU_USUARIO/assistente-pessoal-ia.git
cd assistente-pessoal-ia

# 3. Executar setup
bash setup.sh  # Linux/Mac
# ou
setup.bat      # Windows

# 4. Validar instalação
bash test-basic.sh

# 5. Verificar dados
ls knowledge-base/
ls .assistant-core/agents/
```

### Cenário 2: Recovery após Corrupção

```bash
# 1. Backup do estado atual (por segurança)
mv assistente-pessoal-ia assistente-pessoal-ia-corrompido-$(date +%Y%m%d)

# 2. Clone limpo
git clone https://github.com/SEU_USUARIO/assistente-pessoal-ia.git
cd assistente-pessoal-ia

# 3. Setup e validação
bash setup.sh
bash test-basic.sh

# 4. Se necessário, recuperar dados específicos do backup corrompido
cp -r ../assistente-pessoal-ia-corrompido-*/knowledge-base/projetos/* knowledge-base/projetos/
```

### Cenário 3: Recovery Seletivo

```bash
# Recuperar apenas knowledge base
git checkout HEAD -- knowledge-base/

# Recuperar configurações dos agentes
git checkout HEAD -- .assistant-core/agents/
git checkout HEAD -- .assistant-core/memory/

# Recuperar arquivos específicos
git checkout HEAD -- despejo/daily-dump.md
git checkout HEAD -- knowledge-base/pessoas/pessoa-importante.md
```

### Cenário 4: Recovery Temporal

```bash
# Ver histórico de commits
git log --oneline --graph

# Voltar para commit específico
git checkout abc123

# Criar branch de recovery para explorar
git checkout -b recovery-exploration

# Se estiver correto, aplicar no main
git checkout main
git reset --hard abc123

# Ou recuperar arquivos específicos
git checkout main
git checkout abc123 -- knowledge-base/
```

---

## 🚀 Migração entre Dispositivos

### Migração Completa

#### Dispositivo Origem:
```bash
# 1. Fazer backup final
git add .
git commit -m "Backup final antes da migração $(date)"
git push

# 2. Criar backup de arquivos locais
tar -czf assistente-migracao-$(date +%Y%m%d).tar.gz \
    --exclude='.git' \
    .
```

#### Dispositivo Destino:
```bash
# 1. Instalar dependências
# [específico do SO - ver TROUBLESHOOTING.md]

# 2. Clonar repositório
git clone https://github.com/SEU_USUARIO/assistente-pessoal-ia.git
cd assistente-pessoal-ia

# 3. Setup inicial
bash setup.sh
bash test-basic.sh

# 4. Configurar Git
git config user.name "Seu Nome"
git config user.email "seu.email@exemplo.com"

# 5. Validar funcionalidade
/organizador "teste de migração bem-sucedida"
```

### Migração Incremental

Para manter dois dispositivos sincronizados:

```bash
# Dispositivo A - enviar mudanças
git add .
git commit -m "Trabalho do dispositivo A - $(date)"
git push

# Dispositivo B - receber mudanças
git pull
bash test-basic.sh  # Validar integridade
```

### Resolução de Conflitos

```bash
# Se houver conflitos durante pull
git status  # Ver arquivos em conflito

# Para cada arquivo em conflito
git add arquivo-resolvido.md

# Completar merge
git commit -m "Resolvidos conflitos de sincronização"
git push
```

---

## 🚨 Backup de Emergência

### Protocolo de Emergência Rápida

```bash
#!/bin/bash
# Script: emergency-backup.sh

echo "🚨 BACKUP DE EMERGÊNCIA INICIADO"

# 1. Backup imediato para múltiplos locais
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

# Backup local
tar -czf "/tmp/emergency-backup-$TIMESTAMP.tar.gz" \
    knowledge-base/ despejo/ todos/ diario/ .assistant-core/

# Backup Git
git add .
git commit -m "🚨 EMERGENCY BACKUP - $TIMESTAMP"
git push origin main

# Backup para USB/drive externo (se disponível)
if [ -d "/media/backup" ]; then
    cp "/tmp/emergency-backup-$TIMESTAMP.tar.gz" "/media/backup/"
fi

# Backup para Dropbox/OneDrive (se configurado)
if [ -d "$HOME/Dropbox" ]; then
    cp "/tmp/emergency-backup-$TIMESTAMP.tar.gz" "$HOME/Dropbox/"
fi

echo "✅ Backup de emergência concluído"
echo "📁 Arquivo: /tmp/emergency-backup-$TIMESTAMP.tar.gz"
```

### Quando Usar Backup de Emergência

- 🚨 Antes de atualizações importantes do sistema
- 🚨 Antes de mudanças experimentais no código
- 🚨 Quando detectar corrupção de dados
- 🚨 Antes de formatação/reinstalação
- 🚨 Antes de viagens (backup extra)

---

## 📚 Versionamento da Knowledge Base

### Tags para Marcos Importantes

```bash
# Criar tag para marcos importantes
git tag -a v1.0-conhecimento-inicial -m "Estado inicial da knowledge base"
git tag -a v1.1-projeto-x-completo -m "Conhecimento após conclusão do Projeto X"
git tag -a v2.0-reestruturacao -m "Após reestruturação da base de conhecimento"

# Enviar tags para remoto
git push origin --tags

# Listar tags
git tag -l

# Voltar para tag específica
git checkout v1.0-conhecimento-inicial
```

### Branches para Experimentos

```bash
# Criar branch para experimentos
git checkout -b experimento-nova-estrutura

# Fazer mudanças experimentais
# ...

# Se deu certo, fazer merge
git checkout main
git merge experimento-nova-estrutura

# Se não deu certo, descartar
git checkout main
git branch -D experimento-nova-estrutura
```

### Backup Semanal Estruturado

```bash
#!/bin/bash
# Script: weekly-backup.sh

WEEK=$(date +%Y-W%U)
BRANCH="backup-semana-$WEEK"

# Criar branch da semana
git checkout -b $BRANCH
git add .
git commit -m "Backup semanal $WEEK

📊 Estatísticas da semana:
- Arquivos na knowledge base: $(find knowledge-base -name "*.md" | wc -l)
- Interações com agentes: $(wc -l < .assistant-core/logs/agent-interactions.log)
- Projetos ativos: $(ls knowledge-base/projetos/ | wc -l)

🎯 Principais conquistas:
- [Adicione manualmente os highlights da semana]"

# Voltar para main
git checkout main

# Push da branch de backup
git push origin $BRANCH

# Criar tag
git tag -a "semana-$WEEK" -m "Snapshot da semana $WEEK"
git push origin --tags
```

---

## 📊 Monitoramento de Backup

### Status de Backup

Crie o arquivo `scripts/backup-status.sh`:

```bash
#!/bin/bash
# Verificar status de backup

echo "📊 STATUS DO BACKUP - $(date)"
echo "=================================="

# 1. Status Git local
echo "🔄 Git Local:"
if git status --porcelain | grep -q .; then
    echo "  ⚠️  Há mudanças não commitadas"
    git status --short
else
    echo "  ✅ Todos os dados estão commitados"
fi

# 2. Status remoto
echo ""
echo "☁️  Repositório Remoto:"
if git remote get-url origin >/dev/null 2>&1; then
    if git fetch --dry-run 2>&1 | grep -q "up to date"; then
        echo "  ✅ Sincronizado com remoto"
    else
        echo "  ⚠️  Necessário push/pull"
    fi
else
    echo "  ❌ Repositório remoto não configurado"
fi

# 3. Último backup
echo ""
echo "📅 Último Backup:"
LAST_COMMIT=$(git log -1 --format="%H %s %ai")
echo "  $LAST_COMMIT"

# 4. Tamanho dos dados
echo ""
echo "💾 Tamanho dos Dados:"
echo "  Knowledge Base: $(du -sh knowledge-base/ | cut -f1)"
echo "  Configurações: $(du -sh .assistant-core/ | cut -f1)"
echo "  Total: $(du -sh . --exclude='.git' | cut -f1)"

# 5. Arquivos críticos
echo ""
echo "📁 Arquivos Críticos:"
for file in "despejo/daily-dump.md" ".assistant-core/agents/organizador.yaml"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file (AUSENTE)"
    fi
done
```

### Alertas de Backup

```bash
# Adicionar ao crontab para verificação diária
0 9 * * * cd /caminho/para/assistente-pessoal-ia && bash scripts/backup-status.sh | mail -s "Status Backup Assistente IA" seu.email@exemplo.com
```

---

## ✅ Checklist de Backup

### Configuração Inicial
- [ ] Git configurado com usuário e email
- [ ] Repositório remoto privado criado e conectado
- [ ] Primeiro backup realizado com sucesso
- [ ] Scripts de backup automático configurados
- [ ] Teste de recovery realizado

### Rotina Diária
- [ ] Verificar se backup automático funcionou
- [ ] Commit manual se necessário
- [ ] Verificar sincronização com remoto

### Rotina Semanal
- [ ] Executar `bash scripts/backup-status.sh`
- [ ] Criar tag semanal se apropriado
- [ ] Verificar integridade dos dados
- [ ] Testar recovery de arquivo aleatório

### Rotina Mensal
- [ ] Backup físico/offline
- [ ] Limpeza de branches antigas
- [ ] Revisão da estratégia de backup
- [ ] Teste de recovery completo

---

## 🎯 Resumo das Melhores Práticas

1. **Commits Frequentes**: Faça commit a cada sessão de trabalho
2. **Mensagens Descritivas**: Use mensagens de commit que expliquem o que mudou
3. **Push Diário**: Sincronize com repositório remoto diariamente
4. **Tags para Marcos**: Use tags para marcos importantes
5. **Teste de Recovery**: Teste procedimentos de recovery regularmente
6. **Múltiplos Locais**: Mantenha backups em pelo menos 2 locais diferentes
7. **Monitoramento**: Monitore o status de backup regularmente

---

**Lembre-se**: Seus dados pessoais e profissionais são únicos e insubstituíveis. Um sistema de backup bem implementado é seu seguro contra perda de informações valiosas.

🛡️ **Seus dados estão protegidos** - Com essas estratégias, você tem múltiplas camadas de proteção contra qualquer tipo de perda de dados.