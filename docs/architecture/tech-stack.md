# Tech Stack

## Infraestrutura em Nuvem

- **Provedor:** N/A (Sistema 100% Local)
- **Serviços Principais:** Sistema de arquivos local + Claude Code + Obsidian
- **Regiões de Deploy:** Máquina local do usuário

## Tabela de Stack Tecnológico

| Categoria | Tecnologia | Versão | Propósito | Rationale |
|-----------|------------|---------|-----------|-----------|
| **Plataforma** | Claude Code | Current | Interface principal e processamento IA | Subscription existente, elimina complexidade adicional |
| **Configuração** | YAML | 1.2 | Templates e configuração de agentes | Human-readable, compatível com BMAD patterns |
| **Documentos** | Markdown | CommonMark | Knowledge-base e persistência | Transparente, versionável, universalmente suportado |
| **Referências** | Obsidian | Current | Gerenciamento automático de [[links]] | Graph view, backlinks automáticos, mobile access |
| **Versionamento** | Git | 2.40+ | Backup e histórico de mudanças | Robusto, permite rollback, familiar para desenvolvedor |
| **Estrutura** | Filesystem | N/A | Organização de dados | Zero overhead, máxima simplicidade |
| **Processamento** | Claude API | Current | IA para organização e splitting | Integrado ao Claude Code, sem APIs adicionais |
