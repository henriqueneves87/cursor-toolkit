# Plano: toolkit_v5_upgrade

Fase: Evolução do toolkit v4.4 → v5.0
Versao: 1.0
Status: BLOCO B CONCLUIDO
Modo de execucao: MANUAL (uma tarefa por conversa)
Ultima atualizacao: 2026-02-24
Pre-requisitos: Repo cursor-toolkit clonado em C:\Users\User\cursor-toolkit. Decisoes aprovadas (DR_029).

---

## Objetivo

Reduzir o toolkit de 48 para 30 artefatos, eliminar redundancias, criar /project-init, criar manual de uso, adicionar suporte Trae, implementar enforcement mecanico (pre-commit + CI), e renomear repo para ai-coding-toolkit.

---

## Contexto

### Estado atual (v4.4)

- 20 commands, 13 skills, 8 agents, 3 rules no repo + 7 user rules no Cursor
- Redundancia: mesmo conceito em 3-6 locais (ex: code-with-logs)
- Sem manual de uso para o humano
- governed-task consome ~2000 tokens repetindo o que ja esta em rules/skills
- project-docs-init nao cria context.md nem roadmap.md
- Sem suporte Trae
- Sem pre-commit hooks nem CI

### Decisoes aprovadas (DR_029)

1. Criar /project-init (evolucao do project-docs-init)
2. Deletar governed-task (nao arquivar)
3. Reduzir commands de 20 para 11
4. Consolidar user rules de 7 para 3
5. Manual no toolkit repo + referencia em projetos
6. Renomear repo para ai-coding-toolkit
7. Pre-commit + CI com fundamento no manual

### Referencia completa

- c:\saphiro_baas\docs\05_decisions\reports\DR_028_analise_anti_vibecoding.md
- c:\saphiro_baas\docs\05_decisions\reports\DR_029_plano_melhoria_toolkit.md

---

## Decisoes tecnicas

| Decisao | Escolha | Justificativa |
|---------|---------|---------------|
| Onde vive o manual | `docs/manual.md` no toolkit repo | Fonte unica de verdade, versionado com o toolkit |
| Formato do manual | Markdown com exemplos reais | Legivel por humanos e IAs |
| Conteudo canonico | 1 lugar por conceito, demais referenciam | Elimina redundancia e tokens gastos |
| Rules consolidadas | 3 user rules em vez de 7 | ~75% menos tokens |
| project-init | Command em commands/ | Substitui project-docs-init |
| Trae | trae-toolkit/ com install + project_rules.md | Segue padrao do windsurf-toolkit |
| Pre-commit | ruff (lint + format) | Enforcement mecanico real |
| CI | GitHub Actions com ruff + pytest | Vibecoding nao passa no merge |
| Rename | ai-coding-toolkit (GitHub redirect) | Reflete escopo multi-IDE |

---

## Tarefas

### T1 -- Criar command /project-init

- **Complexidade:** media
- **Arquivos:** `commands/project-init.md` (NOVO)
- **Depende de:** nenhuma
- **Conflita com:** nenhuma
- **Status:** concluido
- **Criterio de aceite:** Command cria context.md, roadmap.md, overview.md, conventions.md, integrations.md e toda a arvore de pastas numeradas
- **Notas para IA:**

  Criar `commands/project-init.md` baseado no `commands/project-docs-init.md` existente (ler como referencia), mas com as seguintes diferencas:

  1. Criar `docs/00_overview/context.md` com estrutura canonica (Objetivo, Estado, Decisoes, Restricoes, Proximo Passo, Metricas, Referencias, Regras Criticas)
  2. Criar `docs/00_overview/roadmap.md` com fases previstas (mesmo que pendentes)
  3. Usar pastas numeradas: `00_overview/`, `01_architecture/`, `02_business_rules/`, `03_api/`, `04_operations/`, `05_decisions/reports/`, `06_testing/`, `07_changelog/`, `_scratchpad/`, `execution_plans/`
  4. overview.md, conventions.md e integrations.md ficam em `01_architecture/`
  5. Validacao final com 7 itens (context.md? roadmap.md? overview? conventions? pastas numeradas? _scratchpad? execution_plans?)
  6. Proximo passo sugere `/create-execution-plan`
  7. Maximo 300 linhas

  **Restricoes:**
  - NAO duplicar conteudo dos skills (apenas referenciar)
  - NAO incluir project-docs-init antigo no mesmo repo (sera deletado em T3)

