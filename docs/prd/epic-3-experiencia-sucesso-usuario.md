# Epic 3: Experiência e Sucesso do Usuário Final

**Objetivo do Épico:** Garantir que usuários comuns (não-desenvolvedores) consigam usar o sistema com sucesso nos primeiros 7 dias, eliminando fricção de adoção através de onboarding guiado, feedback visual constante, e backup invisível.

**Público-Alvo:** Pessoas com TDAH que NÃO são desenvolvedores

**Filosofia:** "Mostre, não explique" + "Funciona sem precisar entender"

---

## Story 3.0: Upgrade Path para Usuários Existentes

**Como um** usuário que já tem Épicos 0-2 instalados,
**Eu quero** atualizar para Epic 3 sem perder meus dados ou configurações,
**Para que** eu aproveite as novas funcionalidades de UX sem fricção.

### Critérios de Aceitação

#### 1. Detecção de Instalação Existente

**Script:** `scripts/upgrade-to-epic3.sh` / `scripts/upgrade-to-epic3.bat`

**Funcionamento:**
- Detecta se Épicos 0-2 já estão instalados
- Verifica presença de `.assistant-core/`, `knowledge-base/`, agentes
- Identifica versão atual do sistema (via arquivo `.version` ou tags Git)
- Exibe resumo do que será adicionado/modificado

**Validação:**
```bash
# Arquivos críticos existentes
required_files=(
    ".assistant-core/agents/organizador.md"
    "knowledge-base/"
    "despejo/daily-dump.md"
)

# Se qualquer arquivo crítico ausente → erro: "Execute setup.sh primeiro"
```

#### 2. Backup Automático Pré-Upgrade

**Antes de qualquer modificação:**
- Cria backup automático: `backup-pre-epic3-$(date).zip`
- Inclui: `.obsidian/`, `.assistant-core/memory/`, configurações personalizadas
- Exibe mensagem: "✅ Backup criado em: backup-pre-epic3-2025-10-01.zip"
- Permite continuar ou cancelar upgrade

#### 3. Adição de Arquivos Novos (Não-Destrutiva)

**Arquivos adicionados SEM sobrescrever existentes:**

**Obsidian:**
- `knowledge-base/🏠 INÍCIO.md` (novo dashboard visual)
- `knowledge-base/BEM-VINDO.md` (tutorial novo usuário)
- `COMO-BUSCAR.md` (guia de busca)
- `OBSIDIAN-EM-5-MINUTOS.md` (tutorial rápido)
- `ATALHOS-OBSIDIAN.md` (cartão de referência)

**Dashboards:**
- `MEU-PROGRESSO.md` (checklist primeira semana)
- `📈 MEU-DASHBOARD.md` (dashboard pessoal)
- `todos/PROGRESSO-VISUAL.md` (progresso visual)

**Scripts:**
- `RECUPERAR-BACKUP.sh/.bat` (recovery simplificado)
- `EXPORTAR-TUDO.sh/.bat` (export manual)

**Cache/Data:**
- `.assistant-core/data/dashboard-cache.yaml` (vazio inicialmente)

#### 4. Atualização de Configurações Obsidian (Preservando Customizações)

**Estratégia de merge inteligente:**

```bash
# Se .obsidian/workspace.json JÁ existe (usuário customizou)
if [ -f "knowledge-base/.obsidian/workspace.json" ]; then
    # Preserva workspace do usuário
    echo "⚠️  Workspace Obsidian existente detectado - preservando suas customizações"

    # Cria arquivo SUGESTÃO separado
    cp templates/obsidian-workspace-epic3.json knowledge-base/.obsidian/workspace-suggested.json
    echo "💡 Sugestões de configuração em: .obsidian/workspace-suggested.json"
else
    # Primeira instalação → aplica configuração padrão Epic 3
    cp templates/obsidian-workspace-epic3.json knowledge-base/.obsidian/workspace.json
fi
```

**Hotkeys:**
```bash
# Se .obsidian/hotkeys.json existe → merge (não sobrescreve)
# Adiciona APENAS hotkeys novos que usuário não configurou
# Preserva 100% dos hotkeys customizados pelo usuário
```

#### 5. Atualização de Agentes (Saudação Contextual)

**Modificação dos agentes existentes para suportar Epic 3:**

**Agente Organizador (`.assistant-core/agents/organizador.md`):**
- Adiciona detecção de primeira execução
- Se primeira vez → inicia tour guiado (Story 3.1 AC1)
- Se não primeira vez → saudação contextual (Story 3.3 AC2)
- Preserva 100% da funcionalidade existente

**Outros agentes (secretaria, arquiteto, psicologo, mentor):**
- Adiciona saudação contextual com memória
- Mantém comandos e workflows existentes
- Zero quebra de funcionalidade

**Estratégia:**
```bash
# Backup dos agentes originais
cp .assistant-core/agents/*.md .assistant-core/agents/backup-pre-epic3/

# Aplica patches (adiciona seções, não remove)
patch .assistant-core/agents/organizador.md < patches/epic3-organizador.patch
```

#### 6. Validação Pós-Upgrade

