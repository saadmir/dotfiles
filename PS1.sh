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

	#get color codes from display_terminal_colors.hs
	 _GREEN="\[\e[38;5;22m\]"
	_RED="\[\e[38;5;196m\]"
	_GREY="\[\e[38;5;235m\]"
	_DARK_YELLOW="\[\e[38;5;58m\]"
	_END_COLOR="\[\e[0m\]"

	#default prompt color for local sessions
	_COLOR="${_GREY}"

	if [ -n "$MY_SSH_CLIENT" ] ; then
    MY_HOSTNAME="${MY_HOSTNAME}"
		#this is SSH session, show user and host names in green
		_COLOR="${_GREEN}"
  else
    if [ -n "$MY_IP" ] ; then
      MY_HOSTNAME="${MY_IP}"
    fi
  fi

  export PS1="${_COLOR}[${MY_USERNAME}@${MY_HOSTNAME}]: ${_DARK_YELLOW}\w $ ${_END_COLOR}"
  export SUDO_PS1="${_RED}${MY_USERNAME}@${MY_HOSTNAME}: \w # ${_END_COLOR}"
fi
