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
- Fase 2: Consolidacao → relatorio (Composer/pool incluso)
- Fase 3: Acao pos-review → triagem de acoes + guiar usuario (Composer/pool incluso)

### 4. Salvar artefatos

- Relatorio: `docs/05_decisions/reports/review_exec_{NNN}_{nome}_{YYYY-MM-DD}.md`
- Prompt de handoff para analise profunda (se items [PRECISA ANALISE]): `docs/04_operations/prompts_review_{NNN}_{nome}.md`
- Prompt de handoff para features complexas (se LACUNAs complexas): `docs/04_operations/prompts_correcao_{NNN}_{nome}.md`

### 5. Acao pos-review (OBRIGATORIO)

A IA DEVE guiar o usuario ate a acao, nao apenas listar inconsistencias:

1. Resumo executivo (tabela de severidades + top 5)
2. Agrupar inconsistencias por tipo de acao:
   - **Correcoes rapidas** (DRIFTs, LACUNAs simples) → "Posso aplicar agora?"
   - **Features complexas** (LACUNAs com backend+frontend) → prompt de handoff para /create-execution-plan (Opus)
   - **Analise profunda** (items [PRECISA ANALISE]) → prompt de handoff para Sonnet/GPT-5.4
3. Perguntar: "Posso aplicar as N correcoes rapidas agora?"
4. Se autorizado: aplicar direto na mesma conversa
5. Informar caminhos dos prompts de handoff salvos para as demais acoes

---

## INTEGRACAO

| Antes | Depois |
|-------|--------|
| `/create-execution-plan` | `/review-execution scope=plan` |
| Execucao orquestrada | `/review-execution scope=docs` |
| `/review-execution` (gaps) | `/create-execution-plan` (correcao) |

--- End Command ---
