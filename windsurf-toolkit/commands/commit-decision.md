# commit-decision

# commit-decision — AVALIACAO DE COMMIT

Versão: 1.0  
Tipo: Command  
Uso: Manual (invocado pelo usuário)

## Quando usar

- após testes exploratórios
- após scripts temporários
- após validação de hipótese
- quando houver dúvida se algo deve ser versionado
- antes de sugerir um commit

## Como usar

Digite o comando antes da solicitação:

commit-decision

## Comportamento obrigatório da IA

- avaliar o **critério de valor**
- classificar o artefato em exatamente **uma** categoria:
  - **nao-commitar**
  - **commit-agrupado**
  - **commit-obrigatorio**
- justificar objetivamente a classificação
- **não sugerir commit** se a classificação for `nao-commitar`
- **sugerir mensagem de commit** apenas se aplicável

## Critério de Valor (Obrigatório)

Um artefato deve ser commitado **apenas se** atender a pelo menos um:

- tem valor permanente
- registra decisão técnica
- entra em produção
- será útil para auditoria ou replicação futura

Artefatos exploratórios ou descartáveis **não devem** ser commitados.

## Exemplo de uso

commit-decision  
Esse script de teste deve virar commit?
