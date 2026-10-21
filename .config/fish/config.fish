source /usr/share/cachyos-fish-config/cachyos-config.fish

# Rutas
fish_add_path $HOME/.local/bin $HOME/.cargo/bin $HOME/.npm-global/bin $HOME/go/bin

# Variables de entorno
set -gx EDITOR helix
set -gx VISUAL helix
set -gx QT_QPA_PLATFORMTHEME gtk3
set -gx BAT_THEME Dracula
set -Ux FZF_DEFAULT_OPTS_FILE ~/.config/fzf/fzf.conf

# Desactivar el saludo/fastfetch de CachyOS
function fish_greeting
end

# Función para Yazi (cambio de directorio al salir)
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Configuración interactiva
if status is-interactive
    # Aplica Dracula Official en cada nueva sesión interactiva,
    # asegurando que CachyOS no restablezca sus propios colores.
    fish_config theme choose "Dracula Official"

    set -gx LS_COLORS (vivid generate dracula)
    zoxide init fish | source
    starship init fish | source
end
