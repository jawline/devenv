#!/bin/bash
git clone git@github.com:jawline/vim.git temp_vim
cp -fr ./temp_vim/.vimrc ~/
cp -fr ./temp_vim/.vim/ ~/
rm -rf temp_vim/

