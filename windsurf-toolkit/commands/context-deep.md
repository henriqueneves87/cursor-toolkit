# context-deep — Context Engineering DEEP

Leitura cirúrgica de arquivos específicos para análise detalhada.

---

## Uso

```
/context-deep files="<arquivo1,arquivo2,...>" [lines="<ini-fim>"]
```

**Exemplos:**
```
/context-deep files="src/api/auth.py"
/context-deep files="src/api/auth.py,src/utils/validation.py"
/context-deep files="src/api/auth.py" lines="50-100"
```

---

## Objetivo

Leitura pontual e detalhada de arquivos específicos com custo controlado (<=600 tokens).

---

## Comportamento

### 1. Confirmar objetivo

Perguntar ao usuário (se não estiver claro):
> "Qual é o objetivo desta leitura? (ex: entender função X, analisar bug Y, validar implementação Z)"

### 2. Ler apenas arquivos/trechos indicados

- Ler arquivos especificados
- Se `lines` fornecido, ler apenas intervalo indicado
- Se arquivo muito grande, sintetizar seções menos relevantes

### 3. Gerar Context Pack DEEP

**Formato obrigatório:**

```markdown
# Context Pack DEEP — [Arquivo(s)]

**Data:** YYYY-MM-DD HH:MM:SS
**Arquivo(s):** [lista de arquivos]
**Linhas:** [intervalo, se aplicável]

## Objetivo da Leitura
[objetivo específico]

## Regras Identificadas
- [regra 1]
- [regra 2]

## Decisões Técnicas
- [decisão 1]
- [decisão 2]

## Padrões Observados
- [padrão 1]
- [padrão 2]

## Problemas Potenciais
- [problema 1]
- [problema 2]

## Oportunidades de Melhoria
- [oportunidade 1]
- [oportunidade 2]

## Resumo Executivo
[resumo em <=10 linhas do que foi encontrado]
```

---

## Token Budget

**Máximo:** <=600 tokens

---

## Regras

- Ler apenas arquivos/trechos especificados
- Não fazer dump completo se arquivo muito grande
- Sintetizar e extrair insights ao invés de copiar texto
- Converter texto bruto em conhecimento estruturado

---

## Saída Final

> "Análise DEEP concluída. Posso seguir para próxima ação ou precisa de mais detalhes?"

---

## Integração

- `context-boot` — contexto mínimo (executar primeiro)
- `context-focus` — contexto por tipo de tarefa
