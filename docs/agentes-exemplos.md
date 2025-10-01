# Exemplos Práticos dos Agentes - Assistente Pessoal IA

**Versão**: 1.0
**Data**: 2025-09-26

---

## 🎯 Visão Geral

Este documento contém exemplos práticos reais de como usar cada um dos 5 agentes especializados do sistema. Cada exemplo mostra entrada, processamento e saída esperada.

## 📋 Índice

1. [/organizador - Organizador Inteligente](#organizador---organizador-inteligente)
2. [/secretaria - Assistente Executiva](#secretaria---assistente-executiva)
3. [/arquiteto - Arquiteto de Soluções](#arquiteto---arquiteto-de-soluções)
4. [/psicologo - Psicólogo de Suporte TDAH](#psicologo---psicólogo-de-suporte-tdah)
5. [/mentor - Mentor de Carreira](#mentor---mentor-de-carreira)
6. [Workflows Combinados](#workflows-combinados)

---

## 🗂️ /organizador - Organizador Inteligente

**Personalidade**: Confrontador construtivo, questiona decisões, força categorização específica

### Exemplo 1: Processamento de Despejo Diário

**Entrada:**
```
despejo/daily-dump.md:

reunião projeto mobile app terça 14h com maria
comprar café e açúcar
lembrar de responder email do cliente X sobre proposta
ideia: sistema de backup automático para clientes
joão mandou documentos do projeto Y por whatsapp
ansioso com deadline sexta-feira projeto Z
preciso estudar react native para projeto mobile
fazer exercício - academia ou corrida
ligar para dentista marcar consulta
```

**Comando:**
```bash
/organizador despejo/daily-dump.md
```

**Saída Esperada:**
```markdown
# Processamento Completo do Despejo - 26/09/2025

## ⚠️ Perguntas de Confronto Construtivo

Antes de categorizar, preciso confrontar algumas coisas:

1. **Reunião com Maria** - Você tem agenda preparada? Objetivos claros? Ou vai improvisar de novo?
2. **Email do Cliente X** - Há quanto tempo está pendente? Por que não respondeu ainda?
3. **Projeto Z** - O que especificamente causa ansiedade? Prazo, complexidade ou falta de planejamento?
4. **React Native** - Estudo genérico ou tem lista específica do que precisa aprender?

## 📊 Categorização Forçada

### 🔥 URGENTE - Necessário ação hoje
- **Responder email Cliente X** → `knowledge-base/pessoas/cliente-x.md`
- **Definir agenda reunião Maria** → `knowledge-base/projetos/mobile-app.md`
- **Revisar documentos João (Projeto Y)** → `knowledge-base/projetos/projeto-y.md`

### 📅 AGENDADO - Data específica
- **Reunião mobile app** (Terça 14h) → `todos/por-projeto/mobile-app.md`
- **Deadline Projeto Z** (Sexta) → Quebrar em tarefas diárias

### 💡 IDEIAS/PROJETOS FUTUROS
- **Sistema backup automático** → `knowledge-base/projetos/sistema-backup-clientes.md`

### 🏠 PESSOAL
- **Compras**: café, açúcar → Lista de compras
- **Saúde**: dentista, exercício → `todos/por-pessoa/autocuidado.md`

### 📚 DESENVOLVIMENTO
- **React Native** → Criar plano de estudos específico

## 🎯 Ações Obrigatórias - AGORA

1. **Defina 3 objetivos** para reunião com Maria
2. **Responda email Cliente X** nos próximos 30 minutos
3. **Quebre Projeto Z** em tarefas de 2 horas cada
4. **Agende dentista** agora (2 minutos no telefone)

## 📝 Arquivos Criados/Atualizados

- `knowledge-base/pessoas/maria.md` - Perfil e histórico de reuniões
- `knowledge-base/pessoas/cliente-x.md` - Proposta e comunicações
- `knowledge-base/projetos/mobile-app.md` - Projeto, reuniões, decisões
- `knowledge-base/projetos/projeto-y.md` - Documentos do João
- `knowledge-base/projetos/projeto-z.md` - Deadline e status
- `todos/por-projeto/mobile-app.md` - Tarefas específicas
- `todos/por-pessoa/autocuidado.md` - Saúde e bem-estar

## 🔗 Referências Criadas

Automaticamente vinculei:
- [[Maria]] ↔ [[Mobile App]]
- [[Cliente X]] ↔ [[Proposta Pendente]]
- [[João]] ↔ [[Projeto Y]]
- [[Projeto Z]] ↔ [[Deadline Sexta]]

**Próximo passo**: Use `/secretaria` para status detalhado dos projetos.
```

### Exemplo 2: Organização de Projeto Complexo

**Entrada:**
```bash
/organizador "tenho um projeto de e-commerce mas as informações estão espalhadas: alguns requirements no email, mockups no figma, conversas no slack, código no github, banco de dados ainda não definido, equipe não sabe direito o que fazer"
```

**Saída Esperada:**
```markdown
# Confronto: Projeto E-commerce Caótico

## 🚨 Realidade Check

Você tem um **PROJETO SEM PROJETO**. Informações espalhadas não é gestão, é caos organizado.

**Perguntas confrontadoras:**
1. Quem é o dono real deste projeto? Você ou a bagunça?
2. Como você espera que a equipe execute algo que nem você tem organizado?
3. Quantas horas já foram perdidas procurando informações?

## 📋 Plano de Organização FORÇADA

### Fase 1: Centralização Imediata (2 horas)
1. **Criar arquivo mestre** `knowledge-base/projetos/ecommerce-projeto.md`
2. **Copiar TODOS requirements** dos emails para o arquivo
3. **Linkar mockups Figma** com descrição de cada tela
4. **Exportar decisões importantes** do Slack
5. **Documentar estrutura atual** do GitHub

### Fase 2: Definição Técnica (1 dia)
1. **Definir arquitetura banco** - Pare de procrastinar isso
2. **Criar documento técnico** detalhado
3. **Definir tecnologias** finais (sem mudanças depois)

### Fase 3: Comunicação com Equipe (Hoje!)
1. **Reunião emergencial** para alinhar todos
2. **Compartilhar documentação** centralizada
3. **Definir responsabilidades** claras

## 📂 Estrutura Obrigatória

```
knowledge-base/projetos/ecommerce/
├── 00-visao-geral.md           # Overview do projeto
├── 01-requirements.md          # Todos requirements consolidados
├── 02-arquitetura-tecnica.md   # Banco, APIs, tecnologias
├── 03-design-mockups.md        # Links Figma + descrições
├── 04-decisoes-tecnicas.md     # Histórico de decisões
├── 05-equipe-responsabilidades.md # Quem faz o quê
└── 06-timeline-milestones.md   # Prazos realistas
```

## ⚡ Ação Imediata (Próximas 3 horas)

1. **Pare tudo** o que está fazendo
2. **Crie arquivo mestre** agora
3. **Consolide informações** dos emails (30 min)
4. **Exporte decisões** do Slack (30 min)
5. **Chame reunião equipe** para amanhã

## 🎯 Próximos Comandos Recomendados

- `/arquiteto "definir arquitetura banco ecommerce com [requirements]"`
- `/secretaria "criar timeline realista projeto ecommerce"`
- `/mentor "como liderar equipe em projeto desorganizado"`

**Confronto final**: Ou você organiza isso HOJE ou aceita que o projeto vai falhar por desorganização. Escolha.
```

---

## 📋 /secretaria - Assistente Executiva

**Personalidade**: Profissional, detalhista, orientada a resultados, excelente comunicadora

### Exemplo 1: Status de Múltiplos Projetos

**Entrada:**
```bash
/secretaria "preciso do status completo de todos os projetos para reunião com CEO amanhã às 9h"
```

**Saída Esperada:**
```markdown
# Relatório Executivo - Status de Projetos
**Data**: 26/09/2025
**Preparado para**: Reunião CEO (27/09 - 09:00)
**Preparado por**: Assistente Executiva

---

## 📊 Resumo Executivo (Para CEO)

| Projeto | Status | % Concluído | Risco | Próximo Milestone |
|---------|--------|-------------|-------|-------------------|
| Mobile App | 🟡 Em Andamento | 75% | Baixo | Beta 15/10 |
| E-commerce | 🔴 Atrasado | 45% | Alto | Review 30/09 |
| Sistema Backup | 🟢 No Prazo | 90% | Baixo | Deploy 05/10 |

## 🎯 Pontos Críticos para Discussão

### 1. E-commerce (ATENÇÃO NECESSÁRIA)
- **Problema**: Arquitetura do banco ainda não definida
- **Impacto**: Atraso de 2 semanas no desenvolvimento
- **Ação**: Decisão técnica urgente necessária
- **Responsável**: Arquiteto de Sistemas + Product Owner

### 2. Mobile App (ACOMPANHAR DE PERTO)
- **Status**: Desenvolvimento backend 80% concluído
- **Próximos 7 dias**: Integração com APIs externas
- **Risco identificado**: Dependência de API terceiros
- **Mitigação**: Fallback manual já desenvolvido

### 3. Sistema Backup (SUCESSO)
- **Destaque**: Projeto model para outros
- **Entrega**: Antecipada em 1 semana
- **Feedback cliente**: Excelente

---

## 📅 Agenda Sugerida para Reunião (30 min)

### Primeiros 10 minutos
- ✅ Sucessos: Sistema Backup entregue
- ✅ Progresso: Mobile App on track

### Próximos 15 minutos
- 🔴 **Decisão necessária**: E-commerce - aprovar arquiteto sênior?
- 🟡 **Acompanhamento**: Mobile App - risco API terceiros

### Últimos 5 minutos
- 📈 **Métricas gerais**: 3 projetos, 70% média conclusão
- 🎯 **Próximos 30 dias**: 2 entregas programadas

---

## 📋 Documentos de Apoio Preparados

1. **Detalhamento técnico E-commerce** (`projetos/ecommerce-detalhes.md`)
2. **Timeline Mobile App** (Gantt chart disponível)
3. **Métricas de produtividade** (Último trimestre)
4. **Budget atual vs planejado** (Planilha atualizada)

---

## 🎯 Ações Pós-Reunião Planejadas

### Se aprovada contratação arquiteto:
- [ ] Iniciar processo seleção (até 29/09)
- [ ] Agendar entrevistas (semana 30/09-04/10)
- [ ] Onboarding novo membro (até 07/10)

### Se não aprovada:
- [ ] Replanejar timeline E-commerce (+3 semanas)
- [ ] Realocar recursos internos
- [ ] Comunicar nova data aos stakeholders

---

## 📞 Contatos Importantes

- **Arquiteto de Sistemas**: (11) 99999-9999
- **Product Owner E-commerce**: maria@empresa.com
- **Lead Mobile**: joao@empresa.com

---

**✅ Reunião preparada e documentada. CEO tem todas as informações necessárias para decisões estratégicas.**

**Próximos comandos sugeridos pós-reunião:**
- `/organizador "processar decisões da reunião CEO"`
- `/arquiteto "implementar decisões técnicas aprovadas"`
```

### Exemplo 2: Preparação de Reunião Complexa

**Entrada:**
```bash
/secretaria "reunião estratégica na quinta com 5 stakeholders diferentes para definir roadmap 2025, preciso preparar tudo"
```

**Saída Esperada:**
```markdown
# Preparação Reunião Estratégica - Roadmap 2025
**Data da Reunião**: Quinta-feira, 28/09/2025
**Duração**: 2 horas (14:00-16:00)
**Participantes**: 5 stakeholders + você

---

## 👥 Análise de Stakeholders

| Nome | Cargo | Interesse Principal | Estilo Comunicação | Preparação Específica |
|------|-------|--------------------|--------------------|----------------------|
| João Silva | CTO | Viabilidade técnica | Dados, gráficos | Métricas performance |
| Maria Santos | CFO | ROI, investimentos | Números, budget | Análise financeira |
| Pedro Costa | CMO | Market fit, crescimento | Histórias, cases | Dados de mercado |
| Ana Oliveira | CPO | User experience | Protótipos, feedback | Research usuários |
| Carlos Lima | CEO | Visão estratégica | Big picture | Cenários futuro |

---

## 📋 Agenda Estruturada (120 minutos)

### 🎯 Abertura (15 min) - CEO lidera
- **Contexto**: Onde estamos vs onde queremos chegar
- **Objetivo**: Definir roadmap alinhado com estratégia
- **Regras**: Decisões baseadas em dados, não opiniões

### 📊 Situação Atual (30 min) - Você apresenta
- **Métricas chave**: Performance atual produtos
- **Feedback usuários**: Research da Ana (5 min)
- **Capacidade técnica**: Análise do João (10 min)
- **Performance financeira**: Overview Maria (5 min)
- **Market position**: Update Pedro (10 min)

### 🎯 Visão 2025 (45 min) - Discussão facilitada
- **Cenários possíveis**: 3 opções preparadas
- **Trade-offs**: Recursos vs ambição vs prazo
- **Priorização**: Framework RICE aplicado
- **Votação**: Stakeholders ranqueiam iniciativas

### ⚡ Decisões e Próximos Passos (30 min)
- **Roadmap final**: Top 5 iniciativas 2025
- **Budget aprovação**: Números do Maria
- **Timeline**: Milestones por trimestre
- **Responsabilidades**: DRIs (Directly Responsible Individuals)

---

## 📂 Materiais Preparados

### 1. Apresentação Master (45 slides)
- **Slides 1-10**: Situação atual com métricas
- **Slides 11-25**: Análise competitiva e mercado
- **Slides 26-35**: 3 cenários possíveis para 2025
- **Slides 36-45**: Framework priorização + template decisão

### 2. Documentos de Apoio
- **Planilha financeira**: 3 anos projetados (Maria)
- **Research report**: UX findings 2024 (Ana)
- **Tech assessment**: Capacidade vs demanda (João)
- **Market analysis**: Competitors + opportunities (Pedro)

### 3. Templates para Decisão
- **Priorization matrix**: Iniciativas ranqueadas
- **Resource allocation**: People + budget por projeto
- **Timeline visual**: Gantt 2025 editável
- **Success metrics**: KPIs por iniciativa

---

## 🎯 Preparação Individual por Stakeholder

### Para João (CTO)
**Envie hoje**: Technical feasibility assessment por iniciativa
**Pergunte**: "Que limitações técnicas precisamos considerar?"
**Prepare**: Métricas current performance + capacity planning

### Para Maria (CFO)
**Envie hoje**: ROI estimado por cenário
**Pergunte**: "Budget available para novas iniciativas?"
**Prepare**: Cost-benefit analysis detalhado

### Para Pedro (CMO)
**Envie hoje**: Market opportunity analysis
**Pergunte**: "Como validamos market-fit das iniciativas?"
**Prepare**: Competitive landscape + TAM/SAM

### Para Ana (CPO)
**Envie hoje**: User journey maps + pain points
**Pergunte**: "Que funcionalidades usuários mais pedem?"
**Prepare**: Prototype conceitos principais

### Para Carlos (CEO)
**Envie hoje**: Executive summary (2 páginas)
**Pergunte**: "Visão estratégica para discussão?"
**Prepare**: Business case cada iniciativa

---

## ⚙️ Logística da Reunião

### 📅 Cronograma Preparação
- **Hoje (26/09)**: Enviar materiais para stakeholders
- **Amanhã (27/09)**: Confirmar presença + sala + tech setup
- **Quinta manhã**: Setup final + dry run apresentação

### 🏢 Setup Físico
- **Sala**: Sala de reuniões principal (capacidade 8 pessoas)
- **Tech**: Projetor testado, backup laptop, flipchart
- **Materiais**: Impressões agendadas, post-its, canetas
- **Catering**: Coffee break 15:30 agendado

### 📱 Backup Plans
- **Ausência stakeholder**: Proxy decision maker identificado
- **Problemas técnicos**: Apresentação impressa disponível
- **Overtime**: Sala reservada até 17:00

---

## 📊 Success Metrics da Reunião

### ✅ Objetivos Mínimos
- [ ] Roadmap 2025 definido (top 5 iniciativas)
- [ ] Budget aprovado por iniciativa
- [ ] Timeline acordada por todos
- [ ] DRIs designados

### 🎯 Objetivos Ideais
- [ ] Consenso unânime nas decisões
- [ ] Quick wins identificados (Q1 2025)
- [ ] Process para review mensal definido
- [ ] Success metrics acordadas

---

## 🚀 Follow-up Pós-Reunião (Automático)

### Imediatamente após (30 min)
- [ ] Ata circulada para todos participantes
- [ ] Action items enviados para DRIs
- [ ] Next steps agendados no calendário

### Próximas 48h
- [ ] Roadmap visual criado e distribuído
- [ ] Primeira reunião DRIs agendada
- [ ] Success metrics baseline estabelecida

---

**✅ Reunião estratégica completamente preparada. Stakeholders alinhados, materiais prontos, logística confirmada.**

**Próximo comando recomendado pós-reunião:**
`/organizador "processar decisões roadmap 2025 e criar plano implementação"`
```

---

## 🏗️ /arquiteto - Arquiteto de Soluções

**Personalidade**: Analítico, questionador, confronto construtivo, especialista em decisões técnicas

### Exemplo 1: Decisão Técnica Complexa

**Entrada:**
```bash
/arquiteto "preciso escolher entre microserviços e monolito para novo sistema de e-commerce que vai crescer rapidamente"
```

**Saída Esperada:**
```markdown
# Análise Arquitetural: Microserviços vs Monolito E-commerce

## 🔍 Confronto Inicial - Perguntas Fundamentais

Antes de qualquer decisão, preciso confrontar suas suposições:

### 1. Definição de "Crescimento Rápido"
- **Quantos usuários simultâneos** você espera em 6 meses? 1 ano?
- **Volume de transações/dia** projetado?
- **Expansão geográfica** planejada?
- **Crescimento da equipe** técnica previsto?

### 2. Contexto da Equipe Atual
- **Quantos desenvolvedores** têm experiência com microserviços?
- **DevOps capability** atual (containers, orquestração, monitoring)?
- **Time-to-market** é mais importante que escalabilidade inicial?

### 3. Realidade do Negócio
- **Budget** para infraestrutura complexa?
- **Tolerância a downtime** para aprendizado da equipe?
- **Complexidade operacional** aceitável?

---

## ⚖️ Análise Confrontativa

### Cenário: Equipe < 5 devs, MVP em 3 meses
**RECOMENDAÇÃO: MONOLITO (você odeia ouvir isso, né?)**

**Por que microserviços vão te ferrar:**
- ⚠️ **Overhead operacional** vai consumir 40% do tempo da equipe
- ⚠️ **Debugging distribuído** vai virar pesadelo
- ⚠️ **Network latency** entre serviços vai impactar UX
- ⚠️ **Data consistency** vai ser seu pior inimigo

### Cenário: Equipe > 10 devs, produto já validado
**RECOMENDAÇÃO: MICROSERVIÇOS GRADUAL**

**Por que monolito vai te limitar:**
- ⚠️ **Deploy coupling** vai travar releases
- ⚠️ **Code conflicts** vão aumentar exponencialmente
- ⚠️ **Technology lock-in** vai impedir inovação
- ⚠️ **Scaling bottlenecks** vão aparecer rapidamente

---

## 🏗️ Arquitetura Recomendada por Fase

### Fase 1: Monolito Bem Estruturado (0-6 meses)
```
┌─────────────────────────────────────┐
│           E-commerce Monolito        │
├─────────────────────────────────────┤
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ │
│  │   Web   │ │   API   │ │ Worker  │ │
│  │  Layer  │ │  Layer  │ │  Queue  │ │
│  └─────────┘ └─────────┘ └─────────┘ │
├─────────────────────────────────────┤
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ │
│  │ Product │ │  Order  │ │ Payment │ │
│  │ Service │ │ Service │ │ Service │ │
│  └─────────┘ └─────────┘ └─────────┘ │
├─────────────────────────────────────┤
│           Database Layer            │
└─────────────────────────────────────┘
```

**Vantagens desta fase:**
- ✅ Deploy simples (um artifact)
- ✅ Debugging local
- ✅ Transações ACID simples
- ✅ Time-to-market rápido

### Fase 2: Modular Monolito (6-12 meses)
```
┌─────────────────────────────────────┐
│        API Gateway / Load Balancer  │
├─────────────────────────────────────┤
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ │
│  │ Product │ │  User   │ │ Payment │ │
│  │ Module  │ │ Module  │ │ Module  │ │
│  └─────────┘ └─────────┘ └─────────┘ │
├─────────────────────────────────────┤
│     Event Bus (Internal Messages)   │
├─────────────────────────────────────┤
│ ┌──────────┐ ┌──────────┐ ┌────────┐ │
│ │ Products │ │  Users   │ │ Orders │ │
│ │    DB    │ │    DB    │ │   DB   │ │
│ └──────────┘ └──────────┘ └────────┘ │
└─────────────────────────────────────┘
```

### Fase 3: Microserviços Gradual (12+ meses)
```
┌─────────────────────────────────────┐
│           API Gateway               │
└─────────────┬───────────────────────┘
              │
    ┌─────────┼─────────┬─────────────┐
    │         │         │             │
┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐
│ Product │ │  User   │ │ Payment │ │ Shipping │
│ Service │ │ Service │ │ Service │ │ Service  │
└─────────┘ └─────────┘ └─────────┘ └─────────┘
    │         │         │             │
┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐
│ Product │ │  User   │ │ Payment │ │ Shipping │
│   DB    │ │   DB    │ │   DB    │ │    DB   │
└─────────┘ └─────────┘ └─────────┘ └─────────┘
```

---

## 📊 Decision Matrix (Objetiva)

| Critério | Peso | Monolito | Microserviços | Vencedor |
|----------|------|----------|---------------|----------|
| Time-to-Market | 25% | 9/10 | 4/10 | **Monolito** |
| Escalabilidade | 20% | 5/10 | 9/10 | **Microserviços** |
| Manutenibilidade | 15% | 6/10 | 8/10 | **Microserviços** |
| Complexidade Op. | 15% | 9/10 | 3/10 | **Monolito** |
| Performance | 10% | 8/10 | 6/10 | **Monolito** |
| Team Readiness | 10% | 9/10 | 4/10 | **Monolito** |
| Cost | 5% | 9/10 | 5/10 | **Monolito** |
| **TOTAL** | 100% | **7.25** | **6.05** | **MONOLITO** |

---

## 🎯 Recomendação Final (Baseada em Dados)

### Para Seu Contexto Específico:

**START com MONOLITO**, mas com arquitetura que permite migração:

1. **Domain-Driven Design** desde o início
2. **Clean Architecture** com boundaries claros
3. **Event-driven** internamente preparado
4. **Database per domain** (mesmo que shared instance)
5. **API-first** approach para todos endpoints

### Migration Path Definido:
```
Meses 0-6:   Monolito bem estruturado
Meses 6-12:  Modular monolito + event bus
Meses 12-18: Primeiro microserviço (payment)
Meses 18-24: Gradual extraction dos demais
```

---

## 🚧 Próximas Decisões Arquiteturais Necessárias

1. **Database Strategy**:
   - PostgreSQL single instance vs per-domain
   - Event sourcing para audit trail?
   - Read replicas para analytics?

2. **Authentication/Authorization**:
   - JWT vs Session-based
   - OAuth2 implementation
   - Role-based vs Attribute-based access

3. **Caching Strategy**:
   - Redis layer design
   - CDN for static assets
   - Application-level caching

4. **Message Queue**:
   - RabbitMQ vs Apache Kafka
   - Event schema versioning
   - Dead letter queue handling

---

## 💡 Confronto Final

**Você provavelmente queria ouvir "microserviços são sempre a resposta"**.

A verdade: **Microserviços são uma solução para problemas que você ainda não tem**.

**Start simple, evolve smart.**

Sua arquitetura deve crescer com seu produto, não estar 2 anos à frente dele.

---

**Próximos comandos recomendados:**
- `/organizador "estruturar plan de implementação arquitetura monolito-para-microserviços"`
- `/secretaria "timeline e recursos necessários para implementação"`
```

### Exemplo 2: Review de Arquitetura Existente

**Entrada:**
```bash
/arquiteto "revise nossa arquitetura atual: temos API Node.js + React frontend + MySQL + Redis cache, mas está ficando lento com crescimento"
```

**Saída Esperada:**
```markdown
# Review Arquitetural: Performance Issues Analysis

## 🔍 Diagnóstico Confrontativo

### Antes de eu sugerir qualquer solução, vamos confrontar o óbvio:

**Você tem dados reais ou só "feeling" de que está lento?**

### 1. Métricas Necessárias (que você provavelmente não tem):
- **Response time** médio das APIs críticas?
- **Throughput** atual vs capacity?
- **Database slow queries** identificadas?
- **Memory/CPU usage** patterns?
- **Cache hit ratio** do Redis?

### 2. Definição de "Crescimento":
- **Quantos usuários** a mais desde quando?
- **Volume de requests** aumentou quanto?
- **Tamanho dos datasets** cresceu significativamente?

---

## 🔧 Análise da Stack Atual

### ✅ O que está CERTO na sua arquitetura:
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   React     │────│   Node.js   │────│   MySQL     │
│  Frontend   │    │   API       │    │  Database   │
└─────────────┘    └─────────────┘    └─────────────┘
                           │
                   ┌─────────────┐
                   │   Redis     │
                   │   Cache     │
                   └─────────────┘
```

- ✅ **Stack coesa**: JavaScript end-to-end
- ✅ **Cache layer**: Redis implementado
- ✅ **Separation of concerns**: Frontend/Backend separados

### ⚠️ O que está PROBLEMÁTICO (meu palpite):

#### 1. Database Bottlenecks (90% das vezes é isso)
- **Queries N+1** no Node.js
- **Missing indexes** em queries complexas
- **Single database** para tudo (reads + writes)
- **No connection pooling** adequado

#### 2. Cache Inadequado
- **Cache strategy** provavelmente reativa, não proativa
- **Cache invalidation** mal implementada
- **Hot data** não identificado corretamente

#### 3. Node.js Issues
- **Single-threaded** gargalo em CPU-intensive operations
- **Memory leaks** em long-running processes
- **Blocking operations** não identificadas

---

## 📊 Plano de Diagnóstico OBRIGATÓRIO

### Fase 1: Measurement (1 semana)
```javascript
// 1. Adicionar APM (New Relic/DataDog)
const newrelic = require('newrelic');

// 2. Database query profiling
const mysql = require('mysql2/promise');
const pool = mysql.createPool({
  // ... config
  logging: true,
  benchmark: true
});

// 3. API endpoint timing
app.use((req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    console.log(`${req.method} ${req.path}: ${Date.now() - start}ms`);
  });
  next();
});

// 4. Redis monitoring
redis.monitor((time, args, source, database) => {
  console.log(`${time}: ${args}`);
});
```

### Fase 2: Quick Wins (2 semanas)
1. **Database Optimization**:
   ```sql
   -- Identificar slow queries
   SHOW FULL PROCESSLIST;
   SELECT * FROM mysql.slow_log ORDER BY start_time DESC LIMIT 10;

   -- Adicionar indexes baseado em queries
   EXPLAIN SELECT * FROM orders WHERE user_id = ? AND status = ?;
   CREATE INDEX idx_orders_user_status ON orders(user_id, status);
   ```

2. **Connection Pooling**:
   ```javascript
   const pool = mysql.createPool({
     connectionLimit: 10,
     host: 'localhost',
     user: 'user',
     password: 'password',
     database: 'ecommerce'
   });
   ```

3. **Redis Optimization**:
   ```javascript
   // Cache de queries caras
   const cacheKey = `user_orders_${userId}`;
   let orders = await redis.get(cacheKey);
   if (!orders) {
     orders = await db.getUserOrders(userId);
     await redis.setex(cacheKey, 300, JSON.stringify(orders)); // 5 min TTL
   }
   ```

### Fase 3: Architectural Improvements (1 mês)

#### Option A: Read Replicas + Query Optimization
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   React     │────│   Node.js   │────│   MySQL     │
│  Frontend   │    │   API       │    │  (Master)   │
└─────────────┘    └─────────────┘    └─────────────┘
                           │                   │
                   ┌─────────────┐    ┌─────────────┐
                   │   Redis     │    │   MySQL     │
                   │   Cache     │    │ (Read Rep.) │
                   └─────────────┘    └─────────────┘
```

**Pros**: Simples, resolve 80% dos casos
**Cons**: Still single point of failure no master

#### Option B: Microservices + Event Sourcing
```
┌─────────────┐    ┌─────────────┐
│   React     │────│ API Gateway │
│  Frontend   │    │  (Node.js)  │
└─────────────┘    └─────────────┘
                           │
         ┌─────────────────┼─────────────────┐
         │                 │                 │
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Users     │    │  Products   │    │   Orders    │
│  Service    │    │  Service    │    │  Service    │
│ (Node.js)   │    │ (Node.js)   │    │ (Node.js)   │
└─────────────┘    └─────────────┘    └─────────────┘
       │                   │                   │
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Users     │    │  Products   │    │   Orders    │
│  Database   │    │  Database   │    │  Database   │
└─────────────┘    └─────────────┘    └─────────────┘
```

**Pros**: Scalabilidade infinita, fault tolerance
**Cons**: Complexidade 10x, time precisa estar ready

---

## 🎯 Recomendação Baseada em Realidade

### Se tráfego < 1000 requests/min:
**OPTION A: Otimização Current Stack**
- Read replicas
- Query optimization
- Better caching strategy
- **Custo**: 2 semanas dev + $200/mês infra
- **Risk**: Baixo
- **Performance gain**: 300-500%

### Se tráfego > 5000 requests/min:
**OPTION B: Gradual Microservices**
- Start com Users service separado
- Event-driven architecture
- **Custo**: 2 meses dev + $800/mês infra
- **Risk**: Médio
- **Performance gain**: 1000%+

---

## 📋 Action Plan Imediato

### Esta Semana:
1. **Implementar monitoring** (APM + database profiling)
2. **Identify top 5 slow queries**
3. **Check Redis hit ratio**
4. **Profile Node.js memory usage**

### Próximas 2 Semanas:
1. **Add database indexes** baseado em profiling
2. **Implement proper connection pooling**
3. **Optimize cache strategy**
4. **Fix N+1 query problems**

### Próximo Mês:
1. **Implement read replicas** se necessário
2. **Consider CDN** para assets estáticos
3. **Load testing** para validar improvements

---

## 🚧 Red Flags para Não Ignorar

- **Database CPU > 80%** consistentemente
- **API response time > 2s** em 95th percentile
- **Memory leaks** evidentes
- **Error rate > 1%**

**Se qualquer red flag aparecer: STOP TUDO e foque nela primeiro.**

---

## 💡 Confronto Final

**Você provavelmente quer uma bala de prata: "migre para microserviços".**

**Realidade**: 80% dos problemas de performance são queries mal feitas e cache inadequado.

**Fix the basics first, then scale the architecture.**

**Próximos comandos recomendados:**
- `/secretaria "criar timeline e orçamento para otimizações de performance"`
- `/organizador "estruturar plano de implementação das melhorias"`
```

---

## 💚 /psicologo - Psicólogo de Suporte TDAH

**Personalidade**: Empático, compreensivo, especializado em TDAH, focado no bem-estar

### Exemplo 1: Gestão de Overwhelm

**Entrada:**
```bash
/psicologo "me sinto completamente sobrecarregado, tenho 5 projetos ao mesmo tempo, deadline na sexta, equipe cobrando, não consigo focar em nada, mente acelerada, ansioso"
```

**Saída Esperada:**
```markdown
# Suporte para Overwhelm - Protocolo de Emergência TDAH

## 💙 Validação Emocional Primeiro

**Respire. O que você está sentindo é REAL e VÁLIDO.**

Para pessoas com TDAH, o overwhelm não é "falta de organização" - é uma **sobrecarga neurológica real**. Seu cérebro está processando tudo ao mesmo tempo sem filtros. Você não está falhando.

**Isto VAI passar. Você já superou momentos assim antes.**

---

## 🚨 Protocolo de Emergência Imediata (Próximos 15 minutos)

### 1. PARAR e Respirar (2 minutos)
- **Técnica 4-7-8**: Inspire 4 segundos, segure 7, expire 8
- Repita 4 vezes
- **Não pense em nada** além da respiração

### 2. Brain Dump Total (5 minutos)
Despeje **TUDO** no `despejo/daily-dump.md` sem filtro:
- Projetos
- Deadlines
- Preocupações
- Medos
- Qualquer coisa na sua mente

**Não organize. Apenas despeje.**

### 3. Regra do 3 (5 minutos)
Das 1000 coisas na sua mente, escolha **APENAS 3** para hoje:
- 1 thing URGENTE (deadline sexta)
- 1 thing IMPORTANTE (projeto principal)
- 1 thing FÁCIL (para dar sensação de conquista)

**Todo o resto OFICIALMENTE não existe hoje.**

### 4. Micro-break de Movimento (3 minutos)
- 30 segundos de alongamento
- Beba um copo d'água
- Olhe para longe da tela
- **Movimento ajuda o cérebro TDAH a resetar**

---

## 🧠 Estratégias TDAH-Específicas para Esta Situação

### Para a Mente Acelerada:
```
🎯 FOCO FORÇADO - Técnica Pomodoro TDAH:
- 15 minutos (não 25) de trabalho focado
- 5 minutos break obrigatório
- Após 4 ciclos: break de 30 minutos

🔇 REDUÇÃO DE ESTÍMULOS:
- Notificações OFF
- Música instrumental ou white noise
- Uma aba do navegador por vez
- Celular em modo avião ou outro cômodo
```

### Para a Ansiedade:
```
✋ TÉCNICA DE GROUNDING 5-4-3-2-1:
- 5 coisas que você VÊ
- 4 coisas que você TOCA
- 3 coisas que você OUVE
- 2 coisas que você CHEIRA
- 1 coisa que você PROVA

💭 REFRAME COGNITIVO:
- "Tenho 5 projetos" → "Sou confiável, me dão projetos importantes"
- "Não consigo focar" → "Meu cérebro está protegendo contra sobrecarga"
- "Vou falhar" → "Já superei situações difíceis antes"
```

### Para os Projetos:
```
📊 TRIAGE DE URGÊNCIA REAL (não urgência percebida):
- CRÍTICO: O que acontece se eu NÃO fizer hoje?
- IMPORTANTE: O que pode esperar 24-48h?
- NICE-TO-HAVE: O que é ansiedade, não necessidade real?

🎯 ESTRATÉGIA DE CHUNKING:
- Pegue a tarefa mais assustadora
- Quebre em pedaços de 15 minutos
- Faça APENAS o primeiro pedaço
- Celebre (sério, isso é importante para TDAH)
```

---

## 💪 Plano de Sobrevivência para Hoje

### 🌅 Manhã (Agora - 12h)
1. **Execute protocolo de emergência** (15 min)
2. **Escolha UMA tarefa** do deadline sexta
3. **Trabalhe 15 min** só nela
4. **Break de 5 min + movimento**
5. **Repita ciclo** até almoço

### 🌞 Tarde (13h - 17h)
1. **Almoce** (nutrir o cérebro é obrigatório)
2. **15 min de caminhada** ou movimento
3. **2 pomodoros TDAH** (15min + 5min break)
4. **Comunique progresso** para equipe
5. **NÃO aceite** novas demandas hoje

### 🌙 Noite (17h+)
1. **PARE de trabalhar** às 18h (máximo)
2. **Atividade descompressora**: exercício, banho, música
3. **Reflita** no que conseguiu (sem autocrítica)
4. **Prepare** ambiente para amanhã
5. **Sleep hygiene** para restaurar foco

---

## 🛡️ Proteções para a Semana

### Para a Equipe que está Cobrando:
**Comunicação Transparente:**
```
"Pessoal, estou organizando prioridades para entregar com qualidade.
Vou focar em [projeto X] hoje e [projeto Y] amanhã.
Updates diários às 17h. Obrigado pela compreensão."
```

**Não é desculpa, é gestão profissional.**

### Para o Deadline de Sexta:
**Estratégia de Redução de Escopo:**
1. **Identifique** o MÍNIMO viável para entrega
2. **Comunique** redução de escopo (melhor que atraso)
3. **Entregue** algo funcional vs algo perfeito incompleto
4. **Documente** próximos passos para pós-deadline

### Para Futuros Overwhelms:
**Sistema de Early Warning:**
- ⚠️ **3 projetos simultâneos** = atenção redobrada
- 🚨 **4+ projetos** = recusar novas demandas
- 🆘 **5+ projetos** = conversa com gestor/redução forçada

---

## 🧘 Técnicas de Auto-Compaixão

### Quando a Autocrítica Atacar:
- **"Outras pessoas conseguem mais"** → "Outras pessoas têm cérebros diferentes"
- **"Deveria ser mais produtivo"** → "Estou fazendo meu melhor com as condições atuais"
- **"Sou desorganizado"** → "Tenho um estilo diferente de processar informações"

### Mantras para TDAH:
- **"Progresso, não perfeição"**
- **"Uma coisa de cada vez"**
- **"Meu valor não depende da minha produtividade"**
- **"Isto também passará"**

---

## 📞 Rede de Apoio Ativada

### Para Hoje:
- **Avise** uma pessoa de confiança sobre seu estado
- **Peça** para checarem com você às 15h
- **Não** tome decisões importantes sobre carreira/projetos

### Para Esta Semana:
- **Considere** conversar com gestor sobre carga
- **Avalie** se precisa de ajuda profissional adicional
- **Planeje** estratégias preventivas

---

## 🎯 Success Metrics para Hoje

### ✅ Vitórias Mínimas (você só precisa disso):
- [ ] Protocolo de emergência executado
- [ ] 1 hora de trabalho focado total
- [ ] Comunicação com equipe feita
- [ ] Alimentação e hidratação adequadas

### 🌟 Bonus (se conseguir, ótimo; se não, tudo bem):
- [ ] 2+ horas de trabalho focado
- [ ] Exercício ou movimento
- [ ] Relaxamento antes de dormir

---

## 💙 Lembrete Final

**Você está lidando com uma condição neurológica real, não com "falta de força de vontade".**

**O TDAH torna situações normalmente gerenciáveis em desafios maiores. Isto não é culpa sua.**

**Você já superou 100% dos seus piores dias até agora. Esta estatística é invencível.**

**Estou aqui sempre que precisar. Use `/psicologo` sempre que o overwhelm voltar.**

---

**Próximos comandos recomendados após estabilização:**
- `/organizador despejo/daily-dump.md` (para estruturar as 3 prioridades)
- `/secretaria "comunicar status atual e próximos passos para equipe"`
- `/psicologo "estratégias preventivas contra overwhelm futuro"`

**Agora PARE de ler e EXECUTE o protocolo de emergência. Você consegue. 💪**
```

### Exemplo 2: Estratégias de Foco para TDAH

**Entrada:**
```bash
/psicologo "trabalho de casa, muitas distrações, não consigo manter foco mais que 10 minutos, procrastino tarefas chatas, como criar sistema de foco para TDAH?"
```

**Saída Esperada:**
```markdown
# Sistema de Foco TDAH-Optimized para Home Office

## 💙 Validação Importante

**Primeiro: 10 minutos de foco é NORMAL para TDAH.**

A neurotipia consegue 45-90 minutos de foco sustentado. **TDAH trabalha em sprints curtos**. Não há nada errado com você - seu cérebro apenas funciona diferente.

**Stop trying to focus like neurotypical brains. Work WITH your TDAH, not against it.**

---

## 🧠 Entendendo Seu Cérebro TDAH

### Por que Tarefas Chatas são Kryptonite:
- **Dopamina baixa**: Cérebro TDAH precisa de novelty/reward/urgency
- **Executive dysfunction**: Funções executivas comprometidas
- **Interest-based attention**: Focamos no que é interessante, não importante
- **Time blindness**: Dificuldade em estimar duração/urgência

### Por que Home Office é Extra Desafiador:
- **Lack of structure**: Sem routine externa forçada
- **Distractions everywhere**: Casa = 1000 estímulos
- **No accountability**: Ninguém vendo trabalhar
- **Comfort zone**: Ambiente de relaxamento vs produtividade

---

## 🎯 Sistema de Foco Multi-Camada

### Layer 1: Environment Design (Setup Uma Vez)

#### 🏠 Espaço Físico TDAH-Friendly:
```
✅ MUST HAVE:
- Mesa limpa (apenas 1 projeto por vez)
- Fidget toys ao alcance
- Garrafa d'água sempre cheia
- Timer visível grande
- Noise-cancelling headphones

❌ REMOVE:
- Notificações visuais desnecessárias
- Clutter/bagunça na linha de visão
- Celular (outro cômodo durante foco)
- Snacks tentadores (geram hyperfocus alimentar)
- Multiple screens se causam distração
```

#### 💻 Setup Digital:
```javascript
// Browser Extensions TDAH:
- Cold Turkey Blocker (bloqueia sites)
- Forest (gamification de foco)
- OneTab (consolida abas abertas)
- AdBlock (reduz estímulos visuais)

// Apps Essenciais:
- Be Focused (Pomodoro TDAH-adapted)
- White Noise/Brain.fm
- Toggl (time tracking sem pressure)
```

### Layer 2: Micro-Habits (Diário)

#### 🌅 Morning Routine (15 min):
```
1. 5 min: Movimento (jumping jacks, yoga, caminhada)
2. 5 min: Hydration + mindful breathing
3. 3 min: Choose ONE primary task for day
4. 2 min: Set environment (timer, headphones, water)
```

#### ⚡ Transition Rituals:
```
Antes de Cada Session:
- 30 sec: Deep breath + intention setting
- "Working on X for Y minutes"
- Phone em modo avião/outro cômodo
- Start timer BEFORE opening work

Depois de Cada Session:
- Stand up + stretch (2 min)
- Hydrate + bathroom break
- Quick win celebration (fist pump, "good job")
```

### Layer 3: Focus Protocols

#### 🍅 Pomodoro TDAH (Adapted):
```
Traditional: 25min work + 5min break
TDAH Version: 15min work + 5min break

Why 15 minutes:
- Matches TDAH attention span
- Less overwhelming to start
- More frequent dopamine hits
- Easier to restart after distraction

Schedule:
15 min work → 5 min break → 15 min work → 5 min break
After 4 cycles: 30 min big break
```

#### 🎮 Gamification Strategies:
```
📊 POINT SYSTEM:
- Complete 15min session = 1 point
- No distraction during session = 1 bonus point
- Complete full morning = 5 bonus points
- Daily goal: 10 points

🏆 REWARDS:
- 10 points = favorite snack
- 25 points = episode of series
- 50 points = something special
- 100 points = bigger reward

📈 VISUAL PROGRESS:
- Physical chart on wall
- App with streaks
- Checklist satisfaction
```

### Layer 4: Task Management

#### 🧩 Chunking Strategy:
```
WRONG: "Work on project report"
RIGHT:
- "Open document and add title" (2 min)
- "Write bullet points for section 1" (15 min)
- "Find 3 relevant data points" (15 min)
- "Draft introduction paragraph" (15 min)

Make every task feel like "easy win"
```

#### 🎯 Task Priorization TDAH:
```
Instead of Urgent/Important Matrix, use:

HIGH DOPAMINE (do first):
- New/novel tasks
- Creative work
- Problem-solving
- Collaboration

MEDIUM DOPAMINE (afternoon):
- Routine tasks with music
- Administrative work
- Emails/communication

LOW DOPAMINE (avoid when tired):
- Repetitive data entry
- Long meetings without interaction
- Detailed review/proofreading
```

---

## 🛠️ Practical Implementation Plan

### Week 1: Environment + Habits
- [ ] Setup physical workspace
- [ ] Install focus apps
- [ ] Practice morning routine
- [ ] Try 15-min Pomodoros
- **Goal**: Establish basic structure

### Week 2: Fine-tuning
- [ ] Track what works/doesn't
- [ ] Adjust timer lengths
- [ ] Experiment with background sounds
- [ ] Identify optimal work hours
- **Goal**: Personalize system

### Week 3: Gamification
- [ ] Implement point system
- [ ] Create reward list
- [ ] Visual progress tracking
- [ ] Celebration rituals
- **Goal**: Make focus fun

### Week 4: Advanced Strategies
- [ ] Body doubling sessions
- [ ] Accountability partner
- [ ] Interest-based scheduling
- [ ] Hyperfocus management
- **Goal**: Optimize for your brain

---

## 🎭 Strategies for "Boring" Tasks

### 1. Interest Injection:
```
BORING: Update spreadsheet
INTERESTING: "Optimize data like a detective finding patterns"

BORING: Write meeting notes
INTERESTING: "Create executive summary like a journalist"

BORING: File organization
INTERESTING: "Architect information system like Marie Kondo"
```

### 2. Body Doubling:
```
Virtual Co-working:
- Focusmate.com (1:1 video sessions)
- Caveday.org (group focus sessions)
- Study streams on YouTube/Twitch

Physical Co-working:
- Coffee shop with ambient noise
- Library study rooms
- Friend working nearby (parallel play)
```

### 3. Temptation Bundling:
```
Pair boring task with something pleasant:
- Favorite music/podcast during data entry
- Special drink only during admin work
- Standing desk for variety
- Fidget toy for hands while reading
```

---

## 🚨 Emergency Protocols

### When You Can't Start (Executive Dysfunction):
```
1. MICRO-START (30 seconds):
   - Just open the document
   - Write your name
   - Save file
   - Close computer

2. SIDE-DOOR APPROACH:
   - Do related easy task first
   - Organize workspace
   - Research for 5 minutes
   - Talk about task out loud

3. EXTERNAL PRESSURE:
   - Tell someone your plan
   - Schedule working session with friend
   - Set artificial deadline
   - Work in public space
```

### When You Get Distracted:
```
1. GENTLE REDIRECT (no self-criticism):
   - "Oh, that's interesting, but right now I'm doing X"
   - Physically turn back to work
   - Reset timer for remaining time

2. CAPTURE DISTRACTION:
   - Quick note in "later" file
   - "That's worth exploring after this session"
   - Promise brain you'll return to it

3. RESTART RITUAL:
   - 3 deep breaths
   - Reread current objective
   - Set timer again
```

### When Hyperfocus Strikes:
```
⚠️ SET BOUNDARIES:
- Timer for max 2 hours continuous work
- Hydration alarm every 45 minutes
- Meal/bathroom breaks mandatory

✅ LEVERAGE IT WISELY:
- Use for most important/creative tasks
- Clear schedule for hyperfocus sessions
- Protect from interruptions
- Capture all insights before ending
```

---

## 📊 Tracking & Optimization

### Daily Check-in Questions:
1. **Energy level** when starting work? (1-10)
2. **Total focused time** achieved?
3. **Biggest distraction** today?
4. **What worked** best for focus?
5. **One thing** to try tomorrow?

### Weekly Pattern Recognition:
- **Best time of day** for focused work?
- **Environmental factors** that helped/hindered?
- **Task types** that were easier/harder?
- **Emotional states** that supported focus?

---

## 💙 Self-Compassion Reminders

### When You Have "Bad Focus Days":
- **"My brain is doing its best with its neurochemistry today"**
- **"Rest is productive too"**
- **"Tomorrow is a fresh start"**
- **"Progress isn't always linear"**

### Reframe Internal Critic:
- "I'm lazy" → "My brain needs different strategies"
- "I can't focus" → "I focus differently"
- "I'm failing" → "I'm learning what works for my brain"
- "Others are better" → "Others have different neurological advantages"

---

## 🎯 Success Metrics (TDAH-Realistic)

### Daily Wins:
- [ ] 2+ focused 15-min sessions completed
- [ ] Stayed hydrated during work
- [ ] Took breaks between sessions
- [ ] Celebrated small progress

### Weekly Wins:
- [ ] 70% of planned focus sessions achieved
- [ ] One boring task completed
- [ ] Adjusted system based on what worked
- [ ] Maintained self-compassion during struggles

---

## 🔄 Next Steps Based on Progress

### If System Works Well:
- `/mentor "como usar foco TDAH para crescimento profissional"`
- Add more challenging tasks gradually
- Share strategies with other TDAH friends

### If Still Struggling:
- `/psicologo "foco não melhora, preciso de mais estratégias"`
- Consider professional TDAH coaching
- Evaluate medication with healthcare provider

### If Going Great:
- `/organizador "otimizar workflow baseado em padrões de foco TDAH"`
- Document your personalized system
- Mentor others with TDAH

---

**Remember: You're not broken, you're different. Work with your ADHD brain, not against it. 💙**

**Start with ONE strategy today. You've got this!**
```

---

## 🎓 /mentor - Mentor de Carreira

**Personalidade**: Visionário, estratégico, inspirador, focado em crescimento de longo prazo

### Exemplo 1: Planejamento de Carreira Estratégico

**Entrada:**
```bash
/mentor "trabalho como desenvolvedor pleno há 2 anos, quero ser tech lead em 18 meses, mas não sei se tenho perfil de liderança, como criar plano realista?"
```

**Saída Esperada:**
```markdown
# Plano Estratégico: Desenvolvedor Pleno → Tech Lead (18 meses)

## 🎯 Realidade Check Inicial

**Excelente timing na carreira!** 2 anos como pleno é o momento ideal para this transition. Você não precisa "ter perfil de liderança nato" - **liderança técnica se desenvolve através de prática deliberada**.

**Vamos construir esse perfil juntos, step by step.**

---

## 📊 Gap Analysis: Onde Você Está vs Onde Precisa Chegar

### 💻 Tech Lead Requirements:
| Competência | Peso | Atual (estimado) | Meta 18m | Gap |
|-------------|------|------------------|----------|-----|
| **Technical Mastery** | 25% | 7/10 | 9/10 | Skill deepening |
| **System Design** | 20% | 5/10 | 8/10 | Architecture knowledge |
| **Code Review/Mentoring** | 15% | 6/10 | 9/10 | Teaching skills |
| **Project Leadership** | 15% | 4/10 | 8/10 | Initiative taking |
| **Stakeholder Communication** | 10% | 5/10 | 8/10 | Business alignment |
| **Team Dynamics** | 10% | ?/10 | 8/10 | People skills |
| **Technical Decision Making** | 5% | 5/10 | 9/10 | Judgment + experience |

### 🎯 Your Development Focus Areas:
1. **System Design** (biggest lever)
2. **Project Leadership** (most visible)
3. **Mentoring Skills** (demonstrates readiness)

---

## 🗺️ 18-Month Roadmap

### 📅 Months 1-6: Foundation Building
**Theme**: "Become the Go-To Technical Resource"

#### Technical Depth:
- [ ] **Master your current stack completely**
  - Know performance implications of every choice
  - Understand deployment pipeline end-to-end
  - Debug complex issues without senior help

- [ ] **System Design Fundamentals**
  - Complete "Designing Data-Intensive Applications" book
  - Practice system design interviews weekly
  - Implement personal project showcasing scalability

#### Leadership Foundations:
- [ ] **Start Code Review Excellence**
  - Review 100% of team's PRs with thoughtful feedback
  - Write style guide for your team's codebase
  - Mentor 1 junior developer actively

- [ ] **Documentation Leadership**
  - Create/improve team's technical documentation
  - Write post-mortems for bugs you solve
  - Share knowledge through team tech talks

**📈 Success Metrics Q1-Q2:**
- Reduced senior dev escalations by 50%
- 2+ tech talks delivered to team
- 1 junior dev showing clear improvement under mentoring
- Architecture decision document written

### 📅 Months 7-12: Visibility & Initiative
**Theme**: "Lead Without Authority"

#### Project Leadership:
- [ ] **Own a Complex Feature End-to-End**
  - Gather requirements from stakeholders
  - Design technical solution
  - Coordinate with multiple team members
  - Present progress to management

- [ ] **Process Improvement Leadership**
  - Identify team pain point (deploy, testing, etc.)
  - Propose and implement solution
  - Measure improvement impact
  - Present results to engineering leadership

#### External Visibility:
- [ ] **Cross-Team Collaboration**
  - Become point person for integration projects
  - Participate in architecture review meetings
  - Contribute to engineering-wide initiatives

- [ ] **Industry Engagement**
  - Write 2-3 technical blog posts
  - Speak at local meetup or conference
  - Contribute to open source project

**📈 Success Metrics Q3-Q4:**
- Led project with 3+ team members
- Improved team process with measurable impact
- External recognition (blog views, conference talk)
- Invited to participate in hiring/architecture decisions

### 📅 Months 13-18: Leadership Transition
**Theme**: "Ready for Official Tech Lead Role"

#### Advanced Leadership:
- [ ] **Team Performance Impact**
  - Mentor multiple developers simultaneously
  - Drive team technical standards
  - Resolve conflicts and technical disagreements
  - Represent team in management meetings

- [ ] **Strategic Technical Planning**
  - Create technical roadmap for team
  - Evaluate and recommend new technologies
  - Lead technical debt prioritization
  - Design hiring plan for team growth

#### Transition Preparation:
- [ ] **Shadow Current Tech Lead**
  - Attend all tech lead meetings as observer
  - Take on specific tech lead responsibilities
  - Get feedback on leadership approach
  - Build relationships with key stakeholders

**📈 Success Metrics Q5-Q6:**
- Managing technical decisions for 5+ person team
- Stakeholders specifically request your input
- Junior developers seek you out for guidance
- Manager discusses promotion timeline

---

## 🧭 Leadership Philosophy Development

### Your Emerging Leadership Style:

**Technical Leadership Pillars to Develop:**

#### 1. **Teacher-First Mindset**
```
Instead of: "Here's how to do it"
Practice: "Let me show you how to think about this problem"

Instead of: Fixing all issues yourself
Practice: Guide others to solutions, step back when they can handle it
```

#### 2. **Systems Thinking**
```
Junior Dev Focus: Making this feature work
Tech Lead Focus: How this feature impacts:
- Performance across system
- Maintenance burden for team
- User experience end-to-end
- Business metrics alignment
```

#### 3. **Collaborative Decision Making**
```
Avoid: "We should use technology X because I prefer it"
Practice: "Let's evaluate options based on:
- Team expertise and learning curve
- Project constraints and timeline
- Long-term maintenance implications
- Business requirements alignment"
```

### 🎯 Leadership Opportunities to Seek:

#### In Your Current Role:
- **Volunteer for cross-team projects**
- **Take initiative on technical debt**
- **Become the person who asks clarifying questions in meetings**
- **Write proposals for technical improvements**

#### In Team Dynamics:
- **Facilitate technical discussions (don't dominate)**
- **Advocate for team needs to management**
- **Help resolve teammate conflicts constructively**
- **Celebrate team wins publicly**

---

## 📚 Strategic Learning Plan

### 📖 Essential Reading (Prioritized):
1. **"The Staff Engineer's Path"** by Tanya Reilly (Months 1-2)
2. **"Designing Data-Intensive Applications"** by Martin Kleppmann (Months 3-5)
3. **"Team Topologies"** by Matthew Skelton (Months 6-7)
4. **"The Manager's Path"** by Camille Fournier (Months 8-9)

### 🎓 Courses & Certifications:
- **System Design Course** (Grokking the System Design Interview)
- **Cloud Architecture** certification (AWS/GCP/Azure)
- **Leadership Communication** workshop
- **Public Speaking** course (Toastmasters or similar)

### 🎤 Speaking & Writing Goals:
- **Month 6**: First team tech talk
- **Month 9**: Department-wide presentation
- **Month 12**: External meetup/conference talk
- **Month 15**: Published technical article
- **Month 18**: Speaking at major conference or writing series

---

## 🚀 Tactical Execution Strategies

### Weekly Routine for Leadership Development:
```
Monday:
- Review team goals for week
- Identify mentoring opportunities

Tuesday-Thursday:
- Active code review with teaching mindset
- One-on-one informal mentoring

Friday:
- Reflect on leadership moments from week
- Plan knowledge sharing for next week
- Update personal development progress
```

### Monthly Strategic Activities:
```
Week 1: Technical skill deep-dive
Week 2: Leadership/communication focus
Week 3: Industry learning (reading, courses)
Week 4: Networking and external engagement
```

### Quarterly Milestones:
- **Career conversation with manager**
- **360-degree feedback from peers**
- **Personal brand assessment** (internal/external visibility)
- **Goal adjustment** based on learnings

---

## 💼 Stakeholder Management Strategy

### Building Key Relationships:

#### Your Current Manager:
```
Monthly Check-ins:
- "What leadership skills do you see me developing?"
- "What opportunities can I take on to demonstrate readiness?"
- "How do you recommend I prepare for tech lead responsibility?"

Position Yourself:
- Share your development plan
- Ask for stretch assignments
- Request feedback on leadership moments
```

#### Engineering Leadership:
```
Visibility Strategy:
- Participate in engineering all-hands
- Volunteer for cross-team initiatives
- Share interesting technical learnings
- Contribute to engineering culture discussions

Value Demonstration:
- Solve problems that affect multiple teams
- Propose solutions that save engineering time
- Mentor across team boundaries
```

#### Peer Developers:
```
Peer Leadership:
- Be the person others come to for technical questions
- Facilitate knowledge sharing sessions
- Champion team improvements
- Support others' growth visibly

Collaboration Excellence:
- Always make others look good in team settings
- Share credit generously
- Ask thoughtful questions that help everyone
```

---

## 📊 Success Measurement Framework

### Quantitative Indicators:
- **Code review quality scores** (feedback frequency, issue finding rate)
- **Mentoring impact** (junior developer velocity improvement)
- **Technical talks delivered** (internal and external)
- **Documentation created** (pages written, usage metrics)
- **Process improvements** (cycle time reduction, bug rate improvement)

### Qualitative Feedback:
- **360-degree reviews** from peers, reports, stakeholders
- **Manager assessment** of leadership readiness
- **Team sentiment** about your leadership contributions
- **External recognition** in industry or company

### 📈 Monthly Self-Assessment:
1. **What technical leadership did I demonstrate this month?**
2. **How did I help teammates grow and succeed?**
3. **What impact did I have on team/company technical direction?**
4. **Where do I see the biggest gaps in my development?**
5. **What feedback am I receiving about my leadership growth?**

---

## 🎯 Risk Mitigation & Acceleration Strategies

### Potential Risks:
| Risk | Mitigation Strategy |
|------|-------------------|
| **Technical depth insufficient** | Focus on mastery before breadth, deep-dive monthly |
| **Team doesn't respect leadership** | Earn authority through value delivery, not position |
| **Management doesn't see readiness** | Make impact visible through documentation & presentations |
| **Imposter syndrome** | Track concrete wins, seek regular feedback |

### Acceleration Opportunities:
- **Company reorganization** → Volunteer for new team structures
- **Senior developer leaving** → Step up to fill knowledge gap
- **New technology adoption** → Become subject matter expert
- **Cross-functional projects** → Demonstrate business alignment

---

## 🎭 Personal Brand Development

### Internal Brand:
**"The developer who makes everyone around them better"**

- Known for thoughtful technical decisions
- Sought out for complex problem solving
- Trusted with high-stakes projects
- Develops other developers effectively

### External Brand:
**"Technical leader who bridges code and business value"**

- Shares practical insights through writing/speaking
- Contributes to engineering community
- Demonstrates technical excellence with business impact
- Advocates for sustainable engineering practices

---

## 💪 Confidence Building Strategy

### Addressing "Not Sure If I Have Leadership Profile":

**Leadership isn't about personality type - it's about developed skills:**

#### Technical Leaders Come From All Personalities:
- **Introverts** often make excellent technical leaders (deep thinking, careful communication)
- **Analytical minds** excel at systematic problem solving
- **Detail-oriented people** create reliable systems
- **Collaborative types** build strong team dynamics

#### Your Strengths to Leverage:
- **2 years experience** = solid foundation without arrogance
- **Self-awareness** about development needs = growth mindset
- **18-month timeline** = realistic planning skills
- **Seeking mentorship** = coachability

### Daily Confidence Practices:
- **Document daily wins** (however small)
- **Share one thing you learned** each day
- **Help one teammate** each day
- **Take one small initiative** each week

---

## 🔄 Adaptation Strategy

### Quarterly Reviews:
**Every 3 months, assess:**
1. **What's working better than expected?** (double down)
2. **What's harder than anticipated?** (adjust approach)
3. **What opportunities emerged?** (pivot if better path)
4. **What feedback surprised you?** (blind spots)

### Scenario Planning:
**If promotion opportunity comes early:**
- Ready or not, demonstrate growth mindset
- Ask for specific development priorities
- Request mentor assignment
- Set 90-day prove-yourself goals

**If timeline needs extension:**
- Identify specific skill gaps causing delay
- Get clear feedback on what's missing
- Adjust plan based on company needs
- Consider lateral moves for experience

---

## 🎯 The 18-Month Vision

**Picture yourself in 18 months:**

You walk into the office and junior developers seek you out for advice. In team meetings, others look to you when technical decisions need to be made. You're invited to architecture meetings because your input is valued. Your manager discusses the timeline for your promotion because it's a "when," not "if."

**You didn't become a different person - you developed skills deliberately.**

**Most importantly: you're making other developers better, and that's what great technical leadership is really about.**

---

## 🚀 Immediate Next Steps (This Week):

1. **Have career conversation with manager** - share this plan
2. **Identify one junior developer** to start mentoring
3. **Choose first system design topic** to master
4. **Schedule weekly code review goals**
5. **Pick first book** from reading list

**You're not hoping to stumble into leadership - you're building it systematically.**

**Next milestone check-in: `/mentor "review 3-month progress and adjust plan"`**

**You've got this! Leadership is built, not born. Let's build yours deliberately. 🚀**
```

### Exemplo 2: Transição de Carreira

**Entrada:**
```bash
/mentor "trabalho em marketing há 5 anos mas quero migrar para tech, especificamente UX design, tenho 32 anos, é muito tarde? como fazer transição sem perder renda?"
```

**Saída Esperada:**
```markdown
# Plano de Transição: Marketing → UX Design (32 anos)

## 💪 Mindset Reset: "Muito Tarde" é Bullshit

**32 anos é o momento PERFEITO para transição para UX.**

**Por quê?**
- **5 anos de marketing** = entendimento profundo de user behavior, business goals
- **Maturidade profissional** = stakeholder management, deadline pressure, communication skills
- **Life experience** = empatia genuína com diferentes user personas
- **Financial stability** = pode fazer transição inteligente, não desesperada

**Pessoas fazem career pivots aos 40, 50, 60. Você está no timing ideal.**

---

## 🎯 Suas Vantagens Competitivas Únicas

### Marketing → UX é Transição NATURAL:

| Marketing Skill | UX Application | Competitive Advantage |
|----------------|----------------|----------------------|
| **User segmentation** | User personas | Você já pensa em target audiences |
| **A/B testing** | Usability testing | Você entende statistical significance |
| **Conversion optimization** | UX optimization | Você liga design a business metrics |
| **Stakeholder communication** | Design buy-in | Você sabe "vender" design decisions |
| **Brand understanding** | Design systems | Você entende brand consistency |
| **Data analysis** | UX research | Você sabe interpretar user data |

**Você não está começando do zero - está aplicando skills em novo contexto.**

---

## 📊 Transition Strategy: Bridge, Don't Burn

### Modelo de Transição Inteligente (12-18 meses):

```
Meses 1-6: BRIDGE BUILDING
├── Current job: 100%
├── UX learning: 10-15h/week
├── Portfolio building: weekends
└── Risk: Zero income loss

Meses 7-12: SKILL VALIDATION
├── Current job: 80-90%
├── Freelance UX: 10-20%
├── Portfolio: client projects
└── Risk: Minimal income loss

Meses 13-18: TRANSITION
├── UX role: full-time
├── Income: matched or higher
├── Portfolio: proven results
└── Risk: Calculated leap
```

---

## 🎓 Learning Strategy: Skills-Based, Not Theory-Heavy

### Phase 1: Foundation (Months 1-3)
**Goal: Understand what UX actually involves day-to-day**

#### Core Concepts (2-3h/week):
- [ ] **UX Process**: Discovery → Design → Test → Iterate
- [ ] **Design Thinking**: Human-centered problem solving
- [ ] **User Research**: Qual vs quant methods
- [ ] **Information Architecture**: Content organization
- [ ] **Interaction Design**: User flows and wireframes
- [ ] **Visual Design**: UI principles, typography, color

#### Tools Learning (2-3h/week):
- [ ] **Figma** (industry standard, free)
- [ ] **Miro/Mural** (workshop facilitation)
- [ ] **Maze/UserTesting** (usability testing)
- [ ] **Google Analytics** (you already know this!)

#### Resource Stack:
```
📚 Books (1 book/month):
- "Don't Make Me Think" by Steve Krug
- "The Design of Everyday Things" by Don Norman
- "About Face" by Alan Cooper

🎥 Online Learning:
- Google UX Design Certificate (Coursera)
- Interaction Design Foundation
- YouTube: AJ&Smart, Flux

🎧 Podcasts (commute time):
- Design Better (InVision)
- User Defenders
- What is Wrong with UX
```

### Phase 2: Application (Months 4-6)
**Goal: Create portfolio pieces that show UX thinking**

#### Project Strategy:
**Don't create fake projects - solve real problems:**

1. **Redesign your current company's product/service**
   - You understand the business deeply
   - Access to real user feedback
   - Can measure actual impact

2. **Pro-bono work for local nonprofits**
   - Real clients with real constraints
   - Portfolio pieces with social impact
   - Testimonials for credibility

3. **Daily UI challenge (modified)**
   - Not just visual design
   - Include user research rationale
   - Show design process, not just output

#### Portfolio Development:
```
Project Structure (repeat 3-4 times):
├── Problem definition (marketing brain advantage)
├── User research (leverage your analytics skills)
├── Ideation & sketching
├── Wireframing & prototyping
├── Usability testing
├── Final design + metrics impact
└── Lessons learned
```

### Phase 3: Transition (Months 7-12)
**Goal: Prove UX skills with real client work**

#### Freelance Strategy:
```
Start Small, Scale Smart:

Month 7-8: $25-40/hour projects
- Website audits for small businesses
- Landing page optimization
- User research for local companies

Month 9-10: $50-75/hour projects
- Full website redesigns
- Mobile app UX consultation
- User journey mapping

Month 11-12: $75-100/hour projects
- Complex application design
- Design system creation
- Multi-phase UX projects
```

#### Client Acquisition:
- **Your marketing network** (they need UX help!)
- **Upwork/Fiverr** (build ratings quickly)
- **Local business groups** (chamber of commerce, etc.)
- **Referrals from current colleagues**

---

## 💰 Financial Strategy: Zero Income Loss

### Income Bridge Plan:

#### Current Situation Analysis:
- **Current salary**: $X/month
- **Essential expenses**: $Y/month
- **Financial cushion needed**: 3-6 months expenses
- **Risk tolerance**: Conservative (smart!)

#### Transition Funding:
```
Revenue Streams During Transition:

Primary (80%): Current marketing job
- Negotiate remote/flexible schedule
- Reduce to 4 days/week if possible
- Use UX skills to improve current role

Secondary (15%): Freelance UX work
- Start with 5-10h/week
- Scale to 15-20h/week
- Goal: $1000-2000/month by month 10

Tertiary (5%): UX-related side income
- Online course creation
- UX writing/blogging
- Design template sales
```

#### Timeline for Income Replacement:
```
Months 1-6: Focus on learning (investment phase)
Months 7-9: $500-1500/month freelance income
Months 10-12: $1500-3000/month freelance income
Months 13+: Full-time UX salary (target: match or exceed current)
```

---

## 🎯 Job Market Strategy: Experience-Focused Positioning

### Your Value Proposition:
**"UX Designer with Marketing Background Who Drives Business Results"**

#### Resume Positioning:
```
WRONG approach:
"Junior UX Designer seeking entry-level position"

RIGHT approach:
"Marketing Professional Transitioning to UX Design
• 5 years optimizing user experience through marketing
• Proven track record improving conversion rates
• Deep understanding of user behavior and business metrics
• Portfolio of UX projects with measurable impact"
```

#### Target Companies:
```
Tier 1 (Highest Probability):
- Marketing agencies adding UX services
- Startups needing marketing + UX hybrid
- Your current company (internal transition)
- Companies where you have warm connections

Tier 2 (Good Fit):
- Mid-size companies with established UX teams
- B2B companies valuing business understanding
- Companies in industries you understand

Tier 3 (Stretch Goals):
- Large tech companies (after 1-2 years experience)
- Design consultancies
- Companies with highly competitive UX teams
```

### Interview Strategy:
```
Leverage Your Background:

Question: "Why UX design?"
Answer: "Through 5 years in marketing, I realized the biggest impact on conversion comes from user experience. I want to solve problems earlier in the funnel - at the design stage rather than trying to optimize poor experiences through campaigns."

Question: "How do you handle stakeholder pushback?"
Answer: "In marketing, I regularly had to defend campaign strategies with data. I bring that same approach to UX - showing how design decisions impact business metrics stakeholders care about."

Question: "What's your biggest weakness?"
Answer: "I sometimes over-research because I love understanding users. I'm learning to balance thorough research with rapid iteration and deadlines."
```

---

## 🚀 Acceleration Strategies

### Leverage Your Marketing Network:
- **Current colleagues** who need UX help
- **Client companies** who know your work quality
- **Marketing agencies** expanding into UX
- **Startup founders** in your network

### Industry Transition Shortcuts:
```
Fast-Track Opportunities:

1. MarTech/AdTech Companies:
   - Need UX designers who understand marketing
   - Your background is huge advantage
   - Often willing to train on UX specifics

2. Marketing Agencies:
   - Adding UX services to offerings
   - Need someone who speaks both languages
   - Internal transition possible

3. E-commerce Companies:
   - Conversion optimization = UX optimization
   - Your marketing metrics knowledge valuable
   - Can show immediate business impact
```

### Networking Strategy:
```
Month 1-2: Join UX communities
- Local IXDA chapter
- UX Mastery Community (online)
- Ladies that Design (if applicable)

Month 3-4: Start contributing
- Share marketing insights in UX contexts
- Comment thoughtfully on others' work
- Offer marketing expertise to UX projects

Month 5-6: Become known
- Speak at UX meetups about marketing/UX intersection
- Write articles about conversion UX
- Mentor other career changers
```

---

## ⚡ Quick Wins Strategy

### Immediate Value-Adds (This Month):
1. **Audit your current company's UX** (free internal project)
2. **Learn Figma basics** (weekend project)
3. **Join UX communities** (networking starts now)
4. **Read "Don't Make Me Think"** (foundation knowledge)

### 90-Day Goals:
- [ ] Complete Google UX Certificate
- [ ] Create first portfolio piece (company audit)
- [ ] Make 10 UX professional connections
- [ ] Land first small freelance project

### 6-Month Goals:
- [ ] 3-4 strong portfolio pieces
- [ ] $500+/month freelance income
- [ ] Speaking opportunity at local meetup
- [ ] Clear transition timeline established

---

## 🛡️ Risk Management

### Worst-Case Scenarios & Mitigation:

#### "What if I can't find UX work after investing time/money?"
**Mitigation**:
- UX skills enhance marketing career (growth marketing, conversion optimization)
- Portfolio projects show strategic thinking
- Freelance income provides secondary revenue stream

#### "What if I take too long to transition?"
**Mitigation**:
- No deadline pressure means quality learning
- Marketing salary continues during transition
- Can accelerate if opportunities arise early

#### "What if I don't like UX after trying it?"
**Mitigation**:
- Marketing + UX skills = unicorn candidate for many roles
- Product marketing roles value UX understanding
- Growth marketing increasingly requires UX knowledge

---

## 🎯 Success Metrics & Milestones

### Monthly Check-ins:
- **Learning hours completed** (target: 10-15/week)
- **Portfolio progress** (projects completed/in progress)
- **Network expansion** (new connections made)
- **Freelance income** (if applicable to timeline)

### Quarterly Major Milestones:
```
Q1: Foundation Built
- UX vocabulary fluent
- First portfolio piece complete
- Local UX community involvement

Q2: Skills Validated
- 3 portfolio pieces complete
- First freelance project delivered
- Industry connections established

Q3: Market Ready
- Portfolio demonstrates UX thinking
- Freelance income growing
- Interview-ready positioning

Q4: Transition Executed
- Full-time UX role secured
- Income matched or exceeded
- Career change complete
```

---

## 💡 The Long-Term Vision

**Picture yourself 2 years from now:**

You're sitting in a design critique, talking through user research findings with developers and product managers. Your marketing background lets you connect design decisions to business metrics in ways your colleagues can't. Companies compete for candidates with your unique skill combination.

**You didn't become a different person - you applied existing strengths in a new field.**

**The marketing skills that brought you success will differentiate you as a UX designer.**

---

## 🎯 Immediate Next Steps (This Week):

1. **Enroll in Google UX Certificate** (Coursera, start immediately)
2. **Download Figma** and complete first tutorial
3. **Join local UX meetup** (find event to attend this month)
4. **Audit one user experience** you interact with daily
5. **Set weekly learning schedule** (specific times blocked)

**This isn't a career restart - it's strategic career evolution.**

**Next check-in: `/mentor "review UX transition progress and adjust timeline"`**

**Your marketing background is an asset, not something to overcome. Use it! 🚀**
```

---

## 🔄 Workflows Combinados

### Workflow Completo: Gestão de Projeto com Múltiplos Agentes

**Cenário**: Desenvolvedor liderando projeto complexo de e-commerce com equipe pequena e prazo apertado.

#### Fase 1: Captura e Organização Inicial
```bash
# Despejo inicial sem filtro
echo "projeto ecommerce prazo 6 semanas, equipe só 3 devs, cliente quer muitas features,
não temos arquitetura definida, frontend/backend/banco todos em aberto,
ansioso com complexidade, não sei por onde começar" >> despejo/daily-dump.md

# Processamento inicial
/organizador despejo/daily-dump.md
```

#### Fase 2: Decisões Técnicas Estratégicas
```bash
# Definir arquitetura
/arquiteto "projeto e-commerce 6 semanas, equipe 3 devs, precisa arquitetura stack completa otimizada para velocidade"

# Organizar decisões técnicas
/organizador "estruturar decisões técnicas do arquiteto em plano implementação"
```

#### Fase 3: Gestão Executiva e Coordenação
```bash
# Criar timeline realista
/secretaria "6 semanas projeto ecommerce, 3 desenvolvedores, criar timeline realista com milestones"

# Status para stakeholders
/secretaria "preparar comunicação para cliente sobre escopo realista vs expectativas"
```

#### Fase 4: Gestão do Stress e Estratégias de Foco
```bash
# Lidar com ansiedade do prazo
/psicologo "liderando projeto complexo, prazo apertado, ansioso com responsabilidade, como manter foco e confiança?"

# Estratégias específicas para equipe pequena
/psicologo "estratégias para manter produtividade equipe pequena sob pressão sem burnout"
```

#### Fase 5: Visão de Longo Prazo e Crescimento
```bash
# Extrair aprendizados de carreira
/mentor "liderando primeiro projeto complexo, como usar esta experiência para crescimento profissional?"

# Planejamento pós-projeto
/mentor "após entregar projeto difícil, quais próximos passos para consolidar posição de liderança?"
```

### Resultado Esperado do Workflow:
- **Projeto estruturado** com arquitetura sólida
- **Timeline realista** comunicada para stakeholders
- **Equipe protegida** contra burnout
- **Estratégias de foco** para alta produtividade
- **Crescimento profissional** extraído da experiência
- **Documentação completa** para futuros projetos

---

**🎯 Os agentes trabalham melhor em combinação - cada um oferece perspectiva única para problemas complexos!**