# Agent Memory System - Troubleshooting

Guia completo de solução de problemas do sistema de memória dos agentes especializados.

**Autor:** James (Dev Agent)
**Data:** 2025-09-25
**História:** 0.3 - Agent Memory System Foundation

---

## 🚨 Problemas Comuns e Soluções

### 1. Erro: "Arquivo de memória não encontrado"

**Sintomas:**
```
Arquivo de memória não encontrado: organizador-memory.yaml
```

**Soluções:**
1. Verificar estrutura: `ls -la .assistant-core/memory/`
2. Executar setup básico:
```bash
mkdir -p .assistant-core/memory
```
3. Criar arquivos de memória manualmente se necessário:
```bash
touch .assistant-core/memory/{organizador,secretaria,arquiteto,psicologo,mentor}-memory.yaml
```

### 2. Erro: "Knowledge-Base Manager não disponível"

**Sintomas:**
```
Knowledge-Base Manager não disponível - algumas funcionalidades serão limitadas
```

**Soluções:**
1. Verificar se Knowledge-Base Manager foi implementado:
```bash
ls -la .assistant-core/knowledge_base_manager.py
```
2. Verificar imports Python:
```python
python -c "from .assistant_core.knowledge_base_manager import create_knowledge_manager; print('KB Manager OK')"
```
3. Reinstalar se necessário conforme História 0.2

### 3. Memória não carrega personalidade

**Sintomas:**
- Agente comporta-se de forma inconsistente
- `personality_context` sempre vazio

**Soluções:**
1. Forçar atualização de personalidade:
```python
from .assistant_core.agent_memory_system import create_agent_memory_system
ams = create_agent_memory_system()
ams.manter_personalidade('organizador')
```
2. Verificar se arquivo YAML está corrompido:
```bash
python -c "import yaml; yaml.safe_load(open('.assistant-core/memory/organizador-memory.yaml'))"
```

### 4. Performance lenta no carregamento

**Sintomas:**
- Carregamento demora mais de 3 segundos
- Cache não funciona

**Soluções:**
1. Limpar cache de memória:
```python
ams._memory_cache.clear()
```
2. Verificar tamanho dos arquivos de memória:
```bash
ls -lah .assistant-core/memory/
```
3. Fazer backup e resetar memória se muito grande:
```bash
python -c "
from .assistant_core.agent_memory_system import create_agent_memory_system
ams = create_agent_memory_system()
ams.backup_memoria('organizador')
ams.reset_memoria_agente('organizador')
"
```

### 5. Integração com slash commands falha

**Sintomas:**
```
Erro ao carregar memória do agente 'organizador': ModuleNotFoundError
```

**Soluções:**
1. Verificar path do Python:
```python
import sys
print(sys.path)
# Adicionar .assistant-core se necessário
sys.path.append('.assistant-core')
```
2. Usar import absoluto:
```python
import os
os.chdir('.')  # Garantir diretório correto
from assistant_core.agent_memory_system import create_agent_memory_system
```

---

## 🔧 Comandos de Diagnóstico

### Verificar Status Completo

```bash
# Estrutura de arquivos
ls -la .assistant-core/memory/
ls -la .assistant-core/logs/

# Testar Python imports
python -c "
import sys
sys.path.append('.assistant-core')
try:
    from agent_memory_system import create_agent_memory_system
    print('✅ AgentMemorySystem importado')
    ams = create_agent_memory_system()
    print('✅ AgentMemorySystem criado')
except Exception as e:
    print(f'❌ Erro: {e}')
"
```

### Teste Básico de Funcionalidade

```python
# Executar em Python
import sys
sys.path.append('.assistant-core')

from agent_memory_system import create_agent_memory_system

# Criar sistema
ams = create_agent_memory_system()
print("Sistema criado")

# Testar carregamento de cada agente
for agent in ['organizador', 'secretaria', 'arquiteto', 'psicologo', 'mentor']:
    memoria = ams.carregar_memoria_agente(agent)
    status = "✅" if memoria else "❌"
    print(f"{status} {agent.capitalize()}: {'Carregado' if memoria else 'Falhou'}")

# Testar atualização
test_data = {
    'user_input': 'Teste de memória',
    'agent_response': 'Memória funcionando',
    'context': {'test': True},
    'success': True
}

if ams.atualizar_memoria_agente('organizador', test_data):
    print("✅ Atualização de memória funcionando")
else:
    print("❌ Atualização de memória falhou")
```

