function open() {
    xdg-open "$@" > /dev/null
}

export PS1="\[\033[01;34m\]\w>\[\033[00m\] "
