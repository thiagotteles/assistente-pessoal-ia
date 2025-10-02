# UX Brief: Transformação User-First do Assistente Pessoal IA

**Para**: UX Expert
**De**: Winston (Architect)
**Data**: 02/10/2025
**Objetivo**: Definir experiência de usuário para instalação NPM e documentação

---

## 🎯 Contexto

Estamos transformando o **Assistente Pessoal IA** de projeto de desenvolvimento em **produto end-user**.

### Problema Atual
- Instalação complexa (`git clone` + setup manual)
- README focado em desenvolvedores
- Documentação técnica e fragmentada
- Estrutura de arquivos expõe detalhes de implementação

### Solução Técnica (Já Definida)
- NPM package com instalador interativo (`npx assistente-pessoal-ia install`)
- README user-first focado em benefícios
- Documentação progressiva (básico → avançado)
- Arquivos técnicos ocultos do usuário

### Seu Papel
Definir **como o usuário interage** com o sistema em cada ponto de contato:
1. Descoberta inicial (README, marketing)
2. Instalação (prompts, mensagens, fluxo)
3. Primeiro uso (onboarding, tutoriais)
4. Uso diário (comandos, feedback, erros)
5. Manutenção (updates, troubleshooting)

---

## 👥 Persona Principal

**Nome**: Marina, 34 anos
**Profissão**: Desenvolvedora Full-Stack
**Condição**: TDAH diagnosticado

**Características**:
- 🧠 **Cognitivo**: Processamento rápido, memória de curto prazo limitada
- 💻 **Técnico**: Confortável com terminal, mas prefere simplicidade
- ⏱️ **Tempo**: Impaciente, quer valor imediato (< 5 minutos)
- 😰 **Dor**: Frustração com sistemas complexos que abandona rapidamente
- 🎯 **Objetivo**: "Segundo cérebro" que funcione sem esforço

**Quote**:
> "Eu não quero aprender outro sistema. Só quero que funcione e me ajude a lembrar das coisas."

---

## 📋 Definições UX Necessárias

### 1. Instalação: Prompts do Installer

**Contexto Técnico**: O instalador usa `inquirer.js` para fazer perguntas ao usuário.

**Sua Tarefa**: Defina tom, ordem e texto das perguntas.

#### Perguntas Obrigatórias

**Q1: Local de Instalação**
```
Atual (técnico):
"Onde deseja instalar o Assistente?"
Default: ~/assistente-ia

Melhore:
- Tom: [amigável/formal/casual]
- Texto sugerido: [escreva]
- Default: [~/assistente-ia ou outro?]
- Ajuda/hint: [texto explicativo curto]
```

**Q2: Nome do Usuário**
```
Atual:
"Seu nome (para personalização dos agentes):"

Melhore:
- Por que pedimos? [explique benefício]
- Texto sugerido: [escreva]
- Exemplo: [se houver]
- Opcional ou obrigatório? [decida]
```

**Q3: Setup Git (Backup Automático)**
```
Atual:
"Deseja configurar backup automático com Git?"

Melhore:
- Como explicar "Git" para não-devs?
- Texto sugerido: [escreva]
- Default: [Sim/Não, por quê?]
- Disclaimer: [se necessário]
```

**Q4: Setup Obsidian**
```
Atual:
"Configurar integração com Obsidian?"

Melhore:
- Como explicar benefício do Obsidian?
- Texto sugerido: [escreva]
- Default: [Sim/Não]
- Link para download se não instalado?
```

**Q5: Abrir após instalação**
```
Atual:
"Abrir no Claude Code após instalação?"

Melhore:
- Texto sugerido: [escreva]
- Default: [Sim/Não]
```

#### Ordem das Perguntas

**Atual**: Local → Git → Nome → Obsidian → Abrir

**Melhore**:
- Qual ordem faz mais sentido?
- Agrupar perguntas relacionadas?
- Progressive disclosure (essencial primeiro, opcional depois)?

#### Mensagens de Progresso

