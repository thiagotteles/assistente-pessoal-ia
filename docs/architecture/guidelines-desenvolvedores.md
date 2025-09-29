# Guidelines para Desenvolvedores - Assistente Pessoal IA

## Mudanças Importantes na Estrutura do Projeto

Este documento descreve as mudanças recentes na organização do projeto e diretrizes para futuros desenvolvedores.

## 🏗️ Mudanças na Estrutura

### 1. Reorganização dos Testes

**ANTES:**
```
projeto/
├── test-story-1.2.sh
├── test-story-1.3.sh
├── test-basic.sh
├── test-agents.py
├── test-results.txt
└── ... (outros arquivos espalhados)
```

**DEPOIS:**
```
projeto/
└── tests/
    ├── test-story-1.2.sh
    ├── test-story-1.3.sh
    ├── test-basic.sh
    ├── test-agents.py
    ├── test-results.txt
    └── ... (todos os testes organizados)
```

**⚠️ IMPORTANTE:** Todos os scripts de teste agora devem estar na pasta `tests/`. Atualize seus comandos:

```bash
# ANTES
./test-basic.sh

# DEPOIS
./tests/test-basic.sh
```

### 2. Novo Sistema de Deploy Limpo

Foi criado o script `scripts/deploy-assistant.sh` que instala apenas os arquivos essenciais para usuários finais.

**Arquivos Essenciais (sempre incluir no deploy):**
- `.claude/` - Configurações do Claude Code
- `.assistant-core/` - Core dos agentes
- `knowledge-base/` - Base de conhecimento
- `todos/`, `despejo/`, `diario/` - Dados do usuário
- Scripts específicos para usuário final

**Arquivos de Desenvolvimento (excluir do deploy):**
- `tests/` - Todos os testes
- `.bmad-core/` - Configurações de desenvolvimento
- `docs/` - Documentação técnica
- `logs/`, `cache/`, `performance/` - Arquivos temporários
- Scripts de desenvolvimento

## 📋 Diretrizes para Novos Desenvolvedores

### 1. Adicionando Novos Arquivos

**Para arquivos de TESTE:**
```bash
# SEMPRE criar na pasta tests/
touch tests/test-nova-funcionalidade.sh
chmod +x tests/test-nova-funcionalidade.sh
```

**Para arquivos de USUÁRIO FINAL:**
- Se for essencial para o assistente funcionar → adicionar ao script de deploy
- Se for apenas para desenvolvimento → não adicionar

**Para DOCUMENTAÇÃO:**
- Documentação técnica → `docs/`
- Documentação para usuário final → considerar incluir no deploy ou criar versão simplificada

### 2. Modificando o Script de Deploy

Se você adicionar novos componentes essenciais, SEMPRE atualize o script `deploy-assistant.sh`:

```bash
# Exemplo: Adicionando nova pasta essencial
if [ -d "$SOURCE_DIR/nova-pasta-essencial" ]; then
    log "Copiando nova pasta essencial..."
    cp -r "$SOURCE_DIR/nova-pasta-essencial" "$DEST_DIR/"
    success "✓ Nova pasta essencial copiada"
fi
```

E adicione na lista de verificação:
```bash
ESSENTIAL_DIRS=(".claude" ".assistant-core" "knowledge-base" "todos" "despejo" "nova-pasta-essencial")
```

### 3. Executando Testes

**Testes individuais:**
```bash
./tests/test-basic.sh
./tests/test-story-1.2.sh
```

**Todos os testes:**
```bash
# Executar todos os testes .sh
for test in tests/test-*.sh; do
    echo "Executando $test..."
    ./"$test"
done
```

### 4. Testando o Deploy

**CRÍTICO**: SEMPRE teste o script de deploy antes de fazer commit de mudanças estruturais.

**Teste Básico:**
```bash
# 1. Teste em pasta temporária
./scripts/deploy-assistant.sh /tmp/test-deploy-$(date +%H%M%S)

# 2. Verifique estrutura essencial
TEST_DIR="/tmp/test-deploy-$(date +%H%M%S)"
ls -la "$TEST_DIR"

# 3. Validação automática
cd "$TEST_DIR"
test -d .claude && echo "✓ Claude OK" || echo "✗ Claude MISSING"
test -d .assistant-core && echo "✓ Core OK" || echo "✗ Core MISSING"
test -d knowledge-base && echo "✓ KB OK" || echo "✗ KB MISSING"
test -d todos && echo "✓ Todos OK" || echo "✗ Todos MISSING"
test -d despejo && echo "✓ Despejo OK" || echo "✗ Despejo MISSING"

# 4. Teste funcional (manual)
# Abra Claude Code nesta pasta
# Execute: /assistentes:agents:organizador
# Deve carregar sem erros

# 5. Limpeza
cd .. && rm -rf "$TEST_DIR"
```

**Teste Completo (antes de release):**
```bash
# Script de teste completo
cat > test-deploy-complete.sh << 'EOF'
#!/bin/bash
set -e

TEMP_DIR="/tmp/deploy-test-$(date +%Y%m%d-%H%M%S)"
echo "Testando deploy em: $TEMP_DIR"

# 1. Deploy
./scripts/deploy-assistant.sh "$TEMP_DIR"

# 2. Verificar tamanho
echo "Tamanho da instalação limpa:"
du -sh "$TEMP_DIR"
echo "Tamanho do projeto completo:"
du -sh . --exclude=".git"

# 3. Verificar arquivos essenciais
cd "$TEMP_DIR"
echo "Verificando estrutura..."
for dir in .claude .assistant-core knowledge-base todos despejo; do
    if [ -d "$dir" ]; then
        echo "✓ $dir"
    else
        echo "✗ $dir MISSING!"
        exit 1
    fi
done

# 4. Verificar arquivos desnecessários (devem estar AUSENTES)
for item in tests docs .bmad-core logs performance; do
    if [ -e "$item" ]; then
        echo "✗ $item shouldn't be here!"
        exit 1
    else
        echo "✓ $item correctly excluded"
    fi
done

echo "✅ Deploy test passed!"
cd - && rm -rf "$TEMP_DIR"
EOF

chmod +x test-deploy-complete.sh
./test-deploy-complete.sh
```

