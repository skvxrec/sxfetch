#!/bin/sh

logo="           ____  ____
  _____ __/ __ \/ __/
 (_-<\\ \\ / /_/ /\\ \\  
/___/_\\_\\\\____/___/
       "

info="os     $(. /etc/os-release && echo $PRETTY_NAME)
kernel $(uname -r)
uptime $(uptime | sed 's/.*up //' | sed 's/,.*//')
shell  $(basename $SHELL)
memory $(free -m | awk '/Mem:/{print $3"M / "$2"M"}')"

paste <(echo "$logo") <(echo "$info")
