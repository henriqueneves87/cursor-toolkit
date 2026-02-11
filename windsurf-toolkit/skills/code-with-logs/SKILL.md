---
name: code-with-logs
description: Generates executable code with narrative logs including timestamp [HH:MM:SS]. Use for scripts, tests, jobs, ETLs, migrations requiring progress tracking.
---

# Code with Logs v3.0 (Generic)

## APLICAÇÃO AUTOMÁTICA OBRIGATÓRIA

**Esta skill DEVE ser aplicada automaticamente SEMPRE que detectar:**

- Criação de novo script Python executável
- Criação de novo teste (`test_*.py`)
- Criação de subagente (classe com método `executar()` ou `execute()`)
- Criação de job/ETL (função `main()` ou similar)
- Criação de migration SQL
- Qualquer código executável com função `main()` ou chamável diretamente

**NÃO é necessário comando explícito do usuário.**

## Regra de Ouro (INQUEBRÁVEL)

> **Log de progresso NÃO é log técnico.**

- NÃO usar `[module][function]`
- NÃO usar colchetes `[]` como prefixo
- NÃO usar logger padrão de debug
- NÃO misturar progresso com dados detalhados

## Instruções Obrigatórias

SEMPRE que gerar código executável, inclua logs narrativos com **timestamp obrigatório `[HH:MM:SS]`**.

### Timestamp Obrigatório

**TODOS os logs importantes DEVEM incluir timestamp:**

- Logs de início
- Logs de progresso
- Logs de conclusão
- Logs de finalização
- Logs de erro

### Helper Python (Adaptável ao Projeto)

**Se o projeto tiver um helper de logs, USE-O.** Exemplos comuns:

```python
# Se o projeto tem LoggerComTimestamp:
from app.utils.log_helpers import LoggerComTimestamp
logger = LoggerComTimestamp()

# Se o projeto não tem helper, use inline:
from datetime import datetime

def log_ts(msg: str, emoji: str = "🔄"):
    ts = datetime.now().strftime('%H:%M:%S')
    print(f"{emoji} [{ts}] {msg}")
```

**Prioridade:** helper do projeto > helper inline > print com timestamp manual.

### Formato de Logs (Python)

**Saída esperada:**
```
▶️ [14:23:15] Iniciando processamento de dados (ET: 2m)
🔄 [14:23:18] Passo 1/5 — Carregando arquivos (ETA: 90s)
✅ [14:23:25] Passo 1 concluído (⏱️ 10.2s)
🎉 [14:25:13] Execução concluída (⏱️ 118.5s | Início: 14:23:15 | Fim: 14:25:13)
```

### Formato de Logs (SQL)

**SEMPRE inclua timestamp em RAISE NOTICE:**

```sql
DECLARE
    v_inicio TIMESTAMP := clock_timestamp();
    v_agora TIMESTAMP;
BEGIN
    RAISE NOTICE '[%] ▶️ Iniciando processamento', TO_CHAR(v_inicio, 'HH24:MI:SS');
    
    v_agora := clock_timestamp();
    RAISE NOTICE '[%] 🔄 Passo 1/5 — Processando (ETA: 40s)', TO_CHAR(v_agora, 'HH24:MI:SS');
    
    v_agora := clock_timestamp();
    RAISE NOTICE '[%] ✅ Passo 1 concluído (⏱️ %s)', 
        TO_CHAR(v_agora, 'HH24:MI:SS'),
        EXTRACT(EPOCH FROM (v_agora - v_inicio))::INTEGER || 's';
END;
```

### Subagentes com Timestamp

Quando criar subagentes, use prefixo no logger:

```python
# Com helper do projeto:
logger = LoggerComTimestamp(prefixo="[SUBAGENTE 1]")

# Ou inline:
def log_sub(msg, emoji="🔄", prefix="[SUBAGENTE 1]"):
    ts = datetime.now().strftime('%H:%M:%S')
    print(f"{emoji} [{ts}] {prefix} {msg}")
```

### Logs de Erro

**SEMPRE inclua timestamp e contexto em logs de erro:**

```
❌ [14:24:30] Erro: Falha ao processar lote 4/10
❌ [14:24:30] Motivo: timeout na persistência
❌ [14:24:30] Ação: execução interrompida
```

## Exemplo Completo (Python Genérico)

```python
from datetime import datetime
import time

def log_ts(msg: str, emoji: str = "🔄"):
    ts = datetime.now().strftime('%H:%M:%S')
    print(f"{emoji} [{ts}] {msg}")

def main():
    inicio = time.time()
    log_ts("Iniciando processamento de dados (ET: 2m)", "▶️")
    
    # Passo 1
    log_ts("Passo 1/3 — Carregando dados (ETA: 60s)", "🔄")
    # ... código ...
    log_ts(f"Passo 1 concluído (⏱️ {time.time()-inicio:.1f}s)", "✅")
    
    # Passo 2
    log_ts("Passo 2/3 — Processando (ETA: 45s)", "🔄")
    # ... código ...
    log_ts(f"Passo 2 concluído (⏱️ {time.time()-inicio:.1f}s)", "✅")
    
    # Passo 3
    log_ts("Passo 3/3 — Finalizando (ETA: 15s)", "🔄")
    # ... código ...
    
    total = time.time() - inicio
    log_ts(f"Execução concluída (⏱️ {total:.1f}s)", "🎉")

if __name__ == "__main__":
    main()
```

## Proibições Explícitas

- Criar código executável sem logs
- Criar logs sem timestamp
- SQL sem timestamp em RAISE NOTICE
- Scripts longos sem indicação de progresso

## Regra Final

Sistema sem narrativa é sistema cego.
Código que executa sem log não é confiável.
**Logs sem timestamp não são rastreáveis.**
