---
name: git-workflow
description: Padrões de workflow Git com branching, commit messages, PR descriptions e critério de valor para commits. Use quando trabalhar com Git, criar commits, branches ou PRs.
---

# Git Workflow

## Aplicação Automática

Aplicar quando detectar:
- Criação de commits
- Criação de branches
- Criação de pull requests
- Dúvida sobre versionamento

## Critério de Valor para Commits

**Princípio:** Commit = registrar valor permanente ou decisão relevante.

### COMMITAR:
- Funcionalidades implementadas
- Correções de bugs reais
- Regras de negócio
- Código permanente
- Documentação oficial
- Testes definitivos

### NÃO COMMITAR:
- Código exploratório
- Scripts descartáveis
- Tentativas sem resultado
- Material de `_scratchpad`
- Logs de debug temporários

## Commit Messages

### Formato

```
<tipo>: <descrição curta em imperativo>

[corpo opcional — o que e por que]
```

### Tipos

| Tipo | Uso |
|------|-----|
| `feat` | Nova funcionalidade |
| `fix` | Correção de bug |
| `refactor` | Refatoração sem mudança de comportamento |
| `docs` | Documentação |
| `test` | Testes |
| `chore` | Manutenção, configuração, reorganização |
| `perf` | Melhoria de performance |
| `style` | Formatação, sem mudança de lógica |

### Exemplos

```
feat: add user authentication with JWT
fix: correct tax calculation for international orders
refactor: extract validation logic into separate module
docs: update API reference with new endpoints
test: add edge case tests for payment processing
chore: reorganize project structure
```

### Regras

- Imperativo presente ("add", não "added" ou "adds")
- Primeira letra minúscula após o tipo
- Sem ponto final
- Máximo 72 caracteres na primeira linha
- Corpo opcional: explicar o que e por que, não o como

## Branching

### Padrões de Branch

```
feature/<nome>     — nova funcionalidade
fix/<nome>         — correção de bug
chore/<nome>       — manutenção, reorganização
refactor/<nome>    — refatoração
docs/<nome>        — documentação
test/<nome>        — testes
```

### Fluxo

1. Criar branch a partir de `main`
2. Desenvolver na branch
3. Commits pequenos e atômicos
4. PR quando pronto
5. Review + merge

## Pull Requests

### Formato

```markdown
## Summary
- [bullet 1]
- [bullet 2]
- [bullet 3]

## Changes
- [arquivo 1]: [o que mudou]
- [arquivo 2]: [o que mudou]

## Test plan
- [ ] [teste 1]
- [ ] [teste 2]
```

## Checkpoint antes de Mudanças Estruturais

Antes de reorganizações, refatorações amplas ou deleções:

1. `git status` — verificar worktree limpo
2. `git commit -m "checkpoint: pre-<descrição>"` — salvar estado
3. `git switch -c chore/<descrição>` — criar branch dedicada

## Proibições

- Commits gigantes misturando múltiplas mudanças
- Commits sem mensagem descritiva
- Push --force em main/master sem autorização explícita
- Commitar secrets, chaves, senhas ou .env
- Commitar material exploratório/descartável

## Regra Final

Commit é memória institucional.
Branch é isolamento seguro.
PR é comunicação técnica.
**Git desorganizado é história perdida.**
