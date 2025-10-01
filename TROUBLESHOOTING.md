# Guia de Resolução de Problemas - Assistente Pessoal IA

**Versão**: 1.0
**Data**: 2025-09-26

---

## 🎯 Visão Geral

Este guia contém soluções para os problemas mais comuns que você pode encontrar ao usar o Assistente Pessoal IA. Os problemas estão organizados por categoria para facilitar a localização da solução.

## 📋 Índice

1. [Problemas de Instalação](#problemas-de-instalação)
2. [Problemas com Agentes](#problemas-com-agentes)
3. [Problemas com Obsidian](#problemas-com-obsidian)
4. [Problemas de Performance](#problemas-de-performance)
5. [Problemas com Knowledge Base](#problemas-com-knowledge-base)
6. [Problemas com Testes](#problemas-com-testes)
7. [Recuperação de Dados](#recuperação-de-dados)
8. [Problemas Específicos de SO](#problemas-específicos-de-so)

---

## 🔧 Problemas de Instalação

### ❌ Erro: "Python não encontrado"

**Sintomas:**
```
python3: command not found
ou
'python3' is not recognized as an internal or external command
```

**Soluções:**

#### Windows:
1. **Instalar Python do site oficial:**
   - Vá para [python.org](https://python.org)
   - Baixe Python 3.8+ para Windows
   - **IMPORTANTE**: Marque "Add Python to PATH" durante instalação

2. **Verificar instalação:**
   ```cmd
   python --version
   python3 --version
   ```

3. **Se ainda não funcionar:**
   ```cmd
   # Usar 'python' ao invés de 'python3' no Windows
   python test-agents.py
   ```

#### macOS:
```bash
# Instalar via Homebrew (recomendado)
brew install python3

# Ou via Xcode Command Line Tools
xcode-select --install
```

#### Linux (Ubuntu/Debian):
```bash
sudo apt update
sudo apt install python3 python3-pip
```

### ❌ Erro: "Git não encontrado"

**Sintomas:**
```
git: command not found
```

**Soluções:**

#### Windows:
- Baixe e instale o Git de [git-scm.com](https://git-scm.com)
- Escolha "Git from the command line and also from 3rd-party software"

#### macOS:
```bash
# Via Homebrew
brew install git

# Ou via Xcode
xcode-select --install
```

#### Linux:
```bash
# Ubuntu/Debian
sudo apt install git

# CentOS/RHEL
sudo yum install git
```

### ❌ Erro: "Permissão negada" ao executar scripts

**Sintomas:**
```
bash: ./setup.sh: Permission denied
```

**Solução:**
```bash
# Dar permissão de execução
chmod +x setup.sh
chmod +x test-basic.sh
chmod +x test-recovery.sh

# Então executar
bash setup.sh
```

### ❌ Setup incompleto ou com erros

**Solução Rápida:**
```bash
# Execute recuperação automática
bash test-recovery.sh

# Execute setup novamente
bash setup.sh  # Linux/Mac
setup.bat      # Windows

# Valide com testes
bash test-basic.sh
```

---

## 🤖 Problemas com Agentes

### ❌ Agente não responde ou dá erro

**Sintomas:**
- Comandos `/organizador`, `/secretaria`, etc. não funcionam
- Mensagens de erro sobre configuração

**Diagnóstico:**
```bash
# Teste específico dos agentes
python3 test-agents.py
```

**Soluções:**

#### 1. Verificar arquivos de configuração:
```bash
# Verificar se existem
ls .assistant-core/agents/
# Deve mostrar: organizador.yaml, secretaria.yaml, arquiteto.yaml, psicologo.yaml, mentor.yaml

ls .assistant-core/memory/
# Deve mostrar: organizador-memory.yaml, secretaria-memory.yaml, etc.
```

#### 2. Recriar configurações ausentes:
```bash
bash test-recovery.sh
```

#### 3. Verificar conteúdo dos arquivos:
```bash
# Verificar se arquivos não estão vazios
cat .assistant-core/agents/organizador.yaml
```

### ❌ Erro: "Módulo não encontrado" nos testes Python

**Sintomas:**
```
ModuleNotFoundError: No module named 'yaml'
```

**Soluções:**

#### Instalar dependências:
```bash
# Via pip
pip3 install pyyaml

# Ou se tiver requirements.txt
pip3 install -r requirements.txt
```

### ❌ Agentes funcionam mas respostas são genéricas

**Possíveis Causas:**
1. Arquivos de memória vazios ou corrompidos
2. Configurações YAML incorretas
3. Knowledge base vazia

**Soluções:**
```bash
# 1. Regenerar memória dos agentes
bash test-recovery.sh

# 2. Verificar knowledge base
ls knowledge-base/
# Deve ter conteúdo em pessoas/, projetos/, etc.

# 3. Executar organizador com conteúdo real
/organizador despejo/daily-dump.md
```

---

## 🧠 Problemas com Obsidian

### ❌ Obsidian não reconhece como vault válido

**Sintomas:**
- Obsidian não abre a pasta `knowledge-base/`
- Erro "Not a valid vault"

**Solução:**
```bash
# Verificar estrutura .obsidian
ls knowledge-base/.obsidian/
# Deve ter: app.json, graph.json, hotkeys.json

# Se não existir, recriar
bash test-recovery.sh

# Forçar criação manualmente
mkdir -p knowledge-base/.obsidian
```

**Configuração Manual no Obsidian:**
1. Abra Obsidian
2. "Open folder as vault" → selecione `knowledge-base/`
3. Se pedir para criar vault → Aceite

### ❌ Links [[]] não funcionam

**Sintomas:**
- Referências `[[nome]]` não criam links
- Backlinks não aparecem

**Soluções:**

#### 1. Verificar configuração Obsidian:
- Settings → Files & Links → "Automatically update internal links" ✅
- Settings → Files & Links → "Use [[Wikilinks]]" ✅

#### 2. Criar arquivos alvo:
```bash
# Se [[João Silva]] não funciona, criar arquivo
touch "knowledge-base/pessoas/joao-silva.md"
```

#### 3. Usar formato correto:
```markdown
# Correto
[[João Silva]]

# Incorreto
[João Silva]
(João Silva)
```

### ❌ Obsidian lento ou travando

**Soluções:**

#### 1. Reduzir plugins:
- Settings → Community plugins → Disable plugins desnecessários

#### 2. Otimizar graph view:
- Graph view → Filters → Limit nodes
- Desabilitar orphan files se tiver muitos

#### 3. Limpar cache:
```bash
# Fechar Obsidian e limpar cache
rm -rf knowledge-base/.obsidian/workspace*
rm -rf knowledge-base/.obsidian/cache
```

---

## ⚡ Problemas de Performance

### ❌ Sistema lento para processar informações

**Possíveis Causas:**
1. Arquivos muito grandes
2. Muitos arquivos na knowledge base
3. Sistema com pouca memória

**Soluções:**

#### 1. Limpar arquivos antigos:
```bash
# Limpar logs antigos
find .assistant-core/logs/ -name "*.log" -mtime +30 -delete

# Arquivar despejo processado
mv despejo/daily-dump.md despejo/processed/dump-$(date +%Y%m%d).txt
touch despejo/daily-dump.md
```

#### 2. Otimizar knowledge base:
```bash
# Verificar tamanho dos arquivos
find knowledge-base/ -name "*.md" -size +1M

# Quebrar arquivos grandes
/organizador "arquivo knowledge-base/projetos/projeto-grande.md está muito grande, quebrar em partes"
```

#### 3. Configurar Git para performance:
```bash
git config core.preloadindex true
git config core.fscache true
git config gc.auto 256
```

### ❌ Testes demoram muito para executar

**Soluções:**
```bash
# Executar apenas testes essenciais
bash test-basic.sh --quick

# Ou pular testes opcionais
export SKIP_OPTIONAL_TESTS=1
bash test-basic.sh
```

---

## 📚 Problemas com Knowledge Base

### ❌ Knowledge Base vazia ou sem conteúdo

**Sintomas:**
- Pastas `pessoas/`, `projetos/` vazias
- Agentes não têm contexto

**Soluções:**

#### 1. Criar conteúdo inicial:
```bash
bash test-recovery.sh
```

#### 2. Processar despejo existente:
```bash
# Adicionar conteúdo no despejo
echo "Projeto X - reunião com Maria amanhã
Ideia: app de receitas
Comprar café" >> despejo/daily-dump.md

# Processar com organizador
/organizador despejo/daily-dump.md
```

### ❌ Referências [[]] quebradas

**Sintomas:**
- Links para arquivos que não existem
- Backlinks não funcionando

**Soluções:**

#### 1. Listar referências quebradas:
```bash
# Procurar por links [[]] em todos os arquivos
grep -r "\[\[.*\]\]" knowledge-base/ | grep -v ".obsidian"
```

#### 2. Criar arquivos ausentes:
```bash
# Para cada referência quebrada [[Nome]], criar arquivo
touch "knowledge-base/pessoas/nome.md"
# ou
touch "knowledge-base/projetos/nome.md"
```

#### 3. Corrigir links automaticamente:
```bash
/organizador "corrigir referências quebradas na knowledge base"
```

### ❌ Metadados YAML corrompidos

**Sintomas:**
```
Error parsing YAML front matter
```

**Soluções:**

#### 1. Verificar formato YAML:
```yaml
---
id: exemplo
type: pessoa
created: 2025-01-09T10:00:00
updated: 2025-01-09T10:00:00
tags: [exemplo, pessoa]
---
```

#### 2. Corrigir arquivos corrompidos:
```bash
# Fazer backup
cp arquivo-corrompido.md arquivo-corrompido.md.bak

# Remover metadados corrompidos e recriar
tail -n +10 arquivo-corrompido.md > temp.md
mv temp.md arquivo-corrompido.md

# Regenerar metadados
/organizador "recriar metadados YAML para arquivo-corrompido.md"
```

---

## 🧪 Problemas com Testes

### ❌ test-basic.sh falha

**Sintomas:**
```
❌ Teste X: FALHOU
```

**Diagnóstico:**
```bash
# Executar com verbose
bash -x test-basic.sh

# Ou executar recuperação primeiro
bash test-recovery.sh
bash test-basic.sh
```

**Soluções por Categoria de Teste:**

#### Teste de Estrutura:
```bash
# Se diretórios estão ausentes
mkdir -p .assistant-core/{agents,memory,logs,data}
mkdir -p {despejo/processed,todos/{por-projeto,por-pessoa}}
mkdir -p knowledge-base/{decisoes,contextos,projetos,pessoas}
```

#### Teste de Agentes:
```bash
# Se configurações estão ausentes
bash test-recovery.sh
```

#### Teste de Python:
```bash
# Se módulos não são encontrados
pip3 install pyyaml
# Ou usar conda
conda install pyyaml
```

### ❌ test-agents.py falha

**Sintomas:**
```python
ImportError: No module named 'yaml'
FileNotFoundError: [Errno 2] No such file or directory: '.assistant-core/agents/organizador.yaml'
```

**Soluções:**
```bash
# 1. Instalar dependências
pip3 install pyyaml

# 2. Verificar estrutura
ls .assistant-core/agents/
ls .assistant-core/memory/

# 3. Se arquivos ausentes
bash test-recovery.sh

# 4. Testar novamente
python3 test-agents.py
```

---

## 💾 Recuperação de Dados

### ❌ Perda acidental de dados

**Recuperação via Git:**
```bash
# Ver histórico de commits
git log --oneline

# Recuperar arquivo específico
git checkout HEAD~1 -- knowledge-base/pessoas/pessoa-importante.md

# Recuperar para commit específico
git checkout abc123 -- arquivo-perdido.md

# Recuperar tudo para estado anterior
git reset --hard HEAD~1
```

### ❌ Knowledge Base corrompida

**Recuperação Completa:**
```bash
# 1. Backup atual (por segurança)
cp -r knowledge-base knowledge-base-backup-$(date +%Y%m%d)

# 2. Recuperar estrutura
bash test-recovery.sh

# 3. Recuperar via Git se disponível
git checkout HEAD -- knowledge-base/

# 4. Reprocessar despejo se necessário
/organizador despejo/daily-dump.md
```

### ❌ Configurações de agentes perdidas

**Recuperação:**
```bash
# Método 1: Recuperação automática
bash test-recovery.sh

# Método 2: Recuperação via Git
git checkout HEAD -- .assistant-core/

# Método 3: Download das configurações originais (se disponível)
# [comando específico depende de onde o projeto foi obtido]
```

### ❌ Obsidian não salva mudanças

**Possíveis Causas:**
1. Permissões de arquivo
2. Vault corrompido
3. Conflito de sincronização

**Soluções:**
```bash
# 1. Verificar permissões
chmod -R 755 knowledge-base/

# 2. Recriar configuração Obsidian
rm -rf knowledge-base/.obsidian
bash test-recovery.sh

# 3. Forçar commit das mudanças
cd knowledge-base
git add .
git commit -m "Backup manual das mudanças"
```

---

## 💻 Problemas Específicos de SO

### Windows

#### ❌ "Execution of scripts is disabled"
```powershell
# No PowerShell como Administrador
Set-ExecutionPolicy RemoteSigned
```

#### ❌ Caracteres especiais não funcionam
```cmd
# Configurar codificação UTF-8
chcp 65001
```

#### ❌ Paths com espaços causam erro
```bash
# Sempre usar aspas
"/c/Program Files/Python/python.exe" test-agents.py
```

### macOS

#### ❌ "cannot be opened because the developer cannot be verified"
```bash
# Para cada script
xattr -d com.apple.quarantine setup.sh
xattr -d com.apple.quarantine test-basic.sh
```

#### ❌ SIP (System Integrity Protection) bloqueia operações
```bash
# Usar homebrew em vez de instalações no sistema
brew install python3
```

### Linux

#### ❌ Dependências ausentes
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3 python3-pip git curl

# CentOS/RHEL
sudo yum install python3 python3-pip git

# Arch
sudo pacman -S python git
```

#### ❌ Permissões SELinux
```bash
# Se necessário, ajustar contexto SELinux
restorecon -R /caminho/para/assistente-pessoal-ia/
```

---

## 🚨 Protocolo de Emergência

### Quando Tudo Falha

#### 1. Backup de Emergência
```bash
# Salvar dados críticos
tar -czf backup-emergencia-$(date +%Y%m%d).tar.gz \
  despejo/ knowledge-base/ todos/ diario/

# Salvar configurações
tar -czf config-backup-$(date +%Y%m%d).tar.gz .assistant-core/
```

#### 2. Reinstalação Limpa
```bash
# Mover dados para segurança
mv knowledge-base knowledge-base-old
mv despejo despejo-old

# Executar setup limpo
bash setup.sh

# Restaurar dados gradualmente
cp -r knowledge-base-old/* knowledge-base/
cp -r despejo-old/* despejo/

# Validar
bash test-basic.sh
```

#### 3. Recuperação Manual
```bash
# Criar estrutura mínima
mkdir -p {despejo,knowledge-base,todos,diario}
mkdir -p .assistant-core/{agents,memory}

# Executar recuperação
bash test-recovery.sh

# Reprocessar informações críticas
/organizador "reprocessar informações críticas de backup"
```

---

## 📞 Quando Procurar Ajuda

### Problemas Resolvidos por Este Guia
- ✅ Instalação e configuração
- ✅ Problemas comuns dos agentes
- ✅ Integração com Obsidian
- ✅ Performance básica
- ✅ Recuperação de dados

### Problemas que Precisam de Suporte
- 🔍 Bugs no código dos agentes
- 🔍 Problemas de compatibilidade com novas versões
- 🔍 Corrupção grave de dados não recuperável
- 🔍 Problemas de integração com Claude Code

### Informações para Reportar Problemas

Se precisar reportar um problema:

```bash
# Colete informações do sistema
echo "=== INFORMAÇÕES DO SISTEMA ==="
uname -a
python3 --version
git --version

echo "=== STATUS DOS TESTES ==="
bash test-basic.sh

echo "=== ESTRUTURA DO PROJETO ==="
find . -type f -name "*.yaml" -o -name "*.md" | head -20

echo "=== LOGS RECENTES ==="
tail -50 .assistant-core/logs/*.log 2>/dev/null || echo "Sem logs disponíveis"
```

---

## ✅ Checklist de Verificação

Antes de reportar um problema, verifique:

- [ ] Executou `bash test-recovery.sh`
- [ ] Tentou `bash test-basic.sh` após a recuperação
- [ ] Verificou se arquivos críticos existem
- [ ] Testou em terminal/prompt limpo
- [ ] Verificou permissões de arquivos
- [ ] Fez backup dos dados importantes
- [ ] Consultou seções relevantes deste guia

---

**Lembre-se**: A maioria dos problemas pode ser resolvida com `bash test-recovery.sh` seguido de `bash test-basic.sh`. Quando em dúvida, sempre faça backup primeiro!

🔧 **Seus dados são importantes** - sempre faça backup antes de tentar correções que modificam arquivos.