### Verificar Integração Knowledge-Base

```python
# Testar integração KB
ams = create_agent_memory_system()

if ams.knowledge_manager:
    print("✅ Knowledge-Base Manager integrado")

    # Testar sincronização
    if ams.sincronizar_com_knowledge_base('organizador'):
        print("✅ Sincronização funcionando")
    else:
        print("⚠️  Sincronização não executou (normal se não há dados)")

    # Testar busca de contexto
    results = ams.recuperar_contexto_knowledge_base('organizador', 'teste')
    print(f"📄 Contexto recuperado: {len(results)} entradas")
else:
    print("❌ Knowledge-Base Manager não disponível")
```

---

## 📋 Checklist de Validação

### Estrutura de Arquivos
- [ ] `.assistant-core/memory/` existe
- [ ] 5 arquivos `*-memory.yaml` existem
- [ ] `.assistant-core/logs/` criado
- [ ] `agent_memory_system.py` existe

### Funcionalidade Básica
- [ ] Pode criar AgentMemorySystem sem erro
- [ ] Pode carregar memória de cada um dos 5 agentes
- [ ] Pode atualizar memória com nova interação
- [ ] Pode manter personalidade consistente
- [ ] Backup automático funciona

### Integração Knowledge-Base
- [ ] Knowledge-Base Manager detectado automaticamente
- [ ] Sincronização com KB funciona
- [ ] Busca de contexto retorna resultados
- [ ] Referências [[]] são processadas
- [ ] Aprendizado compartilhado funciona

### Integração Slash Commands
- [ ] Hooks de inicialização funcionam
- [ ] Hooks de finalização funcionam
- [ ] Contexto de memória é aplicado
- [ ] Personalidade influencia resposta

---

## 🔍 Logs e Debug

### Localização dos Logs
- Logs principais: `.assistant-core/logs/agent_memory_system.log`
- Logs Knowledge-Base: `.assistant-core/logs/knowledge_base_manager.log`

### Configurar Debug Detalhado

```python
import logging

# Habilitar debug para AgentMemorySystem
logging.getLogger('AgentMemorySystem').setLevel(logging.DEBUG)

# Habilitar debug para Knowledge-Base Manager
logging.getLogger('KnowledgeBaseManager').setLevel(logging.DEBUG)

# Ver todos os logs
handler = logging.StreamHandler()
handler.setLevel(logging.DEBUG)
logging.getLogger().addHandler(handler)
```

### Informações Úteis para Debug

1. **Sistema operacional e versão Python**
2. **Conteúdo dos arquivos de memória YAML**
3. **Stack trace completo de erros**
4. **Estado do cache de memória**
5. **Status da integração Knowledge-Base**

---

## 🚑 Recuperação de Emergência

### Backup Automático

Backups são criados em `.assistant-core/memory/.backups/` automaticamente.

### Restaurar Memória Corrompida

```bash
# Listar backups disponíveis
ls .assistant-core/memory/.backups/

# Restaurar de backup
cp ".assistant-core/memory/.backups/organizador-memory_backup_2025-09-25_14-30-00.yaml" ".assistant-core/memory/organizador-memory.yaml"
```

### Reset Completo de Memória

```python
# CUIDADO: Remove toda a memória personalizada
from .assistant_core.agent_memory_system import create_agent_memory_system

ams = create_agent_memory_system()

# Reset individual
ams.reset_memoria_agente('organizador')

# Reset de todos os agentes
for agent in ams.agents:
    ams.backup_memoria(agent)  # Backup antes do reset
    ams.reset_memoria_agente(agent)
```

### Recrear Sistema do Zero

```bash
# Backup completo
cp -r .assistant-core/memory .assistant-core/memory_backup_$(date +%Y%m%d_%H%M%S)

# Remover e recriar
rm -rf .assistant-core/memory
mkdir -p .assistant-core/memory/.backups

# Executar setup inicial novamente
python -c "
from .assistant_core.agent_memory_system import create_agent_memory_system
ams = create_agent_memory_system()
print('Sistema recriado com sucesso')
"
```

