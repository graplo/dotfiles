function cowes
    set fortunes_es \
        amistad arte ciencia deprimente familia famosos filosofia \
        humanos informatica libertad pintadas poder proverbios \
        refranes sabiduria sentimientos varios varios-pre \
        verdad vida

    set modos b d g s t w y
    set modo_random (printf '%s\n' $modos | shuf -n1)

    set_color bd93f9
    fortune $fortunes_es 2>/dev/null | cowsay -r -$modo_random
    set_color normal
end
