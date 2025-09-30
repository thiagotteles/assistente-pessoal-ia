# Task: Preparar Conversa Difícil

## Configuração
```yaml
elicit: true
language: portuguese
interaction_style: structured-supportive
focus: difficult-conversations
```

## Propósito

Preparar usuário para conversas difíceis (feedback, pedidos, limites), negociações (salariais, promoções), e decisões importantes de carreira através de frameworks estruturados, role-play e simulação.

---

## Workflow

### Etapa 1: Identificação do Tipo de Conversa

**Perguntar ao usuário:**
- "Que tipo de conversa difícil você precisa ter?"

**Categorizar em:**

1. **Feedback Difícil** - Dar feedback negativo/construtivo a alguém
2. **Negociação Salarial** - Pedir aumento ou negociar oferta
3. **Estabelecimento de Limites** - Comunicar boundaries (horário, escopo, carga)
4. **Conversa de Promoção** - Advocacia por promoção/progressão
5. **Decisão de Carreira** - Mudança de empresa, pivô de área, transição
6. **Conflito/Confronto** - Resolver desentendimento ou problema interpessoal
7. **Pedido Difícil** - Pedir algo que pode ser negado (recursos, mudança, exceção)

**Carregar framework apropriado:**
- Ler `.assistant-core/data/frameworks-conversas.md`
- Selecionar seção relevante do framework

### Etapa 2: Coleta de Contexto da Situação

**Elicitação detalhada:**

#### Para TODAS as conversas:

**Pessoas envolvidas:**
- "Quem estará na conversa? Qual o papel/senioridade?"
- "Como é seu relacionamento atual com essa pessoa?"
- "Há dinâmica de poder? (Gestor, peer, report)"

**Contexto da situação:**
- "O que levou a necessidade dessa conversa?"
- "Há histórico relevante?" (Tentativas anteriores, padrões)
- "Qual é o estado emocional atual?" (Seu e da outra pessoa)

**Objetivo da conversa:**
- "Qual o outcome ideal?" (Acordo, mudança de comportamento, clareza)
- "Qual seria outcome aceitável mínimo?"
- "Qual seria outcome inaceitável?" (Para saber quando parar)

#### Contexto específico por tipo:

**Se Feedback Difícil:**
- "Quais comportamentos específicos observou?" (Fatos, não interpretações)
- "Qual o impacto concreto desses comportamentos?"
- "Essa pessoa já recebeu feedback sobre isso antes?"
- "Há receptividade ou resistência esperada?"

**Se Negociação Salarial:**
- "Qual sua compensação atual?"
- "Qual o número que você quer pedir?"
- "Fez pesquisa de mercado?" (Dados de salário para sua senioridade/localização)
- "Quais suas conquistas recentes quantificáveis?"
- "Qual seu BATNA?" (Best Alternative - pode continuar no emprego atual? Tem outra oferta?)
- "Quando foi seu último ajuste?"

**Se Estabelecimento de Limites:**
- "Qual o limite específico que precisa comunicar?" (Horário, escopo, carga)
- "Por que é importante para você?" (Saúde, família, valores)
- "Esse limite foi cruzado antes? Como reagiu?"
- "Qual consequência se limite for violado?" (Algo que VOCÊ controla)

**Se Conversa de Promoção:**
- "Há quanto tempo está no nível atual?"
- "Conhece os critérios de promoção para próximo nível?"
- "Quais evidências tem de estar performando no nível seguinte?"
- "Há gaps conhecidos?" (Áreas onde ainda não demonstrou prontidão)
- "Timing: Período de performance review ou fora de ciclo?"

**Se Decisão de Carreira (Ex: Sair da empresa):**
- "Já decidiu ou ainda está explorando?"
- "Quais são os valores/fatores mais importantes nessa decisão?"
- "Há contraproposta que faria você ficar?" (Se aplicável)
- "Como quer deixar a relação com empresa/gestor?"

### Etapa 3: Preparação Estruturada usando Framework

**Aplicar framework específico:**

#### Exemplo: Preparação para Feedback Difícil

