# optmize-prompt

# optimize-prompt — OTIMIZAÇÃO GOVERNADA DE PROMPT (HARD STOP)

Versão: 2.2  
Tipo: Command  
Uso: Manual (invocado pelo usuário)  
Modo: PREPARAÇÃO DE PROMPT (NÃO EXECUTÁVEL)

---

## ESTADO OPERACIONAL (OBRIGATÓRIO)

MODO ATIVO: PREPARAÇÃO DE PROMPT  
ESTE MODO BLOQUEIA QUALQUER EXECUÇÃO DE TAREFA.

Enquanto este modo estiver ativo, a IA:

- ❌ NÃO executa tarefas
- ❌ NÃO gera código executável
- ❌ NÃO continua fluxo automaticamente
- ❌ NÃO assume decisões técnicas
- ❌ NÃO inicia governed-task, code-with-logs ou similares

Qualquer execução neste modo é **ERRO**.

---

## OBJETIVO

Reescrever um prompt fornecido pelo usuário para máxima clareza,
previsibilidade e aderência à Convenção Oficial do projeto.

Este command **apenas prepara o prompt**.
A execução depende de **validação explícita do usuário**.

---

## COMO USAR

O usuário deve digitar:

optimize-prompt
<prompt original>


---

## COMPORTAMENTO OBRIGATÓRIO DA IA

Ao receber `optimize-prompt`, a IA deve:

1. Entrar explicitamente em **MODO: PREPARAÇÃO DE PROMPT**
2. NÃO executar a tarefa solicitada
3. NÃO gerar código
4. NÃO propor execução automática
5. Atuar apenas como **editor de prompt**
6. Preservar integralmente a intenção original
7. Eliminar ambiguidades
8. Inserir um bloco técnico inicial obrigatório
9. FINALIZAR A RESPOSTA APÓS ENTREGAR O PROMPT OTIMIZADO

---

## FORMATO OBRIGATÓRIO DA RESPOSTA

A resposta DEVE conter **exatamente os blocos abaixo**, nesta ordem,
e **NADA além disso**.

---

### 1. PROMPT ORIGINAL (INALTERADO)

```text
<copiar exatamente o prompt fornecido pelo usuário>

2. PROMPT OTIMIZADO (PRONTO PARA USO)
CONTEXTO TÉCNICO (OBRIGATÓRIO)

- Siga integralmente a Convenção Oficial do projeto.
- Se a tarefa envolver mais de uma etapa, use Sequential Thinking.
- Se houver geração de código executável, utilize o command `code-with-logs`.
- Não utilize fallback oculto.
- Não assuma stack, framework ou tecnologia.
- Qualquer alteração estrutural exige autorização prévia.
- Priorize clareza, correção e logs legíveis.
- Não execute nada fora do escopo solicitado.

OBJETIVO
<descrição clara do que se espera>

ESCOPO
<o que está dentro e fora do pedido>

INSTRUÇÕES
<passos ou orientações em ordem lógica>

RESULTADO ESPERADO
<critérios objetivos de sucesso>
