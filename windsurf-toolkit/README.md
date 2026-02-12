# windsurf-toolkit

Coleção de **skills**, **commands**, **agents** e **rules** para o [Windsurf IDE](https://codeium.com/windsurf), projetados para governança de IA, qualidade de código e produtividade.

> **Adaptado do cursor-toolkit** — Sistema completo de convenções e ferramentas para desenvolvimento com IA.

## O que está incluído

### Skills (13)

| Skill | Descrição |
|-------|-----------|
| `code-with-logs` | Logs narrativos com timestamp `[HH:MM:SS]` obrigatório em todo código executável |
| `create-execution-plan` | Execution plans otimizados para IA executar tarefas multi-etapas (com template) |
| `create-subagents` | Padrão modular de subagentes Python com early return e logs |
| `create-documentation` | Estrutura de documentação organizada com anti-dumping e progressive disclosure |
| `error-handling-patterns` | Padrões de tratamento de erro: early return, erros explícitos, propagação |
| `testing-patterns` | Padrões AAA (Arrange-Act-Assert), edge cases, testes narrativos |
| `git-workflow` | Branching, commit messages, PR descriptions, critério de valor |
| `create-rule` | Meta-skill para criar regras do Windsurf (`.windsurf/rules/`) |
| `create-skill` | Meta-skill para criar Agent Skills (`.windsurf/skills/`) |
| `migrate-to-skills` | Converte rules e commands antigos para o formato Skills |
| `update-cursor-settings` | Modifica configurações do Windsurf/VSCode (`settings.json`) |
| `frontend-conventions` | Convenções para desenvolvimento frontend robusto e sofisticado |

### Workflows (19)

| Workflow | Descrição |
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
| `help-commands` | Guia prático de quando e por que usar cada workflow |
| `optimize-prompt` | Reescreve prompts para máxima clareza (modo HARD STOP) |
| `summarize-session` | Resume sessão de trabalho para continuidade futura |
| `update-context` | Atualiza memória longa do projeto (`context.md`) |
| `frontend-dev-boot` | Inicialização rápida de ambiente de desenvolvimento frontend |
| `frontend-polish` | Refinamento e polimento de interfaces frontend |
| `frontend-ux-audit` | Auditoria de UX e acessibilidade em aplicações frontend |

### Rules (3)

| Rule | Descrição |
|------|-----------|
| `ai-conventions-base.md` | Template base de convenções para projetos (adaptar ao seu projeto) |
| `cursor-toolkit-enforcement.mdc` | Regras de enforcement do toolkit |
| `frontend-robusto-sophisticated.mdc` | Convenções para frontend robusto e sofisticado |

---

## Instalação

### Pré-requisitos

- [Windsurf IDE](https://codeium.com/windsurf) instalado
- [Git](https://git-scm.com/) instalado

### 1. Clonar o repositório

```bash
git clone https://github.com/henriqueneves87/cursor-toolkit.git
cd cursor-toolkit/windsurf-toolkit
```

### 2. Instalar

**Windows (PowerShell como Admin):**

```powershell
.\install.ps1
```

**Linux/Mac:**

```bash
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

**Instalação Global (automática):**

```
~/.codeium/windsurf/skills/         → 13 skills (instalados globalmente)
~/.codeium/windsurf/global_workflows/ → 19 workflows (instalados globalmente)
~/.codeium/windsurf/memories/       → global_rules.md (rules globais)
```

✅ **TUDO INSTALADO GLOBALMENTE!** Skills, workflows e rules ficam disponíveis em todos os projetos.

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
cd windsurf-toolkit
./install.sh --copy --force   # Linux/Mac
.\install.ps1 -Copy -Force    # Windows
```

---

## Uso com projetos

### Skills (globais)

✅ **Instalados automaticamente** em `~/.codeium/windsurf/skills/`

O Windsurf carrega skills globais + skills do projeto (`.windsurf/skills/`) sem conflito.

**Recomendação:**
- **windsurf-toolkit** (global): skills genéricas para qualquer projeto
- **`.windsurf/skills/`** (projeto): skills específicas do seu projeto

### Global Rules

✅ **Instaladas automaticamente** em `~/.codeium/windsurf/memories/global_rules.md`

Aplicadas em todas as conversas do Windsurf.

### Workflows (por projeto)

⚠️ **Instalação MANUAL por projeto**

Workflows no Windsurf são por projeto, não globais. Para cada projeto:

**Windows:**
```powershell
.\install-workfglobais\caminho\do\projeto
```
✅dsautmaticamne em `~/.c`deium/windsu`f/global_worbash/`

oklwsagaambéms!Disponíveis em qulque.
./install-workflows.sh /caminho/do/projeto
``Use  Cacade com

/aome*do-*
```bash
cp -r windsurf-toolkit/workflows seu-projeto/.windsurf/
``Eemplos
- ecoosextvboqt` - Carregau contextoodínomo kf ow` no 
-  /rplyconvento`  Apca checist de cnvençõe
-`/create-exctionlan` - Gera excui  lan Atdmizada
- esfroptíndfpclish` a Adici nad toast, soepetrn,eemptytts

---

## Estrutura

```
windsurf-toolkit/
├── README.md (documentação específica)
├── install.ps1 (instalador Windows)
├── install.sh (instalador Linux/Mac)
├── skills/ (13 skills)
├── workflows/ (19 workflows)
└── rules/ (3 rules)
│   ├── git-workflow/SKILL.md
│   ├── create-rule/SKILL.md
│   ├── create-skill/SKILL.md
│   ├── create-subagent/SKILL.md
│   ├── migrate-to-skills/SKILL.md
│   ├── update-cursor-settings/SKILL.md
│   └── frontend-conventions/SKILL.md
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
│   ├── update-context.md
│   ├── frontend-dev-boot.md
│   ├── frontend-polish.md
│   └── frontend-ux-audit.md
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
    ├── ai-conventions-base.md
    ├── cursor-toolkit-enforcement.mdc
    └── frontend-robusto-sophisticated.mdc
```

---

## Diferenças entre Cursor e Windsurf

O **windsurf-toolkit** é uma adaptação do **cursor-toolkit** com as seguintes mudanças:

**Estrutura de diretórios:**
- Skills globais: `~/.codeium/windsurf/skills/` (Windsurf) vs `~/.cursor/skills/` (Cursor)
- Workflows: `~/.windsurf/workflows/` (Windsurf) vs `~/.cursor/commands/` (Cursor)
- Rules: `~/.windsurf/rules/` (Windsurf) vs `~/.cursor/rules/` (Cursor)

**Conceitos:**
- Windsurf usa **Workflows** (invocados com `/nome`) ao invés de **Commands**
- Windsurf não tem conceito de **Agents** - funcionalidade integrada no Cascade
- Skills seguem o mesmo padrão [agentskills.io](https://agentskills.io) em ambos

---

## Compartilhando com a equipe

1. Cada membro clona o repo e roda o instalador
2. Updates: `git pull` (symlinks) ou `git pull + install` (cópia)
3. Para contribuir: PR no repo principal com novas skills/commands/agents

---

## Licença

MIT
