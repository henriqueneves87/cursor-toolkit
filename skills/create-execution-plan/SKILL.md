---
name: create-execution-plan
description: Creates optimized execution plans for multi-step tasks. Use for planning requests, complex bugs, multi-step features requiring upfront planning.
---

# Create Execution Plan v1.0

## APLICACAO AUTOMATICA OBRIGATORIA

**Esta skill DEVE ser aplicada automaticamente SEMPRE que detectar:**

- Pedido de planejamento ou plano de execucao
- Correcao de bug complexo (multiplos arquivos/camadas)
- Feature com mais de 3 tarefas
- Tarefa que envolve backend + frontend + banco
- Comando `/create-execution-plan`
- Contexto de `/governed-task` que requer planejamento

## O que e um Execution Plan

Documento estruturado que permite a uma IA executar tarefas complexas **sem ambiguidade**. Cada tarefa contem contexto suficiente (arquivo, linha, codigo exato) para execucao direta.

**Principio:** A IA que executa o plano pode ser DIFERENTE da que criou. O plano deve ser autocontido.

## Anatomia Obrigatoria

Todo execution plan DEVE conter estas secoes, nesta ordem:

### 1. Cabecalho

```markdown
# Plano: [Nome descritivo em snake_case]

Fase: [N ou Hotfix]
Status: NAO INICIADO | EM ANDAMENTO | CONCLUIDO
Ultima atualizacao: YYYY-MM-DD
Pre-requisitos: [lista ou "nenhum"]
```

### 2. Objetivo (1-2 frases)

O resultado esperado ao concluir o plano. Sem jargao, direto.

### 3. Diagnostico (OBRIGATORIO para bugs/hotfixes)

Secao que documenta a causa raiz com **evidencias concretas**:

- **Logs reais** (copiar trecho relevante do erro)
- **Queries** (resultado de consultas ao banco)
- **Codigo** (trecho exato onde o problema ocorre, com arquivo e linha)
- **Mapa de dados** (tabela mostrando o que existe vs o que falta)

**Regra:** Diagnostico sem evidencia e achismo. SEMPRE incluir evidencia.

Para features novas (nao bugs), esta secao pode ser substituida por "Contexto" com a situacao atual.

### 4. Decisoes tecnicas

```markdown
| Decisao | Escolha | Justificativa |
|---------|---------|---------------|
```

### 5. Tarefas (formato T1..TN)

Cada tarefa DEVE conter TODOS os campos abaixo:

```markdown
### T1 -- [Nome claro da tarefa]

- **Complexidade:** minima | baixa | media | alta
- **Arquivos:** [lista exata de arquivos criados/modificados]
- **Depende de:** nenhuma | T0 | T1, T2
- **Status:** pendente | em andamento | concluido
- **Criterio de aceite:** [frase que confirma que esta pronto]
- **Notas para IA:**

  [Contexto especifico que a IA precisa para executar esta tarefa.
   DEVE incluir:
   - Caminho exato do arquivo
   - Linha ou bloco de codigo a alterar (quando aplicavel)
   - Snippet "antes" e "depois" (quando a alteracao e pontual)
   - Restricoes especificas desta tarefa
   - Qualquer ID, constante ou convencao necessaria]
```

**Regra de ouro das Notas para IA:** Se uma IA diferente pegar apenas esta tarefa, ela DEVE conseguir executar sem ler o resto do plano.

### 6. Ordem de execucao

```markdown
## Ordem de execucao

Bloco A (CRITICO):
  T1 + T2 + T3 (paralelo) → DEPLOY

Bloco B (ESTRUTURAL):
  T4 → T5 → T6

Sequencia completa:
  [T1 + T2 + T3] → [T4] → [T5 + T6] → deploy final
```

Usar notacao: `+` para paralelo, `→` para sequencial, blocos nomeados para agrupamento.

### 7. Notas para IA (globais)

Contexto critico que afeta TODAS as tarefas:

- IDs de recursos (Supabase project ID, merchant IDs, etc.)
- Convencoes do projeto (logger, exceptions, patterns)
- Restricoes globais (PCI, nao criar arquivos, etc.)
- Deploy info (Docker, portas, dominios)
- Skills a aplicar (`code-with-logs` para scripts, `create-subagents` para scripts >200 linhas)

### 8. Metricas de sucesso

Lista de itens verificaveis que confirmam conclusao:

```markdown
- [metrica objetiva 1]
- [metrica objetiva 2]
```

**Regra:** Metricas devem ser verificaveis (testavel, consultavel, observavel). "Funcionar" NAO e metrica.

## Sub-planos

### Quando usar

- Plano com mais de 10 tarefas
- Blocos independentes que podem ser executados em paralelo por agentes diferentes
- Tarefas com dominios distintos (ex: backend vs frontend vs banco)

### Formato

Plano principal referencia sub-planos por arquivo:

```markdown
## Sub-planos

- Bloco A (Backend): `execution_plans/plano_bloco_a.md`
- Bloco B (Frontend): `execution_plans/plano_bloco_b.md`
```

Cada sub-plano segue o mesmo formato (cabecalho, tarefas, notas para IA, metricas).

## Integracao com Skills

Ao gerar o plano, referenciar skills aplicaveis nas Notas para IA:

| Contexto da tarefa | Skill a referenciar |
|--------------------|---------------------|
| Script Python executavel | `code-with-logs` |
| Script >200 linhas ou multi-etapas | `create-subagents` |
| Documentacao | `create-documentation` |
| Migration SQL | Padrao Validacao → Aplicacao → Verificacao |

## Workflow de Criacao

1. **Ler contexto** — context.md ou context-boot do projeto
2. **Analisar pedido** — entender escopo e tipo (bug, feature, refactor)
3. **Coletar evidencias** — logs, queries, codigo (OBRIGATORIO para bugs)
4. **Gerar diagnostico** — causa raiz documentada
5. **Planejar tarefas** — T1..TN com Notas para IA detalhadas
6. **Definir ordem** — grafo de dependencias
7. **Definir metricas** — como saber que deu certo
8. **Salvar** — em `docs/00_overview/execution_plans/{nome}.md`
9. **Apresentar ao usuario** — resumo + pedir confirmacao antes de executar

## Anti-patterns (PROIBIDOS)

- Tarefa sem "Notas para IA" (IA nao sabe o que fazer)
- Plano de bug sem diagnostico com evidencia
- Dependencias implicitas (T3 precisa de T1 mas nao declara)
- Metricas genericas ("funcionar", "ficar bom")
- Tarefas vagas ("melhorar o codigo")
- Plano com mais de 10 tarefas sem sub-planos
- Notas para IA sem caminhos de arquivo
- Snippets de codigo sem indicar onde inserir (antes/depois de qual bloco)

## Template

Para template completo com exemplos, ver [template.md](template.md).

## Regra Final

Plano sem contexto e promessa vazia.
Tarefa sem "Notas para IA" e tarefa que vai falhar.
**Execution plan e contrato entre quem planeja e quem executa.**
