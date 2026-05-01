function cowr
    set modos b d g s t w y
    set modo_random (echo $modos | tr ' ' '\n' | shuf -n1)
    set_color bd93f9
    fortune | cowsay -r -$modo_random
    set_color normal
end