---

### T2 -- Criar manual do toolkit (docs/manual.md)

- **Complexidade:** alta
- **Arquivos:** `docs/manual.md` (NOVO)
- **Depende de:** T1 (precisa referenciar /project-init)
- **Conflita com:** nenhuma
- **Status:** concluido
- **Criterio de aceite:** Manual cobre: instalacao, primeiro projeto, fluxo diario, comandos com exemplos, skills/agents automaticos, fluxos completos (feature, bug, refactor), anti-patterns, referencia rapida
- **Notas para IA:**

  Criar `docs/manual.md` com a seguinte estrutura:

  ```
  # Manual do AI Coding Toolkit

  ## 1. O que e (5 linhas)
  ## 2. Instalacao (Cursor, Windsurf, Trae)
  ## 3. Primeiro Projeto (/project-init)
  ## 4. Fluxo Diario (diagrama + 3 comandos essenciais + 4 situacionais)
  ## 5. Comandos Essenciais (com exemplos reais)
  ## 6. O que acontece automaticamente (skills + agents)
  ## 7. Fluxos Completos (receitas)
     - Iniciar projeto novo
     - Implementar feature
     - Corrigir bug
     - Refatorar codigo
     - Reorganizar projeto
     - Fim de sessao
  ## 8. Pre-commit e CI (fundamento + como usar)
  ## 9. Anti-patterns (vibecoding + dumping)
  ## 10. Referencia Rapida (tabela 1 pagina)
  ```

  **Comandos essenciais (uso frequente):**
  - /project-init, /context-boot, /apply-conventions, /update-context, /create-execution-plan, /decision-needed, /checkpoint-and-branch

  **Comandos situacionais (menos frequente):**
  - /architecture-review, /decision-report, /summarize-session, /help-commands

  **Skills automaticas (8):** code-with-logs, create-subagents, error-handling-patterns, testing-patterns, git-workflow, create-documentation, create-execution-plan, frontend-conventions

  **Agents automaticos (8):** code-reviewer, debugger, test-writer, migration-applier, context-audit-agent, context-feature-agent, context-migration-agent, context-refactor-agent

  **Restricoes:**
  - Maximo 400 linhas
  - Exemplos reais (nao genericos)
  - Linguagem para humano (nao para IA)
  - Incluir secao sobre pre-commit hooks com fundamento anti-vibecoding

---

### T3 -- Deletar commands aposentados

- **Complexidade:** baixa
- **Arquivos:** 10 arquivos em `commands/` e `windsurf-toolkit/workflows/`
- **Depende de:** T1, T2
- **Conflita com:** nenhuma
- **Status:** pendente
- **Criterio de aceite:** 10 commands removidos do repo, tanto em commands/ quanto em windsurf-toolkit/workflows/
- **Notas para IA:**

  **Deletar os seguintes arquivos (Cursor):**
  - `commands/governed-task.md`
  - `commands/project-docs-init.md` (se existir, senao ignorar)
  - `commands/context-focus.md`
  - `commands/context-deep.md`
  - `commands/audit-response.md`
  - `commands/commit-decision.md`
  - `commands/optimize-prompt.md`
  - `commands/frontend-dev-boot.md`
  - `commands/frontend-polish.md`
  - `commands/frontend-ux-audit.md`

  **Deletar os equivalentes no Windsurf:**
  - `windsurf-toolkit/workflows/governed-task.md`
  - `windsurf-toolkit/workflows/context-focus.md`
  - `windsurf-toolkit/workflows/context-deep.md`
  - `windsurf-toolkit/workflows/audit-response.md`
  - `windsurf-toolkit/workflows/commit-decision.md`
  - `windsurf-toolkit/workflows/optimize-prompt.md`
  - `windsurf-toolkit/workflows/frontend-dev-boot.md`
  - `windsurf-toolkit/workflows/frontend-polish.md`
  - `windsurf-toolkit/workflows/frontend-ux-audit.md`

  **NAO deletar:** apply-conventions, architecture-review, checkpoint-and-branch, context-boot, create-execution-plan, decision-needed, decision-report, help-commands, summarize-session, update-context, project-init (novo)

---

### T4 -- Consolidar user rules (7 → 3)

- **Complexidade:** media
- **Arquivos:** `rules/ai-conventions-base.md` (reescrever), `rules/cursor-toolkit-enforcement.mdc` (reescrever), `rules/frontend-robusto-sophisticated.mdc` (deletar)
- **Depende de:** nenhuma
- **Conflita com:** nenhuma
- **Status:** concluido
- **Criterio de aceite:** 3 rules no total, ~200 tokens no total (vs ~800 atuais)
- **Notas para IA:**

  **Rule 1: `rules/ai-conventions-compact.md`** (~50 linhas)
  Substituir `ai-conventions-base.md`. Conteudo:
  - Postura da IA (engenheiro senior, plano antes de executar, nao executar mudancas amplas sem autorizacao)
  - Classificacao de tarefas (exploratoria/operacional/governada)
  - Sequential Thinking para tarefas nao triviais
  - Regras de _scratchpad (transitorio, promover quando validado)
  - Regras de commit (criterio de valor)
  - Seguranca (nenhuma key em codigo, .env obrigatorio)
  - SEM duplicar conteudo dos skills — apenas tabela de referencia: "Para logs: ver skill code-with-logs. Para erros: ver skill error-handling-patterns." etc.

  **Rule 2: `rules/skills-auto-apply.md`** (~15 linhas)
  Substituir `cursor-toolkit-enforcement.mdc`. Conteudo:
  - APENAS a tabela de triggers (contexto → skill)
  - Lista dos agents disponiveis (1 linha cada)
  - SEM re-explicar o que cada skill/agent faz

  **Rule 3: `rules/project-specific-template.md`** (~15 linhas)
  Template que o usuario copia para cada projeto. Conteudo:
  - Placeholder para regras especificas do projeto (ex: Supabase MCP, commit+push, idioma)
  - Exemplo preenchido com regras tipicas

  **Deletar:**
  - `rules/frontend-robusto-sophisticated.mdc` (coberto pelo skill frontend-conventions)

---

### T5 -- Marcar 5 skills de infra com disable-model-invocation

- **Complexidade:** baixa
- **Arquivos:** 5 SKILL.md em `skills/` e `windsurf-toolkit/skills/`
- **Depende de:** nenhuma
- **Conflita com:** nenhuma
- **Status:** concluido
- **Criterio de aceite:** 5 skills com `disable-model-invocation: true` no frontmatter
- **Notas para IA:**

  Adicionar `disable-model-invocation: true` ao frontmatter YAML dos seguintes skills:

  **Cursor (`skills/`):**
  - `skills/create-rule/SKILL.md`
  - `skills/create-skill/SKILL.md`
  - `skills/create-subagent/SKILL.md`
  - `skills/migrate-to-skills/SKILL.md`
  - `skills/update-cursor-settings/SKILL.md`

  **Windsurf (`windsurf-toolkit/skills/`):**
  - Mesmos 5 arquivos no equivalente windsurf

  **Exemplo de frontmatter atualizado:**
  ```yaml
  ---
  name: create-rule
  description: ...
  disable-model-invocation: true
  ---
  ```

  **NAO alterar o corpo dos skills.** Apenas adicionar a linha no frontmatter.

---

### T6 -- Atualizar /help-commands com novo inventario

- **Complexidade:** baixa
- **Arquivos:** `commands/help-commands.md`, `windsurf-toolkit/workflows/help-commands.md`
- **Depende de:** T3 (precisa saber quais commands ficaram)
- **Conflita com:** nenhuma
- **Status:** pendente
- **Criterio de aceite:** help-commands lista exatamente os 11 commands ativos, sem mencionar os aposentados
- **Notas para IA:**

  Reescrever `commands/help-commands.md` com:

  **Comandos essenciais (uso frequente):**
  - `/project-init` — Bootstrap de projeto novo (context.md, roadmap.md, estrutura completa)
  - `/context-boot` — Carregar contexto minimo no inicio da sessao
  - `/apply-conventions` — Checklist pre-geracao de codigo
  - `/update-context` — Atualizar context.md com avanco real
  - `/create-execution-plan` — Planejar tarefa multi-etapas
  - `/decision-needed` — Forcar decisao humana em trade-offs
  - `/checkpoint-and-branch` — Airbag antes de mudancas estruturais

  **Comandos situacionais:**
  - `/architecture-review` — Auditoria DRY-RUN do projeto (mensal)
  - `/decision-report` — Relatorio tecnico versionado
  - `/summarize-session` — Resumo de fim de sessao
  - `/help-commands` — Este guia

  Para cada comando: O QUE faz, QUANDO usar, QUANDO o Cursor falha sem ele.

  Copiar versao atualizada para `windsurf-toolkit/workflows/help-commands.md`.

