---
name: create-subagents
description: Cria subagentes Python seguindo padrão modular com early return e logs. Use quando criar scripts que precisam ser divididos em etapas independentes, validações, aplicações ou verificações.
---

# Create Subagents v2.0 (Generic)

## APLICAÇÃO AUTOMÁTICA OBRIGATÓRIA

**Esta skill DEVE ser aplicada automaticamente SEMPRE que detectar:**

- Script Python com mais de 200 linhas
- Script com múltiplas etapas independentes (validação, aplicação, verificação)
- Script que aplica migrations
- Script que processa dados em lotes
- Script com lógica complexa e múltiplas responsabilidades

## O Que São Subagentes

Subagentes são **classes Python** que encapsulam etapas independentes de uma tarefa maior. Cada subagente:
- Tem responsabilidade única e clara
- Retorna `Tuple[bool, Optional[str]]` (sucesso, erro)
- Usa **early return** para falhas
- Mantém estado interno quando necessário
- Usa logs com timestamp obrigatório

## Estrutura Padrão

**Se o projeto tiver uma biblioteca base de subagentes, USE-A.**
Caso contrário, use este padrão:

```python
from datetime import datetime
from typing import Tuple, Optional

class BaseSubagente:
    """Base para todos os subagentes"""
    
    def __init__(self, prefixo: str = ""):
        self.prefixo = prefixo
    
    def log(self, msg: str, emoji: str = "🔄"):
        ts = datetime.now().strftime('%H:%M:%S')
        prefix = f" {self.prefixo}" if self.prefixo else ""
        print(f"{emoji} [{ts}]{prefix} {msg}")
    
    def executar(self) -> Tuple[bool, Optional[str]]:
        raise NotImplementedError


class MeuSubagente(BaseSubagente):
    """Subagente X: Descrição clara da responsabilidade"""
    
    def __init__(self, parametros):
        super().__init__(prefixo="[SUBAGENTE X]")
        self.parametros = parametros
    
    def executar(self) -> Tuple[bool, Optional[str]]:
        self.log("Iniciando tarefa", "▶️")
        
        # Etapa 1
        self.log("Verificando condição X", "🔄")
        if not self._verificar():
            self.log("Condição X não atendida", "❌")
            return False, "Condição X não atendida"
        self.log("Condição X OK", "✅")
        
        self.log("Tarefa concluída", "🎉")
        return True, None
    
    def _verificar(self) -> bool:
        return True
```

## Orquestração

A função `main()` orquestra subagentes em sequência com **early return**:

```python
import sys
import time
from datetime import datetime

def log_ts(msg: str, emoji: str = "🔄"):
    ts = datetime.now().strftime('%H:%M:%S')
    print(f"{emoji} [{ts}] {msg}")

def main():
    inicio = time.time()
    log_ts("Iniciando tarefa completa (ET: 5m)", "▶️")
    
    # Subagente 1: Validação
    log_ts("Passo 1/3 — Validando", "🔄")
    validador = SubagenteValidacao(...)
    sucesso, erro = validador.executar()
    if not sucesso:
        log_ts(f"Falha na validação: {erro}", "❌")
        sys.exit(1)
    log_ts(f"Passo 1 concluído (⏱️ {time.time()-inicio:.1f}s)", "✅")
    
    # Subagente 2: Aplicação
    log_ts("Passo 2/3 — Aplicando", "🔄")
    aplicador = SubagenteAplicacao(...)
    sucesso, erro = aplicador.executar()
    if not sucesso:
        log_ts(f"Falha na aplicação: {erro}", "❌")
        sys.exit(1)
    log_ts(f"Passo 2 concluído (⏱️ {time.time()-inicio:.1f}s)", "✅")
    
    # Subagente 3: Verificação
    log_ts("Passo 3/3 — Verificando", "🔄")
    verificador = SubagenteVerificacao(...)
    sucesso, erro = verificador.executar()
    if not sucesso:
        log_ts(f"Verificação falhou: {erro}", "⚠️")
    
    total = time.time() - inicio
    log_ts(f"Execução concluída (⏱️ {total:.1f}s)", "🎉")

if __name__ == "__main__":
    main()
```

## Padrões de Nomeação

- Classes: `Subagente[Nome]` (ex: `SubagenteValidacao`, `SubagenteAplicacao`)
- Métodos principais: `executar()` retorna `Tuple[bool, Optional[str]]`
- Métodos auxiliares: `_metodo_privado()` (prefixo `_`)
- Métodos de acesso: `obter_[recurso]()` (ex: `obter_resultado()`)

## Quando Usar

- Script tem múltiplas etapas independentes
- Precisa de validação antes de aplicar mudanças
- Precisa verificar resultado após aplicação
- Tarefa pode falhar em pontos diferentes
- Quer reutilizar etapas em outros scripts

## Quando NÃO Usar

- Script muito simples (1-2 etapas)
- Todas as etapas são sequenciais sem validação
- Não há necessidade de reutilização

## Proibições Explícitas

- Criar subagente sem método `executar()`
- Criar subagente sem logs com timestamp
- Criar subagente sem early return em caso de erro
- Criar orquestração sem tratamento de erro

## Regra Final

Subagentes são modularidade.
Modularidade é clareza.
Clareza é manutenibilidade.
**Código monolítico é dívida técnica.**
