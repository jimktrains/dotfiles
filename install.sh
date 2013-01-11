#!/bin/sh
if [ -e ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc.bak; fi
ln -s `pwd`/vimrc ~/.vimrc

if [ -e ~/.vimrc ]; then mv ~/.vim ~/.vim.bak; fi
ln -s `pwd`/vim ~/.vim

if [ -e ~/.zshrc ]; then mv ~/.zshrc ~/.zshrc.bak; fi
ln -s `pwd`/zshrc ~/.zshrc

if [ -e ~/.gitconfig ]; then mv ~/.gitconfig ~/.gitconfig.bak; fi
ln -s `pwd`/gitconfig ~/.gitconfig

if [ -e ~/.screenrc ]; then mv ~/.screenrc ~/.screenrc.bak; fi
ln -s `pwd`/screenrc ~/.screenrc


echo "source `pwd`/bashrc" >> ~/.bashrc
