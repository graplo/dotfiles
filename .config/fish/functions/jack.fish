# Prende o apaga el demonio q uso con torrra para descargar torrents
function jack --wraps='sudo systemctl start jackett'
    if systemctl is-active --quiet jackett
        sudo systemctl stop jackett
        echo "Jackett apagado"
    else
        sudo systemctl start jackett
        echo "Jackett encendido"
    end
end
