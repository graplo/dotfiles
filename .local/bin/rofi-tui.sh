#!/usr/bin/env bash

# Configuración de tu terminal Ghostty
TERMINAL_CMD="ghostty -e"
ROFI_THEME="$HOME/.config/rofi/themes/tui-menu.rasi"

# Función con tus aplicaciones reales e iconos lógicos de Papirus
get_menu_options() {
    echo -en "LazyGit\x00icon\x1fgit\n"
    echo -en "Yazi (File Manager)\x00icon\x1fsystem-file-manager\n"
    echo -en "Helix (Editor)\x00icon\x1fhelix\n"
    echo -en "iKhal (Calendar)\x00icon\x1foffice-calendar\n"
    echo -en "Aerc (Mail)\x00icon\x1finternet-mail\n"
    echo -en "Taskwarrior\x00icon\x1ftask-pastdue\n"
    echo -en "RMPC (Music)\x00icon\x1fmusic-player\n"
    echo -en "Cliamp (Music Player)\x00icon\x1faudio-player\n"
    echo -en "Torrra (Torrents)\x00icon\x1ftorrent\n"
    echo -en "Cava (Visualizer)\x00icon\x1faudio-volume-high\n"
    echo -en "Cowes (Fortune/Cawsay)\x00icon\x1ffortune\n"
    echo -en "Btop\x00icon\x1fbtop\n"
    echo -en "Htop\x00icon\x1fhtop\n"
    echo -en "Nvtop (GPU)\x00icon\x1fnvtop\n"
}

# Lanza Rofi leyendo los iconos nativos del sistema
if [ -f "$ROFI_THEME" ]; then
    chosen=$(get_menu_options | rofi -dmenu -show-icons -config "$ROFI_THEME" -p "TUI Apps")
else
    chosen=$(get_menu_options | rofi -dmenu -show-icons -icon-theme "Papirus" -p "TUI Apps")
fi

# Mapeo de ejecución corregido
case "$chosen" in
    "LazyGit")               $TERMINAL_CMD "lazygit" ;;
    "Yazi (File Manager)")   $TERMINAL_CMD "yazi" ;;
    
    # CORRECCIÓN HELIX: Forzamos a abrir el directorio actual para inicializar el buffer de Ghostty
    "Helix (Editor)")        ghostty -e /usr/bin/helix . ;; 
    
    "iKhal (Calendar)")      $TERMINAL_CMD "ikhal" ;;
    "Aerc (Mail)")           $TERMINAL_CMD "aerc" ;;
    "Taskwarrior")           $TERMINAL_CMD "taskwarrior-tui" ;;
    "RMPC (Music)")          $TERMINAL_CMD "rmpc" ;;
    "Cliamp (Music Player)") $TERMINAL_CMD "cliamp" ;;
    "Torrra (Torrents)")     $TERMINAL_CMD "torrra" ;;
    "Cava (Visualizer)")     $TERMINAL_CMD "cava" ;;
    
    # CORRECCIÓN COWES: Ejecuta fish, corre tu script, y "read" mantiene la ventana abierta para que la veas
    "Cowes (Fortune/Cawsay)") ghostty -e fish -c "$HOME/.local/bin/cowes; echo; echo '[Presiona Enter para salir]'; read" ;;
    
    "Btop")                  $TERMINAL_CMD "btop" ;;
    "Htop")                  $TERMINAL_CMD "htop" ;;
    "Nvtop (GPU)")           $TERMINAL_CMD "nvtop" ;;
esac
