# 🏗️ Instalação do Agente Arquiteto no Claude Code

## Visão Geral

O **Agente Arquiteto (Marcus)** é um consultor técnico conversacional especializado em:
- ✅ Consultoria técnica com memória contextual profunda
- ✅ Análise crítica de código e arquitetura
- ✅ Questionamento construtivo baseado em histórico
- ✅ Registro e tracking de decisões técnicas
- ✅ Detecção de inconsistências arquiteturais

---

## 🚀 Instalação Automática via Deploy Script

### Opção 1: Deploy Completo (Recomendado)

```bash
# Execute o script de deploy que já inclui o Arquiteto
bash scripts/deploy-assistant.sh /caminho/destino
```

O script automaticamente:
- Copia o agente `arquiteto.md` para `.claude/commands/assistentes/agents/`
- Instala todas as 5 tasks do Arquiteto
- Configura o sistema de memória
- Valida a instalação

---

## 🔧 Instalação Manual

### Passo 1: Copiar Arquivo do Agente

```bash
cp .assistant-core/agents/arquiteto.md ~/.claude/commands/assistentes/agents/
```

### Passo 2: Copiar Tasks do Arquiteto

```bash
# Criar diretório de tasks se não existir
mkdir -p ~/.claude/commands/assistentes/tasks/

# Copiar todas as tasks
cp .assistant-core/tasks/consultoria-tecnica.md ~/.claude/commands/assistentes/tasks/
cp .assistant-core/tasks/analise-projeto.md ~/.claude/commands/assistentes/tasks/
cp .assistant-core/tasks/confronto-tecnico.md ~/.claude/commands/assistentes/tasks/
cp .assistant-core/tasks/registrar-decisao.md ~/.claude/commands/assistentes/tasks/
cp .assistant-core/tasks/historico-decisoes.md ~/.claude/commands/assistentes/tasks/
```

### Passo 3: Copiar Sistema de Memória

```bash
# Criar diretório de memória se não existir
mkdir -p .assistant-core/memory/

# Copiar arquivo de memória
cp .assistant-core/memory/arquiteto-memory.yaml .assistant-core/memory/
```

### Passo 4: Verificar Template (já deve existir)

```bash
# Verificar se template de decisão técnica existe
ls .assistant-core/templates/decisao-tecnica.yaml
```

---

## ✅ Validação da Instalação

### Teste 1: Carregar o Agente

No Claude Code, execute:

```
/arquiteto
```

**Resultado esperado:**
```
👋 Marcus aqui - Arquiteto de Software Confrontador Construtivo 🏗️

Carregando configuração...
✅ Configuração carregada

## Comandos Disponíveis

Por favor, selecione um comando pelo número:

1. *help - Mostrar lista completa de comandos
2. *analise - Review técnico crítico de código/arquitetura
3. *consultoria - Discussões técnicas aprofundadas
4. *confronto - Questionamento construtivo baseado em histórico
5. *decisao - Registrar decisão técnica
6. *historico - Visualizar evolução de decisões
7. *inconsistencias - Detectar conflitos com decisões anteriores
8. *menu - Menu completo de funcionalidades
9. *exit - Sair do modo Arquiteto
```

### Teste 2: Executar Comando de Teste

```
/arquiteto *help
```

**Resultado esperado:** Lista detalhada de todos os comandos com descrições.

### Teste 3: Verificar Memória

```bash
# Verificar que arquivo de memória existe
cat .assistant-core/memory/arquiteto-memory.yaml
```

**Deve conter:**
- `agent_identity` com personalidade Marcus
- `user_patterns` para tracking de preferências
- `interaction_history` para histórico de consultorias
- `cross_agent_context` com integração dos outros agentes

---

## 📚 Como Usar o Agente Arquiteto

### Comandos Principais

#### 1. **Consultoria Técnica** (`*consultoria`)
Discussão aprofundada sobre decisões técnicas com recuperação de contexto histórico.

```
/arquiteto *consultoria
```

**Exemplo de uso:**
```
/arquiteto *consultoria

Marcus: Sobre qual decisão técnica você quer consultoria?
Você: Estou pensando em migrar para microserviços

Marcus: [Recupera decisões anteriores sobre arquitetura]
"Vejo que em [[decisao-monolith-2023]] você optou por monolito...
Por que agora considera microserviços? O que mudou no contexto?"
```

#### 2. **Análise de Projeto** (`*analise`)
Review técnico crítico com questionamento ativo.

```
/arquiteto *analise
```

**Exemplo de uso:**
```
/arquiteto *analise

Marcus: Qual projeto/código você quer que eu analise?
Você: github.com/meu-usuario/meu-projeto

Marcus: [Analisa o código]
"Identifico padrão MVC, mas vejo God Objects em UserController...
Por que não separar responsabilidades usando CQRS?
E se o número de comandos crescer 10x?"
```

#### 3. **Confronto Técnico** (`*confronto`)
Questionamento construtivo baseado em decisões anteriores.

```
/arquiteto *confronto
```

**Exemplo de uso:**
```
/arquiteto *confronto

Marcus: Qual decisão você quer que eu confronte?
Você: Quero usar MongoDB para este projeto

Marcus: [Busca histórico]
"Em [[decisao-postgres-2024]] você migrou de MongoDB para PostgreSQL
pelo rationale: 'Necessidade de transações ACID'
Por que voltar para MongoDB agora? O contexto é diferente?"
```

#### 4. **Registrar Decisão** (`*decisao`)
Persistir decisão técnica com cross-referencing automático.

