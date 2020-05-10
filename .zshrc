export ZSH="/home/mateus/.oh-my-zsh"

ZSH_THEME="agnoster"
plugins=(git vi-mode)

export VISUAL=nvim
export EDITOR="$VISUAL"

source $ZSH/oh-my-zsh.sh
prompt_context(){}

alias cat='bat --theme=Nord'
alias ls='exa --git'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

export PATH="$HOME/.emacs.d/bin:$PATH"
