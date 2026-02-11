---
name: frontend-conventions
description: Enforces robust frontend conventions for React/Next.js - semantic tokens, proper feedback (toast/skeleton/empty), SVG icons, a11y minimum, incremental changes
---

# Frontend Conventions (robusto/sophisticated)

## Quando aplicar
Aplicar sempre que o trabalho envolver UI/UX (React/Next.js) em arquivos `.ts`, `.tsx`, `.css`, `.mdx`.

## Fluxo obrigatório
1. **Consultar o provedor de padrões do time (ex.: Magic-MCP)** quando disponível, antes de propor/alterar UI.
2. Ler o design system do projeto (tokens + specs). Se não existir, criar tokens semânticos mínimos.
3. Não fazer mudanças amplas sem autorização — trabalhar incremental.
4. Garantir “polish” mínimo:
   - toast para ações (CRUD)
   - skeleton para listagens/tabelas
   - empty state para vazio
   - estados: hover/focus-visible/disabled/loading
   - ícones SVG (ex.: lucide-react), sem emojis de estado
   - tokens semânticos (evitar hex hardcoded)
5. Validar:
   - `npm run build` no app afetado
   - limpar `.next` se aparecer 500/404 “fantasma”

## Checklist (rápido)
- [ ] Sem hex hardcoded em componentes
- [ ] Toast/skeleton/empty state aplicados onde necessário
- [ ] Estados completos em inputs/botões
- [ ] Focus visível e mensagens humanas