```markdown
## Preparação para Conversa de Feedback

### Situação a Endereçar
**Comportamento específico:**
{Fatos observáveis, não julgamentos}
- Data/contexto: "Na reunião de 15/09, quando..."
- Ação observada: "Você interrompeu 3 vezes antes que eu terminasse o raciocínio"
- Padrão: "Isso tem acontecido em 4 das últimas 5 reuniões"

**Impacto concreto:**
- No trabalho: "Decisão X foi tomada sem considerar informação Y que eu tentava compartilhar"
- Na equipe: "Outros membros hesitam em falar quando você está presente"
- Em mim: "Sinto que minhas contribuições não são valorizadas, diminuiu minha motivação"

### Objetivo da Conversa
**Outcome ideal:** {Pessoa reconhece comportamento, compromete-se a mudança específica}
**Outcome aceitável:** {Pessoa ouve, mesmo que não concorde imediatamente, mostra disposição a refletir}
**Red flag para parar:** {Pessoa fica defensiva/agressiva e conversa não está produtiva}

### Script Preparado

**Abertura (Contexto positivo):**
"João, valorizo nosso trabalho conjunto nos últimos 6 meses. Quero ter uma conversa que pode ser desconfortável, mas acredito que nos ajudará a colaborar ainda melhor. Tudo bem?"

**Situação (Fatos específicos):**
"Tenho notado que em reuniões, especialmente nas últimas semanas, você tem me interrompido frequentemente antes que eu termine de explicar meu raciocínio. Por exemplo, na reunião de ontem sobre {tópico}, quando eu estava explicando {X}, fui interrompido 3 vezes."

**Impacto (Consequências):**
"Quando isso acontece, sinto que minhas ideias não são totalmente ouvidas, e isso me desmotiva a compartilhar. Também notei que outros na equipe hesitam em falar quando isso acontece."

**Pausa para escuta:**
"Como você vê essa situação?"

[ESCUTE genuinamente - não defenda imediatamente]

**Pedido de mudança (Comportamento específico):**
"Eu gostaria que, em reuniões, cada pessoa tenha pelo menos 2-3 minutos para terminar seu pensamento antes de ser interrompido, exceto se for pergunta clarificadora. Isso funciona para você?"

**Acordo:**
[Negociar acordo específico e mensurável]
"Vamos tentar isso nas próximas 2 semanas e revisitar? Se você notar que vou interromper, pode me sinalizar."

### Perguntas Antecipadas e Respostas

**Se pessoa disser: "Eu não percebo que faço isso"**
→ "Entendo. Interrupções podem ser inconscientes. Por isso estou trazendo isso à sua atenção. Podemos acordar em [solução]?"

**Se pessoa disser: "Você é muito sensível"**
→ "Posso entender que você veja assim. E, independente de sensibilidade, o impacto no trabalho é real [reforçar impacto concreto]. Podemos focar em como melhorar colaboração?"

**Se pessoa ficar defensiva/agressiva:**
→ "Vejo que isso está gerando reação forte. Não é minha intenção atacar você. Vamos pausar e retomar quando ambos estiverem mais calmos?"

### Depois da Conversa

**Follow-up escrito (email):**
"Oi João, obrigado por ter essa conversa difícil comigo hoje. Para confirmar nosso alinhamento:
- [Acordo 1]
- [Acordo 2]
Vamos revisar em 2 semanas. Agradeço a abertura."

**Observar comportamento:**
- Houve mudança?
- Reconhecimento do acordo?
- Se não melhorar: Escalação apropriada
```

#### Exemplo: Preparação para Negociação Salarial

