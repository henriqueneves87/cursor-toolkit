---
name: start-session
description: Inicializa sessão de trabalho. Unifica context-boot + apply-conventions. Use no início de toda sessão.
---

# start-session — Inicialização de Sessão

Versao: 1.1
Tipo: Command
Uso: Manual (início de toda sessão de trabalho)

---

## Objetivo

Comando único que prepara a IA para trabalhar. Substitui `/context-boot` + `/apply-conventions` por uma única interação.

---

## Comportamento OBRIGATÓRIO

Ao receber `/start-session`, executar em sequência:

### 1. Context Boot

- Verificar AGENTS.md → se existe, não repetir stack/convenções
- Ler contexto dinâmico (context.md ou context_core.md)
- Fallback: listar estrutura de diretórios, pontos de entrada, configs
- Gerar Context Pack BOOT (<=500 tokens):
  - Projeto (<=6 linhas), Arquitetura (<=10 linhas), Regras Críticas, Invariantes, Escopo Atual, Riscos, Próximos Arquivos (máx 5)

### 2. Confirmar Convenções

- Skills auto-apply ativas (conforme `skills-auto-apply` rule)
- Checklist pré-geração pronto para uso

### 3. Saída

Uma única resposta com:

```
# Context Pack BOOT — [Nome do Projeto]

[... context pack ...]

---

Boot: ~27k tokens (rules + context). Espaço útil: ~170k tokens.
Convenções ativas. Qual a tarefa?
```

---

## Regras

- Uma única resposta (não dividir em múltiplas mensagens)
- Ser conciso — o objetivo é economizar contexto
- NÃO recomendar modelo no boot — esperar a tarefa ser descrita
- Se context pack ficar grande, priorizar síntese sobre volume
