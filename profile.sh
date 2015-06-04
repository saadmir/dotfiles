#!/bin/bash

alias ls='ls --color=auto'
alias ttmux='tmux new-session -A -s saad'

if [ -f "PS1.sh" ] ; then
  . "PS1.sh"
fi

