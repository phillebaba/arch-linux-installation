export ZSH=/usr/share/oh-my-zsh
export ZSH_THEME="robbyrussell"
export ZSH_CACHE_DIR=~/.cache/oh-my-zsh

plugins=(extract git gitignore terraform docker aws kubectl kubectx pass)

source $ZSH/oh-my-zsh.sh

# User Configuration

## PATH
export PATH=$PATH:$HOME/.local/bin:/usr/local/kubebuilder/bin:$HOME/.krew/bin

## Aliases

## Functions

## Hooks
eval "$(direnv hook zsh)"

## Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

