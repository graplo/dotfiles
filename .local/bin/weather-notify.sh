#!/bin/bash
# Muestra una notificación mako con el detalle del clima actual.
# Pensado para el on-click de custom/weather en Waybar.
# El ícono se pasa como nombre de tema (Papirus) para que mako lo
# renderice grande a la izquierda, en vez de texto Nerd Font inline.

data=$(curl -fsS --max-time 3 "https://wttr.in?format=j1" 2>/dev/null | jq -er '
  [
    .nearest_area[0].areaName[0].value,
    .current_condition[0].weatherDesc[0].value,
    .current_condition[0].temp_C,
    .current_condition[0].FeelsLikeC,
    .current_condition[0].windspeedKmph,
    .current_condition[0].humidity,
    .current_condition[0].weatherCode,
    .weather[0].astronomy[0].sunrise,
    .weather[0].astronomy[0].sunset
  ] | @tsv
' 2>/dev/null)

if [[ -z "$data" ]]; then
  notify-send -a "weather" "Clima" "No se pudo obtener el clima ahora mismo."
  exit 0
fi

IFS=$'\t' read -r city desc temp feels wind humidity weather_code sunrise sunset <<< "$data"

now_epoch=$(date +%s)
sunrise_epoch=$(date -d "today $sunrise" +%s 2>/dev/null || echo 0)
sunset_epoch=$(date -d "today $sunset" +%s 2>/dev/null || echo 0)
if (( sunrise_epoch > 0 && sunset_epoch > 0 && (now_epoch < sunrise_epoch || now_epoch >= sunset_epoch) )); then
  night=true
else
  night=false
fi

case $weather_code in
  113) [[ $night == "true" ]] && icon="weather-clear-night" || icon="weather-clear" ;;
  116) [[ $night == "true" ]] && icon="weather-few-clouds-night" || icon="weather-few-clouds" ;;
  119|122) icon="weather-overcast" ;;
  143|248|260) icon="weather-fog" ;;
  176|263|353) [[ $night == "true" ]] && icon="weather-showers-scattered-night" || icon="weather-showers-scattered" ;;
  179|227|230|323|326|368) [[ $night == "true" ]] && icon="weather-snow-night" || icon="weather-snow" ;;
  182|185|281|284|311|314|317|320|350|362|365|374|377) icon="weather-showers" ;;
  200|386|389|392|395) icon="weather-storm" ;;
  266|293|296|299|302|305|308|356|359) icon="weather-showers-scattered" ;;
  329|332|335|338|371) icon="weather-snow" ;;
  *) icon="weather-clear" ;;
esac

notify-send -a "weather" -i "$icon" \
  "Clima en $city" \
  "Condición: $desc\nTemperatura: ${temp}°C (sensación ${feels}°C)\nViento: ${wind} km/h\nHumedad: ${humidity}%"
