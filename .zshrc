fpath=( "$HOME/.zprompts" $fpath )
autoload -Uz promptinit compinit
promptinit
compinit
prompt blakestheme

function open() {
	xdg-open "$@" > /dev/null
}

function gitclean() {
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

export TERM="screen-256color"
alias ls="ls --color=auto"
alias tmux='tmux -2'
source ~/.nvm/nvm.sh
