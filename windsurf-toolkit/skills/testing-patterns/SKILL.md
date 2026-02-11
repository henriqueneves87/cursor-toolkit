---
name: testing-patterns
description: Padrões para criar testes efetivos com arrange-act-assert, edge cases e testes narrativos. Use quando criar testes unitários, de integração ou end-to-end.
---

# Testing Patterns

## Aplicação Automática

Aplicar quando detectar:
- Criação de arquivos `test_*.py` ou `*_test.py`
- Solicitação de testes para código existente
- Bug fix que precisa de teste de regressão

## Padrão AAA (Arrange-Act-Assert)

Todo teste DEVE seguir:

```python
def test_calculo_desconto_aplica_percentual():
    # Arrange — preparar dados e dependências
    preco = 100.0
    desconto = 0.15
    
    # Act — executar a função sob teste
    resultado = calcular_preco_final(preco, desconto)
    
    # Assert — verificar resultado
    assert resultado == 85.0
```

## Categorias de Teste Obrigatórias

Para cada função crítica, criar testes em 3 categorias:

### 1. Happy Path (caso normal)

```python
def test_login_com_credenciais_validas_retorna_token():
    token = login("user@email.com", "senha_correta")
    assert token is not None
    assert len(token) > 0
```

### 2. Error Cases (caso de erro)

```python
def test_login_com_senha_errada_levanta_erro():
    with pytest.raises(AuthenticationError, match="senha inválida"):
        login("user@email.com", "senha_errada")
```

### 3. Edge Cases (casos limítrofes)

```python
def test_login_com_email_vazio_levanta_erro():
    with pytest.raises(ValueError):
        login("", "senha")

def test_login_com_none_levanta_type_error():
    with pytest.raises(TypeError):
        login(None, "senha")

def test_calculo_desconto_zero_retorna_preco_original():
    assert calcular_preco_final(100.0, 0.0) == 100.0

def test_calculo_desconto_100_percent_retorna_zero():
    assert calcular_preco_final(100.0, 1.0) == 0.0
```

## Nomeação

Formato: `test_[o_que]_[condição]_[resultado_esperado]`

```python
# BOM — descritivo
def test_calculate_total_with_empty_cart_returns_zero():
def test_validate_email_with_missing_at_returns_false():
def test_process_batch_with_timeout_raises_error():

# RUIM — vago
def test_1():
def test_calculate():
def test_it():
```

## Fixtures e Factories

```python
import pytest

@pytest.fixture
def usuario_valido():
    return {"email": "test@example.com", "nome": "Test User"}

@pytest.fixture
def banco_em_memoria():
    db = criar_banco_memoria()
    yield db
    db.limpar()

def test_criar_usuario(banco_em_memoria, usuario_valido):
    resultado = criar_usuario(banco_em_memoria, usuario_valido)
    assert resultado.id is not None
```

## Testes com Logs Narrativos

Para testes longos, incluir progresso:

```python
def test_pipeline_completo():
    log_ts("Teste 1/3 — Preparando dados", "🔄")
    dados = preparar_dados_teste()
    assert len(dados) > 0
    log_ts("Teste 1/3 concluído", "✅")
    
    log_ts("Teste 2/3 — Processando pipeline", "🔄")
    resultado = processar_pipeline(dados)
    assert resultado.status == "sucesso"
    log_ts("Teste 2/3 concluído", "✅")
    
    log_ts("Teste 3/3 — Validando resultados", "🔄")
    assert validar_resultados(resultado)
    log_ts("Teste 3/3 concluído", "✅")
```

## Invariantes de Testes

- Testes DEVEM ser independentes (sem estado compartilhado mutável)
- Testes DEVEM ser determinísticos (mesmo resultado toda vez)
- Testes DEVEM ser rápidos (evitar I/O desnecessário)
- Testes DEVEM testar comportamento, não implementação
- Mock externo, não interno (mock API, não função interna)

## Proibições

- Testes sem assertions
- Testes que dependem de ordem de execução
- Testes que dependem de dados de produção
- Nomes de teste não descritivos
- Tests que testam implementação interna em vez de comportamento

## Regra Final

Teste é documentação executável.
Teste sem nome claro é documentação ilegível.
**Código sem teste é código com prazo de validade.**
