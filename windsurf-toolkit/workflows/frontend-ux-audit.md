# frontend-ux-audit — Auditoria rápida de UX/UI (robusto)

Objetivo: avaliar se uma tela/fluxo está com “cara de produto” e aderente ao design system.

## Como usar
1. Identificar o alvo (app + rota + componentes).
2. Antes de sugerir mudanças, consultar o provedor de padrões do time (ex.: Magic-MCP) quando disponível.
3. Rodar checklist e listar gaps priorizados (P0/P1/P2).

## Checklist (P0 = obrigatório)

### Consistência / tokens (P0)
- [ ] Sem hex hardcoded em componentes críticos (usar tokens/tema).
- [ ] Tipografia/spacing coerentes com o design system do projeto.

### Feedback (P0)
- [ ] Ações CRUD: toast (sucesso/erro).
- [ ] Listas/tabelas: skeleton no loading + empty state quando vazio.
- [ ] Erros: mensagem humana + ação de retry quando possível.

### Estados (P0)
- [ ] Botões/inputs com `hover`, `focus-visible`, `disabled`, `loading`.

### Ícones (P0)
- [ ] Sem emojis como ícones de estado; usar SVG (ex.: lucide-react).

### Acessibilidade (P1)
- [ ] Focus visível e navegável por teclado nos fluxos principais.
- [ ] Contraste mínimo aceitável.

## Saída esperada
- **Resumo (3–7 linhas)**
- **Gaps P0/P1/P2** (bullets)
- **Plano incremental** (2–6 tarefas com arquivos/rotas envolvidas)

