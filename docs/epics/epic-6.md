# Epic 6: Suporte ao Cursor IDE

**ID:** EPIC-6
**Título:** Suporte Completo ao Cursor IDE
**Status:** Planejado
**Prioridade:** Alta
**Versão:** 1.0.5
**Estimativa:** 16 horas

---

## Visão Geral

Estender o Assistente Pessoal IA para funcionar perfeitamente no **Cursor IDE**, mantendo compatibilidade total com **Claude Code** e oferecendo experiência otimizada em ambas as plataformas.

## Problema

Atualmente o sistema funciona apenas no Claude Code (`.claude/commands/`). Usuários do Cursor IDE (base em VS Code com grande adoção) não conseguem usar os agentes, limitando o alcance e utilidade do projeto.

## Solução

Implementar arquitetura dual-IDE que:
1. Detecta automaticamente qual IDE o usuário tem instalado
2. Instala estrutura otimizada para cada IDE
3. Mantém `.assistant-core/` como fonte única de verdade
4. Gera comandos específicos para Cursor (flat structure)
5. Preserva comandos conversacionais para Claude Code

## Objetivos de Negócio

- **Adoção:** Aumentar base de usuários em 50%+ (usuários Cursor)
- **Competitividade:** Igualar recursos de frameworks similares (BMAD)
- **Comunidade:** Atingir comunidade maior e mais ativa (Cursor vs Claude Code)
- **Feedback:** Coletar insights de diferentes perfis de usuários

## Objetivos Técnicos

- ✅ 100% das funcionalidades disponíveis em ambos IDEs
- ✅ Instalação automática detectando IDE
- ✅ Migração sem perda de dados
- ✅ Performance similar (tempo de resposta, uso de memória)
- ✅ Documentação completa para ambos IDEs

## Métricas de Sucesso

### Quantitativas
- **Instalações:** 50%+ dos novos usuários escolhem Cursor
- **Downloads NPM:** Aumento de 30%+ na primeira semana
- **Issues:** Zero issues críticos de compatibilidade Cursor
- **Performance:** Tempo de instalação < 5 minutos

### Qualitativas
- **Feedback:** Avaliação positiva (4.5+/5) em ambos IDEs
- **Documentação:** 90%+ usuários conseguem instalar sem ajuda
- **Comunidade:** Primeiras contribuições de usuários Cursor
- **Artigos:** 2+ tutoriais da comunidade sobre uso no Cursor

---

## Stories

### Story 6.1: Templates e Gerador de Comandos Cursor
**Estimativa:** 4h
**Prioridade:** Alta
- Criar template de comando base para Cursor
- Criar template de comando específico (task direta)
- Implementar gerador automático de comandos
- Criar `.cursor/rules/assistente-core.md`

### Story 6.2: Instalador Dual-IDE
**Estimativa:** 4h
**Prioridade:** Alta
- Implementar detecção automática de IDEs instalados
- Adicionar pergunta "Para qual IDE instalar?" no setup
- Modificar `installSelectedAgents()` para suportar ambos
- Criar função `installForCursor()`
- Criar função `installForClaudeCode()`

### Story 6.3: Geração de Comandos Cursor
**Estimativa:** 3h
**Prioridade:** Alta
- Gerar comandos base para 5 agentes
- Gerar comandos específicos (15-20 comandos)
- Validar sintaxe Markdown
- Testar referências a tasks

### Story 6.4: Testes E2E
**Estimativa:** 3h
**Prioridade:** Média
- Criar suite de testes para Cursor
- Testar cada agente no Cursor
- Testar comandos específicos
- Validar migração de v1.0.4 → v1.0.5

### Story 6.5: Documentação e Marketing
**Estimativa:** 2h
**Prioridade:** Média
- Criar guia "Usando no Cursor"
- Atualizar README com seção Cursor
- Criar comparativo Claude Code vs Cursor
- Atualizar material de marketing
- Adicionar screenshots do Cursor

---

## Histórias de Usuário

### Como desenvolvedor que usa Cursor
**Quero** instalar o Assistente Pessoal IA no meu IDE
**Para** usar os agentes sem mudar para Claude Code

**Critérios de Aceitação:**
- [ ] Instalação detecta Cursor automaticamente
- [ ] Comandos aparecem no menu `/` do Cursor
- [ ] `/organizador` carrega agente Sofia
- [ ] Agente entende comandos em português
- [ ] Tasks são executadas corretamente

### Como usuário do Claude Code
**Quero** continuar usando meus agentes normalmente
**Para** não ser impactado pela nova funcionalidade Cursor

**Critérios de Aceitação:**
- [ ] Estrutura `.claude/commands/assistentes/` mantida
- [ ] Menu `*help` continua funcionando
- [ ] Subcomandos `*processar`, `*organizar` funcionam
- [ ] Migração de v1.0.4 é transparente
- [ ] Zero breaking changes

### Como usuário que usa ambos IDEs
**Quero** ter os agentes em ambos IDEs simultaneamente
**Para** escolher qual usar dependendo do contexto

**Critérios de Aceitação:**
- [ ] Instalador permite selecionar "Ambos"
- [ ] Estruturas `.claude/` e `.cursor/` coexistem
- [ ] Knowledge base é compartilhada
- [ ] Configuração é sincronizada
- [ ] Sem duplicação de dados pessoais

