---
name: error-handling-patterns
description: Padrões de tratamento de erro com early return, erros explícitos e propagação adequada. Use quando criar código que precisa de tratamento de erro robusto, especialmente scripts, APIs e processamento de dados.
---

# Error Handling Patterns

## Aplicação Automática

Aplicar quando detectar:
- Código com blocos try/except
- Funções que podem falhar (I/O, rede, banco de dados)
- Scripts de processamento de dados
- APIs e endpoints

## Princípios Fundamentais

1. **Erros explícitos > erros silenciosos** — nunca engolir exceções
2. **Early return > deep nesting** — falhar cedo, falhar claro
3. **Sem fallback oculto** — se falhar, dizer que falhou
4. **Contexto no erro** — o que falhou, por que, o que fazer

## Padrões Obrigatórios

### 1. Early Return

```python
# BOM — Early return
def processar(dados):
    if not dados:
        return None, "Dados vazios"
    
    if not validar(dados):
        return None, "Dados inválidos"
    
    resultado = transformar(dados)
    return resultado, None

# RUIM — Deep nesting
def processar(dados):
    if dados:
        if validar(dados):
            resultado = transformar(dados)
            return resultado, None
        else:
            return None, "Dados inválidos"
    else:
        return None, "Dados vazios"
```

### 2. Exceções Específicas

```python
# BOM — exceção específica com contexto
try:
    resultado = conectar_banco(config)
except ConnectionError as e:
    log_ts(f"Falha na conexão: {e}", "❌")
    raise
except TimeoutError as e:
    log_ts(f"Timeout na conexão ({config.timeout}s): {e}", "❌")
    raise

# RUIM — catch genérico silencioso
try:
    resultado = conectar_banco(config)
except Exception:
    pass  # ❌ NUNCA
```

### 3. Padrão Result (Tuple)

Para funções que podem falhar sem exceção:

```python
from typing import Tuple, Optional

def operacao() -> Tuple[bool, Optional[str]]:
    """Retorna (sucesso, mensagem_erro)"""
    if not condicao:
        return False, "Condição não atendida"
    
    # ... processamento ...
    return True, None

# Uso
sucesso, erro = operacao()
if not sucesso:
    log_ts(f"Falha: {erro}", "❌")
    sys.exit(1)
```

### 4. Contexto no Erro

```python
# BOM — erro com contexto
raise ValueError(
    f"Valor inválido para campo 'idade': {valor}. "
    f"Esperado: inteiro positivo. Recebido: {type(valor).__name__}"
)

# RUIM — erro genérico
raise ValueError("valor inválido")
```

### 5. Cleanup com Finally

```python
def processar_arquivo(caminho):
    arquivo = None
    try:
        arquivo = open(caminho, 'r')
        dados = arquivo.read()
        return processar(dados)
    except FileNotFoundError:
        log_ts(f"Arquivo não encontrado: {caminho}", "❌")
        return None, f"Arquivo não encontrado: {caminho}"
    finally:
        if arquivo:
            arquivo.close()

# Ou melhor: usar context manager
def processar_arquivo(caminho):
    try:
        with open(caminho, 'r') as arquivo:
            dados = arquivo.read()
            return processar(dados)
    except FileNotFoundError:
        return None, f"Arquivo não encontrado: {caminho}"
```

## Anti-Patterns (PROIBIDOS)

```python
# 1. Catch genérico silencioso
except Exception:
    pass

# 2. Fallback oculto que mascara erro
except Exception:
    return valor_padrao  # O chamador nunca sabe que falhou

# 3. Log sem ação
except Exception as e:
    print(f"Erro: {e}")  # E depois? Continua como se nada tivesse acontecido?

# 4. Re-raise sem contexto
except Exception:
    raise  # OK se realmente não há contexto a adicionar
```

## Proibições

- Nunca usar `except: pass` ou `except Exception: pass`
- Nunca esconder falhas com fallbacks silenciosos
- Nunca gerar erros sem contexto (o que, por que, como resolver)
- Nunca usar deep nesting quando early return resolve

## Regra Final

Erro explícito é documentação viva.
Erro silencioso é dívida técnica invisível.
**Código que falha claro é código confiável.**
