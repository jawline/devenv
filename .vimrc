" Add JavaScript ES6 syntax support
set runtimepath^=~/.vim/bundle/vim-javascript-syntax.vim
syntax on

" Tab settings
set expandtab
set smarttab
set softtabstop=2
set tabstop=2
set shiftwidth=2

set number
set noswapfile
set spell

" Default to a fairly large terminal size
set columns=150
set list

" Enable system keyboard 
set clipboard=unnamedplus

" Handle tmux weird keys
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
