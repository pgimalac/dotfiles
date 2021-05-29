#!/bin/zsh

function _find_position_command_end {
    local pos=1
    while [[ $pos -le $#BUFFER ]] && [[ "$BUFFER[$pos]" == " " ]]; do
        pos=$(($pos + 1))
    done

    while [[ $pos -le $#BUFFER ]] && [[ "$BUFFER[$pos]" != " " ]]; do
        pos=$(($pos + 1))
    done

    echo $pos
}

function _remove_command {
    BUFFER="${BUFFER[@]:$(($(_find_position_command_end)-1))}"
    CURSOR=0
}

zle -N _remove_command

# alt+a
bindkey "^[a" _remove_command

function _remove_args {
    BUFFER="${BUFFER[@]:0:$(_find_position_command_end)}"
    CURSOR=$#BUFFER
}

zle -N _remove_args

# alt+c
bindkey "^[c" _remove_args
