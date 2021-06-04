alias reload="exec zsh"

function _reload {
    BUFFER="reload"
    zle accept-line -w
}

zle -N _reload
bindkey "^R" _reload

# copied from omz zsh-reload module
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/zsh_reload/zsh_reload.plugin.zsh
# compiles zsh config files for faster start (?)

local cache="$ZSH_CACHE_DIR"
autoload -U compinit zrecompile
compinit -i -d "$cache/zcomp-$HOST"

for f in ${ZDOTDIR:-~}/.zshrc "$cache/zcomp-$HOST"; do
    zrecompile -p $f >/dev/null && command rm -f $f.zwc.old
done
