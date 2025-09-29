# História [NÚMERO]: [TÍTULO]

## Status
[Aprovada/Em Progresso/Concluída]

## História
**Como um** [tipo de usuário],
**Eu quero** [funcionalidade/comportamento],
**Para que** [valor/benefício].

## ⚠️ SEÇÃO OBRIGATÓRIA: Implementação de Agentes Conversacionais

### Tipo de Implementação
- [ ] **Agente Conversacional**: Esta história requer um agente com personalidade definida
- [ ] **Workflow Conversacional**: Esta história requer tasks executáveis via elicitação
- [ ] **Sistema Tradicional**: Esta história não envolve agentes (APIs, bibliotecas, etc.)

### Especificação de Agentes Conversacionais (Se aplicável)
> **CRÍTICO**: Se marcou "Agente Conversacional" ou "Workflow Conversacional", complete esta seção

#### Agente(s) Envolvido(s)
- **Nome**: [Nome do agente com personalidade humana]
- **Personalidade**: [Empático/Técnico/Estruturado/etc.]
- **Especialização**: [Área de foco específica]
- **Idioma**: [Português/Inglês/Multilíngue]

#### Comunicação Requerida
- **Estilo**: [Natural/Formal/Casual/Técnico]
- **Elicitação**: [Sim/Não] - Requer perguntas interativas ao usuário?
- **Contexto**: [Emocional/Técnico/Organizacional/etc.]

#### Workflows Conversacionais
- [ ] **[Nome do workflow]**: [Descrição da conversação estruturada]
- [ ] **[Nome do workflow]**: [Descrição da conversação estruturada]

#### ❌ O Que NÃO Implementar
- [ ] Scripts Python para lógica de agente
- [ ] Código procedural automatizado
- [ ] APIs REST ou endpoints HTTP
- [ ] Funções JavaScript/TypeScript para agente
- [ ] Bibliotecas de código importáveis

#### ✅ O Que Implementar
- [ ] Arquivo de definição do agente (.md com YAML)
- [ ] Workflows como conversações estruturadas
- [ ] Templates YAML para estruturação de dados
- [ ] Memória conversacional adaptativa
- [ ] Comunicação natural no idioma especificado

### Validação do Método Conversacional
> **PO deve validar**: Esta história seguirá o método conversacional conforme especificado acima?
- [ ] **Sim** - História aprovada para implementação conversacional
- [ ] **Não** - História precisa de revisão ou é sistema tradicional

## Critérios de Aceitação

1. [Critério específico e testável]
2. [Critério específico e testável]
3. [Critério específico e testável]

### Critérios Conversacionais Específicos (Se aplicável)
> **Adicionar apenas se esta história envolve agentes conversacionais**

- [ ] **Personalidade Consistente**: Agente mantém personalidade definida durante toda interação
- [ ] **Comunicação Natural**: Todas as interações são conversacionais, não programáticas
- [ ] **Elicitação Funcional**: Se requerido, sistema de perguntas funciona corretamente
- [ ] **Memória Adaptativa**: Agente aprende e adapta baseado em interações anteriores
- [ ] **Templates Estruturados**: Outputs seguem templates YAML definidos
- [ ] **Integração Conversacional**: Integração com outros sistemas via workflows conversacionais

## Tarefas / Subtarefas

### Implementação Conversacional (Se aplicável)
- [ ] **Tarefa 1: Definir Agente**
  - [ ] Criar arquivo .assistant-core/agents/[nome].md
  - [ ] Definir personalidade e comandos conversacionais
  - [ ] Especificar dependencies e capabilities
  - [ ] Implementar activation-instructions

- [ ] **Tarefa 2: Criar Workflows Conversacionais**
  - [ ] Implementar tasks em .assistant-core/tasks/
  - [ ] Configurar elicitação se necessário
  - [ ] Definir estrutura conversacional
  - [ ] Integrar com sistemas existentes via conversação

