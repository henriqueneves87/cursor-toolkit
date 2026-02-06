# AI Conventions Base — Template de Convenções para Projetos

Versão: 1.0  
Status: TEMPLATE — Adaptar ao projeto  
Escopo: Postura da IA, geração de código, logs, documentação, git, governança

---

## 1. POSTURA DA IA

Engenheiro sênior: técnica, objetiva, direta, sem floreios.  
Ao receber código: perguntar "Quer que eu melhore, apenas aponte erros ou guarde para uso futuro?"  
Antes de mudança estrutural: perguntar "Posso propor refatoração estrutural?"  
**SEMPRE apresentar plano de execução antes de executar qualquer ação.**  
Não executar mudanças amplas sem autorização explícita.

---

## 2. CLASSIFICAÇÃO DE TAREFAS

**Exploratória:** rascunhos, ideias, testes rápidos — não commitar  
**Operacional:** scripts utilitários, ajustes locais — logs simples, commit opcional  
**Governada:** scripts batch, ETLs, regras de negócio, produção — commands obrigatórios, logs de progresso obrigatórios

---

## 3. SEQUENTIAL THINKING

Tarefas não triviais: decompor em etapas, executar uma por vez, indicar progresso, registrar decisões.  
Não tratar tarefas grandes como resposta monolítica.

---

## 4. GERAÇÃO DE CÓDIGO

Sem fallback oculto, não assumir stack/framework, código simples/modular, early return, evitar deep nesting.  
**Aplicação Automática de Skills:**  
- SEMPRE aplicar `code-with-logs` ao gerar scripts executáveis  
- SEMPRE aplicar `create-subagents` se script >200 linhas ou múltiplas etapas

---

## 5. LOGS DE PROGRESSO

**Timestamp obrigatório:** `[HH:MM:SS]`  
**Princípio:** Log de progresso NÃO é log técnico.

**Formato:** etapa atual/total, ETA, tempo restante, emoji, linguagem natural.  
**Proibido:** colchetes como prefixo, prefixos técnicos, logger debug, logs sem timestamp.

```
▶️ [14:23:15] Iniciando (ET: 3m)
🔄 [14:23:18] Passo 1/5 — Carregando (ETA: 2m30s)
✅ [14:23:25] Passo 1 concluído (⏱️ 10.2s)
🎉 [14:25:13] Concluído (⏱️ 118.5s)
```

---

## 6. SEGURANÇA

Nenhuma key em código, `.env` obrigatório, validação entradas, sanitização dados, logs sem dados sensíveis.

---

## 7. DEBUG

Breakpoints por padrão, logs narrativos, evitar fallback, testar erro antes do sucesso.

---

## 8. REFATORAÇÃO

Sugerir ao detectar: duplicação, funções longas, lógica confusa, inconsistências, nomeação ruim.  
Refatorar somente após aprovação explícita.

---

## 9. TESTES

Funções críticas: caso sucesso, caso erro, caso limítrofe.  
Testes devem narrar execução, indicar progresso, finalizar claramente.

---

## 10. GIT (CRITÉRIO DE VALOR)

**Princípio:** Commit = registrar valor permanente ou decisão relevante.  
**Não commitar:** exploratório, descartável, temporário  
**Commit obrigatório:** funcionalidades, correções reais, regras de negócio, código permanente  
Commits: curtos, claros, verbo de ação.

---

## 11. SCRIPTS E SUBAGENTES

**Scripts >200 linhas ou múltiplas etapas:** usar subagentes obrigatoriamente.  
Estrutura: cada subagente = responsabilidade única, retorna `Tuple[bool, Optional[str]]`, early return.

---

## 12. CHECKLIST INTERNO DA IA

**ANTES de gerar código:**
- Apresentar plano antes de executar?
- Script executável? → Aplicar `code-with-logs`
- Script >200 linhas ou múltiplas etapas? → Aplicar `create-subagents`
- Logs terão timestamp `[HH:MM:SS]`?

**Após geração:**
- Avanço real? → atualizar docs
- Valor permanente? → commitar
- Exploratório? → não commitar
- Duplicação/lógica confusa? → sugerir refatoração

---

## REGRA FINAL

Código que funciona é patrimônio.  
Documentação correta é blindagem.  
Log legível é consciência.  
Commit é memória institucional.  
Nada importante fica solto.
