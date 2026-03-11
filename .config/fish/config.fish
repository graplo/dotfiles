source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
# Rutas
fish_add_path $HOME/.local/bin $HOME/.cargo/bin

if status is-interactive
    fish_config theme choose Dracula
    zoxide init fish | source
    if set -q GHOSTTY_RESOURCES_DIR
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
    end
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

starship init fish | source
alias hx='helix'

set -gx QT_QPA_PLATFORMTHEME gtk3

set -x EDITOR helix
set -x VISUAL helix

# Servicio de busqueda q usa torrra para descargar torrents
alias jack="sudo systemctl start jackett"
alias jackoff="sudo systemctl stop jackett"

# para q torra se ejecute con rrr
alias rrr="torrra"

# Para hledger le asigno hl
alias hl="hledger"