**Checklist automático:**
```bash
echo "🔍 Validando upgrade..."

# 1. Todos os agentes ainda carregam?
for agent in organizador secretaria arquiteto psicologo mentor; do
    # Valida YAML parsing
done

# 2. Knowledge-base intacta?
# Verifica que projetos, pessoas, decisões existentes não foram tocados

# 3. Obsidian abre corretamente?
# Valida .obsidian/workspace.json parsing

# 4. Novos arquivos criados?
# Verifica presença de BEM-VINDO.md, INÍCIO.md, etc

echo "✅ Upgrade para Epic 3 concluído com sucesso!"
echo "📖 Leia knowledge-base/BEM-VINDO.md para conhecer novidades"
```

#### 7. Comunicação Clara ao Usuário

**Mensagem de upgrade:**
```
📦 Upgrade para Epic 3: Experiência de Sucesso do Usuário

O que será adicionado:
✅ Tutorial interativo para novos usuários
✅ Dashboard visual no Obsidian
✅ Feedback de progresso e achievements
✅ Backup automático melhorado

O que NÃO será modificado:
✅ Seus projetos, pessoas, decisões (knowledge-base/)
✅ Suas conversas com agentes (memória preservada)
✅ Suas customizações do Obsidian
✅ Seu daily-dump.md

💾 Backup será criado automaticamente
🔄 Processo é reversível via Git

Continuar? (sim/não)
```

#### 8. Documentação de Upgrade

**Arquivo:** `UPGRADE-EPIC3.md`

```markdown
# Guia de Upgrade para Epic 3

## Para Usuários com Épicos 0-2 Instalados

### Passo 1: Backup Automático
Execute: `bash scripts/upgrade-to-epic3.sh`
Backup criado automaticamente antes de qualquer modificação

### Passo 2: Upgrade Não-Destrutivo
- Novos arquivos adicionados
- Configurações preservadas
- Zero perda de dados

### Passo 3: Explorar Novidades
- Abra `knowledge-base/BEM-VINDO.md` no Obsidian
- Conheça o novo dashboard: `🏠 INÍCIO.md`
- Veja seu progresso: `MEU-DASHBOARD.md`

## Para Instalações Novas

Execute: `bash setup.sh`
Epic 3 já incluído automaticamente
```

**Performance:**
- Upgrade completo: < 30 segundos
- Backup: < 5 segundos (10-50MB típico)
- Validação: < 2 segundos

---

## Story 3.1: Onboarding Interativo - Primeiros Passos

**Como um** novo usuário que acabou de instalar o sistema,
**Eu quero** um tutorial interativo que me guia nos primeiros passos,
**Para que** eu entenda o sistema rapidamente e tenha sucesso em menos de 10 minutos.

### Critérios de Aceitação

#### 1. Tour Inicial Automático e Interativo

**Quando:** Usuário executa `/organizador` pela primeira vez

**O que acontece:**
- Agente detecta primeira vez e inicia tour guiado
- "👋 Olá! Sou a Sofia, sua Organizadora. Vou te mostrar como funciona em 3 passos práticos!"
- Tour completo em < 8 minutos
- Usuário pode pular a qualquer momento (salva progresso)

**Conteúdo do Tour:**
1. **Passo 1**: "Vamos escrever seu primeiro despejo" → Guia para abrir `daily-dump.md`
2. **Passo 2**: "Agora vou processar isso para você" → Demonstração de processamento
3. **Passo 3**: "Veja no Obsidian o que organizei" → Mostra resultado visual

**Performance:**
- Tour é conversacional (zero carga adicional)
- Arquivos de exemplo são pré-carregados na instalação (0 latência)

#### 2. Exemplos Práticos Pré-Incluídos

**Arquivos criados automaticamente na instalação:**

`despejo/daily-dump.md` vem com:
```markdown
# Meu Daily Dump - Jogue tudo aqui!

## 📝 Exemplo de como usar (pode apagar depois):

reunião com João amanhã 14h - discutir orçamento Q2
implementar autenticação no projeto Alpha urgente
ideia: criar app para organizar receitas da vó
ligar pro dentista agendar consulta
estudar sobre arquitetura de microserviços

---

## ✍️ Seu despejo começa aqui:

[Digite livremente - sem estrutura, sem medo]
```

`knowledge-base/BEM-VINDO.md`:
```markdown
# 🎉 Bem-vindo ao seu Assistente Pessoal!

## 🚀 Comece Aqui

Você acabou de instalar seu "segundo cérebro" pessoal. Aqui está como usar:

### Passo 1: Capture Tudo
- Abra `despejo/daily-dump.md`
- Escreva QUALQUER COISA que está na sua cabeça
- Não se preocupe com organização

### Passo 2: Deixe os Agentes Organizarem
- Execute `/organizador *processar`
- Responda algumas perguntas simples
- Pronto! Tudo organizado automaticamente

### Passo 3: Explore o Resultado
- Use este Obsidian para ver suas anotações organizadas
- Clique nos [[links]] para navegar
- Use Ctrl+O para buscar qualquer coisa

## 🤖 Seus 5 Agentes

- **Sofia (/organizador)**: Organiza seu despejo
- **Secretária (/secretaria)**: Gerencia sua agenda e projetos
- **Marcus (/arquiteto)**: Ajuda com decisões técnicas
- **Dr. Helena (/psicologo)**: Suporte emocional e TDAH
- **Leonardo (/mentor)**: Desenvolvimento de carreira

## 📚 Próximos Passos

- [ ] Escrevi meu primeiro despejo
- [ ] Processei com /organizador
- [ ] Explorei o Obsidian
- [ ] Conversei com 3 agentes diferentes
- [ ] Entendi como funciona [[referências]]

---

💡 **Dica TDAH**: Não tente entender tudo de uma vez. Use 1 semana só capturando e processando. O resto vem naturalmente.
```

