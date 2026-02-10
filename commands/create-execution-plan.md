# create-execution-plan — Gerar Execution Plan Otimizado para IA

Versao: 1.0
Tipo: Command
Uso: Manual (invocado pelo usuario)
Escopo: Planejamento de tarefas multi-etapas, correcoes de bug, features, refatoracoes

---

## Objetivo

Gerar um execution plan estruturado e detalhado que qualquer IA consiga executar sem ambiguidade. O plano e salvo em `docs/00_overview/execution_plans/` e segue o formato padrao da skill `create-execution-plan`.

---

## Uso

```
/create-execution-plan [descricao da tarefa]
```

---

## Comportamento OBRIGATORIO

Ao receber este comando, a IA DEVE:

### 1. Carregar contexto do projeto

- Ler `docs/00_overview/context.md` (se existir)
- Se nao existir, executar context-boot minimo (estrutura + stack + estado)
- Identificar: stack, convencoes, banco, deploy

### 2. Classificar o tipo de tarefa

| Tipo | Requer diagnostico? | Foco |
|------|---------------------|------|
| Bug/Hotfix | SIM (com evidencias) | Causa raiz + correcao |
| Feature | NAO (contexto basta) | Especificacao + implementacao |
| Refatoracao | PARCIAL (estado atual) | Antes/depois + criterio |
| Migracao | SIM (estado banco) | Validacao + aplicacao + verificacao |

### 3. Coletar evidencias (para bugs)

ANTES de planejar, a IA DEVE:

- Ler os logs de erro fornecidos pelo usuario
- Consultar banco se necessario (via MCP Supabase)
- Ler os arquivos de codigo envolvidos
- Mapear: o que existe vs o que deveria existir

**NUNCA pular esta etapa para bugs. Plano sem diagnostico e achismo.**

### 4. Gerar o plano

Aplicar a skill `create-execution-plan` e gerar o documento com TODAS as secoes obrigatorias:

1. Cabecalho (fase, status, pre-requisitos)
2. Objetivo (1-2 frases)
3. Diagnostico (com evidencias, para bugs)
4. Decisoes tecnicas (tabela)
5. Tarefas T1..TN (com Notas para IA detalhadas)
6. Ordem de execucao (grafo de dependencias)
7. Notas para IA globais (IDs, convencoes, restricoes)
8. Metricas de sucesso (verificaveis)

### 5. Salvar e apresentar

- Salvar em `docs/00_overview/execution_plans/{nome_snake_case}.md`
- Apresentar resumo ao usuario (tabela de tarefas + ordem)
- **PERGUNTAR:** "Posso executar o plano?"
- **NAO executar sem confirmacao explicita**

---

## Regras para Notas para IA

As "Notas para IA" de cada tarefa DEVEM incluir:

- Caminho exato do arquivo (ex: `src/services/payment_service.py`)
- Numero de linha ou bloco de referencia (quando possivel)
- Snippet de codigo "antes" e "depois" (para alteracoes pontuais)
- IDs e constantes necessarias
- Restricoes especificas da tarefa
- Convencoes do projeto que afetam a tarefa

**Teste mental:** Se uma IA DIFERENTE pegar apenas uma tarefa isolada, ela deve conseguir executar sem ler o resto do plano.

---

## Integracao com Skills

Ao gerar tarefas, referenciar skills aplicaveis:

| Tarefa envolve | Skill a referenciar |
|----------------|---------------------|
| Script Python executavel | `code-with-logs` |
| Script >200 linhas | `create-subagents` |
| Migration SQL | Padrao Validacao → Aplicacao → Verificacao |
| Documentacao | `create-documentation` |

---

## Integracao com Commands

Este command pode ser combinado com:

- `/governed-task` — para tarefas governadas que precisam de plano
- `/context-boot` — para carregar contexto antes de planejar
- `/apply-conventions` — validacao pre-geracao apos plano aprovado

---

## Exemplo de uso

```
/create-execution-plan corrigir erros de pagamento no checkout que aparecem sequencialmente

[usuario cola logs de erro]
```

**Resultado esperado:** Plano com diagnostico (mapa de campos faltando), tarefas com snippets exatos, ordem de execucao, metricas de sucesso.

---

## Regra Final

Plano bom economiza horas de debug.
Plano ruim gera retrabalho.
**Investir 10 minutos no plano salva 2 horas na execucao.**

--- End Command ---
