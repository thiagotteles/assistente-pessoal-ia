# Perguntas Frequentes - Assistente Pessoal IA

**Versão**: 1.0
**Data**: 2025-09-26

---

## 🎯 Visão Geral

Este FAQ responde às perguntas mais comuns sobre instalação, configuração e uso do Assistente Pessoal IA. As perguntas estão organizadas por categoria para facilitar a busca.

## 📋 Índice

1. [Instalação e Configuração](#instalação-e-configuração)
2. [Uso dos Agentes](#uso-dos-agentes)
3. [Integração com Obsidian](#integração-com-obsidian)
4. [Backup e Segurança](#backup-e-segurança)
5. [Performance e Limitações](#performance-e-limitações)
6. [Personalização](#personalização)
7. [TDAH e Neurodivergência](#tdah-e-neurodivergência)
8. [Problemas Técnicos](#problemas-técnicos)

---

## 🔧 Instalação e Configuração

### ❓ **É difícil de instalar? Preciso de conhecimento técnico?**

**R:** Não! O sistema foi projetado para ser simples:
1. Execute o script de setup (`setup.sh` ou `setup.bat`)
2. Execute o teste (`bash test-basic.sh`)
3. Comece a usar

Se encontrar problemas, o arquivo [TROUBLESHOOTING.md](TROUBLESHOOTING.md) resolve a maioria dos casos.

### ❓ **Quais são os requisitos mínimos do sistema?**

**R:** Requisitos são mínimos:
- **Python 3.8+** (para funcionalidades avançadas)
- **Git** (para backup automático)
- **Claude Code** (interface principal)
- **Obsidian** (recomendado, mas opcional)
- **5GB** de espaço livre em disco
- Qualquer sistema: Windows, macOS ou Linux

### ❓ **Funciona offline? Preciso de internet?**

**R:** O sistema é **100% local**:
- ✅ Funciona completamente offline
- ✅ Nenhum dado enviado para nuvem
- ✅ Privacidade total
- ⚠️ Internet necessária apenas para:
  - Setup inicial (se baixar dependências)
  - Backup para repositório remoto (opcional)
  - Uso do Claude Code (que você já tem)

### ❓ **Onde ficam meus dados? São seguros?**

**R:** Todos os dados ficam no **seu computador**:
- Localização: Pasta do projeto `assistente-pessoal-ia/`
- Nenhum dado é enviado para servidores externos
- Backup via Git (você controla onde fica)
- Criptografia padrão do seu sistema operacional

### ❓ **Como faço backup dos meus dados?**

**R:** O sistema já vem configurado com backup automático via Git. Veja o guia completo em [BACKUP.md](BACKUP.md). Resumo:
```bash
# Backup manual rápido
git add . && git commit -m "backup" && git push

# Configurar backup automático
# (veja BACKUP.md para detalhes)
```

---

## 🤖 Uso dos Agentes

### ❓ **Como escolho qual agente usar para cada situação?**

**R:** Cada agente tem uma especialidade:

- **`/organizador`**: Quando tiver informações caóticas para organizar
- **`/secretaria`**: Para status de projetos, coordenação, agendamento
- **`/arquiteto`**: Para decisões técnicas, análise crítica
- **`/psicologo`**: Quando se sentir sobrecarregado, ansioso, precisar de estratégias TDAH
- **`/mentor`**: Para planejamento de carreira, direcionamento de longo prazo

**Dica**: Quando em dúvida, comece com `/organizador` para estruturar as informações.

### ❓ **Os agentes lembram de conversas anteriores?**

**R:** Sim! Cada agente tem **memória persistente**:
- Lembram de projetos em andamento
- Conhecem seu histórico de interações
- Adaptam respostas com base no contexto acumulado
- Memória compartilhada entre agentes quando relevante

### ❓ **Posso usar vários agentes para a mesma questão?**

**R:** Absolutamente! É até recomendado:

**Exemplo - Projeto complexo:**
1. `/organizador` - Para estruturar informações iniciais
2. `/arquiteto` - Para decisões técnicas
3. `/secretaria` - Para coordenação e acompanhamento
4. `/psicologo` - Se houver ansiedade com prazos
5. `/mentor` - Para alinhar com objetivos de carreira

### ❓ **Como faço para "treinar" os agentes com meu contexto?**

**R:** Os agentes aprendem automaticamente:
- Use o arquivo `despejo/daily-dump.md` regularmente
- Processe com `/organizador despejo/daily-dump.md`
- Interaja naturalmente com cada agente
- Quanto mais usar, mais personalizados ficam

### ❓ **Os agentes podem cometer erros?**

**R:** Sim, como qualquer ferramenta IA:
- Sempre revise sugestões importantes
- Use como consultor, não como decisor final
- Para decisões críticas, busque validação adicional
- O sistema é projetado para apoiar, não substituir seu julgamento

---

## 🧠 Integração com Obsidian

### ❓ **É obrigatório usar o Obsidian?**

**R:** Não é obrigatório, mas é **altamente recomendado**:
- ✅ **Sem Obsidian**: Sistema funciona normalmente, dados em markdown
- ⭐ **Com Obsidian**: Visualização em grafo, backlinks, navegação rica

### ❓ **Como configuro o Obsidian corretamente?**

**R:** É automático:
1. Instale o Obsidian (gratuito)
2. "Open folder as vault" → selecione `knowledge-base/`
3. Aceite as configurações automáticas
4. Pronto! O grafo já estará funcional

### ❓ **O que são essas referências [[]] que vejo nos arquivos?**

**R:** São **wikilinks** do Obsidian:
- `[[João Silva]]` cria link para arquivo sobre João
- Se o arquivo não existir, Obsidian oferece criá-lo
- Permitem navegação rápida entre conceitos relacionados
- Fundamentais para o "segundo cérebro" funcionar

### ❓ **Posso usar outros editores de markdown?**

**R:** Sim, os dados são markdown padrão:
- **VS Code**: Com extensões de markdown
- **Typora**: Editor markdown WYSIWYG
- **Zettlr**: Alternativa ao Obsidian
- **Logseq**: Outra alternativa com blocos

Mas o Obsidian oferece a melhor experiência integrada.

### ❓ **Como organizo informações no Obsidian?**

**R:** O sistema já vem organizado:
```
knowledge-base/
├── pessoas/     # [[João Silva]], [[Maria Santos]]
├── projetos/    # [[Projeto X]], [[App Delivery]]
├── decisoes/    # Decisões importantes documentadas
└── contextos/   # Contextos de trabalho e vida
```

Use as pastas como guia, mas o mais importante são os links `[[]]`.

---

## 🛡️ Backup e Segurança

### ❓ **Meus dados podem ser perdidos?**

**R:** Com as configurações padrão, **muito difícil**:
- Git mantém histórico completo local
- Backup automático para repositório remoto
- Script de recuperação para problemas comuns
- Múltiplas camadas de proteção

### ❓ **E se eu deletar algo importante por acidente?**

**R:** Recovery é simples com Git:
```bash
# Ver histórico
git log --oneline

# Recuperar arquivo específico
git checkout HEAD~1 -- arquivo-deletado.md

# Voltar tudo para ontem
git reset --hard HEAD~1
```

### ❓ **Como configuro backup automático para nuvem?**

**R:** Veja guia completo em [BACKUP.md](BACKUP.md). Resumo:
1. Crie repositório **privado** no GitHub/GitLab
2. Configure remote: `git remote add origin <url>`
3. Configure cron/task scheduler para push automático
4. Opcional: Backup adicional para Dropbox/OneDrive

### ❓ **Posso sincronizar entre múltiplos dispositivos?**

**R:** Sim, via Git:
```bash
# Dispositivo A
git add . && git commit -m "trabalho A" && git push

# Dispositivo B
git pull
```

Veja seção "Migração entre Dispositivos" em [BACKUP.md](BACKUP.md).

---

## ⚡ Performance e Limitações

### ❓ **O sistema fica lento com muitos dados?**

**R:** O sistema é otimizado para escalar:
- Markdown é eficiente mesmo com milhares de arquivos
- Git maneja grandes repositórios bem
- Obsidian otimiza visualização automaticamente
- Se ficar lento, veja dicas de performance em [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

### ❓ **Quantos dados posso armazenar?**

**R:** Praticamente ilimitado:
- Arquivos markdown são pequenos (poucos KB cada)
- Git comprime eficientemente
- 10.000 arquivos = ~100MB típico
- Limite prático: espaço em disco disponível

### ❓ **Os agentes têm limite de memória?**

**R:** Não há limite rígido:
- Memória persistente cresce gradualmente
- Sistema otimiza informações relevantes
- Arquivos YAML de memória ficam pequenos (alguns KB)
- Performance mantida mesmo com uso intenso

### ❓ **Funciona bem no Windows?**

**R:** Sim, totalmente compatível:
- Scripts `.bat` para Windows
- Paths com espaços tratados corretamente
- UTF-8 configurado automaticamente
- Testado em Windows 10 e 11

---

## 🎨 Personalização

### ❓ **Posso mudar a personalidade dos agentes?**

**R:** Sim, é personalizável:
- Edite arquivos `.assistant-core/agents/*.yaml`
- Modifique seções `persona` e `traits`
- Adicione instruções específicas
- Reinicie para aplicar mudanças

### ❓ **Como adiciono novos tipos de agentes?**

**R:** Crie novo arquivo YAML:
```yaml
# .assistant-core/agents/meu-agente.yaml
agent: meu-agente
persona:
  role: "Especialista em [área]"
  traits:
    - "Característica 1"
    - "Característica 2"
memoria:
  file: "meu-agente-memory.yaml"
```

### ❓ **Posso mudar a estrutura das pastas?**

**R:** Sim, mas cuidado:
- Edite apenas pastas da `knowledge-base/`
- Mantenha estrutura de `.assistant-core/`
- Atualize referências `[[]]` se necessário
- Faça backup antes de mudanças grandes

### ❓ **Como personalizo templates de arquivos?**

**R:** Use pasta `diario/templates/`:
- Crie templates markdown
- Use com Obsidian (Templates plugin)
- Ou referencie manualmente nos agentes

---

## 🧩 TDAH e Neurodivergência

### ❓ **Como o sistema ajuda especificamente com TDAH?**

**R:** Design TDAH-friendly em todos os aspectos:

**Captura sem fricção:**
- `daily-dump.md` para despejo mental rápido
- Sem preocupação com organização inicial

**Processamento inteligente:**
- `/organizador` estrutura informações caóticas
- `/psicologo` oferece estratégias específicas TDAH

**Memória externa:**
- Sistema lembra para você
- Reduz carga cognitiva

**Foco:**
- Agentes ajudam a priorizar
- Quebram tarefas grandes em pequenas

### ❓ **Que estratégias específicas para TDAH o sistema oferece?**

**R:** O `/psicologo` tem estratégias especializadas:
- **Técnicas de foco**: Pomodoro adaptado, chunking
- **Gestão de overwhelm**: Protocolos de emergência
- **Body doubling**: Agentes como "companhia"
- **Validação emocional**: Suporte para frustração
- **Organização**: Sistemas que funcionam com cérebro TDAH

### ❓ **Como uso quando estou em crise/overwhelm?**

**R:** Protocolo de emergência:
1. **Despeje tudo** em `daily-dump.md` (sem filtro)
2. **`/psicologo "protocolo emergência overwhelm"`**
3. **Siga as instruções** do psicólogo
4. **Foque em 1 coisa** por vez
5. **Celebre pequenos progressos**

### ❓ **E se eu esquecer de usar o sistema?**

**R:** Comum e normal! Estratégias:
- Lembrete visual: deixe `daily-dump.md` aberto
- Rotina leve: apenas 5 minutos de manhã
- Sem culpa: retome quando lembrar
- Start small: use apenas 1 agente primeiro

### ❓ **Posso usar durante episódios de hiperfoco?**

**R:** Sim, pode potencializar:
- `/organizador` para capturar ideias do hiperfoco
- `/arquiteto` para refinar ideias técnicas
- `/secretaria` para não perder detalhes importantes
- Backup automático preserva trabalho do hiperfoco

---

## 🔧 Problemas Técnicos

### ❓ **"Command not found" no terminal**

**R:** Dependências ausentes:
```bash
# Verificar Python
python3 --version

# Verificar Git
git --version

# Se não tiver, instalar (veja TROUBLESHOOTING.md)
```

### ❓ **Teste falha com "Permission denied"**

**R:** Dar permissões aos scripts:
```bash
chmod +x setup.sh
chmod +x test-basic.sh
chmod +x test-recovery.sh
```

### ❓ **Agentes não funcionam**

**R:** Diagnóstico passo a passo:
```bash
# 1. Testar estrutura
bash test-basic.sh

# 2. Testar agentes específicos
python3 test-agents.py

# 3. Se falhar, recuperar
bash test-recovery.sh

# 4. Testar novamente
bash test-basic.sh
```

### ❓ **Git mostra erros de "uncommitted changes"**

**R:** Normal durante uso ativo:
```bash
# Ver o que mudou
git status

# Fazer backup das mudanças
git add .
git commit -m "backup $(date)"
```

### ❓ **Obsidian não abre a knowledge-base**

**R:** Recriar configuração:
```bash
# Regenerar configuração
bash test-recovery.sh

# No Obsidian: Open folder as vault -> knowledge-base/
```

### ❓ **Sistema lento após muito uso**

**R:** Limpeza de manutenção:
```bash
# Limpar logs antigos
find .assistant-core/logs/ -name "*.log" -mtime +30 -delete

# Otimizar Git
git gc --aggressive

# Verificar tamanho
du -sh knowledge-base/
```

---

## 🎯 Perguntas Avançadas

### ❓ **Posso integrar com outras ferramentas?**

**R:** Sim, dados são markdown padrão:
- **Notion**: Import/export via markdown
- **Roam Research**: Compatible com [[links]]
- **Logseq**: Funciona diretamente
- **Anki**: Cards via markdown
- **Todoist**: Export de tarefas

### ❓ **Como migro de outros sistemas de produtividade?**

**R:** Processo gradual:
1. **Exporte dados** do sistema atual (Notion, Evernote, etc.)
2. **Converta para markdown** (pandoc ajuda)
3. **Importe gradualmente** para `knowledge-base/`
4. **Use `/organizador`** para estruturar dados importados
5. **Mantenha sistema antigo** até confortável com novo

### ❓ **Posso usar para equipes/colaboração?**

**R:** Principalmente pessoal, mas possível:
- **Repositório compartilhado**: Git permite colaboração
- **Branches por pessoa**: Cada um trabalha em branch
- **Merge seletivo**: Compartilhar apenas partes relevantes
- **Obsidian Publish**: Para compartilhar conhecimento

### ❓ **Como contribuo para o desenvolvimento?**

**R:** Várias formas:
- **Feedback**: Relate bugs e sugestões
- **Documentação**: Melhore guias existentes
- **Templates**: Crie templates úteis
- **Scripts**: Contribua automações
- **Casos de uso**: Compartilhe workflows

---

## 📞 Ainda tem dúvidas?

### Ordem de consulta:
1. **Este FAQ** - Para perguntas comuns
2. **[USAGE.md](USAGE.md)** - Para guia detalhado de uso
3. **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - Para problemas específicos
4. **[BACKUP.md](BACKUP.md)** - Para questões de backup
5. **Testes**: Execute `bash test-recovery.sh`

### Dicas para encontrar respostas:
- Use **Ctrl+F** para buscar palavras-chave neste FAQ
- Termos técnicos geralmente estão em TROUBLESHOOTING.md
- Workflows complexos estão em USAGE.md
- Questões de dados/segurança estão em BACKUP.md

---

## 💡 Dicas Finais

### Para iniciantes:
1. **Comece simples**: Use apenas `/organizador` primeiro
2. **Não se preocupe com perfeição**: Despeje informações sem filtro
3. **Explore gradualmente**: Adicione agentes conforme necessidade
4. **Seja paciente**: Sistema melhora com uso

### Para usuários avançados:
1. **Automatize rotinas**: Crie scripts personalizados
2. **Use todos os agentes**: Cada um oferece perspectiva única
3. **Customize**: Adapte personalidades dos agentes
4. **Monitore backup**: Configure alertas de sincronização

### Para pessoas com TDAH:
1. **Sem pressão**: Use quando lembrar, sem culpa
2. **Start small**: 5 minutos por dia já ajuda
3. **Celebre sucessos**: Sistema destaca progresso
4. **Use suporte**: `/psicologo` está sempre disponível

---

**Lembre-se**: Este sistema cresce com você. Quanto mais usar, mais útil fica!

🤖 **Seus agentes estão prontos** - Comece despejando suas ideias em `daily-dump.md` e processe com `/organizador`!