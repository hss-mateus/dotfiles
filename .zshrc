export ZSH="/home/mateus/.oh-my-zsh"

ZSH_THEME="agnoster"
plugins=(git)

export VISUAL=nvim
export EDITOR="$VISUAL"

source $ZSH/oh-my-zsh.sh
prompt_context(){}

alias cat='bat --theme=Nord'
alias ls='exa --git'

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
