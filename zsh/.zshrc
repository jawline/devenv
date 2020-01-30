fpath=( "$HOME/.zprompts" $fpath )
autoload -Uz promptinit compinit
promptinit
compinit
prompt blakestheme

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
export TERM="screen-256color"
source ~/.nvm/nvm.sh

open() {
  xdg-open $1 &> /dev/null &
}
