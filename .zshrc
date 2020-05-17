export ZSH="/home/mateus/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(git)

source $ZSH/oh-my-zsh.sh
prompt_context(){}

export VISUAL=nvim
export EDITOR="$VISUAL"

alias cat='bat --theme=Nord'
alias ls='exa --git'
alias v='nvim'
alias e='emacsclient -nc'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
