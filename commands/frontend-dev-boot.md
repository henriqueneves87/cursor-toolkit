# frontend-dev-boot — Setup padronizado (frontend)

Objetivo: levantar ambiente local de frontend **sem drift**, com portas fixas e validações rápidas.

> Este command é um **template**. Ajuste as portas conforme seu projeto.

## Checklist rápido
- [ ] API respondendo em `/health`
- [ ] `.env.local` do(s) frontend(s) aponta para API local
- [ ] Nenhuma porta em uso (`EADDRINUSE`)

## Subir (ordem recomendada)

### API (exemplo)
```bash
uvicorn src.main:app --reload --port 8000
```

### Frontend (exemplo)
```bash
rm -rf .next
npm run dev
```

## Diagnóstico rápido (se 500/404)
- Confirmar que não há outro processo ocupando a porta.
- Limpar `.next` e reiniciar.
- Capturar stack trace do terminal e identificar segmento (layout/page/component).

