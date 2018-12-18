fpath=( "$HOME/.zprompts" $fpath )
autoload -Uz promptinit
promptinit
prompt blakestheme

function open() {
    xdg-open "$@" > /dev/null
}
