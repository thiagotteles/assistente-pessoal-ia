# 🤖 Sistema de Assistente Pessoal com IA

Sistema de assistente pessoal IA com 5 agentes especializados para pessoas com TDAH, oferecendo um "segundo cérebro" digital completamente local e privado.

## 🚨 IMPORTANTE - LEIA PRIMEIRO

**🔥 Se você é um desenvolvedor novo no projeto: [LEIA ESTE ARQUIVO PRIMEIRO](docs/IMPORTANTE-LEIA-PRIMEIRO.md)**

Este arquivo contém avisos críticos sobre o que NÃO deve ser usado e diretrizes oficiais.

## 📋 Status das Stories - Roadmap de Desenvolvimento

| Epic | Story | Nome | Descrição | Status |
|------|-------|------|-----------|--------|
| **Épico 0** | 0.5 | Documentação Operacional Completa | Sistema abrangente de documentação para usuários finais | ✅ Concluído |
| **Épico 1** | 1.1 | Estrutura de Arquivos Base | Estrutura simples e intuitiva para usuários com TDAH | ✅ Concluído |
| **Épico 1** | 1.2 | Sistema de Captura Ultra-Rápida | Arquivo daily-dump.md sem estrutura obrigatória | ✅ Concluído |
| **Épico 1** | 1.3 | Comando Slash Base | 5 comandos funcionais com roteamento inteligente | ✅ Concluído |
| **Épico 1** | 1.4 | Knowledge-Base Compartilhada Básica | Sistema de [[referências]] Obsidian com auto-linking | ✅ Concluído |
| **Épico 2** | 2.1 | Agente Organizador Completo | Processamento de despejo via perguntas específicas | ✅ Concluído |
| **Épico 2** | 2.2 | Agente Secretária Executiva Completa | Gestão de agenda e processamento de reuniões | 📝 Not Created |
| **Épico 2** | 2.3 | Agente Arquiteto Confrontador Completo | Consultoria técnica com confronto construtivo | 📝 Not Created |
| **Épico 2** | 2.4 | Agente Psicólogo Supportivo | Suporte emocional especializado para TDAH | 📝 Not Created |
| **Épico 2** | 2.5 | Agente Mentor de Carreira | Desenvolvimento profissional de longo prazo | 📝 Not Created |
| **Épico 3** | 3.1 | Sistema de Cross-Agent Intelligence | Colaboração automática entre agentes | 📝 Not Created |
| **Épico 3** | 3.2 | Advanced Knowledge-Base Features | Busca semântica e timeline automático | 📝 Not Created |
| **Épico 3** | 3.3 | Obsidian Integration Completa | Graph view otimizado e templates customizados | 📝 Not Created |
| **Épico 3** | 3.4 | Sistema de Backup e Recovery Robusto | Git commits automáticos e cloud backup opcional | 📝 Not Created |
| **Épico 4** | 4.1 | Testes Essenciais Apenas | Framework de testes básicos focado em funcionalidade | 📝 Not Created |

### Legenda de Status
- ✅ **Concluído**: Story implementada e funcional
- ✅ **Approved**: Story validada e pronta para implementação
- 📝 **Not Created**: Story ainda não foi criada/documentada
- 🚧 **In Progress**: Story em desenvolvimento
- ⏸️ **Paused**: Story pausada temporariamente
- ❌ **Blocked**: Story bloqueada por dependência

## 🚀 Instalação e Configuração

> **⚡ QUER INSTALAR RÁPIDO?** → [**Deploy Quick Start Guide**](docs/DEPLOY-QUICKSTART.md) - Instalação em 2 minutos!

### Requisitos do Sistema

- **Python 3.8+** (para funcionalidades avançadas)
- **Git** (para backup automático)
- **Obsidian** (recomendado para visualização da knowledge base)
- **Claude Code** (interface principal)

### Instalação Rápida

**Para Desenvolvimento Completo:**

1. **Clone ou baixe o projeto:**
   ```bash
   git clone <repositorio> assistente-pessoal-ia
   cd assistente-pessoal-ia
   ```

2. **Execute o setup automático:**

   **Linux/macOS:**
   ```bash
   bash setup.sh
   ```

   **Windows:**
   ```cmd
   setup.bat
   ```

**Para Uso Final (Instalação Limpa) - RECOMENDADO:**

1. **Clone o projeto completo** temporariamente:
   ```bash
   git clone <repositorio> temp-assistente
   cd temp-assistente
   ```

