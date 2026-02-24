# Prompts de Execucao — Toolkit v5.0 Upgrade

> **Runbook operacional.** Copie, cole, execute, finalize.
> Ultima atualizacao: 2026-02-24

---

## Como funciona

1. Abra a pasta `C:\Users\User\cursor-toolkit` no Cursor IDE
2. Copie o PROMPT do bloco que quer executar
3. Cole numa conversa nova
4. A IA executa as tarefas, commita, mostra resultado
5. Nova conversa para o proximo bloco

---

## PROMPT BLOCO A — Fundacao (T1 + T4 + T5)

```
Ler o execution plan completo em docs/execution_plans/toolkit_v5_upgrade.md

Executar as tarefas T1, T4 e T5 do Bloco A (fundacao).

CONTEXTO:
- Workspace: C:\Users\User\cursor-toolkit
- Repo: github.com/henriqueneves87/cursor-toolkit (branch main)
- Objetivo: Upgrade toolkit v4.4 → v5.0 (anti-vibecoding, anti-dumping)
- Referencia completa: docs/execution_plans/toolkit_v5_upgrade.md

TAREFAS DESTE BLOCO:

T1 — Criar command /project-init
- Arquivo: commands/project-init.md (NOVO)
- Ler commands/project-docs-init.md como referencia do que MELHORAR
- Ler "Notas para IA" da T1 no execution plan para detalhes exatos
- Diferenca principal: cria context.md + roadmap.md + pastas numeradas

T4 — Consolidar rules (7 → 3)
- Reescrever rules/ai-conventions-base.md → rules/ai-conventions-compact.md (~50 linhas)
- Reescrever rules/cursor-toolkit-enforcement.mdc → rules/skills-auto-apply.md (~15 linhas)
- Criar rules/project-specific-template.md (~15 linhas)
- Deletar rules/frontend-robusto-sophisticated.mdc
- Ler "Notas para IA" da T4 no execution plan para conteudo exato

T5 — Marcar 5 skills de infra com disable-model-invocation: true
- Adicionar disable-model-invocation: true no frontmatter de:
  skills/create-rule/SKILL.md, skills/create-skill/SKILL.md,
  skills/create-subagent/SKILL.md, skills/migrate-to-skills/SKILL.md,
  skills/update-cursor-settings/SKILL.md
- Mesmos 5 em windsurf-toolkit/skills/
- NAO alterar corpo dos skills

REGRAS:
- Ler "Notas para IA" de cada tarefa ANTES de executar
- Commitar cada tarefa separadamente (commits atomicos)
- Push ao final
- Marcar status "concluido" no execution plan apos cada tarefa
- Responder em portugues (BR)
```

---

## PROMPT BLOCO B — Manual (T2)

```
Ler o execution plan em docs/execution_plans/toolkit_v5_upgrade.md

Executar a tarefa T2 do Bloco B.

CONTEXTO:
- Workspace: C:\Users\User\cursor-toolkit
- Bloco A ja foi executado (T1 project-init, T4 rules consolidadas, T5 skills marcadas)
- Referencia: docs/execution_plans/toolkit_v5_upgrade.md

TAREFA:

T2 — Criar manual do toolkit (docs/manual.md)
- Ler "Notas para IA" da T2 no execution plan para estrutura e conteudo
- O manual e para HUMANOS, nao para IAs
- Maximo 400 linhas
- Incluir: instalacao (Cursor/Windsurf/Trae), primeiro projeto (/project-init),
  fluxo diario, 11 comandos com exemplos reais, skills/agents automaticos,
  fluxos completos (feature, bug, refactor), pre-commit + CI com fundamento,
  anti-patterns, referencia rapida
- Ler commands/project-init.md (criado em T1) para referenciar no manual
- Ler rules/ (consolidados em T4) para verificar nomes corretos

REGRAS:
- Commitar e push ao final
- Marcar status "concluido" no execution plan
- Responder em portugues (BR)
```

---

## PROMPT BLOCO C — Limpeza (T3 + T6 + T7)

