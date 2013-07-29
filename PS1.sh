#!/bin/bash

case "$TERM" in
  xterm*|rxvt*|*256*) SHOW_COLORED_PROMPT=yes;;
esac

if [ $SHOW_COLORED_PROMPT = "yes" ] ; then
  MY_PS1=""
  MY_USERNAME=`whoami | awk '{print tolower($0)}'`
  MY_HOSTNAME=`echo $HOSTNAME | awk -F'.' '{print tolower($1)}'`
  MY_SSH_CLIENT=`echo $SSH_CLIENT | awk '{print $1}'`

  if [ -n "$MY_SSH_CLIENT" ] ; then
    MY_PS1="\[\e[1;33m\]${MY_HOSTNAME}\[\e[0m\]\[\e[1;30m\]:\w\[\e[0m\]"
  else
    MY_PS1="\[\e[1;30m\]${MY_HOSTNAME}:\w\[\e[0m\]"
  fi

  if [ $MY_USERNAME = "root" ] ; then
    MY_PS1="${MY_PS1} \[\e[0;31m\][${MY_USERNAME}]#\[\e[0m\] "
  else
    MY_PS1="${MY_PS1} \[\e[0;32m\][${MY_USERNAME}]$\[\e[0m\] "
  fi

  if [ -n "$MY_PS1" ] ; then
    export PS1=${MY_PS1}
  fi
fi