---

## Arquitetura

Ver: [Cursor Support Architecture](../architecture/cursor-support-architecture.md)

### Estrutura de Pastas

```
projeto-usuario/
├── .claude/commands/assistentes/    # Claude Code
│   ├── agents/
│   └── tasks/
├── .cursor/commands/                # Cursor
│   ├── organizador.md
│   ├── organizador-processar.md
│   └── ...
├── .cursor/rules/
│   └── assistente-core.md
└── .assistant-core/                 # Compartilhado
    ├── agents/
    └── tasks/
```

---

## Dependências

### Técnicas
- Node.js 14+ (já requerido)
- NPM package `inquirer` (já instalado)
- Cursor IDE 1.6+ (usuário)
- Claude Code (opcional, usuário)

### Stories
- Epic 5 completo (estrutura `.assistant-core/`)
- v1.0.4 publicado e estável

---

## Riscos e Mitigações

### Risco 1: Cursor muda estrutura de comandos
**Impacto:** Alto
**Probabilidade:** Baixa
**Mitigação:**
- Monitorar changelog do Cursor
- Testes automatizados
- Documentação de fallback

### Risco 2: Experiência inferior no Cursor
**Impacto:** Médio
**Probabilidade:** Média
**Mitigação:**
- Testes extensivos com usuários reais
- Iteração baseada em feedback
- Documentação clara de diferenças

### Risco 3: Duplicação de manutenção
**Impacto:** Médio
**Probabilidade:** Alta
**Mitigação:**
- `.assistant-core/` como fonte única
- Geração automática de comandos
- CI/CD validando ambas estruturas

### Risco 4: Breaking changes para v1.0.4
**Impacto:** Alto
**Probabilidade:** Baixa
**Mitigação:**
- Migração automática
- Backward compatibility
- Documentação de migração

---

## Fases de Rollout

### Fase 1: Alpha (Interno)
**Duração:** 2 dias
**Participantes:** Time core
- Instalar em 3 projetos teste
- Validar ambos IDEs funcionando
- Identificar bugs críticos

### Fase 2: Beta (Comunidade)
**Duração:** 1 semana
**Participantes:** Early adopters (via GitHub issue)
- Release v1.0.5-beta
- Coletar feedback
- Iterar em bugs e UX

### Fase 3: GA (Geral)
**Duração:** -
**Participantes:** Todos
- Release v1.0.5
- Publicar no NPM
- Anunciar no LinkedIn
- Criar tutorial em vídeo

---

## Critérios de Conclusão

### Must Have (Bloqueia release)
- [ ] Instalação funciona em ambos IDEs
- [ ] 5 agentes funcionando no Cursor
- [ ] Tasks acessíveis de ambos IDEs
- [ ] Documentação completa
- [ ] Zero bugs críticos

### Should Have (Importante mas não bloqueia)
- [ ] 15+ comandos específicos Cursor
- [ ] Migração automática testada
- [ ] Screenshots na documentação
- [ ] Vídeo demo no README

### Could Have (Nice to have)
- [ ] Comparativo performance Claude vs Cursor
- [ ] Templates de contribuição Cursor
- [ ] Sugestões de comandos customizados

---

## Cronograma Sugerido

```
Semana 1:
├── Seg-Ter: Story 6.1 (Templates e Gerador)
├── Qua-Qui: Story 6.2 (Instalador Dual-IDE)
└── Sex: Story 6.3 (Geração de Comandos)

Semana 2:
├── Seg-Ter: Story 6.4 (Testes E2E)
├── Qua: Story 6.5 (Documentação)
├── Qui: Alpha testing
└── Sex: Release beta
```

---

## Recursos

### Documentação
- [Cursor Docs - Custom Commands](https://docs.cursor.com/context/rules)
- [Claude Code Docs - Slash Commands](https://docs.claude.com/en/docs/claude-code/slash-commands)

### Exemplos
- [BMAD Framework](https://github.com/bmad-io/bmad)
- [Cursor Commands Examples](https://github.com/hamzafer/cursor-commands)

### Ferramentas
- Cursor IDE 1.6+
- Claude Code latest
- Node.js 14+
- Git

---

## Notas

### Decisões Importantes

1. **Dual Structure vs Single Structure**
   **Decisão:** Dual (`.claude/` + `.cursor/`)
   **Razão:** Otimizar experiência em cada IDE
   **Trade-off:** Duplicação de arquivos vs UX superior

2. **Comandos Específicos vs Só Conversacional**
   **Decisão:** Ambos (base + específicos)
   **Razão:** Flexibilidade para diferentes workflows
   **Trade-off:** Mais comandos vs mais opções

3. **Migração Automática vs Manual**
   **Decisão:** Automática
   **Razão:** Reduzir fricção de upgrade
   **Trade-off:** Complexidade vs facilidade

### Lições Aprendidas (a preencher pós-implementação)

- [ ] O que funcionou bem?
- [ ] O que foi mais difícil que esperado?
- [ ] Feedback dos usuários Cursor?
- [ ] Performance comparada?

---

**Criado:** 2025-10-03
**Atualizado:** 2025-10-03
**Responsável:** Time Core
**Revisores:** Sarah (PO), Winston (Arquiteto)
