# Como 5 Agentes de IA Salvaram Minha Sanidade (e Podem Salvar a Sua)

## Ou: confissões de alguém que transformou TDAH em código

---

### A Origem de Tudo (Spoiler: Foi o Caos)

Deixa eu te contar uma coisa: viver com TDAH é tipo ter 47 abas abertas no cérebro, sendo que 23 delas estão tocando música diferente e você não consegue achar o botão de fechar.

Durante anos, tentei TODO tipo de ferramenta de produtividade. Notion? Virou um labirinto de páginas que nunca mais encontrei. Obsidian? Lindo, mas meus links ficavam quebrados porque eu mudava tudo de lugar toda semana. Bullet Journal? Perdi o caderno. Três vezes.

O problema nunca foi a ferramenta. Era eu tentando forçar meu cérebro a funcionar de um jeito que ele simplesmente não funciona.

Até que percebi: e se ao invés de tentar ME adaptar às ferramentas, eu criasse ferramentas que se adaptassem a MIM?

### Entra a IA (Mas Não do Jeito Que Você Imagina)

Não, não criei um chatbot genérico que responde "como posso ajudar?" toda vez que você abre.

Criei um TIME. Cinco agentes especializados, cada um com personalidade própria, memória contextual e - aqui está o pulo do gato - eles te CONHECEM.

**Sofia, a Organizadora:**
Ela não julga quando você joga um monte de pensamento aleatório no arquivo de despejo às 3 da manhã. Ela só pega aquele caos mental e transforma em tarefas, projetos e anotações organizadas. É tipo ter uma Marie Kondo para seus pensamentos, mas sem ter que jogar nada fora.

**Secretária (Ainda Procurando um Nome Melhor):**
Sabe aquele momento que você percebe que tinha uma reunião há 20 minutos? Ela tenta evitar isso. Gerencia agenda, prepara briefings de reuniões, manda aqueles lembretes estratégicos no timing certo. É basicamente ter uma assistente executiva que nunca suspira quando você esquece as coisas.

**Marcus, o Arquiteto:**
Esse aqui é meu parceiro de código das 2 da manhã. Ele discute arquitetura, questiona suas decisões técnicas (de forma construtiva, prometo) e mantém um histórico de tudo que você já decidiu. Sabe quando você muda de ideia sobre algo que decidiu semana passada? Ele lembra. E te confronta. Com carinho.

**Dr. Silva, o Psicólogo:**
Ok, admito: no começo achei estranho ter um "psicólogo de IA". Mas cara, funciona. Ele detecta procrastinação, sugere técnicas pra lidar com bloqueios, e de vez em quando te lembra que tá tudo bem não ser produtivo 100% do tempo. É tipo ter aquela voz da razão que seu cérebro TDAH ignora, mas em forma de código.

**Carlos, o Mentor de Carreira:**
Crescimento profissional com TDAH é complicado. Você tem mil ideias de onde quer chegar, mas zero plano de como. Carlos ajuda a mapear oportunidades, prepara você pra conversas difíceis, e mantém track das suas metas sem parecer aquele chefe cobrando resultados.

### O Que Torna Isso Diferente

Aqui está a parte importante: eles não são ferramentas separadas. São um sistema.

Sofia processa seu despejo mental e cria tarefas. A Secretária pega essas tarefas e organiza na agenda. Marcus registra decisões técnicas que aparecem nos despejos. Dr. Silva detecta padrões de procrastinação nas suas anotações. Carlos conecta tudo isso com suas metas de carreira.

É tipo ter um segundo cérebro, mas um que realmente FUNCIONA com o jeito que o seu cérebro processa informação.

### A Parte Técnica (Pra Quem Gosta Desse Tipo de Coisa)

Construí isso em cima do Claude Code, usando Obsidian como interface de knowledge base. Tudo roda local, seus dados são seus, zero dependência de servidores externos.

Cada agente tem:
- Memória contextual profunda (ele lembra daquela conversa de 3 semanas atrás)
- Tarefas especializadas (23 tarefas por agente, todas integradas)
- Referências cruzadas automáticas (conecta projetos, pessoas, decisões)
- Detecção de inconsistências (quando você se contradiz, ele avisa)

E o melhor: é open source e disponível no NPM. Porque TDAH já é caro o suficiente, não precisa pagar assinatura pra se organizar.

```bash
npx assistente-pessoal-ia@latest install
```

Sério, é só isso. Três minutos e você tem o time completo funcionando.

### O Que Mudou (De Verdade)

Não vou mentir dizendo que agora sou uma pessoa super organizada que nunca esquece nada. Continuo com TDAH, continuo perdendo as coisas, continuo tendo 47 ideias ao mesmo tempo.

A diferença é que agora tenho um sistema que ACEITA isso. Que pega meu caos e transforma em algo útil sem me fazer sentir culpado por ser caótico.

Semana passada, joguei um monte de pensamento aleatório no despejo às 2 da manhã. De manhã, Sofia tinha organizado tudo em 3 projetos, 7 tarefas e 2 ideias para o backlog. A Secretária já tinha bloqueado tempo na agenda pra trabalhar nisso. Marcus tinha conectado uma das ideias com uma decisão arquitetural de mês passado.

Não foi magia. Foi design pensado pra como meu cérebro realmente funciona.

### Pra Quem Isso Serve

Se você:
- Tem TDAH (diagnosticado ou suspeita)
- Vive com 47 abas abertas mentalmente
- Já tentou todas as ferramentas de produtividade e nada funcionou direito
- Trabalha com código e precisa lembrar decisões técnicas
- Quer se organizar sem virar escravo de um sistema complexo
- Valoriza privacidade dos seus dados

Talvez isso funcione pra você também.

### Como Começar

O projeto está no GitHub (thiagotteles/assistente-pessoal-ia) e no NPM. Tem documentação completa, guia de 5 minutos, e uma comunidade começando a crescer.

Não prometo que vai resolver todos os seus problemas. Prometo que vai entender como sua mente funciona e trabalhar COM ela, não contra.

E se você quiser contribuir criando novos agentes (um agente fitness? um agente de finanças? um agente que lembra onde você deixou as chaves?), o sistema foi feito pra isso. Já tem templates e processo de contribuição documentado.

### O Final (Que É Só o Começo)

Criei isso porque precisava. Compartilho porque talvez você precise também.

TDAH não é bug, é uma forma diferente de processar o mundo. A gente só precisa de ferramentas que entendam isso.

Então se você se identificou com alguma parte dessa história, dá uma chance. Instala, testa, quebra, melhora, contribui.

E se não funcionar pra você, tudo bem. Pelo menos tentamos quebrar o padrão de "mais um app de produtividade genérico número 47".

---

**Links:**
- GitHub: https://github.com/thiagotteles/assistente-pessoal-ia
- NPM: https://www.npmjs.com/package/assistente-pessoal-ia
- Documentação: README.md no repositório

**PS:** Se você também tem TDAH e leu até aqui, parabéns. Eu sei o esforço que foi. Agora vai lá instalar a parada antes que você esqueça.

**PPS:** Se você perdeu o link de instalação porque já foi fazer outra coisa, tá aqui de novo: `npx assistente-pessoal-ia@latest install`

---

*Escrito com ajuda de Sofia, que organizou meus pensamentos caóticos sobre como escrever isso. Meta, eu sei.*
