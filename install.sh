ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/gitconfig ~/.gitconfig
ln -s `pwd`/screenrc ~/.screenrc

ln -s `pwd`/id_rsa ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa

ln -s `pwd`/id_rsa.pub ~/.ssh/id_rsa.pub
cp ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

echo "source `pwd`/bashrc" >> ~/.bashrc
