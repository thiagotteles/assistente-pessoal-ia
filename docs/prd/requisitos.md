# Requisitos

## Funcionais

1. **FR1:** Sistema deve implementar captura ultra-rápida via arquivo despejo único (`daily-dump.txt`) sem estrutura obrigatória
2. **FR2:** Agente `/organizador` deve processar despejo através de perguntas específicas e categorizar automaticamente na knowledge-base
3. **FR3:** Agente `/secretaria` deve oferecer gestão executiva completa: agenda, status de projetos, lembretes, registro de reuniões
4. **FR4:** Agente `/arquiteto` deve funcionar como "braço direito" técnico com memória contextual profunda e questionamento confrontador
5. **FR5:** Sistema deve manter knowledge-base compartilhada única com acesso cruzado automático entre agentes
6. **FR6:** Cada agente deve ter personalidade confrontadora específica que questiona construtivamente ao invés de validar automaticamente
7. **FR7:** Sistema deve funcionar via slash commands no Claude Code seguindo padrão BMAD familiar
8. **FR8:** Agentes devem compartilhar contexto relevante automaticamente sem duplicação de informações
9. **FR9:** Sistema deve registrar e processar transcrições de reuniões gerando resumos estruturados e todos automáticos
10. **FR10:** Todos os dados devem ser human-readable em formato Markdown/YAML para transparência total

## Não-Funcionais

1. **NFR1:** Resposta de agentes deve ser inferior a 3 segundos para manter fluxo TDAH
2. **NFR2:** Sistema deve funcionar 100% localmente via Claude Code (privacidade total)
3. **NFR3:** Captura de informações deve ter ZERO fricção - sem preenchimento obrigatório
4. **NFR4:** Knowledge-base deve ser pesquisável e recuperável em menos de 1 segundo
5. **NFR5:** Sistema deve suportar uso diário por 365 dias sem degradação de performance
6. **NFR6:** Todos os arquivos devem ser versionáveis via Git para backup seguro
7. **NFR7:** Interface deve ser anti-procrastinação: modelo reativo (usuário chama quando quer)
8. **NFR8:** Agentes devem manter consistência de personalidade ao longo do tempo
9. **NFR9:** Sistema deve escalar knowledge-base sem impacto perceptível na velocidade
10. **NFR10:** Processamento de despejo diário deve completar em menos de 30 segundos
