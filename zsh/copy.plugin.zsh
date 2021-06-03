#!/bin/zsh

# My version of copybuffer
# Mostly stolen from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copybuffer
# copy the active line from the command line buffer
# onto the system clipboard, and clear the line

alias copy="xclip -i -selection clipboard"
alias paste="xclip -o -selection clipboard; echo"

copybuffer () {
    if which clipcopy &>/dev/null; then
        echo -n "$BUFFER" | clipcopy
        BUFFER=""
    else
        echo "clipcopy function not found. Please make sure you have Oh My Zsh installed correctly."
    fi
}

zle -N copybuffer

# remove all ctrl+x bindkeys
# otherwise zsh will wait (less than 1s but still) for a second key press
bindkey -r "^X^B" "^X^E" "^X^F" "^X^J" "^X^K" "^X^N" "^X^O" "^X^R" "^X^U" "^X^V" "^X^X" "^X*" "^X=" "^X?" "^XC" "^XG" "^Xa" "^Xc" "^Xd" "^Xe" "^Xg" "^Xh" "^Xm" "^Xn" "^Xr" "^Xs" "^Xt" "^Xu" "^X~"

bindkey "^X" copybuffer
