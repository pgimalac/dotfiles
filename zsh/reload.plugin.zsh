#!/bin/zsh

alias reload="exec zsh"

function _reload {
    BUFFER="reload"
    zle accept-line -w
}

zle -N _reload
bindkey "^R" _reload

# copied from zsh-reload module
# compiles zsh config files for faster start
local cache="$ZSH_CACHE_DIR"
autoload -U compinit zrecompile
compinit -i -d "$cache/zcomp-$HOST"

for f in ${ZDOTDIR:-~}/.zshrc "$cache/zcomp-$HOST"; do
    zrecompile -p $f >/dev/null && command rm -f $f.zwc.old
done
