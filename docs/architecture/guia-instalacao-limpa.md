# Guia de Instalação Limpa - Assistente Pessoal IA

## Visão Geral

Este documento descreve o novo sistema de instalação limpa do Assistente Pessoal IA, que permite deployar apenas os arquivos essenciais para o funcionamento do assistente, sem arquivos de desenvolvimento, testes ou documentação desnecessária.

## Motivação

O projeto completo contém muitos arquivos que são úteis apenas durante o desenvolvimento:
- Arquivos de teste (`test-*.sh`, `test-*.py`)
- Documentação técnica extensa (`docs/`)
- Logs de desenvolvimento (`logs/`)
- Scripts de desenvolvimento (`scripts/` completa)
- Arquivos de backup (`backups/`)
- Performance benchmarks (`performance/`)

Para usuários finais que só querem usar o assistente, esses arquivos são desnecessários e podem causar confusão.

## Arquivos Essenciais vs Desnecessários

### ✅ ESSENCIAIS (Incluídos no Deploy)

**Configurações Core:**
- `.claude/` - Configurações do Claude Code (agents, settings)
- `.assistant-core/` - Core dos agentes, memória, templates
- `.gitignore` - Configuração básica de git

**Dados do Usuário:**
- `knowledge-base/` - Base de conhecimento pessoal
- `todos/` - Sistema de gerenciamento de tarefas
- `despejo/` - Sistema de daily dump
- `diario/` - Diário pessoal

**Scripts Essenciais:**
- `scripts/deploy-assistant.sh` - Para futuras instalações
- `scripts/backup-knowledge-base.sh` - Para backup dos dados

**Documentação Mínima:**
- `README.md` - Personalizado para a instalação limpa

### ❌ DESNECESSÁRIOS (Excluídos do Deploy)

**Desenvolvimento:**
- `.bmad-core/` - Configurações específicas do framework BMAD
- `tests/` - Todos os arquivos de teste
- `docs/` - Documentação técnica completa
- `scripts/` (maioria) - Scripts de desenvolvimento

**Arquivos Temporários:**
- `backups/` - Backups históricos
- `cache/` - Cache de desenvolvimento
- `logs/` - Logs históricos
- `temp/` - Arquivos temporários
- `performance/` - Benchmarks

**Arquivos de Setup:**
- `setup.sh` / `setup.bat` - Scripts de setup do desenvolvimento
- `BACKUP.md`, `FAQ.md`, `TROUBLESHOOTING.md`, `USAGE.md` - Documentação técnica
- `CHANGELOG.md` - História de mudanças

## Como Fazer o Deploy - Passo a Passo

### Método Recomendado (Usuário Final)

**1. Preparação**
```bash
# Clone o projeto completo temporariamente
git clone <url-do-repositorio> temp-assistente-dev
cd temp-assistente-dev
```

**2. Execute o Deploy**
```bash
# Escolha sua pasta de destino e execute:
./scripts/deploy-assistant.sh ~/meu-assistente

# Outros exemplos:
./scripts/deploy-assistant.sh /home/user/assistente
./scripts/deploy-assistant.sh /opt/assistente-ia
./scripts/deploy-assistant.sh /c/Users/Usuario/assistente  # Windows
```

**3. Acesse e Teste**
```bash
cd ~/meu-assistente
ls -la  # Veja a estrutura limpa
```

**4. Limpeza**
```bash
cd .. && rm -rf temp-assistente-dev
```

### Sintaxe Básica do Script

```bash
./scripts/deploy-assistant.sh <diretorio_destino>
```

**Parâmetros:**
- `<diretorio_destino>`: Caminho onde instalar o assistente
- `--help` ou `-h`: Exibe ajuda

### Exemplos Detalhados por Sistema

**Linux:**
```bash
./scripts/deploy-assistant.sh ~/assistente-ia
./scripts/deploy-assistant.sh /home/$USER/meu-assistente
./scripts/deploy-assistant.sh /opt/assistente-empresarial
```

**macOS:**
```bash
./scripts/deploy-assistant.sh ~/assistente-ia
./scripts/deploy-assistant.sh /Users/$USER/Documents/assistente
```

**Windows (Git Bash/WSL):**
```bash
./scripts/deploy-assistant.sh /c/Users/$USER/assistente-ia
./scripts/deploy-assistant.sh /c/assistente
./scripts/deploy-assistant.sh /mnt/c/Users/Usuario/assistente  # WSL
```

### O que o Script Faz

1. **Verifica o diretório de destino** - Cria se não existir, pergunta sobre sobrescrever se existir
2. **Copia arquivos essenciais** - Apenas o que é necessário para o assistente funcionar
3. **Cria estrutura básica** - Se algum componente não existir, cria estrutura mínima
4. **Gera documentação personalizada** - README específico para a instalação limpa
5. **Configura permissões** - Garante que tudo está configurado corretamente
6. **Valida instalação** - Verifica se todos os componentes essenciais estão presentes

### Estrutura da Instalação Limpa

```
assistente-limpo/
├── .claude/                    # Configurações do Claude Code
├── .assistant-core/            # Core dos agentes
├── knowledge-base/             # Base de conhecimento
│   ├── contextos/
│   ├── pessoas/
│   ├── projetos/
│   └── decisoes/
├── todos/                      # Sistema de tarefas
├── despejo/                    # Daily dump
├── diario/                     # Diário pessoal
├── scripts/                    # Scripts essenciais
│   ├── deploy-assistant.sh
│   └── backup-knowledge-base.sh
├── cache/                      # Cache (vazio inicialmente)
├── logs/                       # Logs (vazio inicialmente)
├── README.md                   # Documentação personalizada
└── .gitignore                  # Configuração git
```

