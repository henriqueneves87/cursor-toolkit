# Plano: [NOME_DESCRITIVO]

Fase: [N | Hotfix]
Status: NAO INICIADO | EM ANDAMENTO | CONCLUIDO
Ultima atualizacao: YYYY-MM-DD
Pre-requisitos: [lista ou "nenhum"]

---

## Objetivo

[1-2 frases descrevendo o resultado esperado ao concluir este plano]

---

## Diagnostico (obrigatorio para bugs/hotfixes)

### Causa raiz

[Descricao clara e concisa da causa raiz]

### Evidencias

**Logs:**
```
[Trecho relevante do log de erro]
```

**Estado do banco:**

| Campo/Coluna | Valor esperado | Valor atual | Status |
|--------------|---------------|-------------|--------|
| [campo] | [esperado] | [atual] | OK/FALHA |

**Codigo afetado:**
```
Arquivo: [caminho/arquivo.py], linhas [N-M]
[trecho do codigo com o problema]
```

---

## Decisoes tecnicas

| Decisao | Escolha | Justificativa |
|---------|---------|---------------|
| [decisao 1] | [escolha] | [por que] |

---

## Tarefas

### T1 -- [Nome da tarefa]

- **Complexidade:** baixa | media | alta
- **Arquivos:** `[caminho/arquivo1.py]`, `[caminho/arquivo2.ts]`
- **Depende de:** nenhuma
- **Status:** pendente
- **Criterio de aceite:** [frase verificavel]
- **Notas para IA:**

  No arquivo `[caminho/arquivo.py]`, funcao `[nome_funcao()]`, localizar o bloco:

  ```python
  # ANTES (codigo atual):
  [codigo existente]
  ```

  **Alterar para:**

  ```python
  # DEPOIS (codigo novo):
  [codigo novo]
  ```

  **Restricoes:**
  - [restricao 1]
  - [restricao 2]

---

### T2 -- [Nome da tarefa]

- **Complexidade:** [nivel]
- **Arquivos:** `[caminho/arquivo.ext]`
- **Depende de:** T1
- **Status:** pendente
- **Criterio de aceite:** [frase verificavel]
- **Notas para IA:**

  [Instrucoes detalhadas e especificas]

---

## Ordem de execucao

```
Bloco A ([descricao]):
  T1 + T2 (paralelo) → T3

Bloco B ([descricao]):
  T4 → T5

Sequencia completa:
  [Bloco A] → [Bloco B] → deploy
```

---

## Notas para IA

1. **[Recurso/ID]:** [valor] — [para que serve]
2. **Convencao:** [padrao do projeto relevante]
3. **Restricao:** [o que NAO fazer]
4. **Deploy:** [como o deploy funciona]
5. **Skills aplicaveis:** [code-with-logs, create-subagents, etc.]

---

## Metricas de sucesso

- [Metrica verificavel 1]
- [Metrica verificavel 2]
- [Metrica verificavel 3]
