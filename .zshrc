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
