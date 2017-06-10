#!/bin/bash

case $OSTYPE in
  darwin*)
    alias ls='ls -GFh'
    ;;
  linux*)
    alias ls='ls --color=auto'
    ;;
esac

alias push_ssh_key='function _push_ssh_key(){ cat ~/.ssh/id_rsa.pub | ssh $@ "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"; }; _push_ssh_key'

alias ttmux='tmux -2 new-session -A -s ${USER}';

if [ -d "$HOME/dotfiles" ] ; then
  if [ -f "$HOME/dotfiles/PS1.sh" ] ; then
    . "$HOME/dotfiles/PS1.sh"
  fi
fi

if [ -d "$HOME/local" ] && [ -d "$HOME/local/bin" ] && [[ ":$PATH:" != *":$HOME/local/bin:"* ]] ; then
	export PATH=$HOME/local/bin:$PATH
fi

