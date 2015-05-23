#!/bin/bash
#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#                  setup-vim.sh
#               Created by: spcmd
#           http://spcmd.github.io
#           https://github.com/spcmd
#           https://gist.github.com/spcmd
#

# Setup the directories
VIM_DIR=~/.vim
VIM_AUTOLOAD_DIR=$VIM_DIR/autoload
VIM_BUNDLE_DIR=$VIM_DIR/bundle

if [[ ! -d $VIM_DIR ]]; then
    mkdir -p $VIM_DIR
fi

mkdir -p $VIM_AUTOLOAD_DIR $VIM_BUNDLE_DIR

# Install Pathogen
git clone https://github.com/tpope/vim-pathogen.git
mv vim-pathogen/autoload/pathogen.vim $VIM_AUTOLOAD_DIR
echo "pathogen.vim moved to: $VIM_AUTOLOAD_DIR"
rm -rf vim-pathogen
echo "vim-pathogen directory removed, not needed anymore."

# Vim-Airline
git clone https://github.com/bling/vim-airline
mv vim-airline $VIM_BUNDLE_DIR
echo "vim-airline moved to: $VIM_BUNDLE_DIR"

# NERDTree
git clone https://github.com/scrooloose/nerdtree.git
mv nerdtree $VIM_BUNDLE_DIR
echo "nerdtree moved to: $VIM_BUNDLE_DIR"

# Emmet-Vim
#git clone https://github.com/mattn/emmet-vim.git
#mv emmet-vim $VIM_BUNDLE_DIR
#echo "emmet-vim moved to: $VIM_BUNDLE_DIR"

# Multiple cursors
git clone https://github.com/kristijanhusak/vim-multiple-cursors.git
mv vim-multiple-cursors $VIM_BUNDLE_DIR
echo "vim-multiple-cursors moved to: $VIM_BUNDLE_DIR"

# nerdcommenter
git clone https://github.com/scrooloose/nerdcommenter.git
mv nerdcommenter $VIM_BUNDLE_DIR
echo "nerdcommenter moved to: $VIM_BUNDLE_DIR"

# vim-misc (needed for vim-session)
git clone https://github.com/xolox/vim-misc.git
mv vim-misc $VIM_BUNDLE_DIR
echo "vim-misc moved to: $VIM_BUNDLE_DIR"

# vim-session
git clone https://github.com/xolox/vim-session.git
mv vim-session $VIM_BUNDLE_DIR
echo "vim-session moved to: $VIM_BUNDLE_DIR"

# Vim Easy TODO
git clone https://github.com/spcmd/vim-easy-todo.git
mv vim-easy-todo $VIM_BUNDLE_DIR
echo "vim-easy-todo moved to: $VIM_BUNDLE_DIR"

# neocomplete
git clone https://github.com/Shougo/neocomplete.vim.git
mv neocomplete.vim $VIM_BUNDLE_DIR
echo "neocomplete.vim moved to: $VIM_BUNDLE_DIR"

# VCoolor
#git clone https://github.com/KabbAmine/vCoolor.vim.git
#mv vCoolor.vim $VIM_BUNDLE_DIR
#echo "vCoolor.vim moved to: $VIM_BUNDLE_DIR"

# Colorizer
git clone https://github.com/chrisbra/Colorizer.git
mv Colorizer $VIM_BUNDLE_DIR
echo "Colorizer moved to: $VIM_BUNDLE_DIR"

# Fugitive
#git clone https://github.com/tpope/vim-fugitive.git
#mv vim-fugitive $VIM_BUNDLE_DIR
#echo "vim-fugitive moved to: $VIM_BUNDLE_DIR"

# Patched powerline fonts needed, but you might have it, so not need to install automatically
echo "Powerline fonts aren't installed automatically. If you don't have it already installed, please visit: https://github.com/powerline/fonts and install it manually. Then select one of the installed powerline font type in the terminal settings, and also set this font type in your .vimrc and/or .gvimrc"

# Setup vim config files from dotfiles with stow
if [[ -d ~/dotfiles ]]; then
    cd ~/dotfiles
    echo "using stow to setup vim config files from ~/dotfiles"
    stow vim
fi

# --- NOT USED ---

# Spacegray color scheme
#git clone git://github.com/ajh17/Spacegray.vim.git
#mv Spacegray.vim $VIM_BUNDLE_DIR
#echo "Spacegray.vim moved to: $VIM_BUNDLE_DIR"

# vim-autoclose
#git clone https://github.com/Shougo/neocomplete.vim.git
#mv vim-autoclose $VIM_BUNDLE_DIR
#echo "vim-autoclose moved to: $VIM_BUNDLE_DIR"

# Not using YouCompleteMe anymore, using neocomplete instead.
# YouCompleteMe plugin have some dependencies, so it's better to install it manually
#echo "YouCompleteMe isn't installed automatically. This bundle have some dependencies, so please visit https://github.com/Valloric/YouCompleteMe or http://valloric.github.io/YouCompleteMe for more information, and install it manually."
