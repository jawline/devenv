#!/bin/bash
git clone https://github.com/jawline/vim.git temp_vim
cp -fr ./temp_vim/.vimrc ~/
cp -fr ./temp_vim/.vim/ ~/
rm -rf temp_vim/