2. **Execute o deploy para sua pasta final**:
   ```bash
   # Para Linux/macOS
   ./scripts/deploy-assistant.sh ~/assistente-ia

   # Para Windows (Git Bash/WSL)
   ./scripts/deploy-assistant.sh /c/Users/SeuUsuario/assistente-ia
   ```

3. **Acesse sua instalação limpa**:
   ```bash
   cd ~/assistente-ia  # ou sua pasta escolhida
   ```

4. **Limpe o projeto temporário**:
   ```bash
   cd .. && rm -rf temp-assistente
   ```

**Vantagens da Instalação Limpa:**
- ✅ **90% menor** - Apenas arquivos essenciais
- ✅ **Mais simples** - Sem arquivos de desenvolvimento
- ✅ **Focada no uso** - Experiência otimizada para usuário final
- ✅ **Fácil manutenção** - Backup e organização simplificados

### Validação da Instalação

**Para Desenvolvimento:**
```bash
bash tests/test-basic.sh
```

**Para Instalação Limpa:**
1. **Abra o Claude Code** na pasta do assistente
2. **Execute o comando inicial**:
   ```
   /assistentes:agents:organizador
   ```
3. **Teste a captura rápida** - adicione algo em `despejo/daily-dump.md`
4. **Use o comando processar** para ver o assistente em ação

4. **Configure o Obsidian (recomendado):**
   - Abra o Obsidian
   - Clique em "Open folder as vault"
   - Selecione a pasta `knowledge-base/`
   - Aceite as configurações automáticas

### Configuração do Git (Backup)

```bash
# Configure seu nome e email
git config user.name "Seu Nome"
git config user.email "seu.email@exemplo.com"

# Opcional: Configure repositório remoto privado
git remote add origin <seu-repositorio-privado>
git push -u origin main
```

## 📖 Guia de Uso Rápido

### 1. Captura Ultra-Rápida

**Arquivo**: `despejo/daily-dump.md`

Simplesmente abra este arquivo e despeje **tudo** que está na sua mente:
- Ideias aleatórias
- Tarefas que lembrou
- Informações importantes
- Qualquer coisa que precise capturar rapidamente

**Exemplo:**
```
reunião com João amanhã 14h
implementar feature X no projeto Y
comprar leite
ideia: app para organizar fotos
etc...
```

### 2. Processamento com Agentes

Use o Claude Code para processar suas informações:

- **`/assistentes:agents:organizador *processar`** - Organiza e categoriza automaticamente
- **`/secretaria`** - Para status de projetos e gestão executiva
- **`/arquiteto "como implementar X?"`** - Para decisões técnicas
- **`/psicologo`** - Para suporte emocional e estratégias TDAH
- **`/mentor`** - Para desenvolvimento de carreira

### 3. Knowledge Base no Obsidian

Abra a pasta `knowledge-base/` no Obsidian para:
- Visualizar conexões entre informações
- Usar backlinks automáticos
- Criar mapas mentais visuais
- Navegar por referências [[como esta]]

## 🤖 Os 5 Agentes Especializados

### `/organizador` - Seu Organizador Pessoal
**Função**: Processa despejo diário e organiza informações automaticamente

**Use quando**:
- Precisar organizar informações caóticas
- Quiser categorizar tarefas e ideias
- Precisar de estrutura em dados desorganizados

**Exemplo**:
```
/organizador despejo/daily-dump.md
```

### `/secretaria` - Sua Assistente Executiva
**Função**: Gestão executiva, agenda, status de projetos, coordenação

**Use quando**:
- Precisar de status de projetos
- Quiser agendar ou organizar reuniões
- Precisar de coordenação entre tarefas

**Exemplo**:
```
/secretaria "status do projeto X e próximos passos"
```

### `/arquiteto` - Arquiteto de Soluções
**Função**: Consultoria técnica com confronto construtivo e soluções práticas

**Use quando**:
- Precisar tomar decisões técnicas
- Quiser arquitetura de sistemas ou processos
- Precisar de confronto construtivo em ideias

**Exemplo**:
```
/arquiteto "como estruturar banco de dados para app Y?"
```

### `/psicologo` - Psicólogo de Suporte TDAH
**Função**: Suporte emocional especializado em TDAH, estratégias de foco

**Use quando**:
- Se sentir sobrecarregado ou ansioso
- Precisar de estratégias para foco e organização
- Quiser suporte emocional especializado

**Exemplo**:
```
/psicologo "estou me sentindo sobrecarregado com muitas tarefas"
```

### `/mentor` - Mentor de Carreira
**Função**: Desenvolvimento de carreira e orientação estratégica de longo prazo

