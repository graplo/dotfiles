#!/bin/bash
# O       o O       o O       o
# | O   o | | O   o | | O   o | Le hago un exec directo desde
# | | O | | | | O | | | | O | | waybar con un return-type json
# | o   O | | o   O | | o   O |
# o       O o       O o       O

trap 'pkill -P $$ cava; exit' SIGTERM SIGINT

levels=("⣀" "⣄" "⣤" "⣦" "⣶" "⣷" "⣿" "⣿")
cava -p ~/.config/cava/waybar | while read -r line; do
    read -ra bars <<< "$line"
    [ ${#bars[@]} -lt 8 ] && continue
    
    low=$(( (${bars[0]} + ${bars[1]} + ${bars[2]} + ${bars[3]}) / 4 ))
    high=$(( (${bars[4]} + ${bars[5]} + ${bars[6]} + ${bars[7]}) / 4 ))
    
    text="${levels[$high]}${levels[$low]}"
    
    printf '{"text": "%s"}\n' "$text" || exit
done
