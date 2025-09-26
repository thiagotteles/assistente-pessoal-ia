# Framework de Testes Essenciais

**História:** 0.4 - Framework de Testes Essenciais
**Versão:** 1.0
**Data:** 2025-09-26

---

## 🎯 Visão Geral

O Framework de Testes Essenciais é um conjunto de ferramentas simples e diretas para validar que o Assistente Pessoal IA está funcionando corretamente após instalação ou modificações.

### Filosofia dos Testes

- **Foco na funcionalidade essencial** - sem logs, métricas ou analytics desnecessários
- **Simplicidade máxima** - scripts shell básicos, sem frameworks complexos
- **Validação de instalação** - garantir que o sistema funciona após setup
- **Recuperação rápida** - identificar e corrigir problemas básicos automaticamente

---

## 🧪 Componentes do Framework

### 1. Script Principal: `test-basic.sh`

**Execução:** `bash test-basic.sh`

**Funcionalidade:** Suite completa de testes com 11 categorias de validação:

1. **Estrutura de Diretórios** - Verifica se todos os diretórios necessários existem
2. **Arquivos Base** - Valida presença de arquivos fundamentais
3. **Configurações dos Agentes** - Testa configs dos 5 agentes especializados
4. **Integração Obsidian** - Verifica configuração do vault
5. **Conteúdo dos Arquivos** - Valida se arquivos têm conteúdo inicial
6. **Knowledge-Base Manager** - Testa sistema de persistência (História 0.2)
7. **Agent Memory System** - Testa sistema de memória (História 0.3)
8. **Integração entre Componentes** - Valida integração KB ↔ Memory
9. **Compatibilidade Avançada Obsidian** - Testes aprofundados do vault
10. **Resposta dos 5 Agentes** - Simula testes básicos de cada agente
11. **Performance Básica** - Verificações simples sem analytics

### 2. Testes de Agentes: `test-agents.py`

**Execução:** `python3 test-agents.py`

**Funcionalidade:** Testes especializados dos 5 agentes:

- Validação de configuração YAML de cada agente
- Teste de carregamento de arquivos de memória
- Simulação de resposta básica por agente
- Integração com Agent Memory System
- Verificação de personalidades configuradas

### 3. Script de Recuperação: `test-recovery.sh`

**Execução:** `bash test-recovery.sh`

**Funcionalidade:** Recuperação automática de problemas comuns:

- Recriação de estrutura de diretórios ausentes
- Criação de arquivos base ausentes (README.md, .gitignore, etc.)
- Regeneração de configurações Obsidian
- Verificação de módulos Python críticos
- Criação de conteúdo de exemplo para demonstração

---

## 🚀 Como Usar

### Validação Completa do Sistema

```bash
# 1. Execute o teste principal
bash test-basic.sh

# 2. Se algum teste falhar, execute recuperação
bash test-recovery.sh

# 3. Execute testes novamente para confirmar correções
bash test-basic.sh
```

### Teste Específico dos Agentes

```bash
# Execute testes detalhados dos agentes
python3 test-agents.py
```

### Interpretação dos Resultados

**✅ Teste PASSOU** - Componente funcionando corretamente
**❌ Teste FALHOU** - Problema identificado que precisa correção
**⚠️  Aviso** - Situação não ideal mas não crítica

---

## 🔧 Testes Detalhados por Componente

### Knowledge-Base Manager (História 0.2)

**Testes realizados:**
- Importação e instanciação do módulo
- Teste de `salvar_entrada()` com dados válidos
- Teste de `recuperar_entrada()` por ID
- Validação de metadados YAML automáticos
- Verificação de integridade de dados

**Exemplo de teste:**
```python
from knowledge_base_manager import create_knowledge_manager
kb = create_knowledge_manager()
result = kb.salvar_entrada('Teste', 'Conteúdo teste', source_agent='teste')
entrada = kb.recuperar_entrada(entry_id=result['id'])
```

### Agent Memory System (História 0.3)

