#!/bin/zsh

export PATH=$PATH:/opt/comelec/bin:$HOME/.opam/default/bin

# manual patch in the completion script to fix bat completion
# put zfunc at the start of fpath to override the official completion file
# might need to update the script if bat is updated...
export fpath=($HOME/.zfunc $fpath)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export DOTFILES="$HOME/.dotfiles"
export CONFIG="$HOME/.config"

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
export LS_COLORS="di=34;01"

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
        quick-command-change # custom
        reload # custom
        safe-paste
        transfer # custom
        universalarchive # custom
        zsh-autosuggestions
        zsh-syntax-highlighting # kind of custom
    )
fi

source $ZSH/oh-my-zsh.sh

# enables ** recursive patterns
setopt extended_glob glob_star_short

# interpret ?@*+! after a parenthesis
setopt ksh_glob

# deletes the glob pattern when it has no match
# but "cat *.c" => "cat" if no c file, which has a very different behavior
# setopt null_glob

# prints files starting with a dot when globbing (including file completion)
# but also shows files starting with a dot when tabbing
# setopt glob_dots

# no duplicate consecutive commands in history
setopt histignoredups

# short versions of loops
setopt short_loops

# langage environment variables
export LANG="fr_FR.UTF-8"
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
export TORBROWSER_PKGLANG="fr-FR"

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

# some variables to personnalize plugins
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555"
bindkey '^ ' autosuggest-accept

# disables highlighting pasted text
zle_highlight+=(paste:none)

# ocaml
export OCAMLRUNPARAM="b1"

# my aliases
# override existing applications
alias du="dust"
alias cat="bat -pp"
alias find=fd
alias grep=rg
alias ls="exa -h -g --classify --icons"
alias tree="exa --tree -h --classify --icons"
alias paru="MAKEFLAGS=j8 paru"
alias ssh="TERM=xterm ssh"
alias dd="ddi"
alias zathura="pdetach zathura"
alias vlc="pdetach vlc"
alias libreoffice="pdetach libreoffice"
alias feh="pdetach feh"

# short aliases
alias la='ls -a' # override alias from $(OH_MY_ZSH)/lib/directories.zsh
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
alias dotfiles="cd $DOTFILES"
alias config="cd $CONFIG"
alias sl=ls
alias open="xdg-open"
alias detach=pdetach

# new functions
alias music="vlc $HOME/Nextcloud/Musique/other/* --random"
alias classic="vlc $HOME/Nextcloud/Musique/classic/* --random"
alias cpg++="g++ -g -Wall -Wextra -DONLINE_JUDGE -O2 -std=c++17"
alias copy="xclip -i -selection clipboard"
alias paste="xclip -o -selection clipboard; echo"

lcd () { cd "$1" && ls ${@:2:$#} }
pwd () {
    if [ "$#@" -eq "0" ]; then
        /bin/pwd
    else
        local D
        D=$(/bin/pwd)
        for i in "$@"; do
            echo "$D/$i"
        done
    fi
}

temp () {
    local D
    if [ "$#@" -eq "0" ]; then
        D=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
    elif [ "$#@" -eq "1" ]; then
        D="$1"
    else
        echo "At most one argument expected." 1&>2
        return 1;
    fi
    mkdir "/tmp/$D"
    cd "/tmp/$D"
}

# TODO take a look at that
# autoload zmv
# alias zmv='noglob zmv -W'

# some more bindings

bindkey "^B" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward
