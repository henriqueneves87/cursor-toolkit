#!/bin/bash
# cursor-toolkit install.sh
# Copia rules, skills, commands e agents para .cursor/ dentro do projeto destino.
# Uso: ./install.sh --project-path /caminho/do/projeto [--force] [--uninstall]
set -e

TOOLKIT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_PATH=""
FORCE=false
UNINSTALL=false

# Parser de argumentos
while [[ $# -gt 0 ]]; do
    case "$1" in
        --project-path)
            PROJECT_PATH="$2"
            shift 2
            ;;
        --project-path=*)
            PROJECT_PATH="${1#*=}"
            shift
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --uninstall)
            UNINSTALL=true
            shift
            ;;
        *)
            echo "Opcao desconhecida: $1"
            echo "Uso: $0 --project-path /caminho/do/projeto [--force] [--uninstall]"
            exit 1
            ;;
    esac
done

if [ -z "$PROJECT_PATH" ]; then
    echo "ERRO: --project-path e obrigatorio."
    echo "Uso: $0 --project-path /caminho/do/projeto [--force] [--uninstall]"
    exit 1
fi

CURSOR_DIR="$PROJECT_PATH/.cursor"

echo ""
echo "cursor-toolkit — Instalacao no projeto"
echo "======================================="
echo ""
echo "Toolkit: $TOOLKIT_DIR"
echo "Projeto: $PROJECT_PATH"
echo "Destino: $CURSOR_DIR"
echo ""

if [ ! -d "$PROJECT_PATH" ]; then
    echo "ERRO: Caminho do projeto nao encontrado: $PROJECT_PATH"
    exit 1
fi

TARGETS=("skills" "commands" "agents")

# --- UNINSTALL ---
if $UNINSTALL; then
    echo "Removendo instalacao do projeto..."
    for name in "${TARGETS[@]}"; do
        dst="$CURSOR_DIR/$name"
        if [ -d "$dst" ]; then
            rm -rf "$dst"
            echo "  Removido: $name"
        else
            echo "  $name — nao encontrado, ignorando"
        fi
    done
    if [ -d "$CURSOR_DIR/rules" ]; then
        rm -rf "$CURSOR_DIR/rules"
        echo "  Removido: rules"
    else
        echo "  rules — nao encontrado, ignorando"
    fi
    echo ""
    echo "Desinstalacao concluida."
    exit 0
fi

# --- INSTALL ---
declare -A TOTAL_COPIED
TOTAL_COPIED[skills]=0
TOTAL_COPIED[commands]=0
TOTAL_COPIED[agents]=0
TOTAL_COPIED[rules]=0

for name in "${TARGETS[@]}"; do
    src="$TOOLKIT_DIR/$name"
    dst="$CURSOR_DIR/$name"

    echo "Configurando $name..."

    if [ -d "$dst" ]; then
        if $FORCE; then
            backup="${dst}_backup_$(date +%Y%m%d_%H%M%S)"
            mv "$dst" "$backup"
            echo "  Backup criado: $backup"
        else
            echo "  Ja existe. Use --force para sobrescrever com backup."
            continue
        fi
    fi

    mkdir -p "$dst"
    cp -r "$src"/. "$dst"/
    count=$(find "$dst" -type f | wc -l | tr -d ' ')
    TOTAL_COPIED[$name]=$count
    echo "  Copiado: $dst ($count arquivos)"
done

# --- RULES (.mdc, exceto project-specific-template.mdc) ---
echo "Configurando rules..."
RULES_SRC="$TOOLKIT_DIR/rules"
RULES_DST="$CURSOR_DIR/rules"

if [ -d "$RULES_DST" ]; then
    if $FORCE; then
        backup="${RULES_DST}_backup_$(date +%Y%m%d_%H%M%S)"
        mv "$RULES_DST" "$backup"
        echo "  Backup criado: $backup"
    else
        echo "  Ja existe. Use --force para sobrescrever com backup."
    fi
fi

mkdir -p "$RULES_DST"

rule_count=0
for f in "$RULES_SRC"/*.mdc; do
    fname="$(basename "$f")"
    if [ "$fname" != "project-specific-template.mdc" ]; then
        cp "$f" "$RULES_DST/"
        rule_count=$((rule_count + 1))
    fi
done
TOTAL_COPIED[rules]=$rule_count
echo "  Copiado: $RULES_DST ($rule_count arquivos)"

echo ""
echo "======================================="
echo "  Instalacao concluida!"
echo "======================================="
echo ""
echo "Resumo de arquivos copiados:"
echo "  rules:    ${TOTAL_COPIED[rules]}"
echo "  skills:   ${TOTAL_COPIED[skills]}"
echo "  commands: ${TOTAL_COPIED[commands]}"
echo "  agents:   ${TOTAL_COPIED[agents]}"
echo ""
echo "Opcoes disponiveis:"
echo "  ./install.sh --project-path <caminho>            — Instalar no projeto"
echo "  ./install.sh --project-path <caminho> --force    — Reinstalar (backup do existente)"
echo "  ./install.sh --project-path <caminho> --uninstall — Remover instalacao"
echo ""
echo "Para atualizar: git pull && ./install.sh --project-path <caminho> --force"
