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

### This script is DEPRECATED!
### Using vim-plug instead:
### https://github.com/junegunn/vim-plug


echo 'This script is DEPRECATED!'
echo 'Using vim-plug instead:'
echo 'https://github.com/junegunn/vim-plug'
exit

# Setting up the directories
#VIM_DIR=~/.vim
#VIM_AUTOLOAD_DIR=$VIM_DIR/autoload
#VIM_BUNDLE_DIR=$VIM_DIR/bundle

# If .vim dir doesn't exist, create it
#if [[ ! -d $VIM_DIR ]]; then
    #mkdir -p $VIM_DIR
#fi

# Create the autoload and bunde dir inside .vim
#mkdir -p $VIM_AUTOLOAD_DIR $VIM_BUNDLE_DIR

# Change to the working directory
#cd $VIM_DIR

# Get Pathogen
#git clone https://github.com/tpope/vim-pathogen.git
#mv vim-pathogen/autoload/pathogen.vim $VIM_AUTOLOAD_DIR
#echo "pathogen.vim moved to: $VIM_AUTOLOAD_DIR"
#rm -rf vim-pathogen
#echo "vim-pathogen directory removed, not needed anymore."

# Change to the bundle dir
#cd $VIM_BUNDLE_DIR

# Get the plugins 

# NERDTree
git clone https://github.com/scrooloose/nerdtree.git
# Multiple cursors
git clone https://github.com/kristijanhusak/vim-multiple-cursors.git
# nerdcommenter
git clone https://github.com/scrooloose/nerdcommenter.git
# vim-misc (needed for vim-session)
git clone https://github.com/xolox/vim-misc.git
# vim-session
git clone https://github.com/xolox/vim-session.git
# Vim Easy TODO
git clone https://github.com/spcmd/vim-easy-todo.git
# neocomplete
git clone https://github.com/Shougo/neocomplete.vim.git
# Colorizer
git clone https://github.com/chrisbra/Colorizer.git
# buftabline
git clone https://github.com/ap/vim-buftabline.git

# Patched powerline fonts needed, but you might have it, so not need to install automatically
#echo "Powerline fonts aren't installed automatically. If you don't have it already installed, please visit: https://github.com/powerline/fonts and install it manually. Then select one of the installed powerline font type in the terminal settings, and also set this font type in your .vimrc and/or .gvimrc"

# Setup vim config files from dotfiles with stow
#if [[ -d ~/dotfiles ]]; then
    #cd ~/dotfiles
    #echo "Using stow to setup Vim config files from ~/dotfiles"
    #stow vim
    #echo "DONE: Vim config files has been set."
#fi

# --- NOT USED ---

# Vim-Airline
#git clone https://github.com/bling/vim-airline
# Emmet-Vim
#git clone https://github.com/mattn/emmet-vim.git
# VCoolor
#git clone https://github.com/KabbAmine/vCoolor.vim.git
# Fugitive
#git clone https://github.com/tpope/vim-fugitive.git
# Spacegray color scheme
#git clone git://github.com/ajh17/Spacegray.vim.git
