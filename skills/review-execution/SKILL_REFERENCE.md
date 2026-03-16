---
name: review-execution
description: Revisao pos-execucao que compara fontes de verdade (execution plan, docs, roadmap) com codigo implementado. Gera relatorio de inconsistencias e prompt de handoff para analise profunda. Use quando comando /review-execution for invocado. NAO e auto-aplicavel.
---

# Review Execution v2.0 (referencia completa)

> Versao compacta para uso diario: `SKILL.md`
> Esta versao contem exemplos, templates completos e detalhamento de cada fase.

## ATIVACAO

**Esta skill NAO e auto-aplicavel.** So ativa quando:

- Comando `/review-execution` invocado pelo usuario
- Usuario pede revisao pos-execucao explicitamente

**NUNCA disparar automaticamente.** O custo de contexto so se justifica quando o usuario decide revisar.

## Quando NAO usar

- Revisao de codigo pontual (usar `code-reviewer`)
- Bug especifico com causa raiz conhecida (usar `debugger`)
- Auditoria de resposta da IA (usar `audit-response`)
- Reorganizacao arquitetural (usar `architecture-review`)

---

## Conceito

Revisao pos-execucao compara **fontes de verdade** com **codigo real**, gerando relatorio de inconsistencias acionaveis. Fecha o ciclo:

```
Plan → Execute → Review → (Fix Plan) → Execute → Review ✓
```

**Principio:** Revisar e verificar, nao corrigir. A skill e read-only.

---

## Escopos de Revisao

O usuario escolhe o escopo. Cada escopo tem fonte de verdade e estrategia propria.

### scope=plan

**Fonte de verdade:** Execution plan (tarefas T1..TN)
**Pergunta:** "As tarefas do plano foram implementadas como especificado?"
**Input:** Caminho do execution plan (ou buscar o mais recente)

Verifica por tarefa:
1. Arquivo listado existe?
2. Arquivo foi modificado? (git log/diff)
3. Criterio de aceite atendido? (verificacao semantica no codigo)
4. Snippet "depois" presente no codigo? (se especificado no plano)
5. Implementacao superficial? (buscar `TODO`, `pass`, `NotImplemented`, `...`, stubs)
6. Imports/dependencias adicionados?

### scope=docs

**Fonte de verdade:** Documentacao do projeto (docs/)
**Pergunta:** "A documentacao reflete o codigo real?"
**Input:** Caminho de docs/ (ou usar padrao do projeto)

Verifica:
1. Entidades/endpoints documentados existem no codigo?
2. Campos documentados existem nos models/schemas?
3. Regras de negocio documentadas estao implementadas?
4. Roadmap reflete o estado real? (itens marcados como feitos realmente existem?)
5. Arquitetura documentada bate com a estrutura real?

### scope=full

Combina `plan` + `docs`, mas com estrategia de contexto:
- Fase 0 gera checklist unificado
- Subagentes sao divididos por fonte de verdade (nao por camada)
- Maximo 4 subagentes (limite do Cursor)

---

## Estrategia de Contexto (anti-dumbing)

O maior risco desta skill e sobrecarregar a IA. Cinco camadas de protecao:

### 1. Ativacao manual

Nao consome contexto ate o usuario chamar.

### 2. Parse leve na Fase 0

Extrair CHECKLIST compacto da fonte de verdade. Nao ler codigo ainda.

Formato do checklist:

```
T1 | arquivo: src/services/pay.py | criterio: "endpoint POST /pay retorna 201"
T2 | arquivo: src/models/order.py | criterio: "campo discount_type adicionado"
...
```

### 3. Subagentes cirurgicos

Cada subagente recebe APENAS:
- O checklist das tarefas que deve verificar
- Os caminhos dos arquivos a ler
- Instrucao: "retorne APENAS inconsistencias"

NAO recebe: o plano inteiro, docs inteiros, contexto do projeto.

### 4. Retorno compacto

Subagentes retornam APENAS o que falhou. O que esta OK e descartado.

### 5. Relatorio enxuto

Tabela de inconsistencias + detalhamento so do que falhou. Sem listar o que esta correto.

---

## Fases de Execucao (review em camadas)

### Fase 0 — Parse da Fonte de Verdade (Composer/pool incluso)

