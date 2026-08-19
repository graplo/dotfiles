#!/usr/bin/env bash

echo "🚀 Instalando herramientas y LSPs para Helix..."

# 1. Servidores desde Repositorios Oficiales (Pacman)
sudo pacman -S --needed \
  helix \
  bash-language-server shellcheck shfmt \
  pyright ruff \
  gopls \
  rust-analyzer \
  clangd \
  marksman kdl-lsp \
  lua-language-server \
  vscode-json-languageserver vscode-html-languageserver

# 2. Servidores desde AUR (usando paru o yay)
if command -v paru &> /dev/null; then
    paru -S --needed fish-lsp
elif command -v yay &> /dev/null; then
    yay -S --needed fish-lsp
else
    echo "⚠️  No se encontró paru ni yay. Recuerda instalar 'fish-lsp' manualmente desde AUR."
fi

echo "✅ ¡Todo instalado y listo para usar con Helix!"
