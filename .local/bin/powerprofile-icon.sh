#!/bin/bash
# ▖  ▖    ▌           ▄▖           ▄▖    ▐▘▘▜   
# ▌▞▖▌▀▌▌▌▛▌▀▌▛▘  ▄▖  ▙▌▛▌▌▌▌█▌▛▘  ▙▌▛▘▛▌▜▘▌▐ █▌
# ▛ ▝▌█▌▙▌▙▌█▌▌       ▌ ▙▌▚▚▘▙▖▌   ▌ ▌ ▙▌▐ ▌▐▖▙▖
#       ▄▌                                      
# Lo llamamos como exec desde waybar

profile=$(powerprofilesctl get)
case $profile in
    performance) echo "󰓅" ;;
    balanced)    echo "󰾅" ;;
    power-saver) echo "󰾆" ;;
esac