```
Ler o execution plan em docs/execution_plans/toolkit_v5_upgrade.md

Executar as tarefas T3, T6 e T7 do Bloco C (limpeza).

CONTEXTO:
- Workspace: C:\Users\User\cursor-toolkit
- Blocos A e B ja executados
- Referencia: docs/execution_plans/toolkit_v5_upgrade.md

TAREFAS:

T3 — Deletar commands aposentados
- Deletar 10 commands em commands/ (lista na "Notas para IA" da T3)
- Deletar equivalentes em windsurf-toolkit/workflows/
- NAO deletar: apply-conventions, architecture-review, checkpoint-and-branch,
  context-boot, create-execution-plan, decision-needed, decision-report,
  help-commands, project-init, summarize-session, update-context

T6 — Atualizar help-commands
- Reescrever commands/help-commands.md com 11 commands ativos
- Copiar para windsurf-toolkit/workflows/help-commands.md
- Ler "Notas para IA" da T6 para lista exata

T7 — Criar trae-toolkit/
- Criar trae-toolkit/README.md, install.ps1, install.sh, project_rules.md
- Seguir padrao de windsurf-toolkit/
- Ler "Notas para IA" da T7 para detalhes

REGRAS:
- Commits atomicos por tarefa
- Push ao final
- Marcar status "concluido" no execution plan
- Responder em portugues (BR)
```

---

## PROMPT BLOCO D — Enforcement (T8)

```
Ler o execution plan em docs/execution_plans/toolkit_v5_upgrade.md

Executar a tarefa T8 do Bloco D.

CONTEXTO:
- Workspace PRINCIPAL: C:\Users\User\cursor-toolkit (para templates)
- Workspace SECUNDARIO: c:\saphiro_baas (para aplicar pre-commit + CI)
- Blocos A, B, C ja executados
- Referencia: docs/execution_plans/toolkit_v5_upgrade.md

TAREFA:

T8 — Pre-commit hooks + CI
1. No cursor-toolkit: criar templates/.pre-commit-config.yaml e templates/.github/workflows/ci.yml
2. No saphiro_baas: copiar os templates, instalar pre-commit, commitar e push
- Ler "Notas para IA" da T8 para conteudo exato dos YAMLs

REGRAS:
- Commitar templates no cursor-toolkit primeiro
- Depois commitar .pre-commit-config.yaml e CI no saphiro_baas
- Push em ambos
- Marcar status "concluido" no execution plan
- Responder em portugues (BR)
```

---

## PROMPT BLOCO E — Finalizacao (T9 + T10 + T11)

```
Ler o execution plan em docs/execution_plans/toolkit_v5_upgrade.md

Executar as tarefas T9 e T11 do Bloco E. T10 sera feita manualmente pelo usuario.

CONTEXTO:
- Workspace: C:\Users\User\cursor-toolkit
- Blocos A, B, C, D ja executados
- Referencia: docs/execution_plans/toolkit_v5_upgrade.md

TAREFAS:

T9 — Atualizar README.md
- Reescrever README.md para v5.0 (ai-coding-toolkit, multi-IDE, 11 commands, 8+5 skills, 3 rules)
- Atualizar windsurf-toolkit/README.md tambem
- Ler "Notas para IA" da T9 para conteudo

T10 — Rename repo (INSTRUCOES PARA O USUARIO)
- Apresentar instrucoes passo a passo para o usuario renomear no GitHub
- NAO executar automaticamente

T11 — Atualizar context.md do saphiro_baas
- Workspace secundario: c:\saphiro_baas
- Adicionar nota no context.md: "Toolkit v5.0 concluido"
- Atualizar roadmap.md com secao Toolkit

REGRAS:
- Commitar README no cursor-toolkit
- Commitar context update no saphiro_baas
- Push em ambos
- Marcar tudo como "concluido" no execution plan
- Responder em portugues (BR)
```

---

## Tabela de tarefas

| # | Tarefa | Bloco | Depende de | Status |
|---|--------|-------|------------|--------|
| T1 | Criar /project-init | A | — | pendente |
| T4 | Consolidar rules (7→3) | A | — | pendente |
| T5 | Skills infra disable-model-invocation | A | — | pendente |
| T2 | Criar manual | B | T1 | pendente |
| T3 | Deletar commands aposentados | C | T1, T2 | pendente |
| T6 | Atualizar help-commands | C | T3 | pendente |
| T7 | Criar trae-toolkit/ | C | T4 | pendente |
| T8 | Pre-commit + CI | D | T2 | pendente |
| T9 | Atualizar README v5.0 | E | T1-T7 | pendente |
| T10 | Rename repo (manual) | E | T9 | pendente |
| T11 | Update context saphiro_baas | E | T9 | pendente |

## Ordem de execucao

```
Bloco A [T1 + T4 + T5] → Bloco B [T2] → Bloco C [T3 + T6 + T7] → Bloco D [T8] → Bloco E [T9 → T10 → T11]
```

## Estimativa

- Bloco A: 1 conversa (Sonnet 4.6)
- Bloco B: 1 conversa (Opus recomendado)
- Bloco C: 1 conversa (Sonnet 4.6)
- Bloco D: 1 conversa (Sonnet 4.6)
- Bloco E: 1 conversa (Sonnet 4.6)

**Total: 5 conversas**
