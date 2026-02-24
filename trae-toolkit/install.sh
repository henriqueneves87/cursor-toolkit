#!/usr/bin/env bash
# trae-toolkit install.sh
# Instala project_rules.md no diretorio .trae/ do projeto alvo

set -euo pipefail

TOOLKIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="$TOOLKIT_DIR/project_rules.md"
FORCE=false
PROJECT_PATH=""

# Parsear argumentos
while [[ $# -gt 0 ]]; do
    case "$1" in
        --force|-f)
            FORCE=true
            shift
            ;;
        -*)
            echo "Opcao desconhecida: $1"
            echo "Uso: ./install.sh /caminho/do/projeto [--force]"
            exit 1
            ;;
        *)
            PROJECT_PATH="$1"
            shift
            ;;
    esac
done

echo ""
echo "========================================"
echo "  trae-toolkit - Instalacao"
echo "========================================"
echo ""

# Validar argumentos
if [[ -z "$PROJECT_PATH" ]]; then
    echo "ERRO: Caminho do projeto nao informado."
    echo "Uso: ./install.sh /caminho/do/projeto [--force]"
    exit 1
fi

TRAE_DIR="$PROJECT_PATH/.trae"
DEST_FILE="$TRAE_DIR/project_rules.md"

echo "Projeto:  $PROJECT_PATH"
echo "Destino:  $DEST_FILE"
echo ""

# Validar projeto alvo
if [[ ! -d "$PROJECT_PATH" ]]; then
    echo "ERRO: Diretorio do projeto nao encontrado: $PROJECT_PATH"
    exit 1
fi

# Validar arquivo fonte
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "ERRO: project_rules.md nao encontrado em: $SOURCE_FILE"
    exit 1
fi

# Criar .trae/ se nao existir
if [[ ! -d "$TRAE_DIR" ]]; then
    mkdir -p "$TRAE_DIR"
    echo "Criado: .trae/"
fi

# Verificar se ja existe
if [[ -f "$DEST_FILE" ]]; then
    if [[ "$FORCE" == "true" ]]; then
        BACKUP="$DEST_FILE.backup_$(date +%Y%m%d_%H%M%S)"
        cp "$DEST_FILE" "$BACKUP"
        echo "Backup criado: $BACKUP"
        cp "$SOURCE_FILE" "$DEST_FILE"
        echo "project_rules.md atualizado"
    else
        echo "project_rules.md ja existe em .trae/"
        echo "Use --force para sobrescrever (backup automatico sera criado)."
        exit 0
    fi
else
    cp "$SOURCE_FILE" "$DEST_FILE"
    echo "project_rules.md instalado"
fi

echo ""
echo "========================================"
echo "  Instalacao concluida!"
echo "========================================"
echo ""
echo "Instalado em: $DEST_FILE"
echo ""
echo "O Trae IDE carregara as regras automaticamente."
echo ""
echo "Para atualizar: ./install.sh \"$PROJECT_PATH\" --force"
echo ""