**Performance:**
- Arquivos são estáticos (zero custo)
- Criados durante instalação (não impacta uso)

#### 3. Quick Wins Imediatos (Primeiros 5 Minutos)

**Objetivo:** Usuário vê valor tangível em < 5 minutos

**Fluxo de Sucesso Rápido:**
1. Usuário escreve no daily-dump (30 segundos)
2. Executa `/organizador *processar` (10 segundos de processamento)
3. Agente faz 3-5 perguntas simples (2 minutos de conversa)
4. **RESULTADO VISUAL IMEDIATO**: Agente mostra onde salvou cada informação
5. Usuário abre Obsidian e VÊ as anotações organizadas com [[links]]

**Output do Processamento (exemplo):**
```
✅ Processamento Completo!

Organizei 5 itens do seu despejo:

📅 AGENDA:
   → Reunião com João - Salvo em: todos/por-pessoa/pessoa-joao.md

🚀 PROJETO:
   → Autenticação no Alpha - Salvo em: knowledge-base/projetos/projeto-alpha.md

💡 IDEIA:
   → App de receitas - Salvo em: knowledge-base/ideias/app-receitas.md

✅ TODO:
   → Ligar dentista - Adicionado em: todos/central-todos.md

📚 APRENDIZADO:
   → Microserviços - Salvo em: knowledge-base/aprendizados/microservicos.md

🎯 Abra o Obsidian para ver tudo organizado com links automáticos!
```

**Otimização de Performance:**
- Processamento usa cache de contexto (< 2 segundos)
- Criação de arquivos em batch (1 operação I/O)
- Links [[]] gerados em memória antes de salvar

#### 4. Checklist de Sucesso Primeira Semana

**Dashboard Automático:** `MEU-PROGRESSO.md` criado automaticamente

```markdown
# 📊 Meu Progresso - Primeira Semana

## ✅ Checklist de Sucesso

- [ ] Dia 1: Escrevi no daily-dump
- [ ] Dia 1: Processei com /organizador
- [ ] Dia 2: Conversei com 3 agentes diferentes
- [ ] Dia 3: Encontrei algo antigo no Obsidian (busca)
- [ ] Dia 4: Entendi o sistema de [[referências]]
- [ ] Dia 5: Usei /secretaria para ver status de projetos
- [ ] Dia 7: Vi meu dashboard de atividades

## 📈 Minhas Estatísticas

**Esta semana você:**
- 🗂️ Processou X despejos
- 💬 Conversou X vezes com agentes
- 📝 Criou X anotações na knowledge-base
- ✅ Completou X todos

## 🎯 Próximo Passo Sugerido

[Sugestão personalizada baseada no uso]

---
🔄 Atualizado automaticamente • Último sync: DD/MM/YYYY HH:MM
```

**Performance:**
- Arquivo atualizado apenas após processamento de despejo (não polling)
- Estatísticas calculadas via contagem de arquivos (rápido)
- Cache de 1 hora (evita recalcular constantemente)

#### 5. Vídeos Curtos Integrados (Opcional - Não Bloqueia Story)

**Se time permitir:**
- 5 vídeos de 2 minutos cada (GIF animados alternativamente)
- Hospedados no próprio repo (sem dependência externa)
- Acessíveis via `videos/` ou links no BEM-VINDO.md

**Tópicos:**
1. "Como escrever no daily-dump" (30 segundos)
2. "Processando com /organizador" (2 minutos)
3. "Navegando no Obsidian" (2 minutos)
4. "Usando [[referências]]" (1 minuto)
5. "Seus 5 agentes explicados" (2 minutos)

---

## Story 3.2: Obsidian Simplificado e Pré-Configurado

**Como um** usuário não-técnico que abriu o Obsidian pela primeira vez,
**Eu quero** entender visualmente o que estou vendo sem me sentir perdido,
**Para que** eu consiga navegar minha knowledge-base com confiança.

### Critérios de Aceitação

#### 1. Dashboard Visual Inicial

**Arquivo:** `knowledge-base/🏠 INÍCIO.md` (emoji para destacar visualmente)

```markdown
# 🏠 Seu Painel de Controle

Bem-vindo! Use os links abaixo para navegar:

---

## 📥 Captura Rápida

- [[📝 Daily Dump]] - Jogue tudo aqui (sem estrutura)
- [[✅ Central de Todos]] - Suas tarefas

---

## 📂 Minhas Informações Organizadas

- [[🗂️ Projetos]] - Todos os seus projetos
- [[👥 Pessoas]] - Contatos e relacionamentos
- [[💡 Ideias]] - Insights e brainstorms
- [[📚 Aprendizados]] - Conhecimento capturado
- [[🎯 Decisões]] - Decisões importantes registradas

---

## 🤖 Conversar com Agentes

Execute no Claude Code:
- `/organizador` - Organizar despejo
- `/secretaria` - Status de projetos
- `/arquiteto` - Decisões técnicas
- `/psicologo` - Suporte emocional
- `/mentor` - Carreira e metas

---

## 🔍 Busca Rápida

- **Ctrl + O** (Windows) / **Cmd + O** (Mac) → Buscar qualquer arquivo
- **Ctrl + Shift + F** → Buscar dentro dos arquivos

---

## 📊 Ver Meu Progresso

- [[📈 Meu Dashboard]] - Estatísticas e progresso
- [[🎯 Meu Progresso]] - Checklist primeira semana

---

💡 **Dica**: Clique em qualquer [[link azul]] para navegar!
```

