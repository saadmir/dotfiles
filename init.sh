#!/bin/bash

cd $HOME

sudo apt-get update && sudo apt-get install tmux vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    
bash <(curl -L zellij.dev/launch)

if [ -d "$HOME/dotfiles" ] ; then
  echo "dotfiles already exists. skipping git clone"
else
  git clone --recursive https://github.com/saadmir/dotfiles.git
fi

ln -s $HOME/dotfiles/vim $HOME/.vim
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf

if [ -d "$HOME/dotfiles" ] && [ -f "$HOME/dotfiles/profile.sh" ]  ; then
cat <<EOT >> $HOME/.profile

if [ -d "$HOME/dotfiles" ] && [ -f "$HOME/dotfiles/profile.sh" ]  ; then
  . $HOME/dotfiles/profile.sh
fi

EOT
fi
