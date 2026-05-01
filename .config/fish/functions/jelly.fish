function jelly
    set compose_file ~/.config/containers/jellyfin/compose.yml
    if podman ps | grep -q jellyfin
        podman-compose -f $compose_file down
        echo "Jellyfin apagado"
    else
        podman-compose -f $compose_file up -d
        echo "Jellyfin encendido"
    end
end
