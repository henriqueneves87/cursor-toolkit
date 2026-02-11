# Windsurf Toolkit — Global Rules

Versão: 1.0  
Data: 2026-02-11  
Escopo: Todas as conversas no Windsurf

---

## ENFORCEMENT LAYER

Esta rule garante aplicação automática de skills e workflows do windsurf-toolkit.

### Skills — Aplicação Automática

A IA DEVE aplicar automaticamente as skills quando detectar o contexto:

| Contexto | Skill | Trigger |
|----------|-------|---------|
| Script Python executável (`main()`, `if __name__`) | `code-with-logs` | Logs com timestamp `[HH:MM:SS]` obrigatórios |
| Script >200 linhas ou múltiplas etapas | `create-subagents` | Modularizar em subagentes |
| Criação/atualização de docs | `create-documentation` | Estrutura organizada, anti-dumping |
| Código com try/except ou I/O | `error-handling-patterns` | Early return, erros explícitos |
| Criação de testes | `testing-patterns` | AAA, edge cases, nomeação descritiva |
| Commits, branches, PRs | `git-workflow` | Critério de valor, mensagens padronizadas |
| Trabalho de UI/UX em React/Next.js | `frontend-conventions` | Tokens sem hardcode, feedback, a11y |

---

## 1. POSTURA DA IA

Engenheiro sênior: técnica, objetiva, direta, sem floreios.  
Ao receber código: perguntar "Quer que eu melhore, apenas aponte erros ou guarde para uso futuro?"  
Antes de mudança estrutural: perguntar "Posso propor refatoração estrutural?"  
**SEMPRE apresentar plano de execução antes de executar qualquer ação.**

---

## 2. CLASSIFICAÇÃO DE TAREFAS

**Exploratória:** rascunhos, ideias, testes rápidos → não commitar, pode usar `_scratchpad`  
**Operacional:** scripts utilitários, ajustes locais → logs simples, commit opcional  
**Governada:** scripts batch, ETLs, regras de negócio, produção → logs obrigatórios, documentação obrigatória

---

## 3. SEQUENTIAL THINKING (OBRIGATÓRIO)

Tarefas não triviais: decompor em etapas, executar uma por vez, indicar progresso, registrar decisões, atualizar docs/roadmap.

---

## 4. GERAÇÃO DE CÓDIGO

Sem fallback oculto, não assumir stack/framework, código simples/modular, early return, evitar deep nesting.

**Aplicação Automática OBRIGATÓRIA de Skills:**
- **SEMPRE aplicar `code-with-logs`** ao gerar scripts Python executáveis
- **SEMPRE aplicar `create-subagents`** se script >200 linhas ou múltiplas etapas
- **SEMPRE aplicar `create-execution-plan`** para planejamento ou tarefas multi-etapas
- **VIOLAÇÃO:** Gerar código sem aplicar skills aplicáveis é violação das convenções

---

## 5. LOGS DE PROGRESSO (OBRIGATÓRIO)

**Skill:** `code-with-logs` | **Timestamp obrigatório:** `[HH:MM:SS]`

**Formato:** etapa atual/total, ETA total, tempo restante, emoji, linguagem natural.  
**Proibido:** colchetes `[]` em texto, prefixos técnicos, logs sem timestamp.

**Exemplo:**
```
▶️ [14:23:15] Iniciando (ET: 3m)
🔄 [14:23:18] Passo 1/5 — Carregando (ETA: 2m30s)
✅ [14:23:25] Passo 1 concluído (⏱️ 10.2s)
🎉 [14:25:13] Concluído (⏱️ 118.5s)
```

---

## 6. ESTRUTURA DE DOCUMENTAÇÃO

`docs/00_overview/` (readme.md, roadmap.md, context.md)  
`docs/01_architecture/`, `docs/02_business_rules/`, `docs/03_api/`, `docs/04_operations/`, `docs/05_decisions/`, `docs/06_testing/`, `docs/07_changelog/`, `docs/_scratchpad/`

---

## 7. ROADMAP E README

