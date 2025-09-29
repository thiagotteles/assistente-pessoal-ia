# 🚨 IMPORTANTE - LEIA PRIMEIRO ANTES DE DESENVOLVER

## ⚠️ AVISO CRÍTICO PARA DESENVOLVEDORES

### ❌ NÃO USE REFERÊNCIAS AO "BMAD"

**BMAD™, bmad-core, bmad-method eram apenas exemplos temporários e foram REMOVIDOS do projeto.**

Se você vê referências ao BMAD em qualquer lugar:
- 🚫 **NÃO** implemente nada relacionado ao BMAD
- 🚫 **NÃO** crie pastas .bmad-core
- 🚫 **NÃO** use nomenclatura BMAD™
- 🚫 **NÃO** referencie arquivos bmad-*

### ✅ USE APENAS NOSSA NOMENCLATURA OFICIAL

**Nosso método se chama: "Método Conversacional" ou "Agentes Conversacionais"**

#### 📁 Estrutura Correta de Pastas:
```
.assistant-core/           ← CORRETO
├── agents/               ← CORRETO
├── tasks/                ← CORRETO
├── templates/            ← CORRETO
├── memory/               ← CORRETO
└── data/                 ← CORRETO

.bmad-core/               ← ❌ ERRADO - NÃO CRIAR
```

#### 📝 Nomenclatura Correta:
- ✅ "Método Conversacional"
- ✅ "Agentes Conversacionais"
- ✅ "Sistema Conversacional"
- ❌ "BMAD™" ou "bmad-method"

### 📚 Documentação Oficial

**SEMPRE consulte estes arquivos antes de desenvolver:**

1. **OBRIGATÓRIO**: `docs/architecture/agentes-conversacionais-guidelines.md`
   - Diretrizes completas de implementação
   - Exemplos corretos vs incorretos
   - Como NÃO implementar agentes

2. **Template de Stories**: `.assistant-core/templates/story-template-conversacional.md`
   - Template oficial para novas histórias
   - Seções obrigatórias para agentes conversacionais

3. **Exemplo de Agente**: `.assistant-core/agents/organizador.md`
   - Implementação correta de agente conversacional
   - Estrutura YAML adequada

### 🧪 Como Validar Sua Implementação

Execute sempre o teste antes de entregar:
```bash
bash test-story-2.1.sh
```

**Este teste detecta automaticamente:**
- ❌ Referências incorretas ao BMAD
- ❌ Scripts Python para lógica de agente
- ❌ Estruturas incorretas
- ✅ Implementação conversacional correta

### 🚨 SINAIS DE IMPLEMENTAÇÃO INCORRETA

Se você vê qualquer uma dessas coisas, PARE e corrija:

#### ❌ Sinais de Erro:
- Pastas ou arquivos com "bmad" no nome
- Referências a "BMAD™" em código ou documentação
- Scripts Python (.py) para lógica de agentes
- Arquivos de configuração "bmad-core"
- Importações de bibliotecas "bmad"

#### ✅ Sinais de Implementação Correta:
- Arquivos .md com definições de agentes em YAML
- Comunicação natural em português
- Tasks como workflows conversacionais
- Memória YAML adaptativa
- Templates para estruturação de dados

### 📋 Checklist Obrigatório

Antes de fazer commit, confirme:

- [ ] ✅ Não há referências ao "BMAD" em lugar nenhum
- [ ] ✅ Uso apenas de "Método Conversacional" ou "Agentes Conversacionais"
- [ ] ✅ Estrutura .assistant-core/* correta
- [ ] ✅ Teste `bash test-story-2.1.sh` passou
- [ ] ✅ Documentação consultada: `agentes-conversacionais-guidelines.md`
- [ ] ✅ Se implementou agente: é conversacional, não script Python

### 🆘 Em Caso de Dúvida

1. **PARE** - não implemente nada
2. **CONSULTE** - `docs/architecture/agentes-conversacionais-guidelines.md`
3. **PERGUNTE** - ao Product Owner ou Scrum Master
4. **TESTE** - sempre execute `bash test-story-2.1.sh`

### 📞 Contatos para Esclarecimentos

- **Product Owner**: Responsável por validar implementação conversacional
- **Scrum Master**: Orientação sobre metodologia do projeto

---

## 🎯 Resumo para Pressa

**Se você está com pressa, lembre-se apenas disso:**

1. 🚫 **JAMAIS** use "BMAD" em qualquer lugar
2. ✅ **SEMPRE** use "Método Conversacional"
3. 📁 **SEMPRE** use estrutura `.assistant-core/*`
4. 📚 **SEMPRE** leia `agentes-conversacionais-guidelines.md` primeiro
5. 🧪 **SEMPRE** execute `bash test-story-2.1.sh` antes de entregar

---

**⚡ Esta documentação previne reintrodução de conceitos obsoletos e garante implementações corretas!**