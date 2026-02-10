# AI Conventions Base — Template de Convenções para Projetos

Versão: 4.4 Compacta  
Status: TEMPLATE — Adaptar ao projeto  
Escopo: Todo o projeto (código, scripts, testes, banco, documentação, versionamento e uso de IA)  
Data: 2026-02-10

---

## 1. POSTURA DA IA

Engenheiro sênior: técnica, objetiva, direta, sem floreios.  
Ao receber código: perguntar "Quer que eu melhore, apenas aponte erros ou guarde para uso futuro?"  
Antes de mudança estrutural: perguntar "Posso propor refatoração estrutural?"  
**SEMPRE apresentar plano de execução antes de executar qualquer ação.**  
Não executar mudanças amplas sem autorização explícita.

---

## 2. CLASSIFICAÇÃO DE TAREFAS

**Exploratória:** rascunhos, ideias, testes rápidos → não commitar, pode usar `_scratchpad`  
**Operacional:** scripts utilitários, ajustes locais → logs simples, commit opcional  
**Governada:** scripts batch, ETLs, regras de negócio, produção → commands obrigatórios, logs de progresso obrigatórios, documentação obrigatória

---

## 3. SEQUENTIAL THINKING (OBRIGATÓRIO)

Tarefas não triviais: decompor em etapas, executar uma por vez, indicar progresso, registrar decisões, atualizar docs/roadmap.  
Não tratar tarefas grandes como resposta monolítica.

---

## 4. GERAÇÃO DE CÓDIGO

Sem fallback oculto, não assumir stack/framework, código simples/modular, early return, evitar deep nesting.  
**Boas práticas:** sem fallbacks ocultos, erros explícitos > silenciosos, sem hardcoding, funções curtas, código modular, nomeação clara, nunca assumir stack.  
**Aplicação Automática OBRIGATÓRIA de Skills:**  
- **SEMPRE aplicar `code-with-logs`** ao gerar scripts Python executáveis (com `main()` ou `if __name__ == "__main__"`).  
- **SEMPRE aplicar `create-subagents`** se script >200 linhas ou tem múltiplas etapas independentes.  
- **SEMPRE aplicar `create-execution-plan`** ao receber pedido de planejamento, correção de bug complexo, ou tarefa multi-etapas que precise de plano antes de executar.  
- **VIOLAÇÃO:** Gerar código sem aplicar skills aplicáveis é violação das convenções.

---

## 5. LOGS DE PROGRESSO (OBRIGATÓRIO)

**Skill:** `code-with-logs` | **Timestamp obrigatório:** `[HH:MM:SS]`  
**Princípio:** Log de progresso NÃO é log técnico.

**Formato:** etapa atual/total, ETA total, tempo restante, emoji, linguagem natural.  
**Helper Python:** `LoggerComTimestamp()` — usar obrigatoriamente.  
**Proibido:** colchetes `[]`, prefixos técnicos, logger debug, logs sem timestamp, scripts sem progresso.

**Exemplo mínimo:**
```
▶️ [14:23:15] Iniciando (ET: 3m)
🔄 [14:23:18] Passo 1/5 — Carregando (ETA: 2m30s)
✅ [14:23:25] Passo 1 concluído (⏱️ 10.2s)
🎉 [14:25:13] Concluído (⏱️ 118.5s)
```

---

## 6. ESTRUTURA DE DOCUMENTAÇÃO

`docs/00_overview/` (readme.md, roadmap.md, context.md)  
`docs/01_architecture/`, `docs/02_business_rules/`, `docs/03_api/`, `docs/04_operations/`, `docs/05_decisions/`, `docs/06_testing/`, `docs/07_changelog/`, `docs/_scratchpad/`

**Princípios:** uma pasta = uma responsabilidade, sem sobreposição.

---

## 7. _scratchpad E PROMOÇÃO

Todo material exploratório em `docs/_scratchpad/` com cabeçalho `STATUS: TRANSITÓRIO | DATA: YYYY-MM-DD | CONTEXTO: investigação|teste|hipótese|validação`.  
**Promover para `docs/` se:** define lógica oficial, arquitetura validada, decisão técnica, referência futura, validação produção.  
**Processo:** mover arquivo, remover STATUS, atualizar docs oficiais, registrar em decisions_log.md.  
Proibido manter conhecimento crítico apenas em `_scratchpad`.

---

## 8. ROADMAP E README

**Roadmap:** atualizar sempre que houver funcionalidade nova, avanço de etapa, mudança requisito, decisão estrutural → `docs/00_overview/roadmap.md`  
**README:** atualizar sempre que houver alteração relevante → `docs/00_overview/readme.md` (estrutura, instalação, execução, testes, env vars, arquitetura, fluxos)

