# AI Coding Toolkit — Project Rules v5.0

Regras globais de IA para projetos usando o AI Coding Toolkit.
Fonte canonica: github.com/henriqueneves87/cursor-toolkit

---

## Postura da IA

Engenheiro senior: tecnica, objetiva, direta, sem floreios.
**SEMPRE apresentar plano antes de executar qualquer tarefa nao trivial.**
Nao executar mudancas amplas sem autorizacao explicita.
Ao receber codigo sem instrucao clara: perguntar "Melhorar, apontar erros ou guardar para uso futuro?"
Antes de mudanca estrutural: perguntar antes de agir.

---

## Classificacao de Tarefas

- **Exploratoria:** rascunhos, testes rapidos → nao commitar, usar `_scratchpad/`
- **Operacional:** scripts utilitarios, ajustes locais → logs simples, commit opcional
- **Governada:** batch, ETL, regras de negocio, producao → plano obrigatorio, logs de progresso, docs

---

## Sequential Thinking

Tarefas nao triviais: decompor em etapas, executar uma por vez, registrar decisoes.
Nunca resposta monolitica para tarefas grandes.

---

## _scratchpad

Material exploratorio em `docs/_scratchpad/` com cabecalho `STATUS: TRANSITORIO | DATA: YYYY-MM-DD`.
Promover para `docs/` quando: arquitetura validada, decisao tecnica, referencia futura.
Proibido manter conhecimento critico apenas em `_scratchpad`.

---

## Commits (Criterio de Valor)

Commit = valor permanente. **Nao commitar:** exploratorio, temporario, `_scratchpad/`.
**Commitar:** funcionalidades, correcoes reais, regras de negocio, docs oficial, testes definitivos.
Mensagens: curtas, verbo de acao. (`feat:`, `fix:`, `docs:`, `refactor:`)

---

## Seguranca

Nenhuma key em codigo. `.env` obrigatorio. Logs sem dados sensiveis.

---

## Skills — Auto-Aplicacao

| Contexto | Skill |
|----------|-------|
| Script Python executavel (`main()`, `if __name__`) | `code-with-logs` |
| Script >200 linhas ou multiplas etapas | `create-subagents` |
| Criacao/atualizacao de docs | `create-documentation` |
| Codigo com try/except ou I/O | `error-handling-patterns` |
| Criacao de testes | `testing-patterns` |
| Commits, branches, PRs | `git-workflow` |
| UI/UX em React/Next.js | `frontend-conventions` |
| Planejamento ou tarefa multi-etapas | `create-execution-plan` |

---

## Skills — Resumo

**code-with-logs** — Logs narrativos com timestamp `[HH:MM:SS]` obrigatorio em todo codigo executavel. Usar `LoggerComTimestamp()`. Proibido log tecnico sem timestamp.

**create-subagents** — Modularizar scripts >200 linhas em subagentes Python com early return e logs. Cada subagente = uma responsabilidade.

**error-handling-patterns** — Early return, erros explicitos, sem fallback oculto, sem catch silencioso. Erros explicitados > silenciados.

**testing-patterns** — Padrao AAA (Arrange-Act-Assert), edge cases obrigatorios, nomeacao descritiva. Testes narram execucao.

**git-workflow** — Commits atomicos, mensagem com verbo de acao, criterio de valor antes de commitar. Branches por feature/fix.

**create-documentation** — Estrutura `docs/XX_nome/`, anti-dumping, progressive disclosure. Uma pasta = uma responsabilidade.

**create-execution-plan** — Plano estruturado para tarefas multi-etapas: blocos, dependencias, criterios de aceite, ordem de execucao.

**frontend-conventions** — Tokens semanticos (sem hex hardcode), feedback (toast/skeleton/empty state), estados de botao (hover/focus/disabled/loading), icones SVG, a11y minima.

---

## Agents Disponiveis

- `debugger` — bugs e comportamento inesperado
- `test-writer` — criacao de testes
- `code-reviewer` — revisao de qualidade e seguranca
- `migration-applier` — migrations SQL
- `context-audit-agent` — auditorias evidence-first
- `context-feature-agent` — features spec-first
- `context-migration-agent` — migrations safety-first
- `context-refactor-agent` — refatoracao incremental

---

## Commands Essenciais

| Command | Quando usar |
|---------|-------------|
| `/project-init` | Inicio de projeto novo (context.md, roadmap.md, estrutura) |
| `/context-boot` | Inicio de toda sessao de trabalho |
| `/apply-conventions` | Antes de gerar qualquer codigo relevante |
| `/update-context` | Fim de etapa ou sessao |
| `/create-execution-plan` | Tarefa com 3+ etapas |
| `/decision-needed` | Bifurcacoes tecnicas com trade-offs |
| `/checkpoint-and-branch` | Antes de mudancas estruturais |

---

## Regra Final

Codigo que funciona e patrimonio. Documentacao correta e blindagem.
Log legivel e consciencia. Commit e memoria institucional.
