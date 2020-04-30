export ZSH="/home/mateus/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git)
source $ZSH/oh-my-zsh.sh

alias cat='bat --theme=base16'
alias ls='exa --git'

export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH="/usr/local/smlnj/bin:$PATH"
prompt_context(){}
