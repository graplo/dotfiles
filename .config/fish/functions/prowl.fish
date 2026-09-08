# Prende o apaga el demonio de Prowlarr que uso con torrra
function prowl --wraps='sudo systemctl start prowlarr'
    if systemctl is-active --quiet prowlarr
        sudo systemctl stop prowlarr
        echo "Prowlarr apagado"
    else
        sudo systemctl start prowlarr
        echo "Prowlarr encendido"
    end
end