Durante instalação, usuário vê spinners:
```
⠋ Criando estrutura de diretórios...
✅ Estrutura de diretórios criada

⠋ Copiando arquivos do sistema...
✅ Arquivos do sistema copiados
```

**Sua Tarefa**:
- Melhorar textos dos spinners
- Adicionar/remover etapas visíveis
- Definir emojis apropriados
- Mensagem de erro se algo falhar

---

### 2. Mensagem de Sucesso Final

**Atual** (técnico):
```
✅ Instalação concluída com sucesso!

📂 Local de instalação:
   /Users/marina/assistente-ia

🚀 Próximos passos:

   1. Abra o Claude Code nesta pasta
   2. Execute: /organizador
   3. Comece a usar seu segundo cérebro!

📝 Obsidian:
   Abra "/Users/marina/assistente-ia/knowledge-base" como vault
```

**Sua Tarefa**:
- Reescrever com tom mais acolhedor
- Destacar "quick win" imediato
- Simplificar instruções
- Adicionar call-to-action clara

---

### 3. README.md: Estrutura e Mensagens

**Seções Obrigatórias** (definidas tecnicamente):
1. Hero (título + pitch)
2. O Que É? (explicação)
3. Instalação Rápida
4. Como Usar (3 passos)
5. Por Que Usar? (benefícios TDAH)
6. Documentação
7. Ajuda
8. Privacidade

**Sua Tarefa**:

#### Hero Section
```
Atual:
# 🤖 Assistente Pessoal IA
Seu segundo cérebro para TDAH

Melhore:
- Tagline mais impactante?
- Destaque benefício principal
- Call-to-action ("Instale em 2 min")
```

#### Explicação Rápida
```
Atual:
"Um assistente pessoal com 5 especialistas IA..."

Melhore:
- Analogia melhor que "segundo cérebro"?
- Foco em dor do usuário ou solução?
- Quanto detalhe técnico incluir?
```

#### Benefícios TDAH (Tabela)
```
Atual:
| Problema | Solução |
| Esqueço tudo | Knowledge-base... |

Melhore:
- Linguagem mais empática?
- Exemplos concretos vs abstratos?
- Ordem de importância dos problemas?
```

---

### 4. Mensagens de Erro (Error Messages)

**Cenários Comuns**:

**Erro 1: Node.js não instalado**
```
Técnico:
❌ Error: Node.js not found. Please install Node.js 14+

User-Friendly:
[escreva mensagem]
[sugira ação clara]
[link para solução]
```

**Erro 2: Pasta já existe**
```
Técnico:
❌ Directory already exists: ~/assistente-ia

User-Friendly:
[escreva mensagem]
[ofereça opções: renomear, mesclar, cancelar?]
```

**Erro 3: Git não configurado**
```
Técnico:
❌ Git user.name not configured

User-Friendly:
[escreva mensagem]
[explique por que importa]
[sugira correção automática]
```

---

### 5. Comando `doctor` (Health Check)

**Propósito**: Verificar saúde da instalação e sugerir correções.

**Output Atual** (técnico):
```
🔍 Verificando instalação...

✅ Estrutura de arquivos: OK
❌ Git não inicializado
⚠️  Obsidian não configurado

Sugestões:
- Execute: git init
- Configure Obsidian manualmente
```

**Sua Tarefa**:
- Reescrever mensagens para não-devs
- Definir níveis de severidade (❌ crítico, ⚠️ aviso, ℹ️ info)
- Sugerir comandos de correção automática
- Quando mostrar detalhes técnicos vs abstrair?

---

### 6. Tom de Voz (Voice & Tone)

**Definir para cada contexto**:

| Contexto | Tom Sugerido | Justificativa |
|----------|--------------|---------------|
| **Instalador** | [amigável/encorajador/profissional] | [explique] |
| **README** | [inspirador/prático/técnico] | [explique] |
| **Erros** | [empático/direto/solução] | [explique] |
| **Tutoriais** | [paciente/simples/detalhado] | [explique] |
| **Docs Técnicos** | [preciso/completo/referência] | [explique] |

