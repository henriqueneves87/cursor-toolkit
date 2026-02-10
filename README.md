# cursor-toolkit

Coleção de **skills**, **commands**, **agents** e **rules** para o [Cursor IDE](https://cursor.sh), projetados para governança de IA, qualidade de código e produtividade.

## O que está incluído

### Skills (12)

| Skill | Descrição |
|-------|-----------|
| `code-with-logs` | Logs narrativos com timestamp `[HH:MM:SS]` obrigatório em todo código executável |
| `create-execution-plan` | Execution plans otimizados para IA executar tarefas multi-etapas (com template) |
| `create-subagents` | Padrão modular de subagentes Python com early return e logs |
| `create-documentation` | Estrutura de documentação organizada com anti-dumping e progressive disclosure |
| `error-handling-patterns` | Padrões de tratamento de erro: early return, erros explícitos, propagação |
| `testing-patterns` | Padrões AAA (Arrange-Act-Assert), edge cases, testes narrativos |
| `git-workflow` | Branching, commit messages, PR descriptions, critério de valor |
| `create-rule` | Meta-skill para criar regras do Cursor (`.cursor/rules/`) |
| `create-skill` | Meta-skill para criar Agent Skills (`.cursor/skills/`) |
| `create-subagent` | Meta-skill para criar subagentes do Cursor (`.cursor/agents/`) |
| `migrate-to-skills` | Converte rules e commands antigos para o formato Skills |
| `update-cursor-settings` | Modifica configurações do Cursor/VSCode (`settings.json`) |

### Commands (16)

| Command | Descrição |
|---------|-----------|
| `apply-conventions` | Checklist obrigatório ANTES de gerar código (valida skills aplicáveis) |
| `create-execution-plan` | Gera execution plan otimizado para IA executar tarefas multi-etapas |
| `context-boot` | Carrega contexto mínimo do projeto (<=500 tokens) |
| `context-focus` | Carrega contexto direcionado para tarefa específica (<=900 tokens) |
| `context-deep` | Leitura cirúrgica de arquivos específicos (<=600 tokens) |
| `architecture-review` | Auditoria completa do projeto em modo DRY-RUN (não modifica nada) |
| `audit-response` | Audita a resposta anterior da IA contra as convenções |
| `checkpoint-and-branch` | Cria checkpoint seguro + branch antes de mudanças estruturais |
| `commit-decision` | Avalia se artefatos devem virar commit (critério de valor) |
| `decision-needed` | Lista opções para decisões técnicas, espera escolha do usuário |
| `decision-report` | Gera relatório técnico versionado para tomada de decisão |
| `governed-task` | Força execução governada de tarefas grandes (Sequential Thinking) |
| `help-commands` | Guia prático de quando e por que usar cada command |
| `optimize-prompt` | Reescreve prompts para máxima clareza (modo HARD STOP) |
| `summarize-session` | Resume sessão de trabalho para continuidade futura |
| `update-context` | Atualiza memória longa do projeto (`context.md`) |

### Agents (8)

| Agent | Descrição |
|-------|-----------|
| `context-audit-agent` | Auditorias com abordagem evidence-first |
| `context-feature-agent` | Implementação de features com spec-first |
| `context-migration-agent` | Migrations com safety-first (backup, rollback) |
| `context-refactor-agent` | Refatoração incremental com validação |
| `code-reviewer` | Revisão de código para qualidade, segurança e manutenibilidade |
| `debugger` | Diagnóstico sistemático: root cause analysis, fix, verificação |
| `test-writer` | Criação de testes abrangentes (unit, integration, edge cases) |
| `migration-applier` | Aplicação de migrations SQL (PostgreSQL/Supabase) |

### Rules (1)

| Rule | Descrição |
|------|-----------|
| `ai-conventions-base` | Template base de convenções para projetos (adaptar ao seu projeto) |

---

## Instalação

### Pré-requisitos

- [Cursor IDE](https://cursor.sh) instalado
- [Git](https://git-scm.com/) instalado

### 1. Clonar o repositório

```bash
git clone https://github.com/henriqueneves87/cursor-toolkit.git
```

Clone em qualquer diretório de sua preferência (ex: `C:\Tools\cursor-toolkit` ou `~/tools/cursor-toolkit`).

### 2. Instalar

**Windows (PowerShell como Admin):**

```powershell
cd cursor-toolkit
.\install.ps1
```

**Linux/Mac:**

```bash
cd cursor-toolkit
chmod +x install.sh
./install.sh
```

### Opções de instalação

| Opção | Descrição |
|-------|-----------|
| (padrão) | Cria symlinks — atualização automática via `git pull` |
| `-Copy` / `--copy` | Copia arquivos — não requer Admin no Windows |
| `-Force` / `--force` | Reinstala com backup do existente |
| `-Uninstall` / `--uninstall` | Remove a instalação |

### O que o instalador faz

Cria links simbólicos (ou copia) para os diretórios globais do Cursor:

```
~/.cursor/skills/   → cursor-toolkit/skills/
~/.cursor/commands/  → cursor-toolkit/commands/
~/.cursor/agents/    → cursor-toolkit/agents/
```

---

## Atualização

**Se usou symlinks (padrão):**

```bash
cd cursor-toolkit
git pull
```

Pronto. Symlinks apontam para o repo, então `git pull` atualiza tudo automaticamente.

**Se usou cópia:**

```bash
cd cursor-toolkit
git pull
./install.sh --copy --force   # Linux/Mac
.\install.ps1 -Copy -Force    # Windows
```

---

## Uso com projetos

### Skills globais + Skills do projeto

O Cursor carrega **ambos** — skills globais (`~/.cursor/skills/`) e do projeto (`.cursor/skills/`). Sem conflito.

**Recomendação:**
- **cursor-toolkit** (global): skills genéricas que valem para qualquer projeto
- **`.cursor/skills/`** (projeto): skills específicas do seu projeto

### Adaptando as rules

O arquivo `rules/ai-conventions-base.md` é um **template**. Para usar no seu projeto:

1. Copie para `.cursor/rules/` do seu projeto
2. Adapte as seções conforme necessário
3. Adicione regras específicas do projeto

---

## Estrutura

```
cursor-toolkit/
├── README.md
├── install.ps1          # Instalador Windows
├── install.sh           # Instalador Linux/Mac
├── skills/
│   ├── code-with-logs/SKILL.md
│   ├── create-execution-plan/
│   │   ├── SKILL.md
│   │   └── template.md
│   ├── create-subagents/SKILL.md
│   ├── create-documentation/SKILL.md
│   ├── error-handling-patterns/SKILL.md
│   ├── testing-patterns/SKILL.md
│   ├── git-workflow/SKILL.md
│   ├── create-rule/SKILL.md
│   ├── create-skill/SKILL.md
│   ├── create-subagent/SKILL.md
│   ├── migrate-to-skills/SKILL.md
│   └── update-cursor-settings/SKILL.md
├── commands/
│   ├── apply-conventions.md
│   ├── context-boot.md
│   ├── context-focus.md
│   ├── context-deep.md
│   ├── create-execution-plan.md
│   ├── architecture-review.md
│   ├── audit-response.md
│   ├── checkpoint-and-branch.md
│   ├── commit-decision.md
│   ├── decision-needed.md
│   ├── decision-report.md
│   ├── governed-task.md
│   ├── help-commands.md
│   ├── optimize-prompt.md
│   ├── summarize-session.md
│   └── update-context.md
├── agents/
│   ├── context-audit-agent.md
│   ├── context-feature-agent.md
│   ├── context-migration-agent.md
│   ├── context-refactor-agent.md
│   ├── code-reviewer.md
│   ├── debugger.md
│   ├── test-writer.md
│   └── migration-applier.md
└── rules/
    └── ai-conventions-base.md
```

---

## Compartilhando com a equipe

1. Cada membro clona o repo e roda o instalador
2. Updates: `git pull` (symlinks) ou `git pull + install` (cópia)
3. Para contribuir: PR no repo com novas skills/commands/agents

---

## Licença

MIT
