set runtimepath^=~/.vim/bundle/vim-javascript-syntax
set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/Latex-Text-Formatter

set wildignore+=*/tmp/*,*/bin/*,*/node_modules/*,*.o,*.hi,*.so,*.swp,*.zip,*.dylib     " Ignore files for ctrl-p 
syntax on

set t_Co=256   " This is may or may not needed.

"set background=light
"colorscheme PaperColor

set background=dark
colorscheme hybrid_reverse

" Tab settings
set expandtab
set tabstop=2

set number
set noswapfile
set spell

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
