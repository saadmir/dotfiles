#!/bin/bash

case "$TERM" in
  xterm*|rxvt*|*256*) SHOW_COLORED_PROMPT=yes;;
esac

if [ $SHOW_COLORED_PROMPT = "yes" ] ; then
  MY_PS1=""
  MY_USERNAME=`whoami | awk '{print tolower($0)}'`

  HAS_IPCONFIG=`command -v ipconfig`;
  if [ -n "$HAS_IPCONFIG" ] ; then
    MY_IP=`ipconfig getifaddr en0`
  fi

  MY_HOSTNAME=`echo $HOSTNAME | awk -F'.' '{print tolower($1)}'`
  MY_SSH_CLIENT=`echo $SSH_CLIENT | awk '{print $1}'`

  if [ -n "$MY_SSH_CLIENT" ] ; then
    MY_HOSTNAME="${MY_HOSTNAME}"
  else
    if [ -n "$MY_IP" ] ; then
      MY_HOSTNAME="${MY_IP}"
    fi
  fi

  export PS1="\[\e[0;32m\][${MY_USERNAME}@${MY_HOSTNAME}]:\[\e[0m\] \[\e[0;33m\]\w\[\e[0m\] $ "
  export SUDO_PS1="\[\e[0;31m\][${MY_USERNAME}@${MY_HOSTNAME}]:\[\e[0m\] \[\e[0;33m\]\w\[\e[0m\] # "
fi

alias ls='ls --color=auto'
