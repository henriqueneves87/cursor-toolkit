# frontend-polish — Aplicar polish UX/UI de forma guiada

Objetivo: aplicar incrementalmente **toast**, **skeleton**, **empty states**, **tokens** e **estados** em telas/fluxos para dar "cara de produto", seguindo o design system.

> Antes de aplicar: consultar Magic-MCP (ou equivalente) para padrões/componentes existentes. Não inventar — reutilizar.

## Como usar

1. O usuário indica o **alvo** (app + rota + componente(s)).
2. A IA aplica **um tipo de polish por vez**, em ordem priorizada.
3. Após cada bloco: validar com `npm run build` no app afetado.

## Ordem de aplicação (priorizada)

### 1. Tokens (remover hardcode)
- [ ] Substituir hex hardcoded (`#00537F`, `#e5e7eb`, etc.) por tokens semânticos.
- [ ] Usar classes Tailwind ou CSS vars: `primary`, `surface`, `border`, `text-muted`, `danger`, `success`.
- [ ] Referência: `globals.css`, `tailwind.config`, design system do projeto.

### 2. Estados (botões/inputs)
- [ ] Botões: `hover`, `focus-visible`, `disabled`, `loading`.
- [ ] Inputs: `hover`, `focus-visible`, `disabled`, `error` (borda + mensagem).
- [ ] Evitar animação gratuita; transições leves (150–200ms).

### 3. Feedback — Toast
- [ ] Ações CRUD (criar/editar/deletar): toast de sucesso ou erro ao final.
- [ ] Usar biblioteca do projeto (sonner, react-hot-toast) ou componente compartilhado.

### 4. Feedback — Skeleton
- [ ] Listas/tabelas: exibir skeleton enquanto `loading === true`.
- [ ] Não mostrar lista vazia durante loading; alternar skeleton ↔ conteúdo/empty.

### 5. Feedback — Empty state
- [ ] Lista/tabela vazia: ícone (SVG, lucide-react) + texto + CTA quando aplicável.
- [ ] Proibido emojis como ícones; usar `Inbox`, `FileX`, `Package` ou similar.

### 6. Ícones de estado
- [ ] Erro/sucesso/alerta/loading: SVG (lucide-react), nunca emojis.

## Saída esperada por bloco

- Alterações incrementais e focadas.
- Arquivos modificados listados.
- Sugestão de próximo bloco ou confirmação de conclusão.

## Validação final

- `npm run build` sem erro.
- Conferir hover/focus em navegador (não apenas em modo escuro se aplicável).