**Performance:**
- Arquivo estático (zero custo)
- Carrega instantaneamente no Obsidian
- Emojis são Unicode (sem imagens externas)

#### 2. Obsidian Pré-Configurado com Tema Simples

**Configuração automática durante instalação:**

`.obsidian/workspace.json` (pré-configurado):
```json
{
  "main": {
    "children": [
      {
        "type": "leaf",
        "state": {
          "type": "markdown",
          "state": {
            "file": "🏠 INÍCIO.md"
          }
        }
      }
    ]
  },
  "left": {
    "children": [
      {
        "type": "leaf",
        "state": {
          "type": "file-explorer",
          "state": {}
        }
      },
      {
        "type": "leaf",
        "state": {
          "type": "search",
          "state": {}
        }
      }
    ],
    "collapsed": false
  }
}
```

**Plugins essenciais habilitados (nativos do Obsidian):**
- File explorer
- Search
- Graph view (simplificado)
- Daily notes (configurado para `despejo/`)
- Quick switcher

**Tema:** Default claro (simples, sem customização confusa)

**Otimização:**
- Plugins nativos apenas (sem dependencies externas)
- Graph view limitado a 2 níveis de profundidade (performance + simplicidade)
- Cache habilitado para busca rápida

#### 3. Busca Simples que Funciona (Sem Jargão)

**Guia de Busca:** `COMO-BUSCAR.md`

```markdown
# 🔍 Como Encontrar Suas Anotações

## Busca Rápida (Recomendado)

1. Pressione **Ctrl + O** (Windows) ou **Cmd + O** (Mac)
2. Digite qualquer palavra
3. Pronto! Obsidian mostra todos os arquivos relacionados

**Exemplos:**
- Digite "João" → Mostra reuniões, todos, projetos com João
- Digite "Alpha" → Mostra tudo do projeto Alpha
- Digite "ontem" → Mostra anotações de ontem

---

## Busca Dentro dos Arquivos

1. Pressione **Ctrl + Shift + F**
2. Digite o que procura
3. Obsidian mostra todas as menções

---

## Busca por Data

**No Quick Switcher (Ctrl + O):**
- "2024-01" → Anotações de Janeiro 2024
- "daily-dump" → Seus despejos

---

## Navegação por [[Links]]

Qualquer [[palavra entre colchetes]] é um link clicável!

**Clique para navegar** ou **passe o mouse para preview**

---

💡 **Truque TDAH**: Não sabe o nome? Digite qualquer palavra relacionada!
```

**Performance:**
- Busca nativa do Obsidian (otimizada em Rust)
- Índice de busca em cache (< 100ms para 10k arquivos)
- Resultados em tempo real enquanto digita

#### 4. Tutorial Obsidian Visual em Português

**Arquivo:** `OBSIDIAN-EM-5-MINUTOS.md`

**Estrutura:**
1. Abrir arquivos (Ctrl+O) - GIF animado
2. Buscar texto (Ctrl+Shift+F) - Screenshot
3. Seguir [[links]] - GIF animado
4. Ver Graph view simples - Screenshot
5. Voltar ao início - Link para 🏠 INÍCIO.md

**Otimização:**
- GIFs otimizados (< 500KB cada, max 10 frames/s)
- Carregamento lazy (só carrega quando usuário abre arquivo)
- Alternativa em texto se GIFs não carregarem

#### 5. Atalhos Essenciais Configurados

**Hotkeys pré-configurados em `.obsidian/hotkeys.json`:**

```json
{
  "app:go-back": [{"modifiers": ["Alt"], "key": "ArrowLeft"}],
  "app:go-forward": [{"modifiers": ["Alt"], "key": "ArrowRight"}],
  "switcher:open": [{"modifiers": ["Ctrl"], "key": "O"}],
  "global-search:open": [{"modifiers": ["Ctrl", "Shift"], "key": "F"}],
  "file-explorer:reveal-active-file": [{"modifiers": ["Ctrl", "Shift"], "key": "E"}]
}
```

**Cartão de Referência:** `ATALHOS-OBSIDIAN.md`
- Ctrl+O: Busca rápida
- Ctrl+Shift+F: Buscar em arquivos
- Alt+←: Voltar
- Alt+→: Avançar
- Ctrl+Shift+E: Ver arquivo atual no explorer

---

## Story 3.3: Feedback Visual e Progresso Contínuo

**Como um** usuário com TDAH que precisa de reforço positivo constante,
**Eu quero** ver claramente o que está acontecendo e meu progresso,
**Para que** eu me sinta motivado e confiante usando o sistema diariamente.

### Critérios de Aceitação

#### 1. Dashboard Executivo Pessoal Automático

**Arquivo:** `📈 MEU-DASHBOARD.md` (atualizado automaticamente)