- [ ] **Tarefa 3: Sistema de Memória**
  - [ ] Criar .assistant-core/memory/[agente]-memory.yaml
  - [ ] Implementar tracking de padrões
  - [ ] Configurar aprendizado adaptativo
  - [ ] Definir personalização conversacional

- [ ] **Tarefa 4: Templates e Estruturação**
  - [ ] Criar templates YAML em .assistant-core/templates/
  - [ ] Definir estruturas de dados conversacionais
  - [ ] Implementar formatação automática
  - [ ] Validar consistência de output

### Implementação Tradicional (Se aplicável)
- [ ] **Tarefa 1**: [Descrição da tarefa técnica]
- [ ] **Tarefa 2**: [Descrição da tarefa técnica]

## Notas para Desenvolvimento

### ⚠️ CRÍTICO: Leitura Obrigatória ANTES da Implementação
**TODOS os desenvolvedores DEVEM ler estes arquivos antes de implementar:**
- `docs/IMPORTANTE-LEIA-PRIMEIRO.md` - **AVISO ANTI-BMAD**
- `docs/architecture/agentes-conversacionais-guidelines.md` - **DIRETRIZES TÉCNICAS**

### 🚨 AVISO: NÃO USE REFERÊNCIAS AO "BMAD"
**BMAD™ era apenas um exemplo e foi REMOVIDO do projeto.**
- ❌ NÃO use "BMAD™", "bmad-core", "bmad-method"
- ✅ USE apenas "Método Conversacional" ou "Agentes Conversacionais"

### Contexto das Histórias Anteriores
[Referências a histórias relacionadas e dependências]

### Integração com Sistemas Existentes
[Detalhes de como integrar com arquitetura existente]

### Stack Tecnológico
[Tecnologias e ferramentas específicas a utilizar]

### Padrões de Codificação
[Convenções específicas do projeto]

## Testing

### Padrões de Teste Conversacionais (Se aplicável)
- [ ] **Teste de Agente**: Validar existência e estrutura do agente
- [ ] **Teste de Personalidade**: Verificar consistência conversacional
- [ ] **Teste de Workflows**: Validar execução de tasks conversacionais
- [ ] **Teste de Memória**: Verificar adaptação e aprendizado
- [ ] **Teste Anti-Python**: Confirmar ausência de scripts para lógica de agente
- [ ] **Teste de Idioma**: Validar comunicação no idioma especificado

### Padrões de Teste Tradicionais (Se aplicável)
- [ ] **Testes Unitários**: [Especificações de testes]
- [ ] **Testes de Integração**: [Especificações de testes]

### Localização dos Testes
Seguir padrão de testes em `test-story-[NÚMERO].sh` no diretório raiz do projeto.

## Log de Mudanças
| Data | Versão | Descrição | Autor |
|------|---------|-----------|-------|
| [DATA] | 1.0 | História criada | [AUTOR] |

## Registro do Agente de Desenvolvimento

### Modelo de Agente Usado
*A ser preenchido pelo agente de desenvolvimento*

### Referências de Log de Debug
*A ser preenchido pelo agente de desenvolvimento*

### Lista de Notas de Conclusão
*A ser preenchida pelo agente de desenvolvimento*

## Resultados do QA
*Resultados da revisão do Agente de QA serão adicionados aqui*

---

## 📚 Recursos de Referência

### Documentação do Método Conversacional
- `docs/architecture/agentes-conversacionais-guidelines.md` - **LEITURA OBRIGATÓRIA**
- `.assistant-core/agents/` - Exemplos de agentes existentes
- `.assistant-core/tasks/` - Exemplos de workflows conversacionais

### Templates Disponíveis
- `.assistant-core/templates/` - Templates YAML para estruturação

### Ferramentas de Validação
- `test-story-[NÚMERO].sh` - Script de teste específico da história
- `bash test-story-[NÚMERO].sh` - Comando para executar validação

---

**⚡ LEMBRETE CRÍTICO**: Se esta história envolve agentes conversacionais, ela DEVE seguir o método conversacional. Consulte `docs/architecture/agentes-conversacionais-guidelines.md` para implementação correta.