```markdown
## Preparação para Negociação Salarial

### Pesquisa de Mercado Completa

**Sua senioridade:** Senior Software Engineer
**Localização:** São Paulo
**Indústria:** Fintech

**Dados de mercado:**
- Percentil 50 (mediana): R$ 15.000
- Percentil 75 (bom): R$ 18.000
- Percentil 90 (excelente): R$ 22.000

**Fontes:** Glassdoor, LinkedIn Salary, Blind, conversas com 3 peers

### Seu Caso (Valor Demonstrado)

**Conquistas últimos 12 meses (quantificadas):**
1. Liderei migração para microservices que reduziu custos de infra em 30% (~R$ 200k/ano economia)
2. Feature de {X} aumentou conversão em 15% (~R$ 500k receita adicional estimada)
3. Mentorei 3 engenheiros júniors, 2 foram promovidos
4. Assumi liderança técnica de projeto crítico com 6 pessoas

**Comparação com expectativas do nível:**
- Entregando além do esperado para Senior (já performando em Staff level em escopo)

**Salário atual:** R$ 14.000
**Último ajuste:** Há 18 meses (apenas inflação)

### Seus Números

**Mínimo aceitável:** R$ 17.000 (abaixo disso, consideraria buscar externamente)
**Alvo (pedido):** R$ 19.500
**Ideal:** R$ 21.000

**Justificativa do alvo:**
- Percentil 75-80 baseado em mercado
- Reflete valor demonstrado (impacto concreto)
- Alinha com responsabilidades de Staff (que já está exercendo parcialmente)

### BATNA (Best Alternative)

**Se negarem:**
- Posso continuar no emprego atual confortavelmente por 6-12 meses
- Tenho 2 empresas que demonstraram interesse recentemente
- Não há urgência financeira extrema

**Força do BATNA:** Média-Alta (não desesperado, mas prefere ficar se possível)

### Script Preparado

**Solicitação de reunião:**
"Oi {Gestor}, gostaria de discutir minha compensação. Podemos agendar 30-45min essa semana?"

**Abertura da conversa:**
"Obrigado pelo tempo. Gostaria de discutir minha compensação atual à luz das minhas contribuições e crescimento no último ano."

**Apresentação do caso:**
"Nos últimos 12 meses, assumi {responsabilidades expandidas} e entreguei {conquistas quantificadas}:
- {Conquista 1 com número}
- {Conquista 2 com número}
- {Conquista 3}

Baseado na minha pesquisa de mercado para Senior Engineers com esse nível de impacto em São Paulo, e considerando que meu último ajuste foi há 18 meses, acredito que R$ 19.500 reflete apropriadamente meu valor de mercado e contribuições."

**Pausa para reação:**
[SILÊNCIO - deixe gestor processar e responder primeiro]

**Se disserem "vou verificar o que é possível":**
"Entendo. Qual seria o timeline para essa discussão? Gostaria de alinhar expectativas."

**Se disserem número abaixo do mínimo:**
"Agradeço a oferta. Estava esperando algo mais próximo de R$ 17-19k baseado em mercado e contribuições. Há flexibilidade?"

**Se disserem "esse é o máximo":**
"Entendo a restrição no salário base. Podemos explorar outras compensações?"
- Bônus: "Há possibilidade de bônus de performance?"
- Equity: "Equity adicional?"
- Título: "Promoção para Staff com ajuste em 6 meses?"
- Revisão antecipada: "Revisão em 6 meses ao invés de 12?"
- Benefícios: "Budget de learning ($X/ano), dias extras de PTO?"

### Alternativas ao Salário Base

| Opção | Valor Equivalente | Prioridade |
|-------|-------------------|------------|
| Bônus anual 20% | +R$ 3.360/mês | Alta |
| 10k equity/ano | +R$ 833/mês | Média |
| Título Staff + ajuste em 6m | Alta (acelera carreira) | Alta |
| +5 dias PTO | Qualidade de vida | Média |
| $3k learning budget | Desenvolvimento | Média-baixa |

### Depois da Negociação

**Se aceitarem:**
"Excelente! Obrigado por reconhecer minhas contribuições. Quando isso entraria em vigor?"
[Confirmar por escrito]

**Se negarem completamente:**
"Entendo a posição da empresa. Posso ter 24-48h para processar e voltar?"
[Avaliar se BATNA (buscar externamente) faz sentido]

**Se proposta parcial (entre mínimo e alvo):**
"Agradeço a proposta de R$ X. Deixe-me processar e volto em Y."
[Considerar trade-offs]
```

