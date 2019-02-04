fpath=( "$HOME/.zprompts" $fpath )
autoload -Uz promptinit compinit
promptinit
compinit
prompt blakestheme

function open() {
	xdg-open "$@" > /dev/null
}

function game() {
	parsecd app_daemon=1
}

function gitclean() {
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

alias tmux='tmux -2'
source ~/.nvm/nvm.sh
