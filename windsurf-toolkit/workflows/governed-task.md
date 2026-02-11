# governed-task — GOVERNANÇA DE TAREFAS GRANDES

Versão: 2.0  
Tipo: Command  
Uso: Manual (invocado pelo usuário)  
Escopo: Tarefas grandes, multi-etapas, arquitetura, pipelines, sistemas

---

## OBJETIVO

Forçar a IA a executar tarefas grandes de forma governada, aplicando integralmente:
- AI Governance (regras executáveis)
- Convenção Oficial
- Sequential Thinking
- Skills automáticas
- Subagentes quando apropriado

---

## QUANDO USAR

Use `governed-task` para:

- tarefas grandes
- tarefas multi-etapas
- arquitetura
- pipelines
- criação de sistemas
- refatorações relevantes
- decisões técnicas importantes

---

## COMO USAR

Digite o comando antes da solicitação:

```
@governed_task
```

Ou:

```
/governed-task
```

---

## COMPORTAMENTO OBRIGATÓRIO DA IA

Ao receber `governed-task`, a IA DEVE:

1. **Aplicar integralmente a AI Governance:**
   - Usar Sequential Thinking obrigatoriamente
   - Dividir a tarefa em etapas claras
   - Resolver uma etapa por vez
   - Indicar progresso explicitamente
   - Validar aderência à Convenção Oficial

2. **Aplicar integralmente a Convenção Oficial:**
   - Seguir padrões de código
   - Usar logs narrativos com timestamp
   - Organizar documentação corretamente
   - Avaliar critério de commit
   - Atualizar roadmap quando aplicável

3. **Realizar autoauditoria ao final:**
   - Verificar se todas as etapas foram concluídas
   - Verificar se skills foram aplicadas
   - Verificar se subagentes foram usados quando apropriado
   - Verificar se documentação foi atualizada

4. **Aplicar skills automaticamente quando detectar contexto relevante:**
   - Scripts Python → `code-with-logs` (logs com timestamp `[HH:MM:SS]`)
   - Scripts complexos → `create-subagents` (usar subagentes Python)
   - Migrations SQL → `aplicar-migrations` (padrão Validação → Aplicação → Verificação)
   - Reprocessamento → `reprocessar-dados` (padrão de 4 etapas)
   - Documentação → `create-documentation` (seguir estrutura oficial)

5. **Usar subagentes Python quando apropriado:**
   - Scripts com múltiplas etapas → modularizar usando subagentes
   - Validações → usar subagentes de validação apropriados
   - Aplicações SQL → usar subagentes de aplicação SQL ou migrations
   - Limpeza → usar subagentes de limpeza de dados
   - Reprocessamento em lote → usar subagentes de reprocessamento em lote
   - Cancelamento queries → usar subagentes de cancelamento de queries
   - Validação financeira → usar subagentes de validação financeira

6. **Usar logs com timestamp obrigatoriamente:**
   - Todos os logs devem ter timestamp `[HH:MM:SS]`
   - Use o helper de logging do projeto (se disponível) ou timestamp inline

---

## SKILLS E SUBAGENTES (OBRIGATÓRIO)

**⚠️ Ao executar tarefas governadas, a IA DEVE:**

### 1. Aplicar skills automaticamente:

- **Scripts Python** → `code-with-logs` (logs com timestamp `[HH:MM:SS]`)
- **Scripts complexos** → `create-subagents` (usar subagentes Python)
- **Migrations SQL** → `aplicar-migrations` (padrão Validação → Aplicação → Verificação)
- **Reprocessamento** → `reprocessar-dados` (padrão de 4 etapas)
- **Documentação** → `create-documentation` (seguir estrutura oficial)

### 2. Usar subagentes Python quando apropriado:

- Scripts com múltiplas etapas → modularizar usando subagentes
- Validações → usar subagentes de validação apropriados
- Aplicações SQL → usar subagentes de aplicação SQL ou migrations
- Limpeza → usar subagentes de limpeza de dados
- Reprocessamento em lote → usar subagentes de reprocessamento em lote
- Cancelamento queries → usar subagentes de cancelamento de queries
- Validação financeira → usar subagentes de validação financeira

### 3. Usar logs com timestamp obrigatoriamente:

