# Assistente Pessoal IA

Sistema de assistente pessoal IA com 5 agentes especializados para pessoas com TDAH, oferecendo um "segundo cérebro" digital completamente local e privado.

## 🚀 Instalação e Configuração

### Requisitos do Sistema

- **Python 3.8+** (para funcionalidades avançadas)
- **Git** (para backup automático)
- **Obsidian** (recomendado para visualização da knowledge base)
- **Claude Code** (interface principal)

### Instalação Rápida

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

3. **Valide a instalação:**
   ```bash
   bash test-basic.sh
   ```

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

**Arquivo**: `despejo/daily-dump.txt`

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

- **`/organizador despejo/daily-dump.txt`** - Organiza e categoriza automaticamente
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
/organizador despejo/daily-dump.txt
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
│   ├── daily-dump.txt             # Arquivo principal de captura
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
└── 📁 scripts/                    # Scripts de automação
```

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