**Agente pai executa.**

Para `scope=plan`:
1. Ler o execution plan
2. Extrair: tarefas, arquivos, criterios de aceite, snippets antes/depois
3. Gerar checklist compacto (1 linha por tarefa)

Para `scope=docs`:
1. Listar arquivos em docs/ (sem ler conteudo)
2. Ler APENAS docs relevantes (spec, roadmap, arquitetura)
3. Extrair: entidades, endpoints, campos, regras de negocio
4. Gerar checklist compacto

Para `scope=full`:
1. Executar ambos
2. Unificar em checklist unico

**Output:** Checklist compacto + lista de arquivos de codigo a verificar.

### Fase 1 — Triagem Mecanica (Composer/pool incluso)

Dividir checklist em blocos e disparar subagentes via Task tool.

**Divisao dos subagentes:**

Para `scope=plan`:
- Dividir tarefas em blocos de ~5 tarefas por subagente
- Maximo 4 subagentes

Para `scope=docs`:
- 1 subagente por dominio de docs (spec, roadmap, arquitetura)
- Maximo 3 subagentes

Para `scope=full`:
- 2 subagentes para plan + 2 subagentes para docs

**Cada inconsistencia DEVE ser classificada como:**

- `[MECANICO]` — verificado objetivamente: arquivo existe? imports presentes? stubs/TODOs? campos no model/schema? endpoint registrado?
- `[PRECISA ANALISE]` — exige interpretacao: criterio de aceite com logica condicional, regras de negocio, fluxos com multiplos caminhos, validacoes de dominio

**Template de prompt para subagente:**

```
Voce e um revisor pos-execucao. Verifique se os itens abaixo foram implementados.

CHECKLIST:
{checklist_do_bloco}

REGRAS:
- Leia APENAS os arquivos listados no checklist
- Retorne APENAS inconsistencias (o que esta OK, descarte)
- Classifique cada inconsistencia como [MECANICO] ou [PRECISA ANALISE]
- Para cada inconsistencia, informe: item, classificacao, tipo, severidade, evidencia
- Busque implementacoes superficiais: TODO, pass, NotImplemented, stubs, placeholders
- NAO corrija nada, apenas reporte

FORMATO DE RETORNO:
| Item | Classificacao | Tipo | Severidade | Arquivo | Evidencia |
```

### Fase 2 — Consolidacao (Composer/pool incluso)

**Agente pai executa.**

1. Receber resultados dos subagentes
2. Deduplicar (mesmo item reportado por subagentes diferentes)
3. Classificar por severidade
4. Gerar relatorio MD
5. Se ha items `[PRECISA ANALISE]`: gerar prompt de handoff (ver secao abaixo)

### Fase 3 — Handoff

1. Apresentar resumo executivo ao usuario
2. Top 5 inconsistencias mais criticas
3. Se ha items `[PRECISA ANALISE]`: informar caminho do prompt de handoff
4. Perguntar: "Quer que eu gere um execution plan de correcao com base neste relatorio?"
5. Se sim: aplicar skill `create-execution-plan` usando o relatorio como diagnostico

---

## Prompt de Handoff (analise profunda)

Quando a triagem identificar items `[PRECISA ANALISE]`, gerar prompt autocontido para nova conversa com modelo intermediario (Sonnet/GPT-5.4).

**Salvar em:** `docs/04_operations/prompts_review_{NNN}_{nome}.md` (mesmo NNN do plano original)

### Estrutura obrigatoria

```markdown
# Prompt de Analise Profunda — Review {Nome}

> Cole este bloco inteiro numa conversa nova com Claude 4.6 Sonnet ou GPT-5.4.
> Ultima atualizacao: YYYY-MM-DD

## PROMPT (copie e cole)

```
Voce e um revisor especialista. Analise os items abaixo que foram flagrados
na triagem mecanica como precisando de analise profunda.

ITEMS PARA ANALISE:

{para cada item:}
### Item {N} — {descricao}
- Criterio de aceite original: {criterio}
- Arquivo: {caminho}
- Trecho de codigo relevante:
  ```
  {codigo}
  ```
- Motivo da flag: {por que a triagem nao conseguiu verificar}

