#!/bin/bash
# ▖  ▖    ▌           ▄▖           ▄▖    ▐▘▘▜   
# ▌▞▖▌▀▌▌▌▛▌▀▌▛▘  ▄▖  ▙▌▛▌▌▌▌█▌▛▘  ▙▌▛▘▛▌▜▘▌▐ █▌
# ▛ ▝▌█▌▙▌▙▌█▌▌       ▌ ▙▌▚▚▘▙▖▌   ▌ ▌ ▙▌▐ ▌▐▖▙▖
#       ▄▌                                      
# Lo llamamos como exec desde waybar

profile=$(powerprofilesctl get)
case $profile in
    performance) icon="󰓅" ;;
    balanced)    icon="󰾅" ;;
    power-saver) icon="󰾆" ;;
esac
echo "{\"text\": \"$icon\", \"class\": \"$profile\"}"
