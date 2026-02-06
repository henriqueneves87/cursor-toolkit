#!/bin/bash
# cursor-toolkit install.sh
# Cria symlinks do cursor-toolkit para os diretórios globais do Cursor
# Uso: ./install.sh [--copy] [--force] [--uninstall]

set -e

TOOLKIT_DIR="$(cd "$(dirname "$0")" && pwd)"
CURSOR_DIR="$HOME/.cursor"

FORCE=false
COPY=false
UNINSTALL=false

for arg in "$@"; do
    case $arg in
        --force)  FORCE=true ;;
        --copy)   COPY=true ;;
        --uninstall) UNINSTALL=true ;;
        *)
            echo "Uso: $0 [--copy] [--force] [--uninstall]"
            exit 1
            ;;
    esac
done

echo ""
echo "========================================"
echo "  cursor-toolkit — Instalação"
echo "========================================"
echo ""
echo "Toolkit: $TOOLKIT_DIR"
echo "Cursor:  $CURSOR_DIR"
echo ""

# Verificar se o diretório do Cursor existe
if [ ! -d "$CURSOR_DIR" ]; then
    echo "ERRO: Diretório do Cursor não encontrado: $CURSOR_DIR"
    echo "Verifique se o Cursor está instalado."
    exit 1
fi

TARGETS=("skills" "commands" "agents")

# --- UNINSTALL ---
if $UNINSTALL; then
    echo "Removendo instalação..."
    for name in "${TARGETS[@]}"; do
        dst="$CURSOR_DIR/$name"
        if [ -L "$dst" ]; then
            rm "$dst"
            echo "  Removido symlink: $name"
        elif [ -d "$dst" ]; then
            echo "  AVISO: $dst não é symlink, não removido"
        else
            echo "  $name — não encontrado, ignorando"
        fi
    done
    echo ""
    echo "Desinstalação concluída."
    exit 0
fi

# --- INSTALL ---
for name in "${TARGETS[@]}"; do
    src="$TOOLKIT_DIR/$name"
    dst="$CURSOR_DIR/$name"
    
    echo "Configurando $name..."
    
    if [ -e "$dst" ]; then
        if [ -L "$dst" ]; then
            # Já é symlink
            if $FORCE; then
                rm "$dst"
                echo "  Symlink existente removido (--force)"
            else
                echo "  Symlink já existe. Use --force para substituir."
                continue
            fi
        else
            # Diretório real
            if $FORCE; then
                backup="${dst}_backup_$(date +%Y%m%d_%H%M%S)"
                mv "$dst" "$backup"
                echo "  Backup criado: $backup"
            elif $COPY; then
                echo "  Diretório existe. Copiando arquivos..."
                cp -r "$src"/* "$dst"/
                echo "  Arquivos copiados para $dst"
                continue
            else
                echo "  Diretório já existe. Use --force ou --copy"
                continue
            fi
        fi
    fi
    
    if $COPY; then
        mkdir -p "$dst"
        cp -r "$src"/* "$dst"/
        echo "  Copiado para: $dst"
    else
        ln -s "$src" "$dst"
        echo "  Symlink criado: $dst -> $src"
    fi
done

echo ""
echo "========================================"
echo "  Instalação concluída!"
echo "========================================"
echo ""
echo "Opções disponíveis:"
echo "  ./install.sh              — Instalar (symlinks)"
echo "  ./install.sh --copy       — Instalar (cópia)"
echo "  ./install.sh --force      — Reinstalar (backup do existente)"
echo "  ./install.sh --uninstall  — Remover instalação"
echo ""
echo "Para atualizar (symlinks): git pull"
echo "Para atualizar (cópia):    git pull && ./install.sh --copy --force"
