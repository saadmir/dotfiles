#!/bin/bash

mkdir -p /tmp/making_vim
cd /tmp/making_vim

if [ -n $(command -v git) ] ; then
  git clone https://github.com/vim/vim.git
  if [ -d vim ] ; then
    cd vim
    ./configure \
      --enable-multibyte \
      --enable-perlinterp \
      --enable-pythoninterp \
      --enable-rubyinterp \
      --enable-cscope \
      --enable-gui=auto \
      --enable-gtk2-check \
      --enable-gnome-check \
      --with-features=huge \
      --enable-multibyte \
      --with-x \
      --with-compiledby="Saad Mir <saadmir@gmail.com>" \
      --prefix=$HOME/local

    make && make install
  fi
fi


