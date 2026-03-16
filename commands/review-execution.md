# review-execution — Command

Versao: 2.0
Tipo: Command
Uso: Manual (invocado pelo usuario)

---

## USO

```
/review-execution
/review-execution scope=plan path="docs/00_overview/execution_plans/003_checkout.md"
/review-execution scope=docs
/review-execution scope=full
```

---

## COMPORTAMENTO

Ao receber `/review-execution`:

### 1. Determinar escopo

Se nao informado, perguntar: plan | docs | full

### 2. Identificar fonte de verdade

- **scope=plan:** caminho informado, ou plano mais recente em `docs/00_overview/execution_plans/` (numero mais alto)
- **scope=docs:** `docs/` do projeto (priorizar spec, roadmap, arquitetura; ignorar _scratchpad)
- **scope=full:** combinar ambas

### 3. Aplicar skill `review-execution`

Executar as 4 fases da skill:
- Fase 0: Parse → checklist compacto (Composer/pool incluso)
- Fase 1: Triagem mecanica → items [MECANICO] e [PRECISA ANALISE] (Composer/pool incluso)
- Fase 2: Consolidacao → relatorio + prompt de handoff se necessario (Composer/pool incluso)
- Fase 3: Handoff → apresentar resultado ao usuario

### 4. Salvar artefatos

- Relatorio: `docs/05_decisions/reports/review_exec_{NNN}_{nome}_{YYYY-MM-DD}.md`
- Prompt de handoff (se houver items [PRECISA ANALISE]): `docs/04_operations/prompts_review_{NNN}_{nome}.md`

### 5. Apresentar resultado

1. Resumo executivo (tabela de severidades)
2. Top 5 inconsistencias mais criticas
3. Se ha items [PRECISA ANALISE]: informar caminho do prompt de handoff e recomendar nova conversa com tier intermediario (Sonnet/GPT-5.4)
4. Oferecer: "Quer que eu gere um execution plan de correcao?"

---

## INTEGRACAO

| Antes | Depois |
|-------|--------|
| `/create-execution-plan` | `/review-execution scope=plan` |
| Execucao orquestrada | `/review-execution scope=docs` |
| `/review-execution` (gaps) | `/create-execution-plan` (correcao) |

--- End Command ---
