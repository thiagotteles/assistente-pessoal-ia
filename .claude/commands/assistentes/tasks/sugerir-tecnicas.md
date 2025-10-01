# Task: Sugerir Técnicas TDAH Contextualizadas

## Configuração
```yaml
elicit: true
language: portuguese
context_aware: true
requires_library: tecnicas-tdah.md
```

## Propósito
Recomendar técnicas específicas de manejo de TDAH baseadas no contexto emocional e situacional atual.

## Workflow

### Etapa 1: Avaliar Contexto Atual

Perguntas para entender contexto:
1. **Estado emocional:** Como está se sentindo agora? (1-10)
2. **Nível de energia:** Quanta energia tem? (baixa/média/alta)
3. **Situação específica:** O que está enfrentando neste momento?
4. **Urgência:** Isso precisa acontecer agora ou pode esperar?

### Etapa 2: Carregar Biblioteca de Técnicas

Ler `.assistant-core/data/tecnicas-tdah.md` e filtrar técnicas apropriadas.

### Etapa 3: Selecionar Técnica Baseada em Contexto

**Se ANSIEDADE/PÂNICO:**
→ Respiração 4-7-8, Grounding 5-4-3-2-1

**Se PARALISIA/NÃO SABE POR ONDE COMEÇAR:**
→ Micro-Next-Step, Task Chunking

**Se PROCRASTINAÇÃO ATIVA:**
→ Técnica 2-minutos, Time Boxing

**Se OVERWHELM/SOBRECARGA:**
→ Body Scan, Strategic Breaks, Energy Tracking

**Se PENSAMENTOS CATASTRÓFICOS:**
→ Reestruturação Cognitiva, Auto-Compaixão

**Se FALTA DE FOCO:**
→ Pomodoro Adaptado, Body Doubling

**Se BAIXA ENERGIA:**
→ Matching Tasks to Energy, Micro-breaks

**Se PERFECCIONISMO PARALISANTE:**
→ "Good Enough" vs Perfeição, Reconhecimento de Esforço

### Etapa 4: Apresentar Técnica de Forma TDAH-Friendly

Formato claro e acionável:

```
## [Nome da Técnica]

**Para que serve:** [problema específico]

**Como fazer (passo a passo):**
1. [passo simples e curto]
2. [passo simples e curto]
3. [passo simples e curto]

**Exemplo prático no seu contexto:**
[exemplo específico baseado na situação do usuário]

**Quanto tempo:** [duração realista]

**Quando usar:** [momentos específicos]

Quer tentar agora comigo, ou prefere experimentar sozinho(a)?
```

### Etapa 5: Oferecer Suporte na Execução

Se usuário quiser tentar:
- Guiar passo a passo
- Validar tentativa independente de resultado
- Ajustar se necessário

Se usuário preferir depois:
- Resumir em micro-passo claro
- Oferecer lembrança gentil depois

### Etapa 6: Registrar Efetividade

Após tentativa (imediata ou follow-up):
- Técnica funcionou? (sim/parcial/não)
- Por que funcionou ou não?
- Ajustes necessários para próxima vez?

Atualizar `psicologo-memory.yaml` → `user_patterns.tecnicas_efetivas`

## Princípios

1. **Contextualizar SEMPRE** - técnica genérica não serve
2. **TDAH-Friendly** - passos curtos, linguagem clara
3. **Oferecer, não impor** - "Quer tentar?" não "Faça isso"
4. **Validar esforço** - tentar já é sucesso, independente de resultado
5. **Aprender e adaptar** - técnicas evoluem com uso
6. **Múltiplas opções ok** - se uma não serve, oferecer alternativa

## Outputs
- Técnica específica contextualizada
- Guia passo a passo claro
- Suporte na execução (opcional)
- Registro de efetividade para aprendizado