# audit-response

# audit-response — AUDITORIA DE RESPOSTA DA IA

Versão: 1.0  
Tipo: Command  
Uso: Manual (invocado pelo usuário)

## Quando usar

- quando a resposta da IA parecer estranha
- quando algo violar a convenção
- quando houver dúvida se as rules foram seguidas
- para corrigir sem refazer tudo do zero

## Como usar

Digite o comando isoladamente:

audit-response

## Comportamento obrigatório da IA

- auditar a **resposta imediatamente anterior**
- verificar aderência a:
  - Convenção Oficial
  - AI Governance
  - Commands aplicáveis
- listar explicitamente:
  - o que foi cumprido
  - o que foi violado
- corrigir **apenas** o que estiver em desacordo
- não introduzir mudanças novas além da correção

## Formato obrigatório da resposta

1. Checklist de conformidade  
2. Lista de violações (se houver)  
3. Correção objetiva  

## Exemplo de uso

audit-response