INSTRUCOES:
- Para cada item, verifique se o criterio de aceite foi atendido
- Classifique: OK | inconsistencia (com tipo e severidade)
- Atualize o relatorio em {caminho_do_relatorio} adicionando seus resultados
- Ao final, oferecer /create-execution-plan de correcao se houver inconsistencias

FORMATO:
| Item | Resultado | Tipo | Severidade | Evidencia |
```

## Tabela de items
## Arquivos envolvidos
```

### Regras do prompt de handoff

- O prompt DEVE ser autocontido — colar numa conversa nova basta
- Incluir trechos de codigo relevantes inline (nao depender de leitura de arquivos)
- Incluir o caminho do relatorio de triagem para atualizacao
- Um prompt por review

---

## Taxonomia de Inconsistencias

| Tipo | Descricao |
|------|-----------|
| `nao_implementado` | Previsto na fonte de verdade mas nao existe no codigo |
| `parcial` | Existe mas incompleto (ex: 3 de 5 campos adicionados) |
| `divergente` | Existe mas diferente do especificado |
| `superficial` | Existe mas com stubs/placeholders/TODOs |
| `desatualizado` | Codigo mudou mas doc/plano nao acompanhou |
| `orfao` | Implementado mas nao previsto em nenhum doc/plano |

## Severidades

| Severidade | Criterio |
|------------|----------|
| **BLOQUEANTE** | Impede uso real: funcionalidade inteira ausente, fluxo quebrado |
| **LACUNA** | Funciona mas falta algo relevante: campos, validacoes, acoes |
| **DRIFT** | Desalinhamento doc/codigo: nao quebra mas gera confusao |

---

## Relatorio — Estrutura Completa

```markdown
# Review Execution — {Nome do Projeto/Plano}

Data: YYYY-MM-DD
Escopo: plan | docs | full
Fonte de verdade: {caminho do plano ou docs/}

---

## Resumo Executivo

| Severidade | Qtd |
|------------|-----|
| BLOQUEANTE | N   |
| LACUNA     | N   |
| DRIFT      | N   |
| **Total**  | N   |

Tarefas/itens verificados: N
Inconsistencias encontradas: N (X%)
Items [PRECISA ANALISE]: N (prompt de handoff: {caminho ou "nenhum"})

---

## Inconsistencias

| # | Item | Classif. | Tipo | Severidade | Arquivo | Evidencia |
|---|------|----------|------|------------|---------|-----------|

---

## Detalhamento

### [BLOQUEANTE] Item X — descricao curta
- **Esperado:** (o que a fonte de verdade define)
- **Encontrado:** (o que o codigo tem, ou "nao encontrado")
- **Arquivo:** caminho:linha
- **Acao sugerida:** (1 frase)

---

## Proximo Passo

Recomendacao: `/create-execution-plan` usando este relatorio como diagnostico.
Se ha items [PRECISA ANALISE]: executar prompt de handoff em {caminho} antes.
```

### Caminho do relatorio

```
docs/05_decisions/reports/review_exec_{NNN}_{nome}_{YYYY-MM-DD}.md
```

Se `scope=plan`, usar o mesmo NNN do execution plan original.
Se a pasta nao existir, criar.

---

## Integracao

| Apos review | Acao |
|-------------|------|
| Gerar plano de correcao | `/create-execution-plan` com relatorio como input |
| Correcoes com logs | skill `code-with-logs` |
| Revisar correcoes | skill `code-reviewer` |
| Atualizar docs | skill `create-documentation` |

---

## Anti-patterns

- Disparar automaticamente (consome contexto sem necessidade)
- Ler codebase inteiro na Fase 0 (usar parse leve + checklist)
- Subagentes com escopo amplo (devem receber apenas checklist + caminhos)
- Relatorio listando o que esta OK (so inconsistencias importam)
- Revisar e corrigir ao mesmo tempo (review e read-only)
- Inventar inconsistencias (se a fonte de verdade nao menciona, nao e inconsistencia)
- Subagentes editando codigo (apenas leem e reportam)

---

## Regra Final

Execucao sem revisao e promessa sem verificacao.
Revisao sem fonte de verdade e opiniao.
Inconsistencia sem evidencia e achismo.
**Review fecha o ciclo. Sem review, o ciclo e aberto.**
