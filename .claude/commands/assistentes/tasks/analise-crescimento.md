# Task: Análise de Crescimento Profissional

## Configuração
```yaml
elicit: false  # Análise é baseada em dados históricos
language: portuguese
interaction_style: reflective-analytical
focus: longitudinal-patterns
```

## Propósito

Realizar tracking longitudinal de evolução profissional, identificar padrões de crescimento e estagnação, analisar decisões de carreira anteriores e seus resultados, e aprender preferências e valores profissionais ao longo do tempo.

---

## Workflow

### Etapa 1: Coleta de Dados Históricos

**Fontes de informação:**

1. **Metas de carreira** (múltiplos anos):
   - `knowledge-base/carreira/metas-{ano}.md` (todos os anos disponíveis)
   - Metas completas vs incompletas
   - Timing de conclusão vs planejado

2. **Decisões de carreira:**
   - `knowledge-base/decisoes/decisao-*.md` (filtrar por categoria carreira)
   - Mudanças de empresa
   - Transições de papel/área
   - Negociações importantes

3. **Projetos ao longo do tempo:**
   - `knowledge-base/projetos/projeto-*.md` (histórico completo)
   - Datas, duração, papel, tecnologias
   - Menções de sucesso/desafio

4. **Pessoas e networking:**
   - `knowledge-base/pessoas/pessoa-*.md`
   - Conexões profissionais importantes
   - Mentores, colaboradores-chave

5. **Memória do agente:**
   - `.assistant-core/memory/mentor-memory.yaml`
   - `career_tracking.padroes_crescimento`
   - `learned_patterns.padroes_decisao_carreira`

### Etapa 2: Análise Temporal de Metas

**Para cada ano com dados:**

```python
analise_metas = {
  ano: {
    total_metas: X,
    completas: Y,
    incompletas: Z,
    taxa_conclusao: Y/X,

    categorias: {
      tecnico: {completas, incompletas},
      lideranca: {completas, incompletas},
      compensacao: {completas, incompletas},
      # ...
    },

    tempo_medio_conclusao: {
      planejado_vs_real: "X meses planejado, Y meses real"
    },

    metas_abandonadas: [
      {meta, razao_abandono}
    ]
  }
}
```

**Identificar padrões:**

📊 **Padrão de Conclusão:**
- Taxa de conclusão melhorando ou piorando ao longo dos anos?
- Que tipo de meta é mais frequentemente completada?
- Metas técnicas vs liderança vs compensação: qual tipo tem mais sucesso?

⏱️ **Padrão de Timing:**
- Usuário tende a subestimar ou superestimar tempo necessário?
- Metas de longo prazo (2+ anos) têm mais ou menos sucesso que curto prazo?

🎯 **Padrão de Foco:**
- Áreas de foco mudaram ao longo do tempo?
- Exemplo: "2023 foi ano de aprendizado técnico, 2024 pivô para liderança"

### Etapa 3: Análise de Decisões de Carreira

**Para cada decisão significativa:**

```yaml
decisao_analisada:
  titulo: "Mudança para Empresa X"
  data: "2024-03"
  contexto_pre: "Por que foi feita"
  resultado: "O que aconteceu depois"
  alinhamento_valores: "Se foi consistente com valores declarados"
  impacto_metas: "Acelerou ou desviou de metas?"
  aprendizado: "O que aprendeu com isso"
```

**Perguntas de análise:**
- Decisões impulsivas vs planejadas: Qual tipo teve melhor resultado?
- Quando usuário ignorou valores pessoais: Qual foi o custo?
- Houve decisão que pareceu errada mas foi certa (ou vice-versa)?
- Padrão de risk-taking: Conservative vs bold?

