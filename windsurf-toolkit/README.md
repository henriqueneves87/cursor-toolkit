# windsurf-toolkit

Adaptação do **AI Coding Toolkit** para o [Windsurf IDE](https://codeium.com/windsurf). Mesmas skills, agents e rules — com workflows no lugar de commands e instalação global via `~/.codeium/windsurf/`.

> **Documentação completa:** [`../docs/manual.md`](../docs/manual.md)

---

## O que está incluído

### Skills (8 ativos + 5 infra)

| Skill | Tipo | Ativa quando |
|-------|------|-------------|
| `code-with-logs` | Ativo | Script Python executável |
| `create-subagents` | Ativo | Script >200 linhas |
| `error-handling-patterns` | Ativo | Código com try/except ou I/O |
| `testing-patterns` | Ativo | Criação de testes |
| `git-workflow` | Ativo | Commits, branches, PRs |
| `create-documentation` | Ativo | Criação/atualização de docs |
| `create-execution-plan` | Ativo | Planejamento multi-etapas |
| `frontend-conventions` | Ativo | UI/UX em React/Next.js |
| `create-rule` | Infra ⚙️ | Criação de rules |
| `create-skill` | Infra ⚙️ | Criação de Agent Skills |
| `create-subagent` | Infra ⚙️ | Criação de subagentes |
| `migrate-to-skills` | Infra ⚙️ | Migração para formato Skills |
| `update-cursor-settings` | Infra ⚙️ | Modificar settings.json |

### Workflows (11)

**Essenciais:**

| Workflow | O que faz |
|----------|-----------|
| `/project-init` | Bootstrap de projeto novo: context.md + roadmap.md + estrutura completa |
| `/context-boot` | Carrega contexto mínimo no início da sessão |
| `/apply-conventions` | Checklist pré-geração de código |
| `/update-context` | Atualiza context.md com avanço real |
| `/create-execution-plan` | Plano multi-etapas com dependências |
| `/decision-needed` | Força decisão humana em trade-offs |
| `/checkpoint-and-branch` | Backup antes de mudança arriscada |

**Situacionais:**

| Workflow | O que faz |
|----------|-----------|
| `/architecture-review` | Auditoria DRY-RUN do projeto |
| `/decision-report` | Relatório técnico versionado |
| `/summarize-session` | Resume sessão + próximos passos |
| `/help-commands` | Lista todos os workflows com exemplos |

### Rules (3)

| Rule | Escopo |
|------|--------|
| `ai-conventions-compact.md` | Postura, tarefas, commits, segurança |
| `skills-auto-apply.md` | Tabela de triggers + lista de agents |
| `project-specific-template.md` | Template para regras do projeto |

---

## Instalação

### Pré-requisitos

- [Windsurf IDE](https://codeium.com/windsurf) instalado
- [Git](https://git-scm.com/) instalado

### 1. Clonar o repositório

```bash
git clone https://github.com/henriqueneves87/ai-coding-toolkit.git
cd ai-coding-toolkit/windsurf-toolkit
```

### 2. Instalar

**Windows (PowerShell):**

```powershell
.\install.ps1
```

**Linux/Mac:**

```bash
chmod +x install.sh && ./install.sh
```

### O que o instalador faz

```
~/.codeium/windsurf/skills/          → 13 skills (globais)
~/.codeium/windsurf/global_workflows/ → 11 workflows (globais)
~/.codeium/windsurf/memories/        → global_rules.md (rules compiladas)
```

Tudo instalado globalmente — disponível em todos os projetos.

### Opções

| Opção | Descrição |
|-------|-----------|
| (padrão) | Cria symlinks — atualização via `git pull` |
| `-Copy` / `--copy` | Copia arquivos |
| `-Force` / `--force` | Reinstala com backup |
| `-Uninstall` / `--uninstall` | Remove instalação |

---

## Atualização

**Symlinks:**

```bash
cd ai-coding-toolkit
git pull
```

**Cópia:**

```bash
git pull
cd windsurf-toolkit
.\install.ps1 -Copy -Force    # Windows
./install.sh --copy --force    # Linux/Mac
```

---

## Diferenças em relação ao Cursor

| Conceito | Cursor | Windsurf |
|----------|--------|----------|
| Commands | `.cursor/commands/` | `~/.codeium/windsurf/global_workflows/` |
| Skills | `~/.cursor/skills/` | `~/.codeium/windsurf/skills/` |
| Rules | User Settings | `~/.codeium/windsurf/memories/global_rules.md` |
| Agents | Cursor Agent tab | Cascade (integrado) |

---

## Estrutura

```
windsurf-toolkit/
├── README.md
├── install.ps1          # Instalador Windows
├── install.sh           # Instalador Linux/Mac
├── skills/              # 8 ativos + 5 infra
├── workflows/           # 11 workflows
└── rules/               # 3 rules
    ├── ai-conventions-compact.md
    ├── skills-auto-apply.md
    └── project-specific-template.md
```

---

## Licença

MIT
