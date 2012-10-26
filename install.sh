#!/bin/sh
if [ -e ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc.bak; fi
ln -s `pwd`/vimrc ~/.vimrc

if [ -e ~/.vimrc ]; then mv ~/.vim ~/.vim.bak; fi
ln -s `pwd`/vim ~/.vim

if [ -e ~/.gitconfig ]; then mv ~/.gitconfig ~/.gitconfig.bak; fi
ln -s `pwd`/gitconfig ~/.gitconfig

if [ -e ~/.screenrc ]; then mv ~/.screenrc ~/.screenrc.bak; fi
ln -s `pwd`/screenrc ~/.screenrc

if [ -e ~/.ssh/id_rsa ]; then mv ~/.ssh/id_rsa ~/.ssh/id_rsa.bak; fi
ln -s `pwd`/id_rsa ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa

if [ -e ~/.id_rsa.pub ]; then mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub.bak; fi
ln -s `pwd`/id_rsa.pub ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

if [ -e `which gpg 2>/dev/null` ]; then gpg --import 91E1DB70.gpg.sec; fi

echo "source `pwd`/bashrc" >> ~/.bashrc