**Use quando**:
- Precisar de direcionamento de carreira
- Quiser planejamento estratégico pessoal
- Precisar de coaching para objetivos de longo prazo

**Exemplo**:
```
/mentor "como posso evoluir minha carreira em tecnologia?"
```

## 📁 Estrutura do Projeto

```
assistente-pessoal-ia/
├── 📁 despejo/                    # Captura ultra-rápida
│   ├── daily-dump.md             # Arquivo principal de captura
│   └── processed/                 # Arquivos já processados
├── 📁 knowledge-base/             # "Segundo cérebro" (Obsidian Vault)
│   ├── decisoes/                  # Decisões importantes
│   ├── contextos/                 # Contextos de projetos
│   ├── projetos/                  # Informações de projetos
│   ├── pessoas/                   # Perfis e relacionamentos
│   └── .obsidian/                 # Configurações do Obsidian
├── 📁 todos/                      # Central de tarefas
│   ├── por-projeto/               # Tarefas organizadas por projeto
│   └── por-pessoa/                # Tarefas organizadas por pessoa
├── 📁 diario/                     # Reflexões estruturadas
│   └── templates/                 # Templates para entradas
├── 📁 .assistant-core/            # Configurações dos agentes
│   ├── agents/                    # Configurações YAML dos agentes
│   ├── memory/                    # Memória persistente dos agentes
│   ├── logs/                      # Logs do sistema (opcional)
│   └── data/                      # Dados internos
├── 📁 scripts/                    # Scripts de automação
└── 📁 tests/                      # Todos os testes organizados
    ├── test-basic.sh              # Teste básico do sistema
    ├── test-story-*.sh            # Testes de funcionalidades específicas
    └── test-agents.py             # Testes dos agentes
```

### 🔄 Mudanças Recentes na Estrutura

**Organização de Testes**: Todos os arquivos de teste foram movidos para `tests/`
**Deploy Limpo**: Novo script `scripts/deploy-assistant.sh` para instalações apenas com arquivos essenciais
**Documentação**: Guias específicos para desenvolvedores em `docs/architecture/guidelines-desenvolvedores.md`

## ✨ Características Principais

- ✅ **100% Local** - Todos os dados ficam no seu computador
- ✅ **Privacidade Total** - Nenhum dado é enviado para nuvem
- ✅ **Claude Code Integration** - Interface familiar e poderosa
- ✅ **Obsidian Integration** - Visualização em grafo e backlinks
- ✅ **Git Backup** - Versionamento automático de todos os dados
- ✅ **TDAH-Optimized** - Captura sem fricção, processamento inteligente
- ✅ **5 Agentes Especializados** - Cada um com personalidade e função específica
- ✅ **Memória Persistente** - Agentes lembram de interações anteriores
- ✅ **Cross-Platform** - Funciona em Windows, macOS e Linux

## 🔧 Testes e Validação

Execute regularmente para garantir que tudo está funcionando:

```bash
# Teste completo do sistema
bash test-basic.sh

# Teste específico dos agentes
python3 test-agents.py

# Se houver problemas, execute recuperação automática
bash test-recovery.sh
```

## 📚 Documentação Adicional

- **[Manual de Uso Detalhado](USAGE.md)** - Guia completo para cada agente
- **[Resolução de Problemas](TROUBLESHOOTING.md)** - Soluções para problemas comuns
- **[Backup e Recovery](BACKUP.md)** - Proteção completa dos seus dados
- **[Perguntas Frequentes](FAQ.md)** - Respostas para dúvidas comuns
- **[Framework de Testes](docs/framework-de-testes.md)** - Documentação técnica dos testes

## 🆘 Precisa de Ajuda?

1. **Problemas básicos**: Consulte [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. **Dúvidas de uso**: Consulte [FAQ.md](FAQ.md)
3. **Problemas técnicos**: Execute `bash test-recovery.sh`
4. **Backup de emergência**: Consulte [BACKUP.md](BACKUP.md)

## 🎯 Filosofia do Projeto

Este sistema foi criado especificamente para pessoas com TDAH, seguindo os princípios:

- **Captura sem fricção** - Anote primeiro, organize depois
- **Processamento inteligente** - Deixe os agentes organizarem por você
- **Visualização clara** - Use o Obsidian para ver conexões
- **Backup automático** - Nunca perca informações importantes
- **Privacidade total** - Seus dados são seus

---

🤖 **Sistema funcionando!** Execute `bash test-basic.sh` para validar sua instalação.
