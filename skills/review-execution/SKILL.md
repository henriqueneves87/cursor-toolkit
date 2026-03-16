---
name: review-execution
description: Revisao pos-execucao que compara fontes de verdade (execution plan, docs, roadmap) com codigo implementado. Gera relatorio de inconsistencias e prompt de handoff para analise profunda. Use quando comando /review-execution for invocado. NAO e auto-aplicavel.
---

# Review Execution v2.0 (compacto)

> Referencia completa com exemplos e template de relatorio: `SKILL_REFERENCE.md`
> Consultar SKILL_REFERENCE.md quando: primeira review do projeto ou duvida sobre formato de relatorio.

## ATIVACAO

**NAO e auto-aplicavel.** So ativa com `/review-execution` ou pedido explicito.
**NAO usar para:** revisao pontual (code-reviewer), bug conhecido (debugger), arquitetura (architecture-review).

## ESCOPOS

**scope=plan:** Fonte = execution plan. "Tarefas implementadas como especificado?"
- Arquivo existe? Modificado? Criterio atendido? Stubs/TODOs? Imports?

**scope=docs:** Fonte = docs/. "Docs refletem codigo real?"
- Entidades/endpoints existem? Campos nos models? Regras implementadas? Roadmap atualizado?

**scope=full:** plan + docs. Max 4 subagentes (2 plan + 2 docs).

## ESTRATEGIA ANTI-DUMBING (5 camadas)

1. Ativacao manual (nao consome ate chamar)
2. Parse leve: checklist compacto da fonte de verdade, SEM ler codigo
3. Subagentes cirurgicos: recebem APENAS checklist + caminhos
4. Retorno compacto: APENAS inconsistencias
5. Relatorio enxuto: so o que falhou

## FASES (review em camadas)

**0 — Parse (Composer/pool incluso):** Extrair checklist (1 linha/tarefa: `T1 | arquivo | criterio`). Agente pai.

**1 — Triagem mecanica (Composer/pool incluso):** Subagentes verificam items objetivos. Retornam SO inconsistencias, classificadas como:
- `[MECANICO]` — verificado objetivamente (arquivo existe, imports presentes, stubs/TODOs, campos no model)
- `[PRECISA ANALISE]` — exige interpretacao de logica de negocio, validacao de criterios complexos, fluxos multi-step

**Criterios de classificacao:**
- Triagem mecanica `[MECANICO]`: arquivo existe? imports presentes? stubs/TODOs? campos no model/schema? endpoint registrado?
- Analise profunda `[PRECISA ANALISE]`: criterio de aceite com logica condicional, regras de negocio, fluxos com multiplos caminhos, validacoes de dominio

**Template de prompt para subagente de triagem:**

```
Voce e um revisor pos-execucao. Verifique se os itens abaixo foram implementados.

CHECKLIST:
{checklist_do_bloco}

REGRAS:
- Leia APENAS os arquivos listados no checklist
- Retorne APENAS inconsistencias (o que esta OK, descarte)
- Classifique cada inconsistencia como [MECANICO] ou [PRECISA ANALISE]
- Para cada inconsistencia: item, tipo, severidade, arquivo, evidencia
- Busque: TODO, pass, NotImplemented, stubs, placeholders
- NAO corrija nada, apenas reporte

FORMATO DE RETORNO:
| Item | Classificacao | Tipo | Severidade | Arquivo | Evidencia |
```

**2 — Consolidacao (Composer/pool incluso):** Agente pai deduplica, classifica severidade, gera relatorio MD. Se ha items `[PRECISA ANALISE]`, gera prompt de handoff.

**3 — Handoff + Acao pos-review:** Apresentar resultado estruturado e guiar proximo passo.

## FASE 3 — ACAO POS-REVIEW (obrigatoria)

Apos gerar o relatorio, a IA DEVE apresentar o resultado de forma acionavel:

**1. Resumo executivo** (tabela de severidades + top 5)

**2. Triagem de acoes** — agrupar inconsistencias por tipo de acao:

