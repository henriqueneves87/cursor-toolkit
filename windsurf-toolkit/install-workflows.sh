#!/usr/bin/env bash
# install-workflows.sh
# Helper para instalar workflows do windsurf-toolkit em um projeto especifico

set -e

PROJECT_PATH="$1"
FORCE=false

if [[ "$2" == "--force" ]]; then
    FORCE=true
fi

TOOLKIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKFLOWS_SOURCE="$TOOLKIT_DIR/workflows"
WORKFLOWS_DEST="$PROJECT_PATH/.windsurf/workflows"

echo ""
echo "========================================"
echo "  Instalar Workflows no Projeto"
echo "========================================"
echo ""
echo "Projeto:   $PROJECT_PATH"
echo "Workflows: $WORKFLOWS_SOURCE"
echo ""

# Verificar argumentos
if [[ -z "$PROJECT_PATH" ]]; then
    echo "ERRO: Caminho do projeto nao fornecido"
    echo ""
    echo "Uso: ./install-workflows.sh /caminho/do/projeto [--force]"
    exit 1
fi

# Verificar se o projeto existe
if [[ ! -d "$PROJECT_PATH" ]]; then
    echo "ERRO: Projeto nao encontrado: $PROJECT_PATH"
    exit 1
fi

# Verificar se workflows source existe
if [[ ! -d "$WORKFLOWS_SOURCE" ]]; then
    echo "ERRO: Pasta workflows nao encontrada: $WORKFLOWS_SOURCE"
    exit 1
fi

# Criar diretorio .windsurf se nao existir
WINDSURF_DIR="$PROJECT_PATH/.windsurf"
if [[ ! -d "$WINDSURF_DIR" ]]; then
    mkdir -p "$WINDSURF_DIR"
    echo "Criado: .windsurf/"
fi

# Verificar se workflows ja existe
if [[ -d "$WORKFLOWS_DEST" ]]; then
    if [[ "$FORCE" == true ]]; then
        BACKUP="$WORKFLOWS_DEST"_backup_$(date +%Y%m%d_%H%M%S)
        mv "$WORKFLOWS_DEST" "$BACKUP"
        echo "Backup criado: $BACKUP"
    else
        echo "AVISO: .windsurf/workflows ja existe no projeto"
        echo "Use --force para sobrescrever (criara backup)"
        exit 1
    fi
fi

# Copiar workflows
cp -r "$WORKFLOWS_SOURCE" "$WORKFLOWS_DEST"
COUNT=$(find "$WORKFLOWS_DEST" -type f | wc -l)

echo ""
echo "========================================"
echo "  Workflows instalados!"
echo "========================================"
echo ""
echo "$COUNT workflows copiados para:"
echo "  $WORKFLOWS_DEST"
echo ""
echo "Use no Cascade com: /nome-do-workflow"
echo ""
echo "Exemplos:"
echo "  /context-boot"
echo "  /apply-conventions"
echo "  /create-execution-plan"
echo ""
