# Manual do Usuário - Assistente Pessoal IA

**Versão**: 1.0
**Data**: 2025-09-26

---

## 🎯 Visão Geral

Este manual ensina como usar eficientemente o sistema de Assistente Pessoal IA com seus 5 agentes especializados. Cada agente tem uma personalidade e função específica para atender diferentes necessidades do seu dia a dia.

## 📋 Índice

1. [Workflow Básico](#workflow-básico)
2. [Os 5 Agentes Detalhados](#os-5-agentes-detalhados)
3. [Casos de Uso Práticos](#casos-de-uso-práticos)
4. [Integração com Obsidian](#integração-com-obsidian)
5. [Dicas para Pessoas com TDAH](#dicas-para-pessoas-com-tdah)
6. [Workflows Avançados](#workflows-avançados)

---

## 🔄 Workflow Básico

### 1. Captura → 2. Processamento → 3. Organização → 4. Ação

#### 1. **Captura** (despejo/daily-dump.txt)
Despeje **tudo** que está na sua mente sem se preocupar com organização:

```
Reunião com Maria às 14h amanhã sobre projeto X
Lembrar de comprar café
Ideia: criar app para organizar receitas
Preciso terminar relatório até sexta
João me enviou uns arquivos por email
Ansioso com apresentação na próxima semana
```

#### 2. **Processamento** (Claude Code + Agentes)
Use os agentes especializados para processar suas informações:

```bash
# No Claude Code
/organizador despejo/daily-dump.txt
```

#### 3. **Organização** (Knowledge Base)
As informações são automaticamente organizadas em:
- `knowledge-base/pessoas/maria.md` - Informações sobre Maria
- `knowledge-base/projetos/projeto-x.md` - Detalhes do projeto
- `todos/por-projeto/projeto-x.md` - Tarefas relacionadas

#### 4. **Ação** (Obsidian + Agentes)
Use o Obsidian para visualizar conexões e os agentes para ações específicas:

```bash
/secretaria "qual o status do projeto X?"
/psicologo "como lidar com ansiedade da apresentação?"
```

---

## 🤖 Os 5 Agentes Detalhados

### `/organizador` - Seu Organizador Pessoal

**Personalidade**: Eficiente, sistemático, gosta de estrutura e categorização

**Especialidades**:
- Processar informações desorganizadas
- Categorizar tarefas e projetos
- Criar estruturas e sistemas
- Identificar prioridades

#### Exemplos Práticos

**Processamento de Despejo Diário:**
```bash
/organizador despejo/daily-dump.txt
```

**Saída esperada:**
```yaml
# Tarefas Identificadas:
- Reunião com Maria (Projeto X) - URGENTE
- Comprar café - PESSOAL
- Terminar relatório - TRABALHO (Deadline: Sexta)

# Ideias Capturadas:
- App de receitas - PROJETO_FUTURO

# Follow-ups:
- Revisar email do João
- Preparar apresentação (fonte de ansiedade identificada)

# Sugestões:
- Agendar time para preparação da apresentação
- Criar checklist para o relatório
```

**Organização de Projeto:**
```bash
/organizador "preciso organizar o projeto de redesign do site"
```

**Estruturação de Informações:**
```bash
/organizador "tenho várias ideias soltas sobre um novo produto, como organizo?"
```

### `/secretaria` - Sua Assistente Executiva

**Personalidade**: Profissional, detalhista, orientada a resultados, excelente comunicadora

**Especialidades**:
- Status e acompanhamento de projetos
- Coordenação de reuniões e agendas
- Comunicação profissional
- Gestão de deadlines

#### Exemplos Práticos

**Status de Projetos:**
```bash
/secretaria "preciso do status completo do projeto X para reunião de amanhã"
```

**Saída esperada:**
```markdown
# Status do Projeto X

## Resumo Executivo
- **Status**: Em andamento (75% concluído)
- **Próximo milestone**: Entrega beta (15/10)
- **Riscos**: Atraso na integração com sistema Y

## Principais Deliverables
✅ Design UI/UX - Concluído
🔄 Desenvolvimento Backend - 80%
⏳ Testes integração - Aguardando

## Próximos Passos
1. Finalizar API do módulo de autenticação
2. Agendar reunião com equipe de QA
3. Preparar demo para stakeholders

## Para a Reunião de Amanhã
- Demo funcional disponível
- Documentação de riscos e mitigações
- Timeline atualizada para entrega final
```

**Preparação de Reuniões:**
```bash
/secretaria "tenho reunião com cliente na terça, o que preciso preparar?"
```

**Acompanhamento de Tarefas:**
```bash
/secretaria "quais tarefas estão atrasadas e precisam de atenção?"
```

### `/arquiteto` - Arquiteto de Soluções

**Personalidade**: Analítico, questionador, gosta de desafios técnicos, confronto construtivo

**Especialidades**:
- Decisões técnicas complexas
- Arquitetura de sistemas e processos
- Análise crítica e confronto construtivo
- Soluções inovadoras

#### Exemplos Práticos

**Decisões Técnicas:**
```bash
/arquiteto "devo usar React ou Vue para este novo projeto?"
```

**Saída esperada:**
```markdown
# Análise Técnica: React vs Vue

## Questionamentos Fundamentais
1. **Qual o tamanho e complexidade do projeto?**
2. **Qual a experiência da equipe com cada framework?**
3. **Quais são os requisitos de performance específicos?**
4. **Há necessidade de integração com sistemas legados?**

## Confronto Construtivo
**React seria a escolha "segura", mas é realmente a melhor?**

### Cenário para React:
- Projetos enterprise complexos
- Equipe experiente com JavaScript
- Ecossistema robusto e maduro
- Demanda do mercado de trabalho

### Cenário para Vue:
- Projetos de médio porte
- Curva de aprendizado mais suave
- Performance superior out-of-the-box
- Melhor para prototipagem rápida

## Recomendação Arquitetural
**Baseado em critérios objetivos:**
[Aguardando suas respostas aos questionamentos para recomendação precisa]

## Próximos Passos
1. Definir arquitetura geral do sistema
2. Criar POC (Proof of Concept) com ambos
3. Avaliar performance em cenário real
```

**Arquitetura de Sistemas:**
```bash
/arquiteto "como estruturar um sistema de e-commerce para 10mil usuários simultâneos?"
```

**Revisão Crítica:**
```bash
/arquiteto "revise esta arquitetura de banco de dados [anexar diagrama]"
```

### `/psicologo` - Psicólogo de Suporte TDAH

**Personalidade**: Empático, compreensivo, especializado em TDAH, focado no bem-estar

**Especialidades**:
- Suporte emocional para TDAH
- Estratégias de foco e organização
- Gestão de ansiedade e overwhelm
- Técnicas de produtividade personalizada

#### Exemplos Práticos

**Gestão de Overwhelm:**
```bash
/psicologo "estou me sentindo sobrecarregado com muitas tarefas e não sei por onde começar"
```

**Saída esperada:**
```markdown
# Estratégia para Gestão de Overwhelm

## Validação Emocional
É completamente normal se sentir sobrecarregado, especialmente para pessoas com TDAH. Você não está falhando - seu cérebro apenas processa informações de forma diferente.

## Técnica Imediata: Brain Dump + Priorização
1. **Despeje tudo** no daily-dump.txt (já fez isso? ótimo!)
2. **Respire fundo** - 3 respirações profundas
3. **Escolha APENAS 3 itens** para hoje
4. **Ignore o resto** temporariamente

## Estratégias TDAH-Específicas
- **Chunking**: Quebrar tarefas grandes em pedaços de 15-25 minutos
- **Pomodoro Modificado**: 25min foco + 10min break + recompensa
- **Body doubling**: Trabalhar "junto" com alguém (virtual ou presencial)

## Para Hoje
1. Qual é a tarefa MAIS importante? (só uma)
2. Em quantos pedaços de 15min ela pode ser dividida?
3. Que recompensa você vai se dar após completar?

## Lembrete Importante
Você já conseguiu muita coisa antes. Este momento difícil vai passar.
Foco no progresso, não na perfeição.
```

**Estratégias de Foco:**
```bash
/psicologo "não consigo manter foco em tarefas chatas, mas preciso fazê-las"
```

**Ansiedade e Procrastinação:**
```bash
/psicologo "estou procrastinando uma apresentação importante por ansiedade"
```

### `/mentor` - Mentor de Carreira

**Personalidade**: Visionário, estratégico, inspirador, focado em crescimento de longo prazo

**Especialidades**:
- Planejamento de carreira
- Desenvolvimento de habilidades
- Networking estratégico
- Coaching para objetivos de longo prazo

#### Exemplos Práticos

**Planejamento de Carreira:**
```bash
/mentor "trabalho como desenvolvedor júnior, como evoluir para senior em 2 anos?"
```

**Saída esperada:**
```markdown
# Plano de Carreira: Júnior → Senior (24 meses)

## Análise da Situação Atual
### Competências Técnicas Necessárias
- **Domínio profundo** da stack principal
- **Arquitetura** de sistemas complexos
- **Code review** e mentoring de outros devs
- **DevOps** e deployment automático

### Competências Comportamentais
- **Liderança técnica** sem autoridade formal
- **Comunicação** com stakeholders não-técnicos
- **Gestão de projetos** e deadlines
- **Mentoring** de desenvolvedores júniors

## Roadmap Estratégico (24 meses)

### Primeiro Trimestre (Meses 1-3)
- [ ] Masterizar framework atual (React/Vue/Angular)
- [ ] Estudar padrões de arquitetura (MVC, MVVM, Clean)
- [ ] Começar a fazer code reviews de colegas
- [ ] **Meta**: Ser referência técnica em 1 área específica

### Segundo Trimestre (Meses 4-6)
- [ ] Estudar backend e bancos de dados
- [ ] Implementar projeto pessoal complexo
- [ ] Apresentar tech talk para equipe
- [ ] **Meta**: Contribuir em decisões arquiteturais

### Terceiro Trimestre (Meses 7-9)
- [ ] Liderar projeto de média complexidade
- [ ] Mentorar desenvolvedor estagiário/júnior
- [ ] Estudar DevOps (Docker, CI/CD)
- [ ] **Meta**: Ser responsável por entregas completas

### Quarto Trimestre (Meses 10-12)
- [ ] Propor melhorias no processo de desenvolvimento
- [ ] Participar de recrutamento técnico
- [ ] Estudar gestão de equipes técnicas
- [ ] **Meta**: Demonstrar liderança técnica

### Ano 2 (Meses 13-24)
- [ ] Liderar projetos críticos
- [ ] Definir padrões técnicos da equipe
- [ ] Mentoring formal de 2-3 desenvolvedores
- [ ] **Meta**: Promoção para Senior

## Marcos de Validação
- **Mês 6**: Feedback 360° com líder atual
- **Mês 12**: Revisão de performance + aumento
- **Mês 18**: Discussão sobre promoção
- **Mês 24**: Promoção para Senior

## Próximos Passos Imediatos
1. Qual área técnica você quer ser referência primeiro?
2. Tem algum projeto atual que pode começar a liderar?
3. Há desenvolvedores mais júniors que você pode ajudar?
```

**Desenvolvimento de Habilidades:**
```bash
/mentor "preciso melhorar minhas soft skills para crescer profissionalmente"
```

**Transição de Carreira:**
```bash
/mentor "trabalho em marketing mas quero migrar para tecnologia, como fazer essa transição?"
```

---

## 🎯 Casos de Uso Práticos

### Caso 1: Gerenciamento de Projeto Complexo

**Situação**: Você está liderando um projeto de desenvolvimento de app com múltiplos stakeholders.

**Workflow**:
1. **Captura inicial** (`despejo/daily-dump.txt`):
   ```
   Projeto app delivery
   reunião cliente terça 14h
   dev backend está atrasado
   designer pediu mais tempo para UI
   CEO quer demo para sexta
   ansioso com prazo apertado
   ```

2. **Organização** (`/organizador`):
   ```bash
   /organizador despejo/daily-dump.txt
   ```

3. **Status executivo** (`/secretaria`):
   ```bash
   /secretaria "preciso de status completo do projeto app delivery para reunião com CEO"
   ```

4. **Decisões técnicas** (`/arquiteto`):
   ```bash
   /arquiteto "backend atrasado está impactando timeline, que alternativas arquiteturais temos?"
   ```

5. **Gestão da ansiedade** (`/psicologo`):
   ```bash
   /psicologo "ansioso com prazo apertado do projeto, como lidar?"
   ```

6. **Visão estratégica** (`/mentor`):
   ```bash
   /mentor "como transformar este projeto em oportunidade de crescimento profissional?"
   ```

### Caso 2: Planejamento de Carreira

**Situação**: Desenvolvedor que quer se tornar Tech Lead.

**Workflow**:
1. **Análise estratégica** (`/mentor`):
   ```bash
   /mentor "sou dev pleno, quero virar tech lead em 1 ano"
   ```

2. **Organização do plano** (`/organizador`):
   ```bash
   /organizador "tenho várias habilidades que preciso desenvolver, como priorizar?"
   ```

3. **Acompanhamento executivo** (`/secretaria`):
   ```bash
   /secretaria "como acompanhar progresso mensal do meu plano de carreira?"
   ```

4. **Decisões de aprendizado** (`/arquiteto`):
   ```bash
   /arquiteto "devo focar mais em habilidades técnicas ou gestão de pessoas?"
   ```

5. **Gestão da confiança** (`/psicologo`):
   ```bash
   /psicologo "sinto síndrome do impostor ao pensar em liderar uma equipe"
   ```

### Caso 3: Gestão de TDAH no Trabalho

**Situação**: Pessoa com TDAH lutando com produtividade e foco.

**Workflow**:
1. **Captura sem filtro** (`despejo/daily-dump.txt`):
   ```
   não consegui focar hoje
   muitas reuniões interromperam meu flow
   esqueci de responder email importante
   começei 5 tarefas, não terminei nenhuma
   frustrado comigo mesmo
   ```

2. **Suporte emocional** (`/psicologo`):
   ```bash
   /psicologo despejo/daily-dump.txt
   ```

3. **Estruturação TDAH-friendly** (`/organizador`):
   ```bash
   /organizador "como organizar meu dia considerando TDAH?"
   ```

4. **Gestão executiva adaptada** (`/secretaria`):
   ```bash
   /secretaria "preciso de sistema de acompanhamento que funcione para TDAH"
   ```

5. **Estratégias de longo prazo** (`/mentor`):
   ```bash
   /mentor "como construir carreira sólida tendo TDAH como neurodivergência?"
   ```

---

## 🧠 Integração com Obsidian

### Configuração Básica

1. **Abra a knowledge-base como vault**:
   - Obsidian → Open folder as vault → selecione `knowledge-base/`

2. **Explore as conexões**:
   - Use o Graph View para ver relacionamentos
   - Ative o backlinks panel
   - Use o comando `[[` para criar referências

### Workflows com Obsidian

#### Visualização de Projetos
```markdown
# Em knowledge-base/projetos/meu-projeto.md

# Meu Projeto

## Pessoas Envolvidas
- [[João Silva]] - Desenvolvedor Backend
- [[Maria Santos]] - Designer UI/UX
- [[Pedro Costa]] - Product Owner

## Tecnologias
- [[React]] para frontend
- [[Node.js]] para backend
- [[PostgreSQL]] para banco de dados

## Decisões Importantes
- [[2025-01-15 - Decisão sobre arquitetura]]
- [[2025-01-20 - Mudança no escopo]]
```

#### Mapa Mental de Ideias
Use o Graph View para visualizar como suas ideias se conectam automaticamente através das referências `[[]]`.

### Dicas Avançadas

- **Templates**: Use `diario/templates/` para padronizar entradas
- **Tags**: Use #projeto #pessoa #decisao para categorização
- **Daily Notes**: Configure para captura diária automática
- **Backlinks**: Sempre check o painel de backlinks para descobrir conexões

---

## 🎯 Dicas para Pessoas com TDAH

### Estratégias de Captura

#### 1. Princípio do "Brain Dump"
- **NUNCA** se preocupe com organização na captura
- Use `despejo/daily-dump.txt` como extensão do seu cérebro
- Capture TUDO: ideias, tarefas, preocupações, lembretes

#### 2. Capture Múltipla
- Tenha múltiplos pontos de captura:
  - `daily-dump.txt` para desktop
  - App de notas no celular que sincroniza
  - Papel físico para emergências
- Processe tudo com `/organizador` regularmente

### Estratégias de Processamento

#### 1. Time-boxing com Agentes
```bash
# Sessão de 30 minutos de organização
/organizador despejo/daily-dump.txt
# Quebra de 10 minutos
/psicologo "como manter energia para próxima sessão?"
# Sessão de 30 minutos de ação
/secretaria "que 3 coisas mais importantes posso fazer agora?"
```

#### 2. Rotina de Check-ins
- **Manhã**: `/organizador` + `/secretaria` para planejar o dia
- **Meio-dia**: `/psicologo` para check emocional
- **Tarde**: `/secretaria` para status e próximos passos
- **Noite**: `/mentor` para reflexão e aprendizados

### Estratégias de Foco

#### 1. Agentes como Body Doubling
Use os agentes como "companhia" durante trabalho:
```bash
/psicologo "vou começar uma sessão de foco de 25 minutos, me dê motivação"
# [trabalhar por 25 minutos]
/psicologo "completei a sessão, me celebre e dê próximos passos"
```

#### 2. Quebra de Tarefas Automática
```bash
/organizador "preciso fazer [tarefa grande], quebre em pedaços de 15 minutos"
/psicologo "qual a melhor ordem para fazer essas subtarefas considerando minha energia?"
```

### Gestão de Overwhelm

#### 1. Protocolo de Emergência
Quando se sentir sobrecarregado:
```bash
/psicologo "protocolo de emergência para overwhelm"
# Siga as instruções do psicólogo
/organizador "das tarefas que tenho, quais são realmente urgentes?"
# Foque apenas no essencial
```

#### 2. Validação Emocional Regular
```bash
/psicologo "como está minha saúde mental hoje?"
# Use para check-ins regulares e ajustes de estratégia
```

---

## 🚀 Workflows Avançados

### Workflow 1: Gestão de Múltiplos Projetos

Para pessoas que gerenciam vários projetos simultâneos:

```bash
# 1. Captura consolidada semanal
/organizador "consolide informações de todos os projetos da semana"

# 2. Status executivo por projeto
/secretaria "status individual de cada projeto ativo"

# 3. Priorização estratégica
/mentor "como priorizar tempo entre projetos esta semana?"

# 4. Check-in emocional
/psicologo "como está meu bem-estar gerenciando múltiplos projetos?"

# 5. Otimizações técnicas
/arquiteto "que processos posso automatizar para ser mais eficiente?"
```

### Workflow 2: Preparação para Reunião Importante

```bash
# 1. Preparação de conteúdo
/secretaria "prepare agenda e materiais para reunião com [pessoa/equipe]"

# 2. Revisão técnica
/arquiteto "revise pontos técnicos e antecipe possíveis questionamentos"

# 3. Preparação emocional
/psicologo "estratégias para confiança e foco durante a reunião"

# 4. Visão estratégica
/mentor "como usar esta reunião para atingir objetivos de longo prazo?"

# 5. Organização final
/organizador "checklist final para não esquecer nada importante"
```

### Workflow 3: Review Semanal Completo

```bash
# Segunda-feira: Planejamento
/organizador "organize as capturas da semana passada"
/secretaria "status de todos os projetos e próximas ações"
/mentor "como a semana se alinha com objetivos maiores?"

# Quarta-feira: Check-in do meio
/psicologo "como está meu bem-estar no meio da semana?"
/secretaria "ajustes necessários no planejamento da semana?"

# Sexta-feira: Retrospectiva
/mentor "que lições aprendi esta semana?"
/psicologo "como celebrar conquistas e aprender com dificuldades?"
/organizador "prepare captura para próxima semana"
```

---

## 📊 Métricas de Sucesso

### Indicadores de que o Sistema Está Funcionando

#### Pessoais
- Menos ansiedade sobre "esquecer coisas importantes"
- Maior clareza sobre prioridades
- Sensação de progresso constante
- Melhor equilíbrio vida/trabalho

#### Profissionais
- Entrega mais consistente de projetos
- Melhor comunicação com equipe/clientes
- Decisões técnicas mais fundamentadas
- Crescimento de carreira mais direcionado

#### TDAH-Específicos
- Redução de overwhelm
- Maior capacidade de foco sustentado
- Menos procrastinação
- Autocompaixão aumentada

### Ajustes e Personalização

Cada pessoa é única. Use este manual como base e adapte:

- **Frequência**: Alguns precisam de check-ins diários, outros semanais
- **Agentes favoritos**: Alguns usarão mais o `/psicologo`, outros o `/arquiteto`
- **Workflows**: Crie seus próprios baseados nos exemplos
- **Vocabulário**: Ensine termos específicos aos agentes ao longo do tempo

---

## 🔧 Próximos Passos

1. **Leia este manual por seções**, não tudo de uma vez
2. **Comece com o workflow básico** (Captura → Processamento → Organização → Ação)
3. **Experimente um agente por vez** até se familiarizar
4. **Adapte os exemplos** para sua realidade específica
5. **Use o Obsidian** para visualizar como suas informações se conectam
6. **Seja paciente consigo mesmo** - sistemas levam tempo para serem internalizados

---

**Lembre-se**: Este sistema foi criado para **você**. Adapte, modifique e personalize conforme suas necessidades específicas. Os agentes estão aqui para apoiar, não para julgar ou pressionar.

🤖 **Seus agentes estão prontos para ajudar!** Comece com `/organizador despejo/daily-dump.txt` e veja a mágica acontecer.