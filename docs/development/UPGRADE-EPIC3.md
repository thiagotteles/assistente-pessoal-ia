# 🚀 Guia de Upgrade para Epic 3: Experiência de Sucesso

## O que é o Epic 3?

O **Epic 3** traz melhorias na experiência do usuário do Assistente Pessoal IA:

- ✨ **Onboarding interativo**: Tour guiado nos primeiros passos
- 📊 **Dashboard visual**: Veja seu progresso e estatísticas
- 🎯 **Feedback contínuo**: Saudação contextual e achievements
- 💾 **Backup automático**: Proteção invisível e recovery fácil

## Pré-Requisitos

Antes de fazer upgrade, certifique-se que você tem:

✅ **Épicos 0, 1 e 2 instalados e funcionando**
- Agentes conversacionais operacionais (/organizador, /secretaria, /arquiteto, /psicologo, /mentor)
- Knowledge-base com Obsidian configurado
- Git inicializado no projeto

✅ **Backups recentes**
- O script de upgrade cria backup automático
- Mas é recomendado ter backup manual também

✅ **Git instalado**
- Para backup e rollback automático

## Como Fazer Upgrade

### Opção 1: Upgrade Automático (Recomendado)

#### Linux/Mac/Git Bash (Windows)

```bash
# 1. Entre no diretório do projeto
cd assistente-pessoal-ia

# 2. Execute o script de upgrade
bash scripts/upgrade-to-epic3.sh
```

#### Windows (CMD/PowerShell)

```cmd
REM 1. Entre no diretório do projeto
cd assistente-pessoal-ia

REM 2. Execute o script de upgrade
scripts\upgrade-to-epic3.bat
```

### O que o Script Faz?

O upgrade é **100% não-destrutivo** e segue estas etapas:

1. **Detecta** instalação existente dos Épicos 0-2
2. **Informa** claramente o que será adicionado/preservado
3. **Pede confirmação** antes de qualquer mudança
4. **Cria backup automático** antes de começar
5. **Adiciona novos arquivos** Epic 3 (tutoriais, dashboard, templates)
6. **Aplica patches** nos agentes (tour guiado, saudação contextual)
7. **Mescla configurações** Obsidian (preserva customizações)
8. **Valida** que tudo funcionou corretamente

⏱️ **Tempo total**: < 30 segundos

### O que SERÁ Adicionado

✅ **Novos Arquivos**:
- `knowledge-base/BEM-VINDO.md` - Tutorial interativo
- `knowledge-base/🏠 INÍCIO.md` - Dashboard visual
- `knowledge-base/COMO-BUSCAR.md` - Guia de busca
- `knowledge-base/OBSIDIAN-EM-5-MINUTOS.md` - Tutorial Obsidian
- `knowledge-base/ATALHOS-OBSIDIAN.md` - Atalhos úteis
- `MEU-PROGRESSO.md` - Checklist primeira semana
- `📈 MEU-DASHBOARD.md` - Dashboard executivo
- `todos/PROGRESSO-VISUAL.md` - Barras de progresso
- `.version` - Arquivo de versão (Epic 3.0)
- `.assistant-core/data/dashboard-cache.yaml` - Cache de estatísticas

✅ **Configurações Obsidian**:
- Novos atalhos de teclado
- Templates de projeto/pessoa/decisão/contexto
- Workspace padrão (se não existir)

✅ **Melhorias nos Agentes**:
- **Organizador (Sofia)**: Tour guiado de 3 passos na primeira execução
- **Todos os agentes**: Saudação contextual com estatísticas

### O que NÃO SERÁ Modificado

❌ **Seus dados estão 100% seguros**:
- `knowledge-base/` - Todos seus projetos, pessoas, decisões, contextos
- `.assistant-core/memory/` - Memória dos agentes (conversas, padrões aprendidos)
- `despejo/daily-dump.md` - Suas capturas diárias
- `todos/` - Suas tarefas
- Customizações do Obsidian (workspace, hotkeys personalizados)

**GARANTIA**: Nada será apagado ou sobrescrito. Apenas adições.

## Verificando o Upgrade

Após o upgrade, verifique:

1. **Abra o Obsidian** na pasta `knowledge-base/`
2. **Procure novos arquivos**:
   - `🏠 INÍCIO.md` deve aparecer
   - `BEM-VINDO.md` com tutorial
3. **Execute um agente**: `/organizador`
   - Se for primeira vez, deve iniciar tour guiado
   - Caso contrário, deve exibir saudação contextual
4. **Verifique backup**: Arquivo `backup-pre-epic3-YYYY-MM-DD_HH-MM-SS.zip` criado

## Rollback (se necessário)

Se algo der errado, você tem **3 opções de rollback**:

### Opção 1: Restaurar via Backup ZIP

```bash
# Descompactar backup
unzip backup-pre-epic3-YYYY-MM-DD_HH-MM-SS.zip

# Copiar arquivos de volta
cp -r backup-pre-epic3/* .
```