**Exemplo de Tom**:
```
❌ Muito Técnico:
"Initialize Git repository at target directory"

✅ User-Friendly:
"Vamos configurar backup automático dos seus dados"

❓ Muito Casual?
"Bora fazer um backup maneiro dos seus bagulhos?"
```

**Seu Guideline**: Onde está o equilíbrio ideal para usuário TDAH técnico (dev) mas que quer simplicidade?

---

### 7. Tutoriais e Documentação

**Princípios TDAH-First** (técnicos):
- ✅ Direto ao ponto (sem enrolação)
- ✅ Visual (screenshots, emojis)
- ✅ Progressivo (básico → avançado)
- ✅ Scannable (títulos, listas, destaques)

**Sua Tarefa**: Definir estrutura de docs

#### USAGE.md (Guia Completo)
```
Seções sugeridas:
1. [?] Quick Start (5 min)
2. [?] Conceitos Básicos
3. [?] Comandos dos Agentes
4. [?] Tips & Tricks
5. [?] Casos de Uso Reais

Para cada seção:
- Quanto detalhe?
- Exemplos práticos vs teoria?
- Screenshots necessários?
```

#### FAQ.md (Perguntas Frequentes)
```
Categorias:
- [?] Instalação
- [?] Uso Diário
- [?] Troubleshooting
- [?] Privacidade
- [?] Técnicas

Top 5 perguntas por categoria:
[liste as mais prováveis]
```

#### TROUBLESHOOTING.md
```
Formato sugerido para cada problema:
1. [?] Título do problema (user language)
2. [?] Sintomas (como usuário percebe)
3. [?] Causa (simplificada)
4. [?] Solução (passo-a-passo)
5. [?] Prevenção (se aplicável)

Problemas mais comuns:
[liste top 10]
```

---

### 8. Naming & Terminology

**Decisões de Nomenclatura**:

| Técnico | User-Facing | Decisão UX |
|---------|-------------|------------|
| `.assistant-core/` | `.assistant/` ou `config/`? | [decida] |
| `daily-dump.md` | Manter ou `captura-rapida.md`? | [decida] |
| `knowledge-base/` | Manter ou `meu-cerebro/`? | [decida] |
| `git commit` | "Salvar backup"? | [decida] |
| `slash commands` | "Comandos" ou "Atalhos"? | [decida] |

**Rationale**: Equilibrar familiaridade técnica com acessibilidade não-técnica.

---

### 9. Onboarding Flow (First-Time User)

**Objetivo**: Do `npx install` ao primeiro valor em < 10 minutos.

**Jornada Atual**:
1. Usuário executa `npx assistente-pessoal-ia install`
2. Responde perguntas do instalador
3. Instalação automática
4. Mensagem de sucesso
5. Abre Claude Code
6. [???] - **DEFINIR ESTE PASSO**

**Sua Tarefa**:

#### Passo 6: First Launch Experience
```
Opção A: Tutorial Interativo
- Arquivo TUTORIAL.md abre automaticamente
- Guia passo-a-passo com quick wins
- Checkbox de progresso

Opção B: Quick Start Card
- Arquivo QUICK-START.md minimalista
- 3 ações imediatas
- Links para docs completos

Opção C: Nada (deixar explorar)
- Apenas BEM-VINDO.md
- Usuário descobre naturalmente

Qual melhor para TDAH? [decida + justifique]
```

#### First Quick Win
```
Qual deve ser a PRIMEIRA experiência de valor?

Opção A: Captura rápida
1. Abra daily-dump.md
2. Escreva algo
3. Execute /organizador processar
4. Veja mágica acontecer

Opção B: Tour dos agentes
1. Liste os 5 agentes
2. Teste cada um com exemplo
3. Escolha favorito

Opção C: Personalização
1. Configure seu perfil
2. Escolha agentes ativos
3. Defina preferências

Qual gera mais "aha moment"? [decida]
```

