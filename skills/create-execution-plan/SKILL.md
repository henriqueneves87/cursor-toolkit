---
name: create-execution-plan
description: Cria execution plans otimizados para IA executar tarefas multi-etapas com suporte a mapeamento de codebase grande e execucao paralela via subagentes. Use quando receber pedido de planejamento, correcao de bug complexo, feature multi-etapas, refatoracao de codigo grande, ou qualquer tarefa que precise de plano antes de executar. Aplica automaticamente ao detectar /create-execution-plan.
---

# Create Execution Plan v3.1 (compacto)

> Referencia completa com exemplos: `SKILL_REFERENCE.md`
> Consultar SKILL_REFERENCE.md quando: primeiro plano do projeto, codebase >20 arquivos, ou duvida sobre formato de secao.
> Template: `template.md`

## QUANDO APLICAR

- Pedido de planejamento ou /create-execution-plan
- Bug complexo (multiplos arquivos/camadas)
- Feature com mais de 3 tarefas
- Tarefa backend + frontend + banco
- Refatoracao >500 linhas ou >10 arquivos

**NAO usar:** tarefa 1-2 passos, hotfix 1 linha, exploratorio, ajuste config.

## FASE 0 — Mapeamento (codebase grande/desconhecido)

Ativar quando: codebase desconhecido, >10 arquivos, >500 linhas, contexto insuficiente.

1. Agente pai: estrutura superficial (tree, dominios, lista de arquivos SEM conteudo)
2. Ate 4 subagentes paralelos: mapear 1 dominio cada (classes, funcoes publicas, dependencias — SEM codigo completo)
3. Agente pai: consolidar em Mapa do Codebase (incluir no plano)
4. Leitura cirurgica: APENAS arquivos relevantes para a tarefa

## ANATOMIA OBRIGATORIA

Todo plano DEVE conter, nesta ordem:

1. **Cabecalho:** nome, fase, versao, status, modo ORQUESTRADO, pre-requisitos
2. **Objetivo:** 1-2 frases
3. **Diagnostico/Contexto:** bugs=logs+queries+codigo; features=situacao+mapa+regras
4. **Decisoes tecnicas:** tabela (decisao | escolha | justificativa)
5. **Tarefas T1..TN** — cada uma com TODOS os campos:
   - Complexidade, Estimativa, Arquivos, Depende de, Conflita com, Status, Criterio de aceite
   - **Notas para IA:** caminho exato, linha/bloco, snippet antes/depois, restricoes, regras de negocio
   - Regra de ouro: IA diferente pega APENAS esta tarefa e consegue executar
6. **Ordem de execucao:** `+` = paralelo, `→` = sequencial, `[ ]` = bloco
7. **Mapa de conflitos:** tabela (arquivo | tarefas). Conflitantes NUNCA paralelas
8. **Notas para IA globais:** IDs, convencoes, restricoes, skills aplicaveis
9. **Metricas de sucesso:** verificaveis (testavel, consultavel, observavel)
10. **Rollback/Contingencia:** obrigatorio para migrations/producao

## MODO ORQUESTRADO

1. Orquestrador le plano, identifica proximo bloco
2. Blocos paralelos: ate 4 subagentes via Task tool
3. Cada subagente recebe prompt autocontido (ver template abaixo)
4. Orquestrador consolida, resolve conflitos, commita o bloco
5. Avanca para proximo bloco

**Template de prompt para subagente:**

```
Execute a tarefa {TN} do plano {caminho_do_plano}.

Notas para IA da tarefa:
{notas_da_tarefa}

Contexto global:
{notas_globais}

Regras:
- Execute SOMENTE esta tarefa
- NAO commite (o orquestrador fara isso)
- Marque a tarefa como "concluido" no plano
- Retorne: arquivos criados/alterados e resultado
```

## SUB-PLANOS

Plano >10 tarefas → dividir em sub-planos por dominio. Cada sub-plano segue mesmo formato.
Plano principal referencia sub-planos: `execution_plans/plano_bloco_{x}.md`

## PROMPT DE EXECUCAO

Apos salvar plano, SEMPRE gerar prompt em `docs/04_operations/prompts_execucao_{NNN}_{nome}.md`.
Deve ser autocontido (colar em conversa nova basta), incluir contexto inline, sem depender de context-boot.

**Conteudo minimo obrigatorio do prompt:**
1. Caminho do execution plan
2. Instrucao de identificacao (proxima tarefa/bloco pendente)
3. Caminhos do projeto e referencias somente leitura
4. Contexto critico inline (schema, logger, exceptions, convencoes)
5. Contexto especifico do plano (decisoes tecnicas, regras de negocio, IDs)
6. Instrucoes pos-conclusao (marcar concluido, commitar, push)
7. Instrucao de paralelismo (identificar bloco paralelo, disparar subagentes)
8. Template de prompt para subagente (com placeholders)
9. Regra de conflito (mesmo arquivo = sequencial)
10. Regra de commit (subagentes NAO commitam, orquestrador commita)

## NUMERACAO

Contar `*.md` em `docs/00_overview/execution_plans/` → proximo = contagem+1, zero-padding 3 digitos.
Mesmo numero para plano e prompt de execucao.

**Salvar plano:** `docs/00_overview/execution_plans/{NNN}_{nome}.md`
**Salvar prompt:** `docs/04_operations/prompts_execucao_{NNN}_{nome}.md`

## ANTI-PATTERNS

- Tarefa sem Notas para IA
- Bug sem diagnostico com evidencia
- Dependencias/conflitos implicitos
- Metricas genericas ("funcionar")
- Ler codebase inteiro sem Fase 0
- Subagentes paralelos no mesmo arquivo
- Plano >10 tarefas sem sub-planos

## WORKFLOW

Avaliar escopo → Fase 0 (se aplicavel) → Ler contexto → Analisar pedido → Evidencias → Diagnostico → Tarefas → Conflitos → Ordem → Metricas → Rollback → Salvar → Gerar prompt → Apresentar → NAO executar sem confirmacao.
