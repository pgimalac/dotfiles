#!/bin/zsh

# Path to your oh-my-zsh installation.
export ZSH="/home/pierre/.oh-my-zsh"
export DOTFILES="$HOME/.dotfiles"
export ZSHDOTFILES="$DOTFILES/zsh"

export PATH=$PATH:/opt/comelec/bin:$HOME/.opam/default/bin
export fpath=($HOME/.zfunc $fpath)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="pierre"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Bold blue directories, like exa does
LS_COLORS="di=34;01"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

if [ -z "$plugins" ]; then
    plugins=(
        compleat
        copybuffer # custom
        copydir
        copyfile
        dirhistory # custom
        extract
        fancy-ctrl-z
        fzf # custom
        reload # custom
        # safe-paste
        transfer # custom
        universalarchive # custom
        zsh-autosuggestions
        zsh-syntax-highlighting
    )
fi

# merged a pull request on my fork to cancel that last bug
# but a relatively similar one appeared then

source $ZSH/oh-my-zsh.sh

# enables ** recursive patterns
setopt extended_glob glob_star_short
# interpret ?@*+! after a parenthesis
setopt ksh_glob
# deletes the glob pattern when it has no match
# setopt null_glob
# prints files starting with a dot when globbing (including file completion)
# setopt glob_dots
# no duplicate consecutive commands in history
setopt histignoredups
# short versions of loops
setopt short_loops

# You may need to manually set your language environment
export LANG="fr_FR.UTF-8"
export TORBROWSER_PKGLANG="fr-FR"

export ALL="$LANG"
export LANGUAGE="$LANG"
export LC_ADDRESS="POSIX"
export LC_COLLATE="POSIX"
export LC_CTYPE="$LANG"
export LC_IDENTIFICATION="$LANG"
export LC_MEASUREMENT="$LANG"
export LC_MESSAGE="POSIX"
export LC_MONETARY="$LANG"
export LC_NAME="POSIX"
export LC_NUMERIC="$LANG"
export LC_PAPER="$LANG"
export LC_TELEPHONE="$LANG"
export LC_TIME="$LANG"

# Preferred editor for local and remote sessions
export EDITOR=vim

# if [[ -n $SSH_CONNECTION ]]; then
#     export EDITOR='vim'
# else
#     export EDITOR='subl'
# fi

export ARCHFLAGS="-arch x86_64"

# PAGER env vars
# Use less since most does not support reading ANSI colors, and bat can color man pages
# -R to read ANSI colors
export PAGER="less -R"
# -F to quit when displaying less than one screen, ie not always use fullscreen
export BAT_PAGER="less -RF"
# we want to always use fullscreen, even for small man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p --pager=\"$PAGER\"'"

# my aliases
alias du="dust"
alias cat="bat -pp"
alias find=fd
alias grep=rg
alias ls="exa -h -g --classify --icons"
alias la='ls -a' # override alias from $(OH_MY_ZSH)/lib/directories.zsh
alias tree="exa --tree -h --classify --icons"
alias paru="MAKEFLAGS=j8 paru"
alias ga="git add"
alias gs="git status"
alias gcam="git commit -am"
alias gcm="git commit -m"
alias gc="git checkout"
alias gpush="git push"
alias gpull="git pull"
alias gp="git pull && git push"
alias gd="git diff"
alias zshrc='subl ~/.zshrc'
alias h=history
alias tmp="cd /tmp"
alias sl=ls
alias ssh="TERM=xterm ssh"
alias music="pdetach vlc $HOME/Nextcloud/Musique/other/* --random"
alias classic="pdetach vlc $HOME/Nextcloud/Musique/classic/* --random"
alias cpg++="g++ -g -Wall -Wextra -DONLINE_JUDGE -O2 -std=c++17"
alias dd="ddi"
alias open="xdg-open"
alias detach=pdetach
alias copy="xclip -i -selection clipboard"
alias paste="xclip -o -selection clipboard; echo"
alias zathura="pdetach zathura --fork"

# some nice functions
mkcd () { mkdir "$@" && cd ${@:$#} }
lcd () { cd "$1" && ls ${@:2:$#} }

# some variables to personnalize plugins
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555"
bindkey '^ ' autosuggest-accept

# ocaml
export OCAMLRUNPARAM="b1"
# opam configuration
# test -r /home/pierre/.opam/opam-init/init.zsh && . /home/pierre/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# to remove a bug with bat completion
# => manual patch in the completion script
# might need to update the script if bat is updated...
# compdef '' bat

# some more bindings

bindkey "^B" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward
