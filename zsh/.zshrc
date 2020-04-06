#!/bin/zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

fpath=($fpath $HOME/.rustcompl/_rustup)
# no idea how completion works and couldn't make it work...

# Path to your oh-my-zsh installation.
export ZSH="/home/pierre/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="xxf"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    git-extras
    autojump
    web-search
    copyfile
    compleat
    extract
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=fr_FR.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='subl'
fi

export ARCHFLAGS="-arch x86_64"

# Most variables for Man Pages
export MOST_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export MOST_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export MOST_TERMCAP_me=$'\e[0m'           # end mode
export MOST_TERMCAP_se=$'\e[0m'           # end standout-mode
export MOST_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export MOST_TERMCAP_ue=$'\e[0m'           # end underline
export MOST_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
export PAGER="most"

# fzf variables
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'

# my aliases
alias sed="ambr"
alias du="dust"
alias bat="PAGER=less bat"
alias cat="bat -A -pp"
alias find=fd
alias grep=rg
alias ls="exa -h"
alias tree="exa --tree -h"
alias zathura="zathura --fork"
alias gs="git status"
alias gcam="git commit -am"
alias gcm="git commit -m"
alias gc="git checkout"
alias gpush="git push"
alias gpull="git pull"
alias gp="git pull && git push"
alias zshrc='$EDITOR ~/.zshrc'
alias h=history
alias tmp="cd /tmp"
alias sl=ls
alias ssh='TERM=xterm ssh'

# some nice functions
mkcd () { mkdir "$@" && cd ${@:$#} }
lcd () { cd "$1" && ls ${@:2:$#} }

fzf_change_directory() {
    local directory
    directory=$(
        fd --type d | \
        fzf --query="$1" --no-multi --select-1 --exit-0 \
            --preview 'tree -C {} | head -100'
    )
    if [[ -n $directory ]]; then
        cd "$directory"
    fi
}

fzf_find_edit() {
    local file
    file=$(
        fzf --query="$1" --no-multi --select-1 --exit-0 \
            --preview 'bat --color=always --line-range :500 {}'
    )
    if [[ -n $file ]]; then
        $EDITOR "$file"
    fi
}

fzf_grep_edit(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match
    match=$(
        rg --color=never --line-number "$1" |
        fzf --no-multi --delimiter : \
            --preview "bat --color=always --line-range {2}: {1}"
    )
    local file
    file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $EDITOR "$file" +$(echo "$match" | cut -d':' -f2)
    fi
}

fzf_kill() {
    pid_col=2
    local pids
    pids=$(
        ps -f -u $USER |
        sed 1d |
        fzf --multi |
        tr -s '[:blank:]' |
        cut -d' ' -f"$pid_col"
    )
    if [[ -n $pids ]]; then
        echo "$pids" | xargs kill -9 "$@"
    fi
}

alias fkill='fzf_kill'
alias fge='fzf_grep_edit'
alias ffe='fzf_find_edit'
alias fcd='fzf_change_directory'

export OCAMLRUNPARAM="b1"
# opam configuration
# test -r /home/pierre/.opam/opam-init/init.zsh && . /home/pierre/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