### Etapa 4: Role-play e Simulação

**Oferecer prática:**

"Vamos simular a conversa? Eu faço o papel de {pessoa} e você pratica seu script. Isso ajuda a ganhar confiança e identificar pontos fracos."

**Durante role-play:**

1. **Você (Leonardo como outra pessoa):**
   - Fazer papel realista da outra pessoa
   - Incluir objeções prováveis
   - Testar resistências típicas

2. **Observar:**
   - Tom de voz (confiante vs defensivo)
   - Linguagem corporal (se pessoal)
   - Clareza e concisão
   - Respostas a objeções

3. **Feedback imediato:**
   - "Notei que quando mencionou X, ficou defensivo. Tente reformular assim..."
   - "Excelente como você pausou para ouvir após apresentar caso"
   - "Sugestão: Seja mais específico em Y - quantifique"

**Iterar:**
- Fazer 2-3 rounds de prática
- Ajustar script baseado em feedback
- Praticar até usuário sentir confiança

### Etapa 5: Preparação Emocional

**Gerenciamento de ansiedade:**

"Conversas difíceis geram ansiedade - isso é normal e saudável."

**Técnicas pré-conversa:**

1. **Respiração 4-7-8:**
   - Inspire por 4 segundos
   - Segure por 7 segundos
   - Expire por 8 segundos
   - Repita 3-4 vezes antes da conversa

2. **Visualização positiva:**
   - Visualize conversa indo bem (não perfeita, mas produtiva)
   - Imagine sua postura, tom, reações
   - Mentalize outcome positivo

3. **Plano B emocional:**
   - "Se eu ficar muito emocional durante conversa, o que faço?"
   - Resposta: "Pedir pausa de 5min ou propor retomar em outro momento"
   - Ter essa permissão reduz ansiedade

**Mindset apropriado:**

✅ **Adotar:**
- "Esta conversa é necessária e justa"
- "Tenho direito de pedir/estabelecer/comunicar isso"
- "Outcome não define meu valor, apenas essa situação específica"
- "Estou preparado e tenho dados/contexto sólidos"

❌ **Evitar:**
- "Eles vão odiar/demitir/retaliar" (catastrofização)
- "Sou egoísta por pedir isso" (culpa inapropriada)
- "Preciso ser perfeito nessa conversa" (pressão paralisante)

### Etapa 6: Plano de Contingência

**"E se não for como planejado?"**

Preparar para cenários:

**Cenário 1: Reação muito negativa/agressiva**
→ Plano: "Vejo que isso está gerando reação forte que não é produtiva. Vamos pausar e retomar quando estiverem mais calmos?"
→ Permissão para sair: Está ok encerrar conversa não-produtiva

**Cenário 2: Negação completa (ex: salário)**
→ Plano: Pedir 24-48h para processar, não decidir no calor do momento
→ Avaliar BATNA: Buscar externamente, aceitar status quo, ou negociar outras coisas

**Cenário 3: Você fica muito emocional**
→ Plano: "Preciso de um momento. Podemos fazer uma pausa de 5min?"
→ Não há vergonha: Emoção em conversa difícil é humano

**Cenário 4: Pessoa não entende ou minimiza**
→ Plano: Reforçar com exemplos específicos, se persistir, considerar escalar apropriadamente

### Etapa 7: Checklist Final Pré-Conversa

**24h antes:**
- [ ] Script revisado e pronto
- [ ] Evidências/dados organizados (se aplicável)
- [ ] Praticou pelo menos 1x (role-play ou sozinho)
- [ ] Identificou BATNA e plano B
- [ ] Mentalmente preparado

**1h antes:**
- [ ] Revisou pontos principais (não decore palavra por palavra)
- [ ] Fez exercício de respiração
- [ ] Verificou ambiente (privacidade, sem interrupções)
- [ ] Lembrou: "Estou preparado, isso é justo, consigo fazer isso"

**Durante:**
- [ ] Pausa para ouvir após apresentar seu lado
- [ ] Respire entre falas (evite falar corrido por nervosismo)
- [ ] Se ficar emocional, está ok pedir pausa
- [ ] Foco em fatos e impacto, não emoções puras

