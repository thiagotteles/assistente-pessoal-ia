# 🚀 Quick Start - Deploy do Assistente

**Para usuários que querem instalar apenas os arquivos essenciais do assistente.**

## ⚡ TL;DR - Instalação em 2 Minutos

```bash
# 1. Clone temporariamente
git clone <repo-url> temp-assistente && cd temp-assistente

# 2. Deploy para sua pasta
./scripts/deploy-assistant.sh ~/assistente-ia

# 3. Acesse e teste
cd ~/assistente-ia

# 4. Limpe temporários
cd .. && rm -rf temp-assistente
```

**Pronto!** Abra o Claude Code na pasta `~/assistente-ia` e comece usando `/assistentes:agents:organizador`

---

## 📋 Passo a Passo Detalhado

### 1. Preparação

**Clone o projeto completo** (temporariamente):
```bash
git clone https://github.com/seu-repo/assistente-pessoal-ia temp-assistente-dev
cd temp-assistente-dev
```

### 2. Escolha o Local de Instalação

**Exemplos de caminhos:**

**Linux/macOS:**
- `~/assistente-ia` (pasta pessoal)
- `~/Documents/assistente` (documentos)
- `/opt/assistente` (sistema, precisa sudo)

**Windows:**
- `/c/Users/SeuUsuario/assistente` (Git Bash)
- `/mnt/c/Users/SeuUsuario/assistente` (WSL)

### 3. Execute o Deploy

```bash
# Substitua pelo caminho desejado
./scripts/deploy-assistant.sh ~/assistente-ia
```

**O script irá:**
- ✅ Criar a pasta de destino
- ✅ Copiar apenas arquivos essenciais
- ✅ Configurar estrutura básica
- ✅ Validar instalação
- ✅ Mostrar resumo do que foi instalado

### 4. Validação

```bash
cd ~/assistente-ia

# Verificar estrutura
ls -la
# Deve mostrar: .claude, .assistant-core, knowledge-base, todos, despejo, scripts

# Verificar tamanho (deve ser muito menor que o projeto original)
du -sh .
```

### 5. Primeiro Uso

1. **Abra o Claude Code** na pasta do assistente
2. **Execute o comando inicial**:
   ```
   /assistentes:agents:organizador
   ```
3. **Faça um teste**:
   - Adicione algo em `despejo/daily-dump.md`
   - Use o comando `processar` (opção 1)
   - Veja a mágica acontecer! ✨

### 6. Limpeza

```bash
# Volte para o diretório pai e delete os arquivos temporários
cd ..
rm -rf temp-assistente-dev
```

---

## 🎯 Diferenças - Projeto Completo vs Deploy Limpo

| Aspecto | Projeto Completo | Deploy Limpo |
|---------|------------------|--------------|
| **Tamanho** | ~100MB | ~10MB |
| **Arquivos** | 500+ arquivos | ~50 arquivos |
| **Propósito** | Desenvolvimento | Uso final |
| **Inclui** | Tudo (testes, docs, etc.) | Apenas essenciais |
| **Complexidade** | Alta | Baixa |
| **Foco** | Desenvolvedores | Usuários finais |

---

## 🔧 Opções Avançadas

### Deploy em Local Específico

```bash
# Servidor/produção
./scripts/deploy-assistant.sh /opt/assistente-producao

# Múltiplos usuários
./scripts/deploy-assistant.sh /home/usuario1/assistente
./scripts/deploy-assistant.sh /home/usuario2/assistente

# Backup/teste
./scripts/deploy-assistant.sh ~/assistente-backup
```

### Ver Ajuda do Script

```bash
./scripts/deploy-assistant.sh --help
```

### Atualizar Instalação Existente

```bash
# O script pergunta se quer sobrescrever
./scripts/deploy-assistant.sh pasta-existente
# Digite 'y' para confirmar
```

---

## ❓ Problemas Comuns

**Script não executa:**
```bash
chmod +x scripts/deploy-assistant.sh
```

**Sem permissão para criar pasta:**
```bash
# Use uma pasta onde você tem permissão
./scripts/deploy-assistant.sh ~/assistente
```

**Deploy incompleto:**
```bash
# Execute novamente - é seguro
./scripts/deploy-assistant.sh mesma-pasta
```

---

## 🎉 Pronto para Usar!

Após o deploy, você terá:
- ✅ Assistente pessoal funcional
- ✅ Apenas arquivos necessários
- ✅ Estrutura limpa e organizada
- ✅ Pronto para backup simples

**Próximo passo:** Comece usando o assistente com `/assistentes:agents:organizador` no Claude Code!