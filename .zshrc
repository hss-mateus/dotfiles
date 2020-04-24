export ZSH="/home/mateus/.oh-my-zsh"
ZSH_THEME="McQuen"
plugins=(git)
source $ZSH/oh-my-zsh.sh

alias cat='bat --theme=base16'
alias ls='exa --git'
alias xi='sudo xbps-install'

export VISUAL=nvim
export EDITOR="$VISUAL"