### Opção 2: Rollback via Git (Mais Fácil)

```bash
# 1. Listar últimos commits
git log --oneline | head -10

# 2. Encontrar commit antes do upgrade
# Procure por "Epic 3" na mensagem

# 3. Restaurar para esse commit
git reset --hard <hash-do-commit-antes-epic3>
```

### Opção 3: Script de Recovery

```bash
# Execute o script de recovery
bash RECUPERAR-BACKUP.sh

# Selecione backup desejado da lista
# Confirme e pronto!
```

## Novidades Epic 3

### 1. Tour Guiado Interativo

Na primeira execução do `/organizador`, Sofia (Organizadora) vai:
- Mostrar 3 passos práticos
- Guiar você no primeiro despejo
- Demonstrar processamento automático
- Mostrar resultado visual no Obsidian

⏱️ Tempo: 5-8 minutos (pode pular a qualquer momento)

### 2. Dashboard Visual

Abra `📈 MEU-DASHBOARD.md` no Obsidian para ver:
- Despejos processados esta semana
- Conversas com cada agente
- Notas criadas
- Todos completados
- Streak de dias consecutivos 🔥
- Achievements desbloqueados

Atualizado automaticamente após cada interação.

### 3. Saudação Contextual

Todos os agentes agora te cumprimentam com:
- Tempo desde última conversa
- Total de conversas (#ª conversa)
- Streak de dias consecutivos
- Top 3 contextos/temas recentes

### 4. Backup Automático

Backups acontecem automaticamente:
- Após cada processamento de despejo
- Após cada conversa com agente
- Push para remoto (se configurado)

Mensagem discreta: "💾 Backup automático feito às 14:32 ✓"

### 5. Progresso Visual de Todos

Abra `todos/PROGRESSO-VISUAL.md` para ver:
- Barras de progresso Unicode: ████████░░ 80%
- Todos por projeto
- Metas de carreira
- Próximo passo sugerido

## Troubleshooting

### "Agentes não estão carregando"

**Solução**:
```bash
# 1. Verificar que patches foram aplicados
grep -l "saudacao-contextual:" .assistant-core/agents/*.md

# 2. Se vazio, aplicar patches manualmente
bash scripts/apply-epic3-agent-patches.sh
```

### "Dashboard não aparece no Obsidian"

**Solução**:
1. Feche e reabra o Obsidian
2. Verifique que arquivo `📈 MEU-DASHBOARD.md` existe
3. Use Ctrl+O para buscar "dashboard"

### "Hotkeys não funcionam"

**Solução**:
1. Obsidian → Settings (Ctrl+,)
2. Hotkeys → Verificar conflitos
3. Se necessário, restaurar backup: `.assistant-core/agents/backup-pre-epic3/obsidian-config/hotkeys.json`

### "Upgrade travou ou deu erro"

**Solução**:
1. Use Ctrl+C para cancelar
2. Execute rollback via Git:
   ```bash
   git reset --hard HEAD~1
   ```
3. Abra issue em: https://github.com/seu-repo/assistente-pessoal-ia/issues

## Performance

O upgrade deve ser **rápido**:

| Etapa | Tempo |
|-------|-------|
| Detecção instalação | < 1s |
| Backup automático | ~2-5s |
| Criação de arquivos | ~3-8s |
| Patches de agentes | ~5-10s |
| Merge Obsidian | ~2-3s |
| Validação | < 2s |
| **TOTAL** | **< 30s** |

Se demorar mais de 1 minuto, algo pode estar errado.

## Instalação Nova (Sem Upgrade)

Se você está instalando pela primeira vez:

```bash
# 1. Clone o repositório
git clone <repo-url> assistente-pessoal-ia
cd assistente-pessoal-ia

# 2. Execute setup (já inclui Epic 3)
bash setup.sh   # Linux/Mac
setup.bat       # Windows

# 3. Abra Obsidian na pasta knowledge-base/
```

Epic 3 já vem incluído em instalações novas.

## Próximos Passos

Após upgrade bem-sucedido:

1. ✅ Abra `knowledge-base/BEM-VINDO.md` e leia o tutorial
2. ✅ Execute `/organizador` para iniciar tour guiado (se primeira vez)
3. ✅ Explore o dashboard: `📈 MEU-DASHBOARD.md`
4. ✅ Veja progresso de todos: `todos/PROGRESSO-VISUAL.md`
5. ✅ Configure backup remoto (opcional): `git remote add origin <repo-url>`
6. ✅ Experimente novos atalhos Obsidian: `ATALHOS-OBSIDIAN.md`

## Suporte

- 📖 **Documentação**: `docs/`
- 🐛 **Issues**: https://github.com/seu-repo/assistente-pessoal-ia/issues
- 💬 **Dúvidas**: Converse com `/mentor` ou `/psicologo`

---

**Versão**: Epic 3.0
**Data**: 2025-10-01
**Autor**: Bob (Scrum Master) via James (Developer)
