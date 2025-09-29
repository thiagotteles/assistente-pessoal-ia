# Diretrizes de Implementação - Método de Agentes Conversacionais

## ⚠️ CRÍTICO: Como Implementar Corretamente Agentes Conversacionais

Este documento previne confusões sobre como implementar agentes no sistema conversacional. **LEIA ANTES DE DESENVOLVER QUALQUER AGENTE.**

## 🚫 O Que NÃO É o Método Conversacional

### ❌ Implementações INCORRETAS:
- **Scripts Python tradicionais** (como `.py` files com classes e funções)
- **Código procedural** que executa tarefas automaticamente
- **APIs REST** ou endpoints HTTP
- **Funções JavaScript** ou qualquer linguagem de programação tradicional
- **Bibliotecas de código** que são importadas e executadas
- **Automação sem interação humana**

### ❌ Exemplos do que NÃO fazer:
```python
# ERRADO - Este não é o método conversacional
class AgentOrganizador:
    def processar_despejo(self):
        # código automático
        pass
```

```javascript
// ERRADO - Este não é o método conversacional
function processarDespejo() {
    // lógica automatizada
}
```

## ✅ O Que É o Método Conversacional

### ✅ Implementações CORRETAS:

**O método conversacional é baseado em agentes com personalidades que interagem naturalmente através de Claude Code.**

#### 1. **Agentes são Personalidades de IA**
- Cada agente tem nome, personalidade e estilo de comunicação
- Agentes "habitam" personas específicas durante conversação
- Comunicação é natural, não chamadas de função

#### 2. **Workflows são Conversações Estruturadas**
- Tasks são conversações guiadas, não scripts
- Elicitação interativa quando necessário
- Sempre mantém contexto humano

#### 3. **Sistema Funciona Via Claude Code**
- Agentes são ativados via `/agente` ou `@agente`
- Interação é conversacional e contextual
- Zero código tradicional executado

## 📋 Estrutura Correta de um Agente Conversacional

### Arquivo do Agente: `.assistant-core/agents/[nome].md`

```yaml
# Exemplo correto de agente conversacional
agent:
  name: Sofia
  id: organizador
  title: Agente Organizador Especialista em TDAH
  icon: 🗂️
  whenToUse: 'Use para processamento inteligente de daily-dump.txt'

persona:
  role: Organizadora de Informações Pessoais
  style: Empática, eficiente, estruturada
  identity: Especialista que transforma despejos mentais em informação organizada
  focus: Processar sem esforço mental do usuário

commands:
  - help: Show numbered list of commands
  - processar: Execute task processar-despejo.md
  - organizar: Execute task organizar-por-projeto.md
```

### Tasks são Workflows Conversacionais: `.assistant-core/tasks/[nome].md`

```markdown
# Task: Processar Despejo

## Configuração
```yaml
elicit: true
max_questions_per_entry: 3
language: portuguese
interaction_style: empathetic
```

## Workflow

### Etapa 1: Verificação Empática
1. Verificar daily-dump.txt
2. Carregar memória pessoal
3. Adaptar abordagem ao usuário

### Etapa 2: Elicitação Conversacional
Fazer perguntas naturais em português:
- "Percebo que você menciona [X]. Como está se sentindo sobre isso?"
- "Essa situação é realmente urgente ou podemos respirar um pouco?"
```

### Memória é YAML Conversacional: `.assistant-core/memory/[agente]-memory.yaml`

```yaml
# Memória evolui através das conversações
agent_identity:
  name: "Sofia"
  personality_traits:
    - empática
    - estruturada

user_patterns:
  # Aprende através das interações
  frequent_people: {}
  tdah_indicators:
    stress_words: []
```

## 🤝 Como Agentes Interagem

### ✅ Comunicação Correta entre Agentes:
- Agentes se comunicam através de **conversação natural**
- Compartilham insights via **linguagem natural**
- Usam **memória conversacional** para colaborar

### ❌ Comunicação INCORRETA:
- Chamadas de função entre agentes
- APIs ou interfaces programáticas
- Troca de dados via JSON/XML

## 🎯 Exemplos Práticos de Uso

### ✅ Como Usar Agente Conversacional:
```
Usuário: "/organizador *processar"
Sofia: "Oi! Vou analisar seu daily-dump.txt.
       Vi que você mencionou estar cansado.
       Quer que eu processe isso de um jeito mais leve hoje?"
```

### ❌ Uso Incorreto:
```python
# ERRADO - não é conversacional
organizador.processar_despejo(arquivo="daily-dump.txt")
```

## 📚 Integração com Sistemas Existentes

### ✅ Como Integrar Corretamente:
- Agentes **conversam** com Knowledge-Base Manager
- Workflows **descrevem** como usar ferramentas existentes
- Templates **estruturam** outputs de forma natural

### ❌ Integração Incorreta:
- Importar classes Python
- Chamar métodos diretamente
- Automatizar sem contexto conversacional

## 🧠 Princípios Fundamentais

1. **Conversação Natural**: Tudo é conversação, não código
2. **Personalidades Consistentes**: Agentes mantêm personas específicas
3. **Interação Humana**: Sempre considerar contexto e bem-estar do usuário
4. **Workflows Estruturados**: Tasks guiam conversação, não executam código
5. **Memória Adaptativa**: Aprendizado através de interação, não machine learning

## 🔍 Como Identificar Implementação Correta

### ✅ Sinais de Implementação Conversacional Correta:
- Arquivos `.md` com definições de agentes
- Tasks que descrevem conversações estruturadas
- Linguagem natural em português (quando aplicável)
- Elicitação interativa quando necessário
- Memória YAML que evolui conversacionalmente

### ❌ Sinais de Implementação Incorreta:
- Arquivos `.py`, `.js`, `.ts` para lógica de agentes
- Funções que executam automaticamente
- Código que processa sem interação
- APIs ou endpoints para comunicação
- Lógica programática tradicional

## 📖 Documentação de Referência

- **Exemplos de Agentes**: `.assistant-core/agents/`
- **Tasks de Referência**: `.assistant-core/tasks/`
- **Templates**: `.assistant-core/templates/`

## 🎉 Conclusão

**O método conversacional é sobre agentes inteligentes que conversam naturalmente, não automação tradicional.**

Quando implementar um agente:
1. ✅ Crie uma personalidade conversacional
2. ✅ Defina workflows como conversações estruturadas
3. ✅ Use elicitação quando necessário
4. ✅ Mantenha contexto humano sempre
5. ❌ NUNCA escreva código Python/JavaScript para lógica do agente

---

*Este documento previne confusões futuras na implementação do método conversacional*