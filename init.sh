#!/bin/bash

cd $HOME

sudo apt-get update && sudo apt-get install tmux vim zellij

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ -d "$HOME/dotfiles" ] ; then
  echo "dotfiles already exists. skipping git clone"
else
  git clone --recursive https://github.com/saadmir/dotfiles.git
fi

ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc

if [ -d "$HOME/dotfiles" ] && [ -d "$HOME/dotfiles/vim" ] && [ ! -d "$HOME/.vim" ] ; then
  ln -s $HOME/dotfiles/vim $HOME/.vim
fi

if [ -d "$HOME/dotfiles" ] && [ -d "$HOME/dotfiles/vim" ] && [ -f "$HOME/dotfiles/vim/vimrc" ] && [ ! -f "$HOME/.vimrc" ] ; then
  ln -s $HOME/dotfiles/vim $HOME/.vim
fi

if [ -d "$HOME/dotfiles" ] && [ -d "$HOME/dotfiles/tmux.conf" ] && [ ! -f "$HOME/.tmux.conf" ] ; then
  ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
fi

# if [ -d "$HOME/dotfiles" ] && [ -f "$HOME/dotfiles/profile.sh" ]  ; then
# cat <<EOT >> $HOME/.profile

# if [ -d "$HOME/dotfiles" ] && [ -f "$HOME/dotfiles/profile.sh" ]  ; then
#   . $HOME/dotfiles/profile.sh
# fi

EOT
fi

if ! command -v rustc >/dev/null 2>&1; then
  echo "Rust not found. Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! command -v zellij >/dev/null 2>&1; then
  echo "Zellij not found. Installing Zellij..."
  cargo install zellij
fi

if ! command -v nvm >/dev/null 2>&1; then
  echo "nvm not found. Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi
