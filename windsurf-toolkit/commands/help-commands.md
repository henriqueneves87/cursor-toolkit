# help-commands

# help-commands — GUIA PRÁTICO DE USO DOS COMMANDS NO CURSOR

Versão: 1.1  
Tipo: Command  
Uso: Manual (invocado pelo usuário)

## Objetivo

Este comando existe para responder **quando e por que usar cada command**,  
especialmente nos **pontos onde o Cursor costuma falhar sozinho**.

Ele **não executa tarefas**, **não gera código** e **não toma decisões**.  
Serve apenas como **guia rápido e assertivo**.

---

## Como usar

Digite apenas:

help-commands

A IA deve responder **somente com explicações resumidas**, focadas em **uso prático no Cursor**.

---

## Regra mental principal

> Use commands quando quiser **forçar comportamento**,  
> não quando quiser apenas **gerar código**.

---

## Commands disponíveis e quando usar

### governed-task

- quando usar:
  - tarefas grandes
  - problemas com múltiplas etapas
  - criação de pipelines ou sistemas
  - arquitetura ou mudanças estruturais
- quando o Cursor falha:
  - resolve tudo de uma vez
  - não divide em etapas
  - não atualiza docs ou roadmap
- o que força:
  - sequential thinking
  - execução por etapas
  - governança completa

---

### code-with-logs

- quando usar:
  - scripts
  - testes longos
  - jobs, ETLs, migrações
  - qualquer rotina que "fica só com barrinha piscando"
- quando o Cursor falha:
  - execução silenciosa
  - sem noção de progresso
  - impossível saber se travou
- o que força:
  - logs narrativos
  - progresso visível
  - tempo estimado total
  - tempo restante por etapa

---

### decision-needed

- quando usar:
  - trade-offs técnicos
  - escolhas arquiteturais
  - decisões irreversíveis
- quando o Cursor falha:
  - decide sozinho
  - já escreve código sem perguntar
- o que força:
  - comparação de opções
  - prós e contras
  - nenhuma decisão automática

---

### audit-response

- quando usar:
  - resposta parece errada ou incompleta
  - violação de convenção
  - suspeita de refatoração indevida
- quando o Cursor falha:
  - não revisa a própria resposta
- o que força:
  - auditoria da resposta anterior
  - correção pontual
  - sem recomeçar tudo

---

### commit-decision

- quando usar:
  - dúvida se algo deve virar commit
  - após testes exploratórios
  - após scripts temporários
- quando o Cursor falha:
  - sugere commit para tudo
- o que força:
  - critério de valor
  - decisão consciente de versionamento

---

## Regra final

Commands não são burocracia.  
São **freios, trilhos e proteção contra automatismos da IA**.

Se você não quer que a IA:
- resolva tudo de uma vez
- decida por você
- esconda progresso
- polua o git

Use o command adequado.