---

## 📞 Suporte e Recursos

### Auto-Diagnóstico

Execute este script para diagnóstico automático:

```python
#!/usr/bin/env python3
"""Diagnóstico automático do Agent Memory System"""

import sys
import os
from pathlib import Path

def diagnostic():
    print("🧠 Agent Memory System - Diagnóstico")
    print("=" * 50)

    # Verificar estrutura
    base_dir = Path('.')
    memory_dir = base_dir / '.assistant-core' / 'memory'

    print(f"📁 Diretório base: {base_dir.absolute()}")
    print(f"📁 Diretório memória: {memory_dir}")
    print(f"   Existe: {'✅' if memory_dir.exists() else '❌'}")

    # Verificar arquivos de memória
    agents = ['organizador', 'secretaria', 'arquiteto', 'psicologo', 'mentor']
    print("\n🤖 Status dos Agentes:")
    for agent in agents:
        memory_file = memory_dir / f"{agent}-memory.yaml"
        status = "✅" if memory_file.exists() else "❌"
        size = memory_file.stat().st_size if memory_file.exists() else 0
        print(f"   {status} {agent.capitalize()}: {size} bytes")

    # Testar imports
    print("\n📦 Imports Python:")
    try:
        sys.path.append('.assistant-core')
        from agent_memory_system import create_agent_memory_system
        print("   ✅ AgentMemorySystem")

        try:
            from knowledge_base_manager import create_knowledge_manager
            print("   ✅ KnowledgeBaseManager")
            kb_available = True
        except ImportError:
            print("   ⚠️  KnowledgeBaseManager (funcionalidade limitada)")
            kb_available = False
    except Exception as e:
        print(f"   ❌ Erro crítico: {e}")
        return

    # Testar funcionalidade
    print("\n⚡ Teste Funcional:")
    try:
        ams = create_agent_memory_system()
        print("   ✅ Sistema criado")

        # Testar carregamento
        memoria = ams.carregar_memoria_agente('organizador')
        if memoria:
            print("   ✅ Carregamento de memória")

            # Testar atualização
            test_data = {
                'user_input': 'Diagnóstico automático',
                'agent_response': 'Sistema funcionando',
                'context': {'diagnostic': True}
            }

            if ams.atualizar_memoria_agente('organizador', test_data):
                print("   ✅ Atualização de memória")
            else:
                print("   ❌ Atualização falhou")
        else:
            print("   ❌ Carregamento falhou")

        if kb_available and ams.knowledge_manager:
            print("   ✅ Integração Knowledge-Base")
        else:
            print("   ⚠️  Knowledge-Base não integrado")

    except Exception as e:
        print(f"   ❌ Erro funcional: {e}")

    print("\n🎯 Diagnóstico Concluído")

if __name__ == "__main__":
    diagnostic()
```

### Recursos de Auto-Ajuda

1. Este arquivo de troubleshooting
2. `.assistant-core/agent_slash_command_integration.md`
3. Logs detalhados em `.assistant-core/logs/`
4. Comentários no código `agent_memory_system.py`

---

## ✅ Status de Validação

Execute após qualquer alteração no sistema:

```bash
python -c "
import sys; sys.path.append('.assistant-core')
from agent_memory_system import create_agent_memory_system
ams = create_agent_memory_system()

print('🧠 Agent Memory System')
print('Status:', '✅ Operacional' if ams else '❌ Com problemas')
print('Knowledge-Base:', '✅ Integrado' if ams.knowledge_manager else '⚠️ Não disponível')
print('Agentes:', len(ams.agents), 'configurados')

# Teste de cada agente
for agent in ams.agents:
    memoria = ams.carregar_memoria_agente(agent)
    print(f'{agent}: {\"✅\" if memoria else \"❌\"}')"
```

**Status Final: Sistema Validado e Pronto para Uso ✅**

- ✅ Compatível com memórias YAML existentes
- ✅ Integração com Knowledge-Base Manager funcionando
- ✅ Hooks para slash commands implementados
- ✅ Sistema de backup e recovery configurado
- ✅ Troubleshooting documentado