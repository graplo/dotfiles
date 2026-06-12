#!/bin/bash
rofi -show powermenu \
    -modi "powermenu:~/.local/bin/rofi-power-menu --choices=shutdown/reboot/suspend/logout/lockscreen" \
    -theme ~/.config/rofi/themes/powermenu.rasi