```
/arquiteto *decisao
```

**Cria arquivo estruturado em:** `knowledge-base/decisoes/decisao-{nome}.md`

#### 5. **Histórico de Decisões** (`*historico`)
Visualizar evolução de padrões ao longo do tempo.

```
/arquiteto *historico
```

**Mostra:**
- Timeline de decisões
- Padrões recorrentes
- Evolução de preferências
- Inconsistências detectadas

---

## 🤝 Integração com Outros Agentes

O Arquiteto colabora automaticamente com:

### 🧠 Mentor Agent
**Objetivo:** Alinhar desenvolvimento técnico com objetivos de carreira
- Compartilha habilidades técnicas desenvolvidas
- Sugere áreas de aprendizado baseadas em decisões técnicas

### 👩‍💼 Secretária Agent
**Objetivo:** Contexto de projetos e deadlines técnicos
- Recebe informações sobre projetos ativos
- Considera prazos ao recomendar decisões

### 🗂️ Organizador Agent
**Objetivo:** Organização de referências técnicas
- Compartilha decisões técnicas para organização
- Sincroniza contextos de projetos

---

## 🎯 Características da Personalidade Marcus

### Estilo de Comunicação
- **Confrontador Construtivo:** Questiona decisões de forma fundamentada
- **Técnico Profundo:** Conhecimento expert de padrões arquiteturais
- **Direto e Claro:** Feedback sem rodeios
- **Baseado em Histórico:** SEMPRE recupera decisões anteriores

### Padrões de Questionamento

**"Por que não X?"**
```
"Por que não usar cache distribuído que você usou em [[projeto-Y]]?"
```

**"E se Y acontecer?"**
```
"E se o volume crescer 10x como aconteceu em [[projeto-Z]]?"
```

**"Como isso se alinha?"**
```
"Como isso se alinha com sua priorização histórica de simplicidade?"
```

---

## 📊 Sistema de Memória Contextual

### O que o Arquiteto Aprende

1. **Preferências Arquiteturais**
   - Padrões técnicos preferidos
   - Tecnologias favoritas
   - Padrões evitados

2. **Decisões Recorrentes**
   - Rationales que funcionaram
   - Decisões que foram revertidas
   - Evolução de preferências

3. **Trade-offs Priorizados**
   - Performance vs Simplicidade
   - Flexibilidade vs Consistência
   - Time-to-market vs Qualidade

### Localização da Memória

**Arquivo:** `.assistant-core/memory/arquiteto-memory.yaml`

**Estrutura:**
```yaml
agent_identity:
  name: "Marcus"
  personality_traits:
    - confrontador-construtivo
    - tecnicamente-profundo

user_patterns:
  preferencias_arquiteturais: {}
  decisoes_recorrentes: {}
  tecnologias_favoritas: []

interaction_history:
  total_consultorias: 0
  total_confrontos: 0
  total_decisoes_registradas: 0
```

---

## 🗄️ Estrutura de Arquivos de Decisões

### Localização
`knowledge-base/decisoes/decisao-{nome}.md`

### Formato
```markdown
# Decisão: [Título]

**Data:** 2025-09-29
**Projeto:** [[projeto-nome]]
**Participantes:** [[pessoa-1]], [[pessoa-2]]

## Contexto
[Contexto da decisão]

## Alternativas Consideradas
1. [Alternativa 1]
2. [Alternativa 2]

## Decisão Final
[Escolha feita]

## Rationale
[Por que esta decisão?]

## Consequências
[Impactos previstos]

## Decisões Relacionadas
- [[decisao-anterior]]
```

---

## 🔍 Troubleshooting

### Problema: Agente não carrega

**Solução:**
```bash
# Verificar se arquivo existe
ls .assistant-core/agents/arquiteto.md

# Verificar permissões
chmod +r .assistant-core/agents/arquiteto.md
```

### Problema: Comandos não funcionam

**Solução:**
```bash
# Verificar se tasks existem
ls .assistant-core/tasks/consultoria-tecnica.md
ls .assistant-core/tasks/analise-projeto.md
ls .assistant-core/tasks/confronto-tecnico.md
ls .assistant-core/tasks/registrar-decisao.md
ls .assistant-core/tasks/historico-decisoes.md
```

### Problema: Memória não persiste

**Solução:**
```bash
# Verificar se diretório de memória existe
mkdir -p .assistant-core/memory/

# Verificar se arquivo de memória existe
cat .assistant-core/memory/arquiteto-memory.yaml
```

---

## 🧪 Testes de Validação

Execute o script de testes para validar instalação:

```bash
bash tests/test-story-2.3.sh
```

**Resultado esperado:** Todos os testes devem passar ✅

---

## 📖 Documentação Adicional

- **Método Conversacional:** `docs/architecture/agentes-conversacionais-guidelines.md`
- **Componentes do Sistema:** `docs/architecture/componentes.md`
- **Story 2.3:** `docs/stories/2.3.story.md`
- **Guia Rápido:** `docs/guia-rapido.md`

---

## 🆘 Suporte

Em caso de problemas:
1. Verifique os logs de erro do Claude Code
2. Execute os testes: `bash tests/test-story-2.3.sh`
3. Consulte: `docs/IMPORTANTE-LEIA-PRIMEIRO.md`
4. Revise: `docs/architecture/agentes-conversacionais-guidelines.md`

---

**✅ Instalação concluída! O Agente Arquiteto Marcus está pronto para uso.**

Use `/arquiteto` no Claude Code para começar! 🏗️