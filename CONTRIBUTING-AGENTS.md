# Como Contribuir com um Agente

Bem-vindo! Contribuir com um novo agente é simples. Siga este guia passo a passo.

---

## 📋 Pré-requisitos

- Fork do repositório
- Node.js >= 14
- Conhecimento básico de YAML

---

## 🚀 Passo a Passo

### 1. Fork e Clone

```bash
# Fork via GitHub UI
git clone https://github.com/SEU-USER/assistente-pessoal-ia.git
cd assistente-pessoal-ia
npm install
```

### 2. Criar Branch

```bash
git checkout -b feat/agente-NOME
```

### 3. Criar Estrutura do Agente

```bash
mkdir -p src/agents/community/SEU-AGENTE
cd src/agents/community/SEU-AGENTE
```

**Arquivos obrigatórios**:
- `agent.yaml` - Configuração do agente
- `README.md` - Documentação

**Arquivos opcionais**:
- `memory-template.yaml` - Template de memória
- `tasks/` - Tasks específicos (`.md`)

### 4. Criar `agent.yaml`

```yaml
name: "Seu Agente"
command: "/seu-agente"
version: "1.0"
personality:
  type: "supportivo" # ou "confrontador-construtivo"
  traits:
    - "Característica 1"
    - "Característica 2"

functions:
  - name: "funcao_principal"
    description: "O que o agente faz"

prompts:
  greeting: "Olá! Sou o Agente X. Como posso ajudar?"
  processing: "Estou processando..."
```

### 5. Criar `README.md`

```markdown
# Agente: [Nome]

**Comando**: `/seu-agente`
**Autor**: @seu-github
**Categoria**: [financas/criativo/outro]

## 🎯 O que faz

[Descrição clara em 2-3 frases]

## ✨ Funcionalidades

- Feature 1
- Feature 2

## 📝 Exemplo de Uso

\`\`\`
/seu-agente analise meus gastos do mês
\`\`\`

## 🔗 Dependências

- Nenhuma (ou liste aqui)
```

### 6. Adicionar ao Registry

Edite `src/agents/agents.json`:

```json
{
  "agents": {
    "community": [
      {
        "id": "seu-agente",
        "name": "Seu Agente",
        "title": "Título Curto",
        "icon": "💰",
        "description": "Descrição curta (máx 80 chars)",
        "required": false,
        "recommended": false,
        "author": "seu-github",
        "author_github": "https://github.com/seu-user",
        "category": "financas",
        "tags": ["tag1", "tag2"],
        "path": "src/agents/community/seu-agente",
        "version": "1.0.0"
      }
    ]
  }
}
```

### 7. Testar Localmente

```bash
npm link
assistente-pessoal add seu-agente
assistente-pessoal info seu-agente
```

### 8. Validar

```bash
npm run validate-agents
```

Deve passar sem erros!

### 9. Commit e Push

```bash
git add .
git commit -m "feat: Adicionar agente SEU-AGENTE"
git push origin feat/agente-NOME
```

### 10. Criar Pull Request

1. Vá para seu fork no GitHub
2. Clique em "Compare & pull request"
3. Preencha o template (veja abaixo)
4. Aguarde review!

---

## 📝 Template de Pull Request

```markdown
## Novo Agente: [Nome]

**Categoria**: [financas/criativo/tecnico/etc]
**Comando**: `/seu-agente`

### 🎯 O que faz

[Descrição clara]

### ✅ Checklist

- [ ] `agent.yaml` criado
- [ ] `README.md` criado
- [ ] Adicionado ao `agents.json`
- [ ] `npm run validate-agents` passou
- [ ] Testado localmente com `npm link`
- [ ] Documentação completa

### 🧪 Como Testar

\`\`\`bash
assistente-pessoal add seu-agente
# Testar funcionalidade...
\`\`\`
```

---

## ✅ Critérios de Aprovação

**Obrigatórios**:
- ✅ Estrutura correta (agent.yaml + README.md)
- ✅ ID único (não duplicado)
- ✅ Validação passa (`npm run validate-agents`)
- ✅ Documentação clara

**Recomendados**:
- ✅ Exemplos de uso
- ✅ Testes (se aplicável)
- ✅ Screenshots/GIFs (se visual)

---

## 🚫 O que NÃO fazer

- ❌ Modificar agentes `core/` ou `official/`
- ❌ Alterar `package.json` sem necessidade
- ❌ Incluir secrets ou dados sensíveis
- ❌ Agentes que fazem requisições externas sem avisar
- ❌ Código malicioso ou ofensivo

---

## 📂 Estrutura de Categorias

**Existentes**:
- `essencial` - Core system (apenas oficial)
- `produtividade` - Gestão de tarefas
- `tecnico` - Desenvolvimento e arquitetura
- `bem-estar` - Saúde mental
- `carreira` - Desenvolvimento profissional
- `financas` - Gestão financeira
- `criativo` - Design e criatividade

**Adicionar nova categoria?**
Discuta no Issue primeiro!

---

## 🎨 Guia de Ícones

Use emojis relevantes:
- 💰 Finanças
- 🎨 Criativo/Design
- 📚 Educação/Estudos
- 🏃 Fitness/Saúde
- 🎮 Games/Hobbies
- 🌍 Viagens
- 👨‍👩‍👧 Família/Relacionamentos

---

## 💡 Inspiração

Veja agentes existentes:
- `src/agents/official/secretaria/` - Gestão executiva
- `src/agents/official/mentor/` - Desenvolvimento de carreira

---

## 🆘 Ajuda

- **Issues**: [GitHub Issues](https://github.com/yourusername/assistente-pessoal-ia/issues)
- **Discussões**: [GitHub Discussions](https://github.com/yourusername/assistente-pessoal-ia/discussions)

---

**Obrigado por contribuir! 🎉**