---

### T7 -- Criar trae-toolkit/

- **Complexidade:** media
- **Arquivos:** `trae-toolkit/` (NOVO: README.md, install.ps1, install.sh, project_rules.md)
- **Depende de:** T4 (precisa das rules consolidadas)
- **Conflita com:** nenhuma
- **Status:** pendente
- **Criterio de aceite:** trae-toolkit/ com instalador que copia project_rules.md para .trae/ do projeto alvo
- **Notas para IA:**

  Criar `trae-toolkit/` seguindo padrao de `windsurf-toolkit/`:

  **`trae-toolkit/README.md`** — Instrucoes de uso com Trae IDE

  **`trae-toolkit/project_rules.md`** — Compilado a partir de:
  - `rules/ai-conventions-compact.md` (postura + classificacao)
  - `rules/skills-auto-apply.md` (tabela de triggers)
  - Resumo dos skills mais importantes (1-2 linhas cada, nao copiar inteiro)
  - Tudo em UM arquivo (Trae usa arquivo unico em `.trae/project_rules.md`)

  **`trae-toolkit/install.ps1`** e **`trae-toolkit/install.sh`**:
  - Recebe parametro: path do projeto alvo
  - Cria `.trae/` no projeto se nao existir
  - Copia `project_rules.md` para `.trae/project_rules.md`
  - Opcao --force para sobrescrever

---

### T8 -- Pre-commit hooks + CI (template no toolkit + aplicar no saphiro_baas)

- **Complexidade:** media
- **Arquivos:** `templates/.pre-commit-config.yaml` (NOVO no toolkit), `templates/.github/workflows/ci.yml` (NOVO no toolkit), aplicar em `c:\saphiro_baas\`
- **Depende de:** T2 (precisa estar no manual)
- **Conflita com:** nenhuma
- **Status:** pendente
- **Criterio de aceite:** Templates no toolkit, pre-commit + CI funcionando no saphiro_baas
- **Notas para IA:**

  **No toolkit (`templates/`):**

  Criar `templates/.pre-commit-config.yaml`:
  ```yaml
  repos:
    - repo: https://github.com/astral-sh/ruff-pre-commit
      rev: v0.9.0
      hooks:
        - id: ruff
          args: [--fix]
        - id: ruff-format
  ```

  Criar `templates/.github/workflows/ci.yml`:
  ```yaml
  name: CI
  on: [push, pull_request]
  jobs:
    lint:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v4
        - uses: astral-sh/ruff-action@v3
    test:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v4
        - uses: actions/setup-python@v5
          with:
            python-version: '3.11'
        - run: pip install -r requirements.txt
        - run: pytest -v || echo "No tests found"
  ```

  **No saphiro_baas:**
  - Copiar `.pre-commit-config.yaml` para `c:\saphiro_baas\`
  - Copiar `.github/workflows/ci.yml` para `c:\saphiro_baas\`
  - Executar: `pip install pre-commit && pre-commit install`
  - Commitar e push

---

### T9 -- Atualizar README.md do toolkit (v5.0)

- **Complexidade:** media
- **Arquivos:** `README.md`
- **Depende de:** T1, T2, T3, T4, T7
- **Conflita com:** nenhuma
- **Status:** pendente
- **Criterio de aceite:** README reflete estado v5.0: 11 commands, 8+5 skills, 8 agents, 3 rules, 3 IDEs, link para manual
- **Notas para IA:**

  Reescrever `README.md` com:
  - Nome: AI Coding Toolkit (nao mais cursor-toolkit)
  - Descricao: multi-IDE (Cursor + Windsurf + Trae)
  - Tabela de skills: 8 ativos + 5 infra (marcados)
  - Tabela de commands: 11 (7 essenciais + 4 situacionais)
  - Tabela de agents: 8
  - Tabela de rules: 3
  - Instalacao por IDE (Cursor, Windsurf, Trae)
  - Link para `docs/manual.md` como documentacao principal
  - Estrutura de pastas atualizada
  - Secao "Templates" (pre-commit, CI)

  Atualizar `windsurf-toolkit/README.md` tambem.

---

### T10 -- Renomear repo para ai-coding-toolkit

- **Complexidade:** baixa
- **Arquivos:** GitHub Settings (manual pelo usuario)
- **Depende de:** T9 (README atualizado)
- **Conflita com:** nenhuma
- **Status:** pendente
- **Criterio de aceite:** Repo acessivel em github.com/henriqueneves87/ai-coding-toolkit, redirect ativo
- **Notas para IA:**

  **Este passo requer acao manual do usuario no GitHub:**
  1. Ir em github.com/henriqueneves87/cursor-toolkit → Settings
  2. Renomear para `ai-coding-toolkit`
  3. GitHub cria redirect automaticamente
  4. Localmente: `git remote set-url origin https://github.com/henriqueneves87/ai-coding-toolkit.git`
  5. Atualizar install scripts se mencionam URL do repo