**Exemplo de insight:**
```
📌 Padrão Identificado: Risk-Taking Calculado

Análise de 3 mudanças de empresa (2022, 2023, 2024):
- Todas foram para empresas de crescimento (não big tech estável)
- Todas ofereciam aprendizado técnico mesmo com compensação menor
- Resultado: Crescimento acelerado de skills mas instabilidade financeira

Reflexão: Você valoriza aprendizado sobre estabilidade consistentemente.
Consideração: Fase de vida pode exigir mais estabilidade no futuro - planejar transição?
```

### Etapa 4: Análise de Projetos e Evolução Técnica

**Timeline de projetos:**

```
2022: [[projeto-api-legado]] → Backend, Java, Maintenance
      [[projeto-dashboard]]  → Full-stack, React, Greenfield

2023: [[projeto-microservices]] → Arquitetura, Kubernetes, Tech Lead
      [[projeto-ml-pipeline]]   → Data Engineering, Python, Learning

2024: [[projeto-platform-team]] → Platform Eng, Infra-as-Code, Leadership
```

**Análise de evolução:**

📈 **Progressão de Senioridade:**
- Escopo de projetos aumentou?
- Papel mudou? (IC → Tech Lead → Manager)
- Ambiguidade aumentou? (Problemas bem definidos → Mal definidos)

🛠️ **Evolução Técnica:**
- Stack se expandiu ou especializou?
- Profundidade vs amplitude
- Áreas de expertise emergentes

👥 **Liderança e Influência:**
- Tamanho de equipe/projetos liderados
- Tipo de liderança (técnica vs pessoas)
- Influência além do próprio time

### Etapa 5: Identificação de Padrões de Crescimento

**Padrões positivos (aceleram crescimento):**

✅ **Padrão: "Aprendizado através de Projetos Desafiadores"**
- Observação: Crescimento mais rápido em períodos com projetos fora da zona de conforto
- Evidência: Após [[projeto-microservices]], metas técnicas avançaram 2x mais rápido
- Recomendação: Continue buscando projetos 20% além do nível atual

✅ **Padrão: "Network Estratégico"**
- Observação: Conexões com [[pessoa-X]] e [[pessoa-Y]] aceleraram oportunidades
- Evidência: Ambas promoções vieram de projetos co-liderados com essas pessoas
- Recomendação: Investir em relacionamentos profissionais de alto valor

**Padrões negativos (causam estagnação):**

⚠️ **Padrão: "Zona de Conforto Prolongada"**
- Observação: Após 18 meses em [[projeto-manutenção]], metas pararam de avançar
- Evidência: Nenhuma nova habilidade desenvolvida, satisfação diminuiu
- Recomendação: Estabelecer "prazo máximo" de 12-18 meses em projetos similares

⚠️ **Padrão: "Sobre-comprometimento"**
- Observação: Quando assumiu 4+ projetos simultaneamente, todos atrasaram
- Evidência: Q3/2023 teve 0 metas concluídas devido a overwhelm
- Recomendação: Limite hard de 2-3 projetos significativos por vez

### Etapa 6: Análise de Valores Profissionais

**Valores declarados vs demonstrados:**

Compare o que usuário **diz** que valoriza com o que **ações** demonstram:

```yaml
valores_analise:
  aprendizado:
    declarado: "Altamente importante"
    demonstrado: "Consistente - escolheu 3x projetos com aprendizado sobre compensação"
    alinhamento: "✅ FORTE"

  estabilidade:
    declarado: "Importante"
    demonstrado: "Baixo - mudou de empresa 2x em 2 anos, ambas startups"
    alinhamento: "⚠️ DESALINHADO"
    reflexao: "Você diz que valoriza estabilidade, mas age priorizando crescimento/risco. Revisar valores ou reconhecer preferência real?"

  impacto:
    declarado: "Muito importante"
    demonstrado: "Médio - projetos internos de infraestrutura, pouco voltados a usuário final"
    alinhamento: "⚠️ PARCIAL"
    reflexao: "Possível pivô futuro para produtos com impacto de usuário mais direto?"
```