```
CORRECOES RAPIDAS (posso aplicar agora, Composer):
- #3 DRIFT: atualizar status T15-T25 no plano → "concluido"
- #5 DRIFT: remover comentario obsoleto em router.py L74

CORRECOES MODERADAS (posso aplicar agora se autorizado, Composer):
- #4 LACUNA: adicionar campo X no model Y

FEATURES/COMPLEXAS (recomendo execution plan, Opus):
- #1 LACUNA: DRE multi-meses (backend + frontend)
- #2 LACUNA: drill-down com sparkline

ANALISE PROFUNDA (prompt de handoff salvo, Sonnet):
- (items [PRECISA ANALISE], se houver)
```

**3. Perguntar de forma estruturada:**
> "Posso aplicar as N correcoes rapidas agora? Para as features complexas, recomendo /create-execution-plan em nova conversa com Opus."

**4. Se autorizado:** aplicar correcoes rapidas (DRIFTs e LACUNAs simples) direto na mesma conversa.

**5. Se ha features complexas:** gerar prompt de handoff para `/create-execution-plan`, salvar em `docs/04_operations/prompts_correcao_{NNN}_{nome}.md`.

**6. Se ha items [PRECISA ANALISE]:** gerar prompt de handoff para analise profunda (Sonnet), salvar em `docs/04_operations/prompts_review_{NNN}_{nome}.md`.

**Regra:** a IA NAO deve apenas listar inconsistencias e parar. Deve guiar o usuario ate a acao.

## PROMPT DE HANDOFF (analise profunda)

Quando a triagem identificar items `[PRECISA ANALISE]`, gerar prompt autocontido para nova conversa com modelo intermediario (Sonnet/GPT-5.4).

**Salvar em:** `docs/04_operations/prompts_review_{NNN}_{nome}.md` (mesmo NNN do plano original)

**Conteudo obrigatorio do prompt de handoff:**
1. Instrucao: "Analise os items abaixo que foram flagrados na triagem mecanica"
2. Lista de items `[PRECISA ANALISE]` com: item, criterio de aceite original, arquivo, trecho de codigo relevante
3. Caminho do relatorio de triagem (para o modelo atualizar com os resultados)
4. Instrucao: "Atualize o relatorio em {caminho} adicionando os resultados desta analise"
5. Instrucao: "Ao final, oferecer /create-execution-plan de correcao se houver inconsistencias"

**Regra:** o prompt DEVE ser autocontido — colar numa conversa nova com Sonnet/GPT-5.4 basta.

## TAXONOMIA E SEVERIDADES

Tipos: `nao_implementado` | `parcial` | `divergente` | `superficial` | `desatualizado` | `orfao`
Severidades: **BLOQUEANTE** (impede uso) > **LACUNA** (falta algo) > **DRIFT** (desalinhamento)

## RELATORIO

Salvar: `docs/05_decisions/reports/review_exec_{NNN}_{nome}_{YYYY-MM-DD}.md`

**Estrutura minima:**

```markdown
# Review Execution — {Nome}

Data: YYYY-MM-DD | Escopo: {scope} | Fonte: {caminho}

## Resumo Executivo
| Severidade | Qtd |
|------------|-----|
| BLOQUEANTE | N   |
| LACUNA     | N   |
| DRIFT      | N   |

Items verificados: N | Inconsistencias: N (X%)
Items [PRECISA ANALISE]: N (prompt de handoff: {caminho ou "nenhum"})

## Inconsistencias
| # | Item | Classif. | Tipo | Severidade | Arquivo | Evidencia |

## Acoes Recomendadas

### Correcoes rapidas (aplicar agora, Composer)
- [lista de DRIFTs e LACUNAs simples]

### Features complexas (execution plan, Opus)
- [lista com prompt de handoff: {caminho}]

### Analise profunda (Sonnet)
- [lista com prompt de handoff: {caminho}]
```

## ANTI-PATTERNS

Disparar automaticamente | Ler codebase inteiro | Subagentes com escopo amplo | Listar o que esta OK | Revisar e corrigir junto | Inventar inconsistencias | Subagentes editando codigo