**Teste de Diferentes Cenários:**
```bash
# Teste overwrite
./scripts/deploy-assistant.sh /tmp/test-overwrite
echo "y" | ./scripts/deploy-assistant.sh /tmp/test-overwrite

# Teste help
./scripts/deploy-assistant.sh --help

# Teste path com espaços
./scripts/deploy-assistant.sh "/tmp/test with spaces"
```

### 5. Atualizando Documentação

Quando fizer mudanças que afetam usuários finais:

1. **Atualize o README.md principal** com mudanças visíveis
2. **Atualize guia-instalacao-limpa.md** se mudou estrutura de deploy
3. **Atualize este arquivo** se mudou diretrizes de desenvolvimento

## 🔧 Comandos Úteis para Desenvolvimento

### Reorganizar Testes (se necessário)
```bash
# Mover novos arquivos de teste para pasta correta
find . -maxdepth 1 -name "test-*" -type f -exec mv {} tests/ \;
```

### Verificar Integridade do Deploy
```bash
# Script para verificar se deploy está funcionando
./scripts/deploy-assistant.sh /tmp/verify-deploy
cd /tmp/verify-deploy

# Verificar estrutura essencial
test -d .claude && echo "✓ Claude config OK" || echo "✗ Claude config MISSING"
test -d .assistant-core && echo "✓ Assistant core OK" || echo "✗ Assistant core MISSING"
test -d knowledge-base && echo "✓ Knowledge base OK" || echo "✗ Knowledge base MISSING"

cd - && rm -rf /tmp/verify-deploy
```

### Backup Antes de Mudanças Grandes
```bash
# Sempre faça backup antes de reorganizações
cp -r . ../backup-$(date +%Y%m%d-%H%M%S)
```

## 🚨 Checklist antes de Commit

### Organização e Testes
- [ ] Todos os novos testes estão em `tests/`
- [ ] Scripts de teste funcionam nas novas localizações (`./tests/test-*.sh`)
- [ ] Executei pelo menos `./tests/test-basic.sh` com sucesso

### Deploy e Estrutura
- [ ] **Script de deploy foi atualizado** se adicionei novos componentes essenciais
- [ ] **Testei o deploy em pasta limpa** com `./scripts/deploy-assistant.sh /tmp/test`
- [ ] **Validei que arquivos desnecessários não são copiados** (tests/, docs/, logs/, etc.)
- [ ] **Tamanho da instalação limpa** ainda é ~90% menor que o projeto completo

### Documentação
- [ ] **README.md atualizado** se mudanças afetam usuários finais
- [ ] **guia-instalacao-limpa.md atualizado** se mudei estrutura de deploy
- [ ] **guidelines-desenvolvedores.md atualizado** se mudei processo de desenvolvimento

### Validação Final
- [ ] **Deploy funciona nos 3 sistemas**: Linux, macOS, Windows (Git Bash)
- [ ] **Assistente carrega sem erros** na instalação limpa
- [ ] **Comando básico funciona**: `/assistentes:agents:organizador`

## 📝 Padrões de Nomenclatura

### Arquivos de Teste
```bash
test-{funcionalidade}.sh       # Testes de funcionalidade
test-story-{numero}.sh         # Testes de story específica
test-integration-{nome}.sh     # Testes de integração
test-{nome}.py                 # Testes em Python
```

### Scripts de Utilidade
```bash
deploy-{tipo}.sh              # Scripts de deploy
backup-{componente}.sh        # Scripts de backup
validate-{componente}.sh      # Scripts de validação
```

## 🔄 Workflow de Desenvolvimento Recomendado

1. **Desenvolver nova funcionalidade**
   ```bash
   # Criar branch
   git checkout -b feature/nova-funcionalidade

   # Desenvolver...
   # Criar testes em tests/
   ./tests/test-nova-funcionalidade.sh
   ```

2. **Testar integração**
   ```bash
   # Executar todos os testes
   for test in tests/test-*.sh; do ./"$test"; done

   # Testar deploy limpo
   ./scripts/deploy-assistant.sh /tmp/test-nova-feature
   ```

3. **Atualizar documentação**
   ```bash
   # Atualizar docs relevantes
   # Atualizar este arquivo se necessário
   ```

4. **Commit e PR**
   ```bash
   git add .
   git commit -m "feat: nova funcionalidade com testes e docs"
   git push origin feature/nova-funcionalidade
   ```

## 🎯 Objetivos Futuros

Para manter o projeto organizado e focado:

1. **Separação clara** entre desenvolvimento e produção
2. **Deploy automatizado** e confiável
3. **Testes organizados** e executáveis
4. **Documentação atualizada** e acessível
5. **Experiência do usuário** simplificada

---

## ❓ Dúvidas?

Para dúvidas sobre estas diretrizes ou sugestões de melhorias, abra uma issue ou discuta no PR.

**Lembre-se:** O objetivo é manter o projeto organizado enquanto oferece uma experiência limpa para usuários finais!