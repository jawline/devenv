" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

" FZF For fast file searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Nice looking light and dark themes
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Status bar with the files that are open
Plug 'vim-airline/vim-airline'

" NERD Tree
Plug 'preservim/nerdtree'

" Rust integration
Plug 'rust-lang/rust.vim'

call plug#end()

" Hit Ctrl-F to launch FZF
nnoremap <C-f> :FZF<CR>

" Hit Ctrl-N to launch NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Theme

set background=dark
colorscheme onehalfdark
let g:airline_theme='onehalfdark'

" Tab settings
set expandtab
set tabstop=2

" Show line numbers
set number

" Do not litter the file system with intermediates
set noswapfile

" Spell checking
set spell

" Auto-reload files when they change on disk
set autoread
au CursorHold * checktime

" Highlight trailing whitespace
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

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

" Highlight all the stuff on screen that matches a search
set hlsearch

" Switch on syntax highlighting
syntax enable
filetype plugin indent on