**Evolução de valores:**
- Valores mudaram ao longo dos anos?
- Exemplo: "2022: Compensação era prioridade → 2024: Aprendizado é prioridade"
- Mudanças são consistentes com fase de vida?

### Etapa 7: Previsões e Recomendações Baseadas em Padrões

**Baseado em análise histórica:**

🔮 **Previsões:**
- "Baseado em seu padrão, você provavelmente ficará inquieto em [[projeto-atual]] por volta de {data} (~18 meses)"
- "Seu padrão de crescimento sugere prontidão para {próximo nível} em {prazo}"
- "Tendência de buscar projetos greenfield - próxima oportunidade pode ser {área}"

💡 **Recomendações estratégicas:**

**Curto prazo (3-6 meses):**
- Baseado em padrão de estagnação após 18 meses, considere buscar novo desafio
- Fortalecer conexão com [[pessoa-Y]] - historicamente leva a oportunidades

**Médio prazo (6-12 meses):**
- Seu ciclo de mudança de empresa é ~24 meses. Se padrão continuar, preparar próxima transição
- Expandir influência além do time atual - próximo nível exige isso

**Longo prazo (1-3 anos):**
- Trajetória atual aponta para {papel} - preparar sistematicamente para isso
- Considerando valores de aprendizado, áreas emergentes a explorar: {lista}

### Etapa 8: Visualização de Crescimento

**Timeline visual:**

```
2022                    2023                    2024                    2025
│                       │                       │                       │
├─ Eng II               ├─ Senior Eng           ├─ Tech Lead            ├─ Staff? (meta)
│                       │                       │                       │
├─ 2 projetos           ├─ 4 projetos (over!)   ├─ 3 projetos           │
│  Backend focus        │  Full-stack pivot     │  Platform/Infra       │
│                       │                       │                       │
├─ Empresa A            ├─ Mudança → Empresa B  │                       ├─ Próxima mudança?
│  (2 anos)             │  (startup, risco)     │  (1.5 anos)           │  (baseado em padrão)
│                       │                       │                       │
📊 Satisfação: ████     📊 ████████              📊 ██████
   (estagnação)            (crescimento)            (estável)

🎯 Metas: 2/5 ✅        🎯 4/6 ✅                 🎯 3/4 ✅ (em progresso)
```

**Gráfico de habilidades:**

```
Backend Development:    ████████████████████ (Expert)
Cloud/Infra:           ████████████░░░░░░░░ (Advanced)
System Design:         ████████░░░░░░░░░░░░ (Intermediate) ← Foco atual
Leadership:            ████░░░░░░░░░░░░░░░░ (Developing)   ← Gap para Staff
```

### Etapa 9: Sessão de Reflexão Guiada

**Apresentar análise + provocar reflexão:**

"Com base em 3 anos de dados, identifiquei alguns padrões interessantes sobre sua evolução profissional. Vou compartilhar e gostaria de ouvir suas reflexões."

**Tópicos de discussão:**
1. "Esse padrão de {X} ressoa com você? Por que acha que acontece?"
2. "Notei que você {ação}. Isso é intencional ou aconteceu organicamente?"
3. "Valores declarados vs demonstrados têm desalinhamento em {área}. Pensamentos?"
4. "Se essa trajetória continuar, você chegará em {ponto}. É onde quer estar?"

**Provocações construtivas:**
- "Você cresceu muito em {área}, mas plateaued em {outra}. Intencional?"
- "Padrão de mudanças frequentes serviu bem até agora. Servirá nos próximos 5 anos?"
- "Vejo que você evita {tipo de projeto}. Medo ou desinteresse genuíno?"

---

## Outputs Esperados

1. **Relatório de análise** em `knowledge-base/carreira/analise-crescimento-{ano}.md`
2. **Visualizações** (timeline, gráficos de progresso)
3. **Padrões identificados** (positivos e negativos)
4. **Previsões baseadas em dados**
5. **Recomendações estratégicas** (curto, médio, longo prazo)
6. **Memória atualizada** com padrões aprendidos
7. **Sessão reflexiva** para validar insights com usuário