---

### T11 -- Atualizar context.md e roadmap.md do saphiro_baas

- **Complexidade:** baixa
- **Arquivos:** `c:\saphiro_baas\docs\00_overview\context.md`, `c:\saphiro_baas\docs\00_overview\roadmap.md`
- **Depende de:** T1-T9 (todas as mudancas concluidas)
- **Conflita com:** nenhuma
- **Status:** pendente
- **Criterio de aceite:** Decisao 28 no context.md referenciando DR_029. Roadmap com nova secao Toolkit.
- **Notas para IA:**

  **context.md:** Adicionar Decisao 28 — Toolkit v5.0 com resumo compacto e referencia a DR_029.
  **roadmap.md:** Adicionar secao "Toolkit" com estado da migracao v5.0.

---

## Ordem de execucao

```
Bloco A (fundacao — paralelo):
  T1 (project-init) + T4 (consolidar rules) + T5 (skills infra)

Bloco B (manual — sequencial):
  T2 (manual, depende de T1)

Bloco C (limpeza — paralelo):
  T3 (deletar commands) + T6 (help-commands) + T7 (trae-toolkit, depende de T4)

Bloco D (enforcement — paralelo):
  T8 (pre-commit + CI)

Bloco E (finalizacao — sequencial):
  T9 (README) → T10 (rename repo) → T11 (update context)

Sequencia completa:
  [T1 + T4 + T5] → [T2] → [T3 + T6 + T7] → [T8] → [T9 → T10 → T11]
```

---

## Mapa de conflitos de arquivo

| Arquivo | Tarefas que alteram |
|---------|---------------------|
| `commands/help-commands.md` | T6 |
| `rules/ai-conventions-base.md` | T4 |
| `rules/cursor-toolkit-enforcement.mdc` | T4 |
| `README.md` | T9 |

Nenhum conflito real. Tarefas no mesmo bloco paralelo nao tocam os mesmos arquivos.

---

## Notas para IA

1. **Workspace:** C:\Users\User\cursor-toolkit (repo principal)
2. **Workspace secundario:** c:\saphiro_baas (para T8 e T11)
3. **Convencao:** Skills sao conteudo canonico. Rules apenas referenciam skills.
4. **Restricao:** Maximo 300 linhas por command, 400 linhas por manual.
5. **Skills aplicaveis:** `create-documentation` ao gerar manual, `git-workflow` ao commitar.
6. **Windsurf:** Toda mudanca em commands/ deve ser espelhada em windsurf-toolkit/workflows/.
7. **Trae:** Usar `.trae/project_rules.md` (arquivo unico compilado).
8. **Idioma dos artefatos:** Portugues nos exemplos, ingles nos nomes de arquivo.

---

## Metricas de sucesso

- [ ] /project-init cria context.md + roadmap.md + pastas numeradas
- [ ] Manual legivel em <10 minutos por humano novo
- [ ] 11 commands no repo (nao mais, nao menos)
- [ ] 3 rules no repo (nao mais, nao menos)
- [ ] 5 skills de infra com disable-model-invocation: true
- [ ] trae-toolkit/ com install funcional
- [ ] pre-commit hooks funcionando no saphiro_baas
- [ ] CI rodando no saphiro_baas
- [ ] README reflete v5.0
- [ ] Repo renomeado para ai-coding-toolkit
- [ ] context.md atualizado com Decisao 28
