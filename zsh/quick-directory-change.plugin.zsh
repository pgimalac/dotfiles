#!/bin/false

# from https://grml.org/zsh/zsh-lovers.html

function rationalise-dot {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}

zle -N rationalise-dot
bindkey . rationalise-dot
