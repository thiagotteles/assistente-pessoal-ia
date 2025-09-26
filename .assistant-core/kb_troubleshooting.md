# Knowledge Base Manager - Troubleshooting Básico

Guia de solução de problemas comuns do Knowledge Base Manager para desenvolvedores e usuários finais.

**Autor:** James (Dev Agent)
**Data:** 2025-09-25
**História:** 0.2 - Knowledge-Base Manager Core

---

## 🚨 Problemas Comuns e Soluções

### 1. Erro: "Diretório knowledge-base não encontrado"

**Sintomas:**
```
FileNotFoundError: Diretório knowledge-base não encontrado
```

**Soluções:**
1. Executar setup inicial: `bash setup.sh`
2. Verificar estrutura: `ls -la knowledge-base/`
3. Criar manualmente se necessário:
```bash
mkdir -p knowledge-base/{decisoes,contextos,projetos,pessoas}
mkdir -p knowledge-base/.obsidian
```

### 2. Erro de encoding UTF-8

**Sintomas:**
```
UnicodeDecodeError: 'charmap' codec can't decode
```

**Soluções:**
1. Verificar se arquivos estão em UTF-8
2. No Windows, usar editor que suporte UTF-8 (VS Code, Notepad++)
3. Verificar configuração do Python: `python -c "import locale; print(locale.getpreferredencoding())"`

### 3. Links [[]] não funcionando no Obsidian

**Sintomas:**
- Links aparecem como texto simples
- Referências não são clicáveis

**Soluções:**
1. Verificar se knowledge-base/ está aberto como vault no Obsidian
2. Reiniciar Obsidian após criação de novos arquivos
3. Verificar sintaxe: `[[Nome Exato]]` (case-sensitive)

### 4. Arquivo não encontrado ao recuperar entrada

**Sintomas:**
```
recuperar_entrada() retorna None
```

**Soluções:**
1. Verificar se arquivo existe: `ls knowledge-base/contextos/`
2. Usar busca por filename: `recuperar_entrada(filename="arquivo.md")`
3. Verificar frontmatter YAML está correto

### 5. Performance lenta em busca semântica

**Sintomas:**
- Busca demora mais de 5 segundos
- Sistema trava durante busca

**Soluções:**
1. Limitar resultados: `busca_semantica(query="termo", limit=5)`
2. Usar filtro por tipo: `entry_type="contexto"`
3. Verificar se há arquivos muito grandes (>2000 linhas)

---

## 🔧 Comandos de Diagnóstico

### Verificar Instalação Completa

```bash
# Estrutura de diretórios
ls -la knowledge-base/
ls -la .assistant-core/

# Verificar arquivos principais
ls -la .assistant-core/knowledge_base_manager.py
ls -la .assistant-core/kb_agent_integration_guide.md

# Testar Python imports
python -c "import yaml, uuid, pathlib; print('Dependências OK')"
```

### Teste Básico Manual

```python
# Teste rápido em Python
import sys
sys.path.append('.assistant-core')

from knowledge_base_manager import create_knowledge_manager

# Criar instância
kb = create_knowledge_manager()
print("✅ KnowledgeBaseManager criado")

# Testar salvamento
resultado = kb.salvar_entrada(
    titulo="Teste Sistema",
    conteudo="Teste básico do sistema",
    source_agent="dev"
)
print(f"✅ Entrada salva: {resultado['filename']}")

# Testar recuperação
entrada = kb.recuperar_entrada(entry_id=resultado['id'])
if entrada:
    print("✅ Recuperação funcionando")
else:
    print("❌ Problema na recuperação")
```

---

## 📋 Checklist de Validação

### Estrutura de Arquivos
- [ ] `knowledge-base/` existe
- [ ] Subdiretórios criados: `decisoes/`, `contextos/`, `projetos/`, `pessoas/`
- [ ] `.obsidian/` configurado
- [ ] `.assistant-core/knowledge_base_manager.py` existe

### Funcionalidade Básica
- [ ] Pode salvar entrada sem erro
- [ ] Pode recuperar entrada salva
- [ ] Metadados YAML são gerados corretamente
- [ ] Links [[]] funcionam no Obsidian
- [ ] Busca semântica retorna resultados

### Integração com Agentes
- [ ] Todos os 5 agentes estão configurados
- [ ] Templates YAML existem
- [ ] Arquivos de memória existem
- [ ] Documentação de integração disponível

---

## 🔍 Logs e Debug

### Localização dos Logs
- Logs principais: `.assistant-core/logs/knowledge_base_manager.log`
- Configuração Cross-Agent: `.assistant-core/cross_agent_hooks.json`

### Níveis de Log
```python
# Habilitar debug detalhado
import logging
logging.getLogger('KnowledgeBaseManager').setLevel(logging.DEBUG)
```

### Informações Úteis para Debug
1. Sistema operacional
2. Versão do Python
3. Estrutura de diretórios
4. Conteúdo de arquivos problemáticos
5. Stack trace completo do erro

---

## 🚑 Recuperação de Emergência

### Backup Automático
O sistema cria backups automáticos em `knowledge-base/.backups/`

### Restaurar Arquivo
```bash
# Listar backups disponíveis
ls knowledge-base/.backups/

# Restaurar arquivo
cp knowledge-base/.backups/arquivo_2025-09-25T10-30-00.md knowledge-base/contextos/arquivo.md
```

### Reset Completo
```bash
# CUIDADO: Remove todos os dados
rm -rf knowledge-base/
bash setup.sh  # Recriar estrutura básica
```

---

## 📞 Suporte e Contato

### Recursos de Auto-Ajuda
1. Este arquivo de troubleshooting
2. `.assistant-core/kb_agent_integration_guide.md`
3. Comentários no código `knowledge_base_manager.py`
4. Logs em `.assistant-core/logs/`

### Informações para Suporte
Quando reportar problemas, incluir:
- Versão do sistema operacional
- Comando ou ação que causou o erro
- Mensagem de erro completa
- Estrutura de diretórios atual
- Conteúdo relevante dos logs

---

## ✅ Verificação Pós-Implementação

Execute estes testes após qualquer alteração no sistema:

```bash
# 1. Teste de estrutura
ls -la knowledge-base/{decisoes,contextos,projetos,pessoas}

# 2. Teste de criação de arquivo
python -c "
from .assistant_core.knowledge_base_manager import create_knowledge_manager
kb = create_knowledge_manager()
result = kb.salvar_entrada('Teste', 'Conteúdo teste', source_agent='dev')
print('Teste passou:', result is not None)
"

# 3. Teste Obsidian (manual)
# Abrir knowledge-base/ no Obsidian e verificar se vault carrega corretamente
```

### Status: Sistema Validado ✅

- ✅ Compatível com estrutura knowledge-base/ existente
- ✅ Integração com configurações Obsidian funcionando
- ✅ Templates YAML dos agentes compatíveis
- ✅ Troubleshooting básico documentado