**Conteúdo:**
```markdown
# 📈 Meu Dashboard Pessoal

**Última atualização:** DD/MM/YYYY às HH:MM

---

## 📊 Esta Semana

- 🗂️ **Despejos processados:** 5
- 💬 **Conversas com agentes:** 23
- 📝 **Notas criadas:** 18
- ✅ **Todos completados:** 12 de 20 (60%)

---

## 🤖 Uso dos Agentes

| Agente | Conversas | Última vez |
|--------|-----------|------------|
| 🗂️ Sofia (Organizador) | 8 | Há 2 horas |
| 📋 Secretária | 6 | Ontem 14:30 |
| 🏗️ Marcus (Arquiteto) | 5 | Há 3 dias |
| 🧠 Helena (Psicólogo) | 3 | Há 1 semana |
| 🎓 Leonardo (Mentor) | 1 | Há 2 semanas |

💡 **Sugestão**: Você não conversa com Helena há 1 semana. Como está seu bem-estar?

---

## 🔥 Streak (Dias Consecutivos)

**7 dias** processando despejo consecutivamente! 🎉

```
S  T  Q  Q  S  S  D
✅ ✅ ✅ ✅ ✅ ✅ ✅
```

---

## 📋 Progresso em Projetos

- **projeto-alpha**: 8 atualizações esta semana ✅
- **projeto-beta**: 2 atualizações esta semana ⚠️
- **projeto-gamma**: Sem atualizações há 2 semanas 🔴

---

## 🎯 Últimas 5 Atividades

1. ✅ Completou todo "Ligar dentista" - Há 1 hora
2. 📝 Criou nota "Microserviços" - Há 2 horas
3. 💬 Conversa com Sofia sobre organização - Há 2 horas
4. 📅 Agendou reunião com João - Ontem 16:00
5. 🏗️ Decisão técnica sobre arquitetura - Há 2 dias

---

## 🏆 Achievements Desbloqueados

- 🎉 **Primeira Semana Completa** - 7 dias de uso consecutivo
- 🔥 **Em Chamas** - Streak de 7 dias
- 🤖 **Explorador** - Conversou com todos os 5 agentes
- 📚 **Colecionador** - 50+ notas na knowledge-base

---

💪 **Você está indo muito bem! Continue assim!**
```

**Performance Crítica:**

**Otimização 1: Atualização Incremental (Não Recalcula Tudo)**
```python
# Pseudocódigo da lógica
def atualizar_dashboard():
    # Cache de 1 hora
    if cache_valido(1_hora):
        return cache

    # Atualiza apenas contadores novos (desde último sync)
    novos_despejos = contar_arquivos_desde(ultimo_sync, "despejo/processed/")
    novas_notas = contar_arquivos_desde(ultimo_sync, "knowledge-base/")

    # Atualiza cache
    dashboard_cache.update(novos_despejos, novas_notas)
    salvar_cache()

    # Gera markdown (rápido)
    return gerar_markdown(dashboard_cache)
```

**Otimização 2: Geração Assíncrona**
- Dashboard atualizado APÓS processamento de despejo (não bloqueia)
- Máximo 500ms para gerar (timeout se > 500ms, usa cache antigo)
- Sistema de fila (se já gerando, agenda próxima atualização)

**Otimização 3: Dados Pré-Agregados**
```yaml
# .assistant-core/data/dashboard-cache.yaml
ultima_atualizacao: 2025-10-01T14:32:00Z
despejos_processados: 5
conversas_total: 23
notas_criadas: 18
todos_completados: 12
todos_total: 20
streak_dias: 7

conversas_por_agente:
  organizador: 8
  secretaria: 6
  arquiteto: 5
  psicologo: 3
  mentor: 1

ultima_conversa_por_agente:
  organizador: "2025-10-01T12:30:00Z"
  secretaria: "2025-09-30T14:30:00Z"
  # ...
```

**Resultado:** Dashboard gerado em < 100ms mesmo com 10k+ arquivos

#### 2. Indicadores Visuais nas Conversas com Agentes

**Saudação Contextual com Memória:**

```
👋 Olá novamente!

📊 Status:
- Última conversa: Há 2 horas (sobre organização de projeto Alpha)
- Esta é nossa 15ª conversa!
- Você está em um streak de 7 dias! 🔥

🎯 Contexto recuperado:
- Projeto Alpha está na fase de implementação
- Você tem reunião com João amanhã às 14h
- 3 todos pendentes relacionados ao Alpha

Em que posso ajudar hoje?
```

**Implementação:**
```python
def saudacao_contextual(agente_id, user_id):
    # < 50ms target
    memoria = carregar_memoria_cache(agente_id, user_id)  # 10ms (YAML cache)

    ultima_conversa = memoria.get("ultima_conversa")
    total_conversas = memoria.get("total_conversas", 0)
    streak = calcular_streak(user_id)  # 5ms (cache diário)
    contexto_relevante = recuperar_contexto_top3(agente_id, user_id)  # 30ms (índice)

    return gerar_saudacao(ultima_conversa, total_conversas, streak, contexto_relevante)
```

**Performance:**
- Memória carregada de cache YAML (< 10ms)
- Top 3 contextos via índice invertido (não busca em todos arquivos)
- Streak calculado 1x/dia e cacheado
- Total: < 50ms de overhead

#### 3. Progresso Visual de Todos e Metas

**Visualização em Markdown Simples:**

`todos/PROGRESSO-VISUAL.md`:
```markdown
# ✅ Progresso de Todos

**Atualizado:** Há 5 minutos

---

## 📊 Visão Geral

```
Completados: 12/20 (60%)
████████████░░░░░░░░ 60%
```

**Status:**
- ✅ Completados: 12
- 🔄 Em andamento: 3
- ⏳ Pendentes: 5

---

## 🎯 Por Projeto

### projeto-alpha (5/8)
```
████████████░░░░ 62%
```
- ✅ Implementar autenticação
- ✅ Configurar banco de dados
- ✅ Criar API endpoints
- ✅ Testes unitários
- ✅ Deploy staging
- 🔄 Documentação
- ⏳ Code review
- ⏳ Deploy produção

### projeto-beta (2/4)
```
████████░░░░░░░░ 50%
```
- ✅ Definir escopo
- ✅ Protótipo inicial
- 🔄 Validação usuários
- ⏳ Refinamento

---

## 🏆 Metas de Carreira

### Meta: Senior Engineer até Dez/2025

**Progresso geral:** 45%
```
█████████░░░░░░░░░░░ 45%
```

**Sub-metas:**
- [██████████░░░░░░░░░░] 50% - Estudar arquitetura distribuída
- [████████████████░░░░] 80% - Liderar projeto Alpha
- [████░░░░░░░░░░░░░░░░] 20% - Mentorar júniors
- [░░░░░░░░░░░░░░░░░░░░]  0% - Apresentar em conferência

---

💡 **Próximo passo sugerido:** Continuar liderança do Alpha (80% completo!)
```

**Performance:**
- Barras de progresso: caracteres Unicode (sem renderização de imagem)
- Atualizado apenas quando todo muda de status (event-driven)
- Cache de 5 minutos (não precisa ser real-time)

#### 4. Sistema de Achievements Gamificado (Leve)

**Achievements Simples e Motivadores:**

```markdown
# 🏆 Meus Achievements

## 🔓 Desbloqueados (8)

- 🎉 **Primeira Semana** - Usou o sistema por 7 dias consecutivos
- 🔥 **Em Chamas** - Streak de 7+ dias
- 🤖 **Explorador** - Conversou com todos os 5 agentes
- 📚 **Colecionador** - 50+ notas na knowledge-base
- ✅ **Produtivo** - Completou 100+ todos
- 💬 **Conversador** - 50+ conversas com agentes
- 🗂️ **Organizado** - Processou 20+ despejos
- 📈 **Crescimento** - Definiu metas de carreira

## 🔒 Próximos Achievements (5)

- 🏔️ **Montanha** - Streak de 30 dias (faltam 23 dias)
- 🎓 **Estudioso** - 100+ anotações de aprendizado (faltam 65)
- 🎯 **Focado** - Complete uma meta de carreira
- 🤝 **Networker** - 20+ anotações sobre pessoas (faltam 8)
- ⚡ **Relâmpago** - Processe despejo em < 2 minutos
```

**Implementação:**
```python
# Achievements verificados apenas após ações relevantes (não polling)
def verificar_achievements(evento):
    if evento.tipo == "despejo_processado":
        verificar_achievement("processou_20_despejos")
    elif evento.tipo == "todo_completado":
        verificar_achievement("completou_100_todos")
    # ...

    # Notificação se desbloqueou novo achievement
    if achievement_desbloqueado:
        mostrar_notificacao("🎉 Achievement desbloqueado: {nome}")
```

**Performance:**
- Verificação O(1) via contadores em cache
- Apenas eventos relevantes triggam verificação (event-driven)
- Notificações não bloqueiam fluxo principal

#### 5. Notificações Não-Intrusivas

**Mensagens de Encorajamento Contextuais:**

```
# Após processar despejo com sucesso:
✅ Despejo processado com sucesso! Organizei 8 itens para você.
💡 Você está em um streak de 7 dias! Continue assim! 🔥

# Após 1 semana sem conversar com um agente:
💭 Você não conversa com Helena (Psicólogo) há 1 semana.
   Tudo bem com você? 🧠

# Após completar projeto importante:
🎉 Projeto Alpha concluído!
   Você quer que Leonardo (Mentor) te ajude a refletir sobre o aprendizado?

# Detecção de sobrecarga:
⚠️ Você tem 15 todos pendentes e 3 projetos ativos.
   Helena (Psicólogo) pode ajudar com estratégias de priorização?
```

**Performance:**
- Notificações geradas apenas após eventos (não polling)
- Máximo 1 notificação por sessão de processamento (evita spam)
- Regras simples em cache (< 5ms para avaliar)

---

## Story 3.4: Backup Automático Invisível

**Como um** usuário que tem medo de perder dados mas não entende Git,
**Eu quero** que backups aconteçam automaticamente de forma invisível,
**Para que** eu durma tranquilo sabendo que nada será perdido.

### Critérios de Aceitação

#### 1. Git Backup Automático e Silencioso

**Funcionamento:**
- Git commit automático após cada processamento de despejo ✅
- Git commit automático após cada conversa com agente ✅
- Commit incremental (só arquivos modificados)
- Mensagem de commit automática clara

**Mensagem de Commit Automática:**
```
✅ Backup automático: Processamento de despejo

Data: 2025-10-01 14:32:15
Arquivos modificados: 8
- Criados: 5 notas
- Atualizados: 2 todos
- Movidos: 1 arquivo

📊 Status: 23 conversas esta semana | Streak: 7 dias

🤖 Generated by Assistente Pessoal IA
```

