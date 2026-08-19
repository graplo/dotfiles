#!/bin/bash
#        )
#       (_)
#       |`|
#       | |  _() Controlo el brillo del  monitor desde Waybar
# GPL  \_|_|_/

val=$(ddcutil --bus 7 getvcp 10 | grep -oP 'current value =\s+\K\d+')
icons=('󰃚' '󰃛' '󰃜' '󰃝' '󰃞' '󰃟' '󰃠')
idx=$(( val * 6 / 100 ))
echo "{\"text\": \"${icons[$idx]}\", \"tooltip\": \"Brillo: ${val}%\"}"
