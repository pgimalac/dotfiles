# from the omz safe-paste plugin
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/safe-paste/safe-paste.plugin.zsh

# disables highlighting pasted text
zle_highlight+=(paste:none)

set zle_bracketed_paste  # Explicitly restore this zsh default
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
