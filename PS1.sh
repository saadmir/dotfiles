#!/bin/bash

case "$TERM" in
  xterm*|rxvt*|*256*) SHOW_COLORED_PROMPT=yes;;
esac

if [ $SHOW_COLORED_PROMPT = "yes" ] ; then
  MY_PS1=""
  MY_USERNAME=`whoami | awk '{print tolower($0)}'`

  if [ -n $(command -v ip) ] ; then
    export WAN_IP=`ip route get 8.8.8.8 | awk 'NR==1 {print $NF}'`;
  fi
  if [ -z "${WAN_IP}" ] && [ -n $(command -v ipconfig) ] ; then
    export WAN_IP=`ipconfig getifaddr en0`;
  fi


  #this is mac
  if [ -n "$(command -v networksetup)" ] ; then
    INTERFACES_=`networksetup -listallhardwareports`;
    while read -r line
    do
      INTERFACE_=`echo "${line}" | grep "Device: " | sed -e "s/Device\://g" | tr -d ' '` ;
      if [ -n "${INTERFACE_}" ] ; then
        IP_=`ipconfig getifaddr ${INTERFACE_}`;
        if [ -n "${IP_}" ] && [ "${IP_}" != "${LAN_IP}" ] ; then
          export LAN_IP="${IP_}";
        fi
      fi
    done <<<"${INTERFACES_}"
  else

    #this is linux
    IFCONFIG="/sbin/ifconfig"
    for i in $(ls /sys/class/net); do
      if [ "$i" = "lo" ] ; then continue; fi
      IP_=`${IFCONFIG} $i | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
      if [ -n "${IP_}" ] && [ "${IP_}" != "${LAN_IP}" ] ; then
        export LAN_IP="${IP_}";
      fi
    done
  fi

  echo "WAN_IP: ${WAN_IP}";
  echo "LAN_IP: ${LAN_IP}";

  if [ -n "${WAN_IP}" ] ; then MY_IP="${WAN_IP}"; fi
  if [ -n "${LAN_IP}" ] ; then MY_IP="${LAN_IP}"; fi


  MY_HOSTNAME=`echo $HOSTNAME | awk -F'.' '{print tolower($1)}'`
  MY_SSH_CLIENT=`echo $SSH_CLIENT | awk '{print $1}'`

  if [ -n "$MY_SSH_CLIENT" ] ; then
		#hostname in green
    MY_HOSTNAME="\[\e[0;32m\]@${MY_HOSTNAME}\[\e[0m\]"
  else
    if [ -n "$MY_IP" ] ; then
      MY_HOSTNAME="${MY_IP}"
    fi
		#this is local to hostname in grey
    MY_HOSTNAME="\[\e[0;235m\]@${MY_HOSTNAME}\[\e[0m\]"
  fi

  export PS1="\[\e[0;32m\]${MY_USERNAME}\[\e[0m\]${MY_HOSTNAME}: \[\e[0;33m\]\w\[\e[0m\] $ "
  export SUDO_PS1="\[\e[0;31m\]${MY_USERNAME}\[\e[0m\]${MY_HOSTNAME}: \[\e[0;33m\]\w\[\e[0m\] # "
fi