**Depois (24h):**
- [ ] Enviar email de follow-up com acordos (se aplicável)
- [ ] Registrar resultado em knowledge-base
- [ ] Processar emoções (conversar com mentor/amigo se necessário)
- [ ] Celebrar coragem (independente de outcome)

### Etapa 8: Follow-up Pós-Conversa

**Imediatamente após:**

"Como foi? Quero ouvir sobre a conversa."

**Elicitar:**
- O que foi como esperado?
- O que foi diferente?
- Como você se sentiu?
- Qual foi o outcome?

**Processar juntos:**

Se foi bem:
- Celebrar coragem e preparação
- Identificar o que funcionou
- Registrar aprendizado para próximas conversas

Se não foi bem:
- Validar emoções ("É ok estar frustrado/decepcionado")
- Analisar objetivamente (sem culpa): O que aprendeu?
- Avaliar próximos passos
- Reforçar: Ter a conversa já foi sucesso, outcome não define seu valor

**Registrar aprendizado:**

```markdown
## Conversa: {Título}

**Data:** {data}
**Tipo:** {Feedback/Negociação/Limite/etc}
**Pessoa:** [[pessoa-X]]

**Preparação:**
- Tempo investido: {horas}
- Framework usado: {qual}
- Role-play realizado: {sim/não}

**Outcome:**
- Resultado: {descrição}
- Comparado com esperado: {melhor/igual/pior}

**O que funcionou:**
- {item 1}
- {item 2}

**O que melhoraria:**
- {item 1}

**Aprendizados:**
- {insight 1}

**Próximos passos:**
- [ ] {ação 1}
- [ ] {ação 2}
```

Salvar em: `knowledge-base/carreira/conversas-{ano}.md`

---

## Outputs Esperados

1. **Script preparado** para conversa específica
2. **Prática via role-play** com feedback
3. **Preparação emocional** e técnicas de manejo de ansiedade
4. **Plano de contingência** para cenários difíceis
5. **Checklist** de preparação
6. **Follow-up pós-conversa** para processar e aprender
7. **Registro** em knowledge-base para referência futura

---

## Princípios para Conversação

✅ **Estruturado mas Flexível**: Framework dá confiança, mas adapte à situação real
✅ **Prática Aumenta Confiança**: Role-play reduz ansiedade significativamente
✅ **Validação Emocional**: Ansiedade é normal, não fraqueza
✅ **Foco em Ação, Não Perfeição**: Ter a conversa > ter a conversa perfeita
✅ **Aprendizado Contínuo**: Cada conversa difícil é treino para próxima
✅ **Celebrar Coragem**: Independente de outcome, ter a conversa já é vitória

---

## Tratamento de Cenários Especiais

### Cenário: Usuário Muito Ansioso (Paralisado)

**Abordagem gradual:**
- Começar com visualização/prática sem pressão de fazer conversa real
- Quebrar em micro-passos menores
- Se ansiedade é extrema: Sugerir conversar com psicólogo antes
- Lembrar: "Está ok postergar se não se sente pronto. Preparação leva tempo"

### Cenário: Conversa Já Aconteceu (Foi Mal)

**Foco em recovery:**
- Validar sentimentos
- Analisar objetivamente: Há algo a recuperar?
- Se sim: Preparar follow-up para clarificar/corrigir
- Se não: Aprender e seguir em frente
- Lembrar: Uma conversa difícil não define toda sua carreira

### Cenário: Usuário Quer Ser Agressivo (Não Assertivo)

**Redirecionar para assertividade:**
- "Entendo a frustração. E, abordagem agressiva raramente leva a outcome desejado"
- Mostrar diferença: Agressivo ataca pessoa, Assertivo endereça situação
- Praticar reformulação: De "Você é X" para "Quando Y acontece, impacto é Z"

---

**Lembre-se**: Conversas difíceis são habilidades que se desenvolvem. Primeira vez será imperfeita - e está ok. O importante é ter coragem de começar.