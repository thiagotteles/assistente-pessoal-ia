# Guia Rápido - Assistente Pessoal IA

**Para pessoas que querem começar AGORA** ⚡

---

## 🚀 3 Minutos para Começar

### 1️⃣ Execute o Setup (1 minuto)
```bash
# Linux/Mac
bash setup.sh

# Windows
setup.bat
```

### 2️⃣ Valide a Instalação (30 segundos)
```bash
bash test-basic.sh
```

### 3️⃣ Primeira Captura (1 minuto)
1. Abra `despejo/daily-dump.txt`
2. Despeje TUDO que está na sua mente:
   ```
   reunião com João amanhã 14h
   implementar feature X
   comprar café
   ansioso com projeto Y
   ideia: app para receitas
   ```
3. Salve e feche

### 4️⃣ Primeiro Processamento (30 segundos)
No Claude Code:
```bash
/organizador despejo/daily-dump.txt
```

**🎉 Pronto! Você já está usando o sistema.**

---

## 🎯 Uso Diário (5 minutos)

### Manhã (2 minutos)
```bash
/organizador despejo/daily-dump.txt
/secretaria "o que preciso focar hoje?"
```

### Durante o dia (conforme necessário)
```bash
/psicologo "me sinto sobrecarregado"
/arquiteto "como resolver [problema técnico]?"
/mentor "isso alinha com meus objetivos?"
```

### Noite (1 minuto)
```bash
/secretaria "status do dia e próximos passos"
```

---

## 🤖 Os 5 Agentes em 30 Segundos

| Agente | Quando Usar | Exemplo |
|--------|-------------|---------|
| `/organizador` | Info caótica | `despejo/daily-dump.txt` |
| `/secretaria` | Status/coordenação | `"status projeto X"` |
| `/arquiteto` | Decisões técnicas | `"React ou Vue?"` |
| `/psicologo` | Overwhelm/TDAH | `"me sinto perdido"` |
| `/mentor` | Carreira/visão | `"como crescer?"` |

---

## 📁 Estrutura Simples

```
📁 despejo/daily-dump.txt    ← Despeje tudo aqui
📁 knowledge-base/           ← Abra no Obsidian
📁 todos/                    ← Tarefas organizadas
📁 .assistant-core/          ← Configurações (não mexer)
```

---

## 🧠 Obsidian em 1 Minuto

1. **Instale Obsidian** (gratuito)
2. **"Open folder as vault"** → selecione `knowledge-base/`
3. **Explore o Graph View** para ver conexões
4. **Use links [[]]** para navegar

---

## 🆘 Solução Rápida de Problemas

```bash
# Se algo der errado
bash test-recovery.sh

# Se ainda estiver com problemas
bash test-basic.sh

# Se TUDO falhar
cp -r . backup-$(date +%Y%m%d)  # Backup
bash setup.sh                  # Reinstalar
```

---

## 💡 Dicas TDAH (30 segundos)

- **Capture TUDO** sem filtro em `daily-dump.txt`
- **Processe depois** com `/organizador`
- **Use `/psicologo`** quando overwhelm
- **Sem culpa** se esquecer de usar
- **Start small**: 5 minutos/dia

---

## 🔗 Links Úteis

- **Manual Completo**: [USAGE.md](../USAGE.md)
- **Problemas**: [TROUBLESHOOTING.md](../TROUBLESHOOTING.md)
- **Backup**: [BACKUP.md](../BACKUP.md)
- **FAQ**: [FAQ.md](../FAQ.md)

---

## ✅ Checklist de Primeiros Passos

- [ ] Setup executado com sucesso
- [ ] Teste passou (11/11)
- [ ] Primeira captura em `daily-dump.txt`
- [ ] Primeiro `/organizador despejo/daily-dump.txt`
- [ ] Obsidian configurado com `knowledge-base/`
- [ ] Backup configurado (opcional, mas recomendado)

---

**🎯 Meta**: Em 1 semana você estará usando naturalmente o sistema para organizar sua vida pessoal e profissional.

**💪 Próximo passo**: Leia [USAGE.md](../USAGE.md) para casos de uso avançados quando estiver confortável com o básico.