- Todos os logs devem ter timestamp `[HH:MM:SS]`
- Use o helper de logging do projeto (se disponível) ou timestamp inline

**Documentação:**
- Skills: `~/.cursor/skills-cursor/` (globais) ou `.cursor/skills/` (projeto)
- Subagentes Python: consultar documentação do projeto sobre subagentes
- Subagentes Cursor: `.cursor/agents/` ou `~/.cursor/agents/`

---

## INTEGRAÇÃO COM CONTEXT ENGINEERING

Para tarefas que envolvem auditoria, migração, refatoração ou features, considere usar os commands específicos do Context Engineering:

- `context-audit` — Para auditorias técnicas
- `context-migration` — Para migrações
- `context-refactor` — Para refatorações
- `context-feature` — Para novas features

Estes commands podem ser usados em conjunto com `governed-task` ou como alternativa quando o escopo é específico.

---

## EXEMPLO DE USO

```
@governed_task
Preciso criar um pipeline de ingestão com validação e testes.
```

**Comportamento esperado:**
1. IA divide em etapas (Sequential Thinking)
2. Aplica skills automaticamente (`code-with-logs`, `create-subagents`)
3. Usa subagentes Python para modularização
4. Logs com timestamp `[HH:MM:SS]`
5. Atualiza documentação e roadmap
6. Realiza autoauditoria ao final

---

## REGRAS (INQUEBRÁVEIS)

- ❌ Executar tarefa governada sem `governed-task` é **falha de governança**
- ✅ Toda tarefa grande DEVE usar Sequential Thinking
- ✅ Skills devem ser aplicadas automaticamente
- ✅ Subagentes devem ser usados em scripts complexos
- ✅ Logs devem ter timestamp obrigatório
- ✅ Documentação deve ser atualizada quando aplicável

---

## AI GOVERNANCE — MODELO DE 3 CAMADAS

Este command aplica integralmente o modelo de governança em 3 camadas:

### 🧱 CAMADA 1 — AI GOVERNANCE: REGRAS EXECUTÁVEIS (PRIORIDADE ABSOLUTA)

1. Se a tarefa envolver mais de uma etapa → usar Sequential Thinking obrigatoriamente.
2. Se gerar código → não usar fallback, não assumir stack, usar logs narrativos.
3. Se criar scripts, testes ou jobs longos → logs de progresso obrigatórios (passo atual/total + ETA).
4. Se alterar arquitetura, fluxo ou estrutura → pedir autorização antes, atualizar roadmap e registrar decisão.
5. Se detectar duplicação, função longa ou lógica confusa → sugerir refatoração e aguardar aprovação.
6. Antes de responder → validar aderência à Convenção Oficial e informar o que foi aplicado.
7. Commands com `HARD STOP` (ex: optimize-prompt) **bloqueiam qualquer execução** até validação explícita.

❌ Falhar em cumprir qualquer item acima é considerado **ERRO DE GOVERNANÇA**.

### 📐 CAMADA 2 — CONVENÇÃO OFICIAL DE DESENVOLVIMENTO E DOCUMENTAÇÃO

A Convenção define:
- padrões de código
- padrões de logs (incluindo SQL / RAISE NOTICE)
- organização da documentação (`docs/` por assunto)
- critérios de commit
- regras de testes
- refatoração
- segurança
- debug
- contexto vivo
- governança de IA

A Convenção **não é sugestão**. É **contrato técnico**.

### 📏 CAMADA 3 — REGRA DE GOVERNANÇA OPERACIONAL (REGRA MENOR)

Classificação obrigatória das tarefas:

- 🟢 **Exploratória** — não commitar, pode usar `_scratchpad`, sem obrigação de logs
- 🔵 **Operacional** — logs simples recomendados, commit opcional, sem impacto estrutural
- 🔴 **Governada** — uso obrigatório de commands, logs de progresso obrigatórios, avaliação de commit por critério de valor

A IA deve **sempre agir como se estivesse em uma tarefa governada** quando houver dúvida.

---

## REGRA FINAL

Governança não é burocracia.  
É o que impede o caos silencioso.  
IA sem regras vira ruído.  
Sistema sem narrativa vira risco.

---

=== FIM DO COMMAND governed-task ===
