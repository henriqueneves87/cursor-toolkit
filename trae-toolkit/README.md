# trae-toolkit

Suporte ao **Trae IDE** para o [AI Coding Toolkit](https://github.com/henriqueneves87/cursor-toolkit).

Instala `project_rules.md` no diretorio `.trae/` do projeto alvo, carregando todas as convencoes, skills e postura de IA do toolkit.

---

## O que e instalado

Um unico arquivo: `.trae/project_rules.md`

Contem (compilado):
- Postura e classificacao de tarefas da IA
- Tabela de auto-aplicacao de skills
- Resumo das 8 skills principais
- Lista de agents disponiveis
- Referencia rapida de commands

---

## Instalacao

### Pre-requisito

- [Trae IDE](https://www.trae.ai/) instalado
- Git instalado

### 1. Clonar o repositorio

```bash
git clone https://github.com/henriqueneves87/cursor-toolkit.git
```

### 2. Instalar no projeto

**Windows (PowerShell):**

```powershell
cd cursor-toolkit\trae-toolkit
.\install.ps1 -ProjectPath "C:\caminho\do\seu\projeto"
```

**Linux/Mac:**

```bash
cd cursor-toolkit/trae-toolkit
chmod +x install.sh
./install.sh /caminho/do/seu/projeto
```

### Opcoes

| Opcao | Descricao |
|-------|-----------|
| (padrao) | Copia `project_rules.md` para `.trae/` do projeto |
| `-Force` / `--force` | Sobrescreve arquivo existente com backup automatico |

---

## Atualizacao

```bash
cd cursor-toolkit
git pull
cd trae-toolkit

# Windows
.\install.ps1 -ProjectPath "C:\seu\projeto" -Force

# Linux/Mac
./install.sh /seu/projeto --force
```

---

## Estrutura do trae-toolkit

```
trae-toolkit/
├── README.md          (este arquivo)
├── install.ps1        (instalador Windows/PowerShell)
├── install.sh         (instalador Linux/Mac)
└── project_rules.md   (regras compiladas para .trae/)
```

---

## Como o Trae usa o project_rules.md

O Trae IDE carrega automaticamente `.trae/project_rules.md` como contexto de regras para todas as conversas do projeto.

Diferente do Cursor (rules por arquivo) e Windsurf (global_rules + workflows), o Trae usa um **unico arquivo compilado** por projeto.

---

## Diferencas entre IDEs

| IDE | Arquivo de rules | Escopo |
|-----|-----------------|--------|
| Cursor | `~/.cursor/rules/*.md` | Global |
| Windsurf | `~/.codeium/windsurf/memories/global_rules.md` | Global |
| Trae | `.trae/project_rules.md` | Por projeto |

---

## Ver tambem

- `docs/manual.md` — Manual completo do toolkit
- `windsurf-toolkit/` — Suporte ao Windsurf IDE
- `commands/` — Commands para uso no Cursor

---

## Licenca

MIT
