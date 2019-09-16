fpath=( "$HOME/.zprompts" $fpath )
autoload -Uz promptinit compinit
promptinit
compinit
prompt blakestheme

export TERM="screen-256color"
source ~/.nvm/nvm.sh