---

## 9. SEGURANÇA

Nenhuma key em código, `.env` obrigatório, validação entradas, sanitização dados, logs sem dados sensíveis.

---

## 10. DEBUG

Breakpoints por padrão, logs narrativos, evitar fallback, testar erro antes do sucesso.  
Manter atualizado: `docs/04_operations/debug_guide.md`

---

## 11. REFATORAÇÃO

Sugerir ao detectar: duplicação, funções longas, lógica confusa, inconsistências, nomeação ruim.  
Refatorar somente após aprovação explícita.

---

## 12. TESTES

Funções críticas: caso sucesso, caso erro, caso limítrofe.  
Testes devem narrar execução, indicar progresso, finalizar claramente.

---

## 13. GIT (CRITÉRIO DE VALOR)

**Princípio:** Commit = registrar valor permanente ou decisão relevante.  
**Não commitar:** exploratório, descartável, temporário, `_scratchpad/`  
**Commit obrigatório:** funcionalidades, correções reais, regras de negócio, código permanente, docs oficial, testes definitivos  
Commits: curtos, claros, verbo de ação.

---

## 14. SCRIPTS E SUBAGENTES

**Scripts >200 linhas ou múltiplas etapas:** usar subagentes Python obrigatoriamente.  
**Skills:** `code-with-logs`, `create-subagents`  
**Estrutura sugerida:** `scripts/` (canônicos), `scripts/_adhoc/` (temporários)  
Não adicionar scripts diretamente em `_adhoc/` → usar diretórios operacionais apropriados.

---

## 15. CONTEXT ENGINEERING

**Commands:** `/context-boot` (≤500 tokens), `/context-focus` (≤900 tokens), `/context-deep` (≤600 tokens), `/context-audit`, `/context-migration`, `/context-refactor`, `/context-feature`, `/apply-conventions`, `/create-execution-plan`  
**Ver:** `.cursor/commands/context-*.md`, `.cursor/commands/apply-conventions.md`

**Regras fundamentais:**
1. **Anti-Dumping:** não colar grandes blocos código/log/SQL, sintetizar e referenciar
2. **Progressive Disclosure:** BOOT → FOCUS → DEEP, Context Packs 40–90 linhas
3. **Always Produce Context Pack Final:** antes de implementações
4. **Evidence-First (AUDIT):** coletar evidências antes de análises
5. **Safety-First (MIGRATION):** backup, validação antes/depois, rollback plan
6. **Incremental (REFACTOR):** pequenos passos, validar após cada passo
7. **Spec-First (FEATURE):** especificar antes de implementar

---

## 16. CONTEXTO VIVO

Arquivo canônico: `docs/00_overview/context.md` (fonte única de verdade)  
**Estrutura:** Objetivo atual, Estado do sistema, Decisões tomadas, Convenções obrigatórias, Restrições, Próximo passo  
**Atualizar sempre que:** decisão técnica, mudança direção, conclusão etapa, descoberta relevante  
**Command:** `/update-context`  
Contexto não pode ficar desatualizado ou em `_scratchpad`.

---

## 17. CHECKLIST INTERNO DA IA (OBRIGATÓRIO)

**ANTES de gerar código, validar:**
- Apresentar plano antes de executar? → OBRIGATÓRIO
- Tarefa multi-etapas precisa de plano? → Usar `/create-execution-plan` OBRIGATORIAMENTE
- Script executável? → Aplicar `code-with-logs` OBRIGATORIAMENTE
- Script >200 linhas ou múltiplas etapas? → Aplicar `create-subagents` OBRIGATORIAMENTE
- Logs terão timestamp [HH:MM:SS]? → OBRIGATÓRIO via `LoggerComTimestamp()`

**Durante geração:**
- tarefa grande? → Sequential Thinking
- mexe em estrutura? → pedir autorização
- gerou código? → sem fallback + logs timestamp + skills aplicadas
- script/teste/job longo? → logs progresso obrigatórios com ETA + subagentes

**Após geração:**
- avanço real? → atualizar roadmap/docs/context
- valor permanente? → commitar
- exploratório? → não commitar
- duplicação/lógica confusa? → sugerir refatoração

**NUNCA gerar código sem validar checklist acima primeiro.**

---

## REGRA FINAL

Código que funciona é patrimônio. Documentação correta é blindagem. Log legível é consciência. Commit é memória institucional. Context Engineering é performance. Nada importante fica solto.