## Benefícios

### Para Usuários Finais
- **Simplicidade**: Apenas os arquivos necessários
- **Menor tamanho**: ~90% menor que o projeto completo
- **Menos confusão**: Não há arquivos de desenvolvimento para confundir
- **Fácil backup**: Apenas dados importantes para fazer backup

### Para Desenvolvedores
- **Deploy rápido**: Script automatizado para instalações
- **Separação clara**: Desenvolvimento vs produção bem definidos
- **Manutenção**: Mais fácil manter o que é essencial

## Migração de Instalações Existentes

Se você já tem uma instalação completa e quer migrar para uma instalação limpa:

```bash
# 1. Faça backup dos seus dados importantes
cp -r knowledge-base/ backup-kb/
cp -r todos/ backup-todos/
cp -r despejo/ backup-despejo/

# 2. Use o script de deploy em uma nova pasta
./scripts/deploy-assistant.sh ../assistente-limpo

# 3. Copie seus dados para a nova instalação
cp -r backup-kb/* ../assistente-limpo/knowledge-base/
cp -r backup-todos/* ../assistente-limpo/todos/
cp -r backup-despejo/* ../assistente-limpo/despejo/
```

## Manutenção e Updates

Para atualizar uma instalação limpa:

1. **Mantenha seus dados**: Faça backup das pastas de dados do usuário
2. **Baixe a versão mais recente** do projeto de desenvolvimento
3. **Execute novo deploy**: Use o script de deploy na mesma pasta (ele pergunta sobre sobrescrever)
4. **Restaure dados personalizados** se necessário

## Troubleshooting do Deploy

### Problemas Comuns e Soluções

**1. Script não executa**
```bash
# Tornar o script executável
chmod +x scripts/deploy-assistant.sh

# Verificar se está na pasta correta
ls scripts/deploy-assistant.sh
```

**2. Permissões negadas**
```bash
# Para instalar em /opt ou /var
sudo ./scripts/deploy-assistant.sh /opt/assistente

# Ou escolha uma pasta onde você tem permissão
./scripts/deploy-assistant.sh ~/assistente
```

**3. Diretório de destino já existe**
- O script pergunta se quer sobrescrever
- Digite `y` para confirmar ou `n` para cancelar
- Use uma pasta diferente se não quiser sobrescrever

**4. Verificar se deploy foi bem-sucedido**
```bash
cd pasta-destino

# Verificar estrutura essencial
ls -la
# Deve ter: .claude, .assistant-core, knowledge-base, todos, despejo

# Verificar se Claude Code funciona
# Abra Claude Code na pasta e teste comandos
```

**5. Erro "arquivo não encontrado" durante deploy**
```bash
# Certifique-se de estar na pasta raiz do projeto de desenvolvimento
pwd  # deve mostrar path/.../assistente-pessoal-ia
ls .claude  # deve existir
```

**6. Deploy incompleto**
```bash
# Execute novamente - o script é idempotente
./scripts/deploy-assistant.sh mesma-pasta-destino

# Ou delete a pasta e recomece
rm -rf pasta-destino
./scripts/deploy-assistant.sh pasta-destino
```

### Validação Pós-Deploy

**Checklist essencial:**
```bash
cd pasta-assistente-deployado

# 1. Verificar arquivos obrigatórios
test -d .claude && echo "✓ Claude config OK" || echo "✗ FALTANDO"
test -d .assistant-core && echo "✓ Assistant core OK" || echo "✗ FALTANDO"
test -d knowledge-base && echo "✓ Knowledge base OK" || echo "✗ FALTANDO"
test -d todos && echo "✓ Todos OK" || echo "✗ FALTANDO"
test -d despejo && echo "✓ Despejo OK" || echo "✗ FALTANDO"

# 2. Testar funcionalidade básica
# Abra Claude Code nesta pasta
# Execute: /assistentes:agents:organizador
# Deve funcionar sem erros
```

### Cenários Especiais

**Deploy em Servidor/Produção:**
```bash
# 1. Clone em pasta temporária
git clone <repo> /tmp/assistente-dev
cd /tmp/assistente-dev

# 2. Deploy para pasta de produção
./scripts/deploy-assistant.sh /opt/assistente-producao

# 3. Configurar permissões
sudo chown -R usuario:grupo /opt/assistente-producao

# 4. Limpeza
rm -rf /tmp/assistente-dev
```

**Deploy Multi-Usuário:**
```bash
# Cada usuário tem sua própria instalação
./scripts/deploy-assistant.sh /home/usuario1/assistente
./scripts/deploy-assistant.sh /home/usuario2/assistente
```

**Update de Instalação Existente:**
```bash
# 1. Backup dos dados importantes
cp -r pasta-assistente/knowledge-base backup-kb-$(date +%Y%m%d)
cp -r pasta-assistente/todos backup-todos-$(date +%Y%m%d)

# 2. Execute deploy na mesma pasta (confirme sobrescrever)
./scripts/deploy-assistant.sh pasta-assistente

# 3. Dados pessoais são preservados automaticamente
```

---

## Próximos Passos para Desenvolvedores

Ao trabalhar com este sistema:

1. **Sempre teste o script de deploy** antes de release
2. **Mantenha a lista de arquivos essenciais atualizada** no script
3. **Documente mudanças na estrutura** que afetem a instalação limpa
4. **Considere impacto em usuários finais** ao adicionar novos componentes

Este sistema garante que usuários finais tenham uma experiência limpa e focada, enquanto desenvolvedores mantêm todas as ferramentas necessárias para desenvolvimento.