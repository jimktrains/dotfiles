#!/bin/sh

backup_and_install () {
  if [ -e ~/.$1 ]; then mv ~/.$1 ~/.$1.bak; fi
  ln -s `pwd`/$1 ~/.$1
}

backup_and_install vimrc
backup_and_install vim
backup_and_install zshrc
backup_and_install gitconfig
backup_and_install screenrc
backup_and_install Xmodmap
backup_and_install XCompose


echo "source `pwd`/bashrc" >> ~/.bashrc
