# ~ / .config / fish / config.fish

# Rutas de binarios (Equivalente a lo que tenías en .bashrc)
# fish_add_path es inteligente y no duplica rutas si ya existen
fish_add_path $HOME/.local/bin $HOME/bin $HOME/.cargo/bin

if status is-interactive
    # 1. Aplicar el tema Catppuccin Mocha
    fish_config theme choose Dracula

    # 2. Inicializar Zoxide
    zoxide init fish | source

    # 3. Integración de Ghostty (mejorada)
    if set -q GHOSTTY_RESOURCES_DIR
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
    end
end

# 4. Función Yazi (Tu función para cambiar de directorio al salir)
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# para iniciar starship con los colores dracula
starship init fish | source
