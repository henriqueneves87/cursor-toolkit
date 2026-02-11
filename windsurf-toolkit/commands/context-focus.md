# context-focus — Context Engineering FOCUS

Carrega contexto direcionado para tarefa específica.

---

## Uso Simplificado (Modo Assistido)

```
/context-focus
```

**Ou com contexto inicial:**
```
/context-focus investigar timeout no login
/context-focus adicionar coluna email
/context-focus refatorar validação
/context-focus implementar webhook
```

**Não precisa fornecer tudo de uma vez!** A IA vai perguntar o que precisa.

---

## Uso Técnico

```
/context-focus pack="<AUDIT|MIGRATION|REFACTOR|FEATURE>" scope="<módulo>" task="<objetivo>"
```

---

## Objetivo

Preparar contexto específico para tipo de tarefa com custo controlado (<=900 tokens).

---

## Comportamento

### 1. Garantir BOOT executado

Se BOOT não foi executado, executar `/context-boot` primeiro.

### 2. Identificar tipo de tarefa

| Palavras-chave | Pack |
|-----------------|------|
| investigar, auditar, validar, diagnosticar | AUDIT |
| migrar, schema, coluna, tabela, migration | MIGRATION |
| refatorar, extrair, renomear, simplificar | REFACTOR |
| implementar, criar, adicionar, feature | FEATURE |

### 3. Gerar Context Pack FOCUS

**Formato obrigatório:**

```markdown
# Context Pack FOCUS — [Tipo] — [Escopo]

**Data:** YYYY-MM-DD HH:MM:SS
**Pack:** [AUDIT|MIGRATION|REFACTOR|FEATURE]
**Scope:** [escopo]
**Task:** [tarefa]

## Objetivo
[objetivo específico da tarefa]

## Inputs Validados
- [input 1] — Validado
- [input 2] — Validado

## Invariantes (do Pack)
- [invariante 1]
- [invariante 2]

## Riscos Identificados
- [risco 1]
- [risco 2]

## Contexto Relevante
[contexto específico, máximo 20 linhas]

## Checklist Operacional
- [ ] [item 1]
- [ ] [item 2]

## Próximos Passos
- [ ] [próximo passo 1]
- [ ] [próximo passo 2]
```

---

## Token Budget

**Máximo:** <=900 tokens

---

## Saída Final

> "Context Pack FOCUS pronto. Posso seguir para implementação ou falta algo?"

---

## Regras

- Sempre usar Context Pack apropriado do tipo de tarefa
- Validar inputs mínimos antes de prosseguir
- Não fazer dump de conteúdo completo
- Máximo 1 pedido adicional de informação

---

## Integração

- `context-boot` — garante BOOT executado primeiro
- `context-deep` — pode usar DEEP para leitura específica durante FOCUS
