# 🤖 Assistente Pessoal IA

[![npm version](https://img.shields.io/npm/v/assistente-pessoal-ia?style=flat-square)](https://www.npmjs.com/package/assistente-pessoal-ia)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
[![Node](https://img.shields.io/node/v/assistente-pessoal-ia?style=flat-square)](package.json)

**Seu segundo cérebro para TDAH**

Pare de perder pensamentos importantes. O Assistente Pessoal IA captura tudo que vem à sua mente e organiza automaticamente - sem esforço, sem fricção.

📚 **[Quick Start (5min)](QUICK-START.md)** | 📖 **[Manual Completo](docs/user-guide/USAGE.md)** | 🤝 **[Contribuir](CONTRIBUTING-AGENTS.md)**

---

## ✨ Por Que Usar?

Se você tem TDAH, sabe como é:

| 😰 Problema | ✅ Solução |
|------------|-----------|
| **Esqueço tudo** | Despejo diário sem fricção - escreva e o Organizador cuida do resto |
| **Projetos incompletos** | Secretária rastreia tudo e mostra "what's next" |
| **Decisões difíceis** | Arquiteto confronta suas ideias de forma construtiva |
| **Sobrecarga emocional** | Psicólogo oferece suporte especializado em TDAH |
| **Carreira travada** | Mentor ajuda com metas e networking |

---

## 🚀 Instalação em 2 Minutos

```bash
npx assistente-pessoal install
```

**Isso é tudo.** O instalador interativo vai:

1. ✅ Perguntar onde instalar
2. ✅ Deixar você escolher quais agentes quer
3. ✅ Configurar tudo automaticamente
4. ✅ Criar sua primeira captura

---

## 🤖 Escolha Seus Agentes

Durante a instalação, você seleciona quais agentes fazem sentido para você:

### 📋 Organizador (Sofia) - *Essencial*

Processa seu "despejo diário" e organiza automaticamente em:
- ✅ Tarefas (com prioridade)
- ✅ Projetos (com contexto)
- ✅ Anotações (categorizadas)
- ✅ Pessoas (networking)

**Perfeito para**: Todo mundo que esquece coisas

---

### 📊 Secretária - *Recomendado*

Sua assistente executiva que:
- 📅 Organiza reuniões e agenda
- 📈 Mostra status de projetos
- 🎯 Responde "what's next?"
- 📊 Dashboard executivo visual

**Perfeito para**: Profissionais, gestores, pessoas ocupadas

---

### 🏗️ Arquiteto (Marcus) - *Desenvolvedores*

Consultoria técnica com confronto construtivo:
- 🤔 Questiona suas decisões arquiteturais
- 💡 Oferece alternativas que você não pensou
- 📝 Documenta decisões técnicas
- 🔍 Detecta inconsistências

**Perfeito para**: Desenvolvedores, tech leads, arquitetos

---

### 🧠 Psicólogo (Dr. Helena) - *TDAH*

Suporte emocional especializado:
- 😌 Técnicas de TCC para TDAH
- 🌊 Gestão de sobrecarga emocional
- 🎯 Estratégias práticas
- 📔 Diário emocional estruturado

**Perfeito para**: Pessoas com TDAH, ansiedade, burnout

---

### 🎯 Mentor (Leonardo) - *Carreira*

Desenvolvimento profissional:
- 🚀 Definição de metas de carreira
- 🤝 Estratégias de networking
- 📈 Planos de crescimento
- 💼 Gestão de relacionamentos profissionais

**Perfeito para**: Crescimento de carreira, transições, estudantes

---

## 💡 Como Funciona?

### 1. Capture Sem Pensar

Abra `despejo/daily-dump.md` e escreva tudo que vem à mente:

```markdown
- Preciso marcar dentista
- Ideia: app de receitas com IA
- Lembrar de ligar para João
- Bug no backend que o cliente reportou
```

**Sem organização. Sem categorias. Só escreva.**

---

### 2. Deixe o Organizador Trabalhar

No Claude Code, digite:

```
/organizador
```

Em segundos, tudo é organizado automaticamente:

- ✅ "Marcar dentista" → `todos/pessoal.md`
- ✅ "App de receitas" → `knowledge-base/projetos/app-receitas.md`
- ✅ "Ligar para João" → `knowledge-base/pessoas/joao.md`
- ✅ "Bug backend" → `todos/trabalho.md`

---

### 3. Use Outros Agentes

```
/secretaria what's next
→ Mostra suas 3 próximas prioridades

/arquiteto analise projeto app-receitas
→ Questiona suas decisões técnicas

/psicologo
→ Suporte emocional e técnicas de TDAH

/mentor metas
→ Define metas de carreira
```

---

## 📦 Gerenciar Agentes

Depois da instalação, você pode adicionar ou remover agentes:

```bash
# Ver agentes instalados
npx assistente-pessoal list

# Ver todos disponíveis
npx assistente-pessoal available

# Adicionar agente
npx assistente-pessoal add arquiteto

# Remover agente
npx assistente-pessoal remove mentor

# Ver detalhes
npx assistente-pessoal info psicologo
```

---

## 🔒 100% Local e Privado

- ✅ **Seus dados nunca saem do seu computador**
- ✅ **Nenhuma conexão com servidores externos**
- ✅ **Você controla tudo (é só Markdown!)**
- ✅ **Backup automático com Git (opcional)**
- ✅ **Integração com Obsidian (opcional)**

---

## 📚 Documentação

- **[Guia de Uso Completo](docs/user-guide/USAGE.md)** - Como usar cada agente
- **[FAQ](docs/user-guide/FAQ.md)** - Perguntas frequentes
- **[Troubleshooting](docs/user-guide/TROUBLESHOOTING.md)** - Resolvendo problemas
- **[Backup e Recuperação](docs/user-guide/BACKUP.md)** - Proteção de dados

---

## 🤝 Comunidade

### Contribuir Agentes

A comunidade pode criar e compartilhar agentes! Veja:
- **[Como Contribuir Agentes](docs/CONTRIBUTING-AGENTS.md)**
- **[Agentes da Comunidade](src/agents/community/)**

### Reportar Problemas

Encontrou um bug? [Abra uma issue](https://github.com/yourusername/assistente-pessoal-ia/issues)

---

## 🎯 Para Desenvolvedores

Se você quer contribuir com código ou entender a arquitetura:

- **[Arquitetura](docs/architecture/)** - Design do sistema
- **[Stories](docs/stories/)** - Histórias de desenvolvimento
- **[Development Docs](docs/development/)** - Documentação técnica
- **[Instalação Dev](docs/development/INSTALL-DEV.md)** - Setup para desenvolvimento

---

## ⚡ Quick Start Absoluto

```bash
# 1. Instalar
npx assistente-pessoal install

# 2. Entrar na pasta instalada
cd ~/assistente-ia

# 3. Abrir no Claude Code
# (ou seu editor preferido)

# 4. Escrever em despejo/daily-dump.md
# Tudo que vier à mente

# 5. Processar
/organizador

# 6. Profit! 🎉
```

---

## 💬 Depoimentos

> *"Finalmente um sistema que funciona com meu TDAH, não contra ele."*
> — Usuário Beta

> *"Não preciso mais lembrar de organizar. Só despejo e funciona."*
> — Desenvolvedor Full-Stack

> *"O Organizador é literalmente meu segundo cérebro."*
> — Designer com TDAH

---

## 🏆 Features Únicas

- ✅ **Zero fricção** - Capture primeiro, organize depois (automaticamente)
- ✅ **Conversacional** - Agentes com personalidade, não comandos frios
- ✅ **Memória contextual** - Agentes lembram de conversas anteriores
- ✅ **Cross-agent intelligence** - Agentes colaboram entre si
- ✅ **Markdown puro** - Portável, versionável, durável
- ✅ **Obsidian ready** - Visualização rica opcional
- ✅ **Modular** - Escolha apenas o que precisa

---

## 📊 Requisitos

- **Node.js 14+** (para instalação)
- **Claude Code** (ou qualquer editor Markdown)
- **Git** (opcional, para backup)
- **Obsidian** (opcional, para visualização)

---

## 🚀 Comece Agora

```bash
npx assistente-pessoal install
```

**Tempo até o primeiro valor: < 5 minutos**

---

## 📜 Licença

MIT - Use como quiser, onde quiser

---

## 🙏 Créditos

Criado com ❤️ para pessoas com TDAH que querem produtividade sem fricção.

Baseado no framework [BMAD](https://github.com/bmad-method/bmad) para agentes conversacionais.

---

**Não é mais um sistema de produtividade. É o seu segundo cérebro.**

🤖 Instale agora: `npx assistente-pessoal install`