---

## Estrutura do Relatório de Análise

```markdown
# Análise de Crescimento Profissional - {Ano}

**Data da Análise:** {data}
**Período Analisado:** {inicio} a {fim}

---

## Sumário Executivo

**Trajetória Geral:** [resumo em 2-3 frases]

**Destaques:**
- ✅ {conquista principal 1}
- ✅ {conquista principal 2}
- 📈 {área de crescimento significativo}

**Áreas de Atenção:**
- ⚠️ {padrão problemático 1}
- 💡 {oportunidade não explorada}

---

## Análise de Metas

### Taxa de Conclusão

| Ano | Total | Completas | Taxa |
|-----|-------|-----------|------|
| 2022 | 5 | 2 | 40% |
| 2023 | 6 | 4 | 67% |
| 2024 | 4 | 3 | 75% ⬆️ |

**Tendência:** Melhoria consistente na taxa de conclusão

### Por Categoria

{análise detalhada por tipo de meta}

---

## Evolução de Projetos e Habilidades

{timeline visual + análise}

---

## Decisões de Carreira

{análise de decisões principais e resultados}

---

## Padrões Identificados

### Padrões Positivos

#### 1. {Nome do Padrão}
- **Descrição:** {o que é}
- **Evidências:** {dados que suportam}
- **Recomendação:** {como continuar/amplificar}

### Padrões Negativos

#### 1. {Nome do Padrão}
- **Descrição:** {o que é}
- **Evidências:** {dados que suportam}
- **Impacto:** {custo desse padrão}
- **Recomendação:** {como mitigar}

---

## Análise de Valores

{valores declarados vs demonstrados}

---

## Previsões e Recomendações

### Curto Prazo (3-6 meses)
- {recomendação 1}
- {recomendação 2}

### Médio Prazo (6-12 meses)
- {recomendação 1}

### Longo Prazo (1-3 anos)
- {visão estratégica}

---

## Próxima Análise

**Data Sugerida:** {+6 meses ou +1 ano}

**Áreas de Foco para Próxima Revisão:**
- {item a observar}
```

---

## Princípios para Conversação

✅ **Baseado em Dados**: Sempre citar evidências específicas
✅ **Não-Julgamental**: Padrões são observações, não críticas
✅ **Reflexivo**: Provocar pensamento, não impor conclusões
✅ **Equilibrado**: Celebrar crescimentos + endereçar desafios
✅ **Forward-Looking**: Passado informa futuro, mas foco é próximos passos
✅ **Empático**: Reconhecer contexto pessoal que pode explicar padrões

---

## Tratamento de Cenários Especiais

### Cenário: Dados Insuficientes (Novo Usuário)

**Abordagem:**
- "Ainda não tenho dados suficientes para análise longitudinal completa"
- "Vamos estabelecer baseline hoje. Em 6-12 meses, faremos primeira análise comparativa"
- Focar em definir valores e estabelecer tracking

### Cenário: Padrão Negativo Claro (Ex: Estagnação Prolongada)

**Abordagem empática mas direta:**
- "Vou compartilhar observação que pode ser desconfortável, ok?"
- Apresentar dados factuais
- Perguntar "Como você vê isso?"
- Explorar causas sem julgamento
- Co-criar plano de mudança

### Cenário: Usuário Discorda de Análise

**Validação + curiosidade:**
- "Interessante que você vê diferente. Me ajude a entender sua perspectiva?"
- Pode haver contexto que dados não capturaram
- Ajustar análise com novo input
- Análise é ferramenta, não verdade absoluta

---

**Lembre-se**: Análise de crescimento é espelho que mostra trajetória. Objetivo é consciência para escolhas futuras mais intencionais, não julgamento do passado.