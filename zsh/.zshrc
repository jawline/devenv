fpath=( "$HOME/.zprompts" $fpath )
autoload -Uz promptinit compinit
promptinit
compinit
prompt blakestheme

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
export TERM="screen-256color"
source ~/.nvm/nvm.sh

#History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=30000
SAVEHIST=30000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

#Open files using best program in UI
open() {
  xdg-open $1 &> /dev/null &
}

clip() {
  xclip -selection clipboard
}


export PATH=$PATH:~/.bin/
