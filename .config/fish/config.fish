source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
# Rutas
fish_add_path $HOME/.local/bin $HOME/.cargo/bin $HOME/.npm-global/bin $HOME/go/bin

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

set -gx QT_QPA_PLATFORMTHEME gtk3

set -x EDITOR helix
set -x VISUAL helix

set -gx BAT_THEME Dracula

# Para q ollama use mu gpu al iniciar
set -x OLLAMA_VULKAN true

# Para FZF
set -Ux FZF_DEFAULT_OPTS_FILE ~/.config/fzf/fzf.conf
# Para vivid environment variable that controls the colorized output of ls, tree, fd, bfs, dust and many other tools.
set -x LS_COLORS (vivid generate dracula)

# para q este numerado los terminales, y con echo el texto q quieras
if status is-interactive
    set_color bd93f9
    set count (niri msg windows | grep "com.mitchellh.ghostty" | wc -l)
    echo "# $count - fish" | figlet
    set_color normal
end

# para q no salga el fastfech de cachyos al comienzo
function fish_greeting
end
