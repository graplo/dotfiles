#!/usr/bin/env bash

JSON=$(makoctl history -j 2>/dev/null)

if [ "$JSON" = "[]" ] || [ -z "$JSON" ]; then
    echo "[]"
    exit 0
fi

echo "$JSON" | jq '[.[] | {
    id: .id, 
    app: .app_name, 
    title: .summary, 
    body: (.body // ""), 
    urgency: .urgency,
    icon_val: (.app_icon // .icon // "")
}]' | python3 -c '
import sys, json, os
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

# Detecta automáticamente el tema de íconos activo en GTK (Papirus-Dark, etc.)
icon_theme = Gtk.IconTheme.get_default()

def resolve_icon_path(icon_name, app_name):
    if not icon_name and not app_name:
        return ""
    
    # 1. Ruta absoluta directa a archivo real (ej: captura de pantalla temporal)
    clean_path = icon_name.replace("file://", "")
    if clean_path.startswith("/") and os.path.isfile(clean_path):
        return clean_path

    # 2. Buscar en el tema activo del sistema por nombre de ícono o app
    candidates = [icon_name, app_name, app_name.lower() if app_name else ""]
    for candidate in candidates:
        if not candidate:
            continue
        icon_info = icon_theme.lookup_icon(candidate, 32, 0)
        if icon_info:
            return icon_info.get_filename()

    return ""

try:
    data = json.load(sys.stdin)
    for item in data:
        icon_path = resolve_icon_path(item.get("icon_val", ""), item.get("app", ""))
        item["icon_path"] = icon_path if icon_path else ""
        del item["icon_val"]
        
    print(json.dumps(data))
except Exception:
    print("[]")
'