**Testes realizados:**
- Importação e instanciação do sistema de memória
- Carregamento de memória para cada um dos 5 agentes
- Teste de persistência entre sessões
- Verificação de backup automático
- Integração com Knowledge-Base Manager

**Exemplo de teste:**
```python
from agent_memory_system import create_agent_memory_system
ams = create_agent_memory_system()
for agent in ['organizador', 'secretaria', 'arquiteto', 'psicologo', 'mentor']:
    memoria = ams.carregar_memoria_agente(agent)
```

### Integração Obsidian

**Testes realizados:**
- Validação de vault válido (diretório `.obsidian`)
- Estrutura de subdiretórios para [[referências]]
- Configurações de app, graph e hotkeys
- Detecção de arquivos com referências [[]]

---

## 🚨 Troubleshooting

### Problema: Python3 não encontrado

**Solução:**
```bash
# Instalar Python3 no sistema
# Ubuntu/Debian: sudo apt-get install python3
# macOS: brew install python3
# Windows: Baixar de python.org
```

### Problema: Módulos Python ausentes

**Sintoma:** Testes do Knowledge-Base Manager ou Agent Memory System falham

**Solução:**
1. Verificar se as Histórias 0.2 e 0.3 foram implementadas
2. Confirmar que arquivos existem:
   - `.assistant-core/knowledge_base_manager.py`
   - `.assistant-core/agent_memory_system.py`

### Problema: Testes Obsidian falhando

**Solução:**
```bash
# Execute recuperação automática
bash test-recovery.sh
```

### Problema: Arquivos de configuração ausentes

**Solução:**
```bash
# Execute setup inicial novamente
bash setup.sh  # Linux/Mac
setup.bat      # Windows
```

---

## 📊 Métricas de Sucesso

### Critérios de Aprovação

- **11/11 testes passando** - Sistema completamente funcional
- **10/11 testes passando** - Sistema funcional com problemas menores
- **<10/11 testes passando** - Problemas significativos que precisam correção

### Performance Esperada

- **Tempo de execução:** < 30 segundos para teste completo
- **Uso de recursos:** Mínimo (sem analytics ou logs pesados)
- **Compatibilidade:** Cross-platform (Linux, macOS, Windows)

---

## 🔄 Extensibilidade

### Adicionando Novos Testes

1. **Crie função de teste** no `test-basic.sh`:
```bash
test_new_component() {
    print_info "Teste X: Novo Componente"
    local test_passed=true

    # Seus testes aqui

    if [ "$test_passed" = true ]; then
        print_success "Teste Novo Componente: PASSOU"
        return 0
    else
        print_error "Teste Novo Componente: FALHOU"
        return 1
    fi
}
```

2. **Adicione ao runner principal**:
```bash
if test_new_component; then
    ((passed_tests++))
fi
```

3. **Atualize total de testes**:
```bash
local total_tests=12  # Era 11, agora 12
```

### Configurando para Histórias Futuras

O framework foi projetado para ser extensível. Ao implementar novas histórias:

1. Adicione testes específicos ao `test-basic.sh`
2. Crie scripts especializados quando necessário
3. Atualize `test-recovery.sh` para cobrir novos componentes
4. Mantenha filosofia de simplicidade e foco funcional

---

## ✅ Status de Implementação

**Concluído:**
- ✅ Script principal com 11 categorias de teste
- ✅ Testes especializados de agentes em Python
- ✅ Script de recuperação automática
- ✅ Documentação completa de uso
- ✅ Integração com componentes das Histórias 0.1, 0.2, 0.3
- ✅ Compatibilidade cross-platform
- ✅ Tratamento gracioso de dependências opcionais

**Características principais:**
- **Sem overhead desnecessário** - foco na funcionalidade essencial
- **Recuperação automática** - correção de problemas comuns
- **Mensagens em português** - interface amigável para usuário final
- **Código em inglês** - padrões de desenvolvimento mantidos
- **Extensibilidade** - pronto para histórias futuras

O Framework de Testes Essenciais está **completo e operacional** para validação do Assistente Pessoal IA! 🎉