**Feedback Visual Não-Intrusivo:**
```
# Após processamento
✅ Despejo processado com sucesso!
💾 Backup automático feito às 14:32 ✓
```

**Implementação Performance:**
```bash
# Hook pós-processamento (assíncrono)
function backup_automatico() {
    # Executa em background (não bloqueia usuário)
    (
        git add -A
        git commit -m "$(gerar_mensagem_commit)" --quiet

        # Push para remoto se configurado (opcional, não bloqueia)
        if git remote | grep -q "origin"; then
            git push origin main --quiet &
        fi
    ) &
}
```

**Performance:**
- Git commit: ~50-200ms (dependendo de arquivos modificados)
- Executado em background (não bloqueia usuário)
- Push para remoto é assíncrono (nunca bloqueia)

#### 2. Recovery Simplificado com 1 Clique

**Script de Recovery:** `RECUPERAR-BACKUP.sh` / `RECUPERAR-BACKUP.bat`

```bash
#!/bin/bash
# RECUPERAR-BACKUP.sh - Recovery Simples para Usuários

echo "🔄 Recuperador de Backup - Assistente Pessoal IA"
echo ""
echo "Últimos 10 backups disponíveis:"
echo ""

# Lista últimos 10 commits de forma amigável
git log -10 --pretty=format:"%h|%ad|%s" --date=format:"%d/%m/%Y %H:%M" | \
while IFS='|' read hash data mensagem; do
    echo "[$hash] $data - $mensagem"
done

echo ""
echo "Digite o código [XXXX] do backup que deseja recuperar:"
read backup_hash

# Validação
if [ -z "$backup_hash" ]; then
    echo "❌ Nenhum código fornecido. Operação cancelada."
    exit 1
fi

# Confirmação
echo ""
echo "⚠️  ATENÇÃO: Isso vai restaurar seus arquivos para o estado do backup escolhido."
echo "   Alterações não salvas desde esse backup serão perdidas."
echo ""
echo "Tem certeza? (sim/não)"
read confirmacao

if [ "$confirmacao" != "sim" ]; then
    echo "❌ Operação cancelada."
    exit 0
fi

# Recovery
echo ""
echo "🔄 Restaurando backup..."
git reset --hard $backup_hash

if [ $? -eq 0 ]; then
    echo "✅ Backup restaurado com sucesso!"
    echo "📂 Abra o Obsidian para ver seus arquivos restaurados."
else
    echo "❌ Erro ao restaurar backup. Entre em contato com suporte."
    exit 1
fi
```

**Performance:**
- Listagem de commits: < 100ms (git log otimizado)
- Reset hard: < 500ms (operação Git nativa otimizada)
- Interface CLI simples (sem dependências)

#### 3. Export Manual para Não-Técnicos

**Script de Export:** `EXPORTAR-TUDO.sh` / `EXPORTAR-TUDO.bat`

```bash
#!/bin/bash
# EXPORTAR-TUDO.sh - Export para Dropbox/Google Drive

echo "📦 Exportador - Assistente Pessoal IA"
echo ""

# Nome do arquivo
data_atual=$(date +%Y-%m-%d_%H-%M-%S)
arquivo_export="assistente-backup-$data_atual.zip"

echo "🗜️  Criando arquivo de export..."

# Exporta knowledge-base, despejo, todos, diario
zip -r "$arquivo_export" \
    knowledge-base/ \
    despejo/ \
    todos/ \
    diario/ \
    .assistant-core/memory/ \
    -q

if [ $? -eq 0 ]; then
    tamanho=$(du -h "$arquivo_export" | cut -f1)
    echo ""
    echo "✅ Export criado com sucesso!"
    echo "📦 Arquivo: $arquivo_export"
    echo "💾 Tamanho: $tamanho"
    echo ""
    echo "Agora você pode:"
    echo "  1. Copiar para Dropbox/Google Drive"
    echo "  2. Enviar por email (se não for muito grande)"
    echo "  3. Guardar em HD externo"
    echo ""
    echo "📌 Última exportação salva em: ULTIMA-EXPORTACAO.txt"
    echo "$data_atual" > ULTIMA-EXPORTACAO.txt
else
    echo "❌ Erro ao criar export."
    exit 1
fi
```

**Performance:**
- Zip apenas pastas essenciais (ignora `.git`, `node_modules`, etc)
- Compressão rápida (`-1` flag para velocidade, não máxima compressão)
- Típico: 10-50MB em < 2 segundos

#### 4. Status Tranquilizador no Dashboard

**Indicador de Backup no Dashboard:**

```markdown
## 💾 Status de Backup

✅ **Seus dados estão seguros**

- 🕐 Último backup: Há 2 horas (01/10/2025 14:32)
- 📊 Total de backups: 47
- 💾 Última exportação manual: 28/09/2025
- ☁️ Push para remoto: ✅ Configurado

---

### 🔄 Próximas Ações

- [ ] Fazer export manual (recomendado mensalmente)
- [ ] Configurar repositório Git remoto privado (opcional)

---

### 🆘 Precisa Recuperar?

Execute: `bash RECUPERAR-BACKUP.sh`
```

**Performance:**
- Informações lidas de arquivos de status simples (< 10ms)
- Não faz operações Git complexas (usa cache)
- Atualizado apenas após backup (event-driven)

#### 5. Validação Automática de Integridade

