---
name: create-documentation
description: Cria documentação técnica seguindo estrutura organizada com anti-dumping e progressive disclosure. Use quando criar, atualizar ou mover qualquer documento em docs/.
---

# Create Documentation v2.0 (Generic)

## APLICAÇÃO AUTOMÁTICA

**Aplicar automaticamente quando detectar:**

- Criação de novo arquivo `.md` em `docs/`
- Movimentação de arquivo de `_scratchpad/` para `docs/`
- Atualização de documentação existente
- Criação de relatório de decisão

## Estrutura Recomendada de Documentação

```
docs/
├── 00_overview/          # Visão geral, contexto, roadmap
├── 01_architecture/      # Arquitetura, fluxos, componentes
├── 02_business_rules/    # Regras de negócio, cálculos
├── 03_api/               # API reference, contratos
├── 04_operations/        # Logging, debug, runbooks
├── 05_decisions/         # Decisões técnicas, relatórios
│   └── reports/
├── 06_testing/           # Estratégia de testes, cenários
├── 07_changelog/         # Changelog
└── _scratchpad/          # Material transitório
```

### Princípios

- **Uma pasta = uma responsabilidade**
- **Conteúdo duplicado é erro**
- **Anti-dumping:** síntese + referência, nunca dump completo

## Regra de Documento Canônico

Para cada assunto, deve existir **apenas um documento canônico**.
Proibido manter dois documentos "competindo" pelo mesmo assunto.

## Nomeação

- Arquivos em `snake_case`
- Nomes curtos e descritivos
- Evitar nomes genéricos (`notes.md`, `temp.md`, `doc.md`)

## Documentação Transitória (_scratchpad)

Documentos exploratórios devem ficar em `docs/_scratchpad/` com cabeçalho:

```markdown
STATUS: TRANSITÓRIO
DATA: YYYY-MM-DD
CONTEXTO: investigação | teste | hipótese | validação
```

**Proibido manter conhecimento crítico apenas no _scratchpad.**

## Promoção de _scratchpad para docs/

Promover quando o documento:
1. Define lógica oficial do sistema
2. Descreve arquitetura validada
3. Registra decisão técnica relevante
4. Serve como referência futura
5. Foi usado para validar produção

**Processo:**
1. Mover arquivo para pasta correta em `docs/`
2. Remover cabeçalho `STATUS: TRANSITÓRIO`
3. Atualizar documentos oficiais relacionados
4. Registrar promoção no changelog/decisions

## Links Entre Documentos

Sempre que mencionar regra, cálculo, decisão ou fluxo oficial, incluir link para o documento canônico correspondente. Isso elimina conhecimento "órfão".

## Proibições

- Criar documento sem definir local correto
- Criar documento duplicado
- Manter conhecimento crítico apenas em _scratchpad
- Usar nomes genéricos
- Criar docs sem links para documentos canônicos relacionados

## Regra Final

Documentação correta é blindagem.
Documentação duplicada é confusão.
**Nada importante fica solto.**