---

### 10. Visual Identity (Branding)

**Emojis & Iconografia**:

| Elemento | Emoji Atual | Sugestão | Rationale |
|----------|-------------|----------|-----------|
| Instalador | 🤖 | [mantenha ou mude?] | [explique] |
| Sucesso | ✅ | [mantenha ou mude?] | [explique] |
| Erro | ❌ | [mantenha ou mude?] | [explique] |
| Aviso | ⚠️ | [mantenha ou mude?] | [explique] |
| Agentes | 🗂️📊🏗️🧠🎯 | [mantenha ou mude?] | [explique] |

**Cores (Terminal)**:
```
Atual:
- Info: Azul
- Sucesso: Verde
- Erro: Vermelho
- Aviso: Amarelo

Melhore:
- Manter padrão ou customizar?
- Acessibilidade (daltonismo)?
```

---

## 📦 Deliverables Esperados

Por favor, crie documentos com:

### 1. UX-INSTALLER-FLOW.md
- Texto completo de todos os prompts
- Ordem das perguntas
- Defaults e validações
- Mensagens de progresso e sucesso

### 2. UX-CONTENT-GUIDE.md
- Tom de voz por contexto
- Glossário de termos
- Exemplos de bom/mau copy
- Templates de mensagens

### 3. UX-ONBOARDING.md
- Fluxo completo first-time user
- Quick wins imediatos
- Tutorial structure
- Success metrics

### 4. UX-ERROR-MESSAGES.md
- Catálogo de erros comuns
- Mensagens user-friendly
- Ações corretivas sugeridas
- Quando/como escalar para suporte

---

## 🎯 Critérios de Sucesso UX

**Instalação deve**:
- ✅ Ser compreensível para "avó" (não-dev)
- ✅ Gerar confiança (não ansiedade)
- ✅ Ter quick win em < 5 minutos
- ✅ Nunca usar jargão sem explicar

**Documentação deve**:
- ✅ Responder "Por que eu uso isto?" antes de "Como uso?"
- ✅ Ter hierarquia clara (scan em 30 segundos)
- ✅ Usar exemplos reais, não abstratos
- ✅ Empoderar, não overwhelm

**Mensagens de erro devem**:
- ✅ Explicar o que deu errado (simples)
- ✅ Dizer como corrigir (ação clara)
- ✅ Não culpar usuário
- ✅ Oferecer ajuda adicional se precisar

---

## ⏱️ Timeline Sugerido

**Fase 1** (1-2 dias): Installer Flow
- Definir prompts e mensagens
- Testar com 2-3 usuários

**Fase 2** (1 dia): Content Guide
- Tom de voz
- Glossário
- Templates

**Fase 3** (1-2 dias): Onboarding
- Fluxo first-time
- Tutorial structure
- Quick wins

**Fase 4** (1 dia): Error Messages
- Catálogo completo
- User-friendly rewrites

**Total**: ~5 dias

---

## 📞 Perguntas Frequentes

**P: Quanto detalhhe técnico mostrar?**
R: Defina você! Mas considere: usuário é dev com TDAH - tecnicamente capaz, mas quer simplicidade.

**P: Tom formal ou casual?**
R: Você decide. Recomendo: profissional amigável (não corporativo chato, não startup over-casual).

**P: Português ou Inglês?**
R: Português para usuário final. Inglês para docs técnicos dev (se houver).

**P: Como testar as escolhas UX?**
R: Sugiro prototype textual + 2-3 test users (um TDAH, um não-dev, um dev).

---

## 🤝 Colaboração

**Próximos Passos**:
1. Revisar este brief
2. Perguntas/clarificações (se houver)
3. Criar deliverables
4. Revisão com Architect (Winston)
5. Implementação técnica

**Contato**: Qualquer dúvida, pingue Winston (Architect) ou time dev.

---

**Winston (Architect)**
*"Design is not just what it looks like. Design is how it works."* - Steve Jobs