**Verificação Silenciosa em Background:**

```bash
# Executado 1x/dia (cron ou task scheduler)
function verificar_integridade() {
    # 1. Verifica se .git existe
    if [ ! -d ".git" ]; then
        notificar_erro "Git não inicializado"
        return 1
    fi

    # 2. Verifica se há commits recentes (< 7 dias)
    ultimo_commit=$(git log -1 --format=%ct)
    agora=$(date +%s)
    dias_sem_commit=$(( ($agora - $ultimo_commit) / 86400 ))

    if [ $dias_sem_commit -gt 7 ]; then
        notificar_aviso "Sem backups há $dias_sem_commit dias"
    fi

    # 3. Verifica integridade do repositório Git
    git fsck --quiet
    if [ $? -ne 0 ]; then
        notificar_erro "Repositório Git corrompido"
        return 1
    fi

    # 4. Verifica arquivos críticos
    arquivos_criticos=(
        "knowledge-base/"
        "despejo/daily-dump.md"
        ".assistant-core/"
    )

    for arquivo in "${arquivos_criticos[@]}"; do
        if [ ! -e "$arquivo" ]; then
            notificar_erro "Arquivo crítico ausente: $arquivo"
            return 1
        fi
    done

    # Tudo OK
    echo "✅ Integridade verificada" > .backup-status
    date >> .backup-status
}
```

**Performance:**
- Executa 1x/dia (não impacta uso normal)
- `git fsck`: ~500ms-2s (dependendo de tamanho do repo)
- Verificação de arquivos: < 50ms
- Total: < 3s executado em background

---

## 🎯 Resumo de Otimizações de Performance

### **Story 3.1: Onboarding**
- ✅ Arquivos de exemplo pré-criados na instalação (0 latência)
- ✅ Processamento com cache de contexto (< 2s)
- ✅ Criação de arquivos em batch (1 I/O operation)

### **Story 3.2: Obsidian**
- ✅ Busca nativa do Obsidian (< 100ms)
- ✅ Índice de busca em cache
- ✅ GIFs otimizados (< 500KB, lazy loading)
- ✅ Graph view limitado a 2 níveis (performance + UX)

### **Story 3.3: Feedback Visual**
- ✅ Dashboard com atualização incremental (não recalcula tudo)
- ✅ Cache de 1 hora para estatísticas
- ✅ Geração assíncrona (máx 500ms, timeout se > 500ms)
- ✅ Dados pré-agregados em YAML cache
- ✅ Dashboard gerado em < 100ms (mesmo com 10k+ arquivos)
- ✅ Memória de agentes em cache YAML (< 10ms)
- ✅ Contexto via índice invertido (não busca em todos arquivos)
- ✅ Streak calculado 1x/dia e cacheado
- ✅ Achievements event-driven (não polling)

### **Story 3.4: Backup**
- ✅ Git commit em background (não bloqueia usuário)
- ✅ Push assíncrono para remoto (nunca bloqueia)
- ✅ Git operations: 50-200ms típico
- ✅ Export ZIP: < 2s para 10-50MB
- ✅ Verificação de integridade: 1x/dia em background

---

## 📊 Métricas de Sucesso do Epic 3

### KPIs Principais:

1. **Taxa de Adoção Completa**: 80%+ dos usuários completam checklist primeira semana
2. **Tempo até Primeiro Valor**: < 10 minutos da instalação até primeiro resultado útil
3. **Retenção Semanal**: 70%+ dos usuários voltam após 7 dias
4. **Satisfação com Busca**: 90%+ conseguem encontrar anotações antigas
5. **Zero Perda de Dados**: 0 relatos de perda de dados por falha de backup

### Métricas Secundárias:

- Tempo médio de processamento de despejo: < 3 minutos
- Uso médio de agentes por semana: 10+ conversas
- Taxa de conclusão do tour inicial: 85%+
- Frequência de exports manuais: 1x/mês mínimo

---

## 🚀 Ordem de Implementação Sugerida

**Prioridade 0 (Upgrade Path - CRÍTICO BROWNFIELD):**
0. Story 3.0: Upgrade para Usuários Existentes

**Prioridade 1 (Crítico para Adoção):**
1. Story 3.1: Onboarding Interativo
2. Story 3.2: Obsidian Simplificado

**Prioridade 2 (Retenção):**
3. Story 3.3: Feedback Visual e Progresso

**Prioridade 3 (Confiança):**
4. Story 3.4: Backup Automático Invisível

---

## 💡 Filosofia do Epic 3

**"Mostre, não explique"**
- Tutorial interativo > Manual de 50 páginas
- Exemplos práticos > Documentação técnica
- Quick wins < 5min > Features complexas

**"Funciona sem precisar entender"**
- Backup automático > "Configure seu Git remoto"
- Dashboard visual > "Execute SELECT COUNT(*) FROM..."
- Busca simples (Ctrl+O) > "Busca semântica com embeddings"

**"TDAH-First Design"**
- Feedback positivo constante
- Progresso visual claro
- Zero fricção para captura
- Reforço positivo (achievements, streaks)

---

**Status**: ⏳ Planejado
**Estimativa**: 3-4 semanas de desenvolvimento (+ Story 3.0: 2-3 dias)
**Dependências**: Epic 0, 1, 2 completos ✅
**Stories**: 5 (3.0 Upgrade + 3.1-3.4 Features)
