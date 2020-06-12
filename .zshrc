ZSH_THEME="agnoster"

plugins=(git)

source $ZSH/oh-my-zsh.sh
prompt_context(){}

export VISUAL=nvim
export EDITOR=nvim

alias cat='bat --theme=base16'
alias ls='exa --git'
alias v='nvim'
alias e='emacsclient -nc'

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