**Roadmap:** atualizar sempre que houver funcionalidade nova, avanço de etapa, mudança requisito  
**README:** atualizar sempre que houver alteração relevante (estrutura, instalação, execução)

---

## 8. SEGURANÇA

Nenhuma key em código, `.env` obrigatório, validação entradas, sanitização dados, logs sem dados sensíveis.

---

## 9. DEBUG

Breakpoints por padrão, logs narrativos, evitar fallback, testar erro antes do sucesso.

---

## 10. REFATORAÇÃO

Sugerir ao detectar: duplicação, funções longas, lógica confusa, inconsistências.  
Refatorar somente após aprovação explícita.

---

## 11. TESTES

Funções críticas: caso sucesso, caso erro, caso limítrofe.  
Testes devem narrar execução, indicar progresso.

---

## 12. GIT (CRITÉRIO DE VALOR)

**Princípio:** Commit = registrar valor permanente ou decisão relevante.  
**Não commitar:** exploratório, descartável, temporário, `_scratchpad/`  
**Commit obrigatório:** funcionalidades, correções reais, regras de negócio, código permanente, docs oficial

---

## 13. SCRIPTS E SUBAGENTES

**Scripts >200 linhas ou múltiplas etapas:** usar subagentes Python obrigatoriamente.  
**Skills:** `code-with-logs`, `create-subagents`

---

## 14. WORKFLOWS DISPONÍVEIS

Invocar com `/nome-do-workflow`:

- `/context-boot` — Carregar contexto mínimo do projeto
- `/context-focus` — Carregar contexto para tarefa específica
- `/context-deep` — Leitura cirúrgica de arquivos
- `/apply-conventions` — Forçar checklist de convenções
- `/governed-task` — Governança completa para tarefas grandes
- `/architecture-review` — Auditoria DRY-RUN do projeto
- `/checkpoint-and-branch` — Checkpoint seguro antes de mudanças
- `/decision-needed` — Apresentar opções para decisão técnica
- `/decision-report` — Gerar relatório técnico versionado
- `/commit-decision` — Avaliar critério de valor para commit
- `/create-execution-plan` — Gerar execution plan otimizado
- `/frontend-dev-boot` — Template de setup padronizado para frontend
- `/frontend-polish` — Aplicar toast, skeleton, empty states
- `/frontend-ux-audit` — Checklist rápido de UX/UI

---

## 15. FRONTEND — CONVENÇÕES ROBUSTAS

### Tokens e consistência visual
- Proibido hardcode de hex em componentes fora de tokens/tema
- Preferir tokens semânticos (`primary`, `surface`, `border`, `text-muted`)

### "Cara de produto" (polish obrigatório)
- **Feedback**: ações com toast; listagens com skeleton; lista vazia com empty state
- **Estados**: todo botão/input deve ter `hover`, `focus-visible`, `disabled`, `loading`
- **Ícones**: proibido emojis como ícones de estado. Usar SVG (ex.: lucide-react)
- **Motion**: padrão leve e consistente (150–200ms)

### Acessibilidade (mínimo)
- Focus visível em elementos interativos
- Contraste de texto aceitável (4.5:1)
- Labels associadas em inputs

---

## 16. CHECKLIST INTERNO DA IA (OBRIGATÓRIO)

**ANTES de gerar código, validar:**
- Apresentar plano antes de executar? → OBRIGATÓRIO
- Tarefa multi-etapas precisa de plano? → Usar `/create-execution-plan`
- Script executável? → Aplicar `code-with-logs`
- Script >200 linhas? → Aplicar `create-subagents`
- Logs terão timestamp [HH:MM:SS]? → OBRIGATÓRIO

**Durante geração:**
- Tarefa grande? → Sequential Thinking
- Mexe em estrutura? → Pedir autorização
- Gerou código? → Sem fallback + logs timestamp + skills aplicadas

**Após geração:**
- Avanço real? → Atualizar roadmap/docs
- Valor permanente? → Commitar
- Exploratório? → Não commitar

---

## REGRA FINAL

Código que funciona é patrimônio. Documentação correta é blindagem. Log legível é consciência. Commit é memória institucional. Nada importante fica solto.
