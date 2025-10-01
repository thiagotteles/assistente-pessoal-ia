# Arquitetura de Alto Nível

## Resumo Técnico

O sistema implementa uma **arquitetura conversacional baseada em agentes** que evolui os conceitos BMAD para criar um "segundo cérebro" especializado para TDAH. Cinco agentes especializados (`/organizador`, `/secretaria`, `/arquiteto`, `/psicologo`, `/mentor`) compartilham uma knowledge-base inteligente local, otimizando para captura ultra-rápida (<5 segundos) e recuperação contextual (<3 segundos). O sistema prioriza transparência total (arquivos .md human-readable), zero fricção (sem formulários), e personalidades confrontadoras que aceleram crescimento pessoal/profissional.

## Visão Geral de Alto Nível

**Estilo Arquitetural:** Arquitetura conversacional orientada a agentes com knowledge-base compartilhada
- **Estrutura de Repositório:** Monorepo (decisão PRD) com todos os componentes em um repositório único
- **Arquitetura de Serviços:** Sistema local baseado em arquivos com agentes especializados via Claude Code
- **Fluxo Principal:** Usuário → Slash Command → Agente Especializado → Knowledge-base → Resposta Contextualizada

**Decisões Arquiteturais Críticas:**
1. **Local-First:** Zero dependências externas exceto Claude Code (privacidade TDAH)
2. **File-Based:** Arquivos .md/.yaml como persistência (transparência + versionamento Git)
3. **Agent-Oriented:** Cinco agentes especializados com personalidades distintas
4. **Conversation-Driven:** Interface exclusivamente conversacional (zero UI tradicional)
5. **Intelligence-Enhanced:** IA gerencia organização automática e splitting de arquivos

## Diagrama de Projeto de Alto Nível

```mermaid
graph TD
    User[Usuário TDAH] --> Claude[Claude Code Interface]

    Claude --> Org[/organizador]
    Claude --> Sec[/secretaria]
    Claude --> Arq[/arquiteto]
    Claude --> Psi[/psicologo - Fase 2]
    Claude --> Men[/mentor - Fase 2]

    Dump[daily-dump.md] --> Org

    Org --> KB[Knowledge-Base Inteligente]
    Sec --> KB
    Arq --> KB
    Psi --> KB
    Men --> KB

    KB --> Dec[decisoes/*.md]
    KB --> Ctx[contextos/*.md]
    KB --> Proj[projetos/*.md]
    KB --> Ppl[pessoas/*.md]

    KB --> Split[IA Auto-Split Arquivos]
    KB --> Cross[Referências [[]] Obsidian]

    Sec --> Todos[central-todos.md]
    Sec --> Diary[diario/*.md]

    subgraph "Sistema Local"
        Claude
        KB
        Split
        Cross
    end

    subgraph "Agentes MVP"
        Org
        Sec
        Arq
    end

    subgraph "Agentes Fase 2"
        Psi
        Men
    end
```

## Padrões Arquiteturais e de Design

- **Padrão de Agente Especializado:** Cada agente tem personalidade, funcionalidades e contexto específicos - _Rationale:_ Espelha como cérebro humano tem diferentes áreas especializadas, otimiza para diferentes tipos de consultoria
- **Knowledge-Base Compartilhada:** Base única com acesso cruzado automático entre agentes - _Rationale:_ Elimina silos de informação, permite contexto holístico, simula memória associativa
- **Captura Ultra-Rápida:** Arquivo despejo sem estrutura obrigatória → organização IA posterior - _Rationale:_ Remove fricção crítica para usuários TDAH, permite captura no momento do insight
- **Confronto Construtivo:** Agentes questionam ao invés de validar automaticamente - _Rationale:_ Acelera crescimento pessoal/profissional, evita confirmação bias, simula mentoria real
- **File-Based Persistence:** Arquivos .md como "banco de dados" - _Rationale:_ Transparência total, versionamento Git, portabilidade, eliminação de lock-in de tecnologia
- **Referências [[]] Obsidian:** Sistema de links Wiki-style para conectar informações - _Rationale:_ Cria rede de conhecimento conectada, aproveita poder do Obsidian para visualização
