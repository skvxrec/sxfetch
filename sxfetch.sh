#!/bin/bash

if [ -f /etc/os-release ]; then
  . /etc/os-release
  os_id="$ID"
  os_name="$PRETTY_NAME"
else
  os_id=$(uname -s | tr '[:upper:]' '[:lower:]')
  os_name=$(uname -s)
fi

os_id="${SXFETCH_LOGO:-$os_id}"

case "$os_id" in
sxos)
  logo="           ____  ____
  _____ __/ __ \/ __/
 (_-<\\ \\ / /_/ /\\ \\
/___/_\\_\\\\____/___/
                "
  ;;
darwin)
  logo="                    ____   ____
  __ _  ___ _ ____ / __ \\ / __/
 /  ' \\/ _ \`// __// /_/ /_\\ \\
/_/_/_/\\_, / \\__/ \\____//___/
                             "
  ;;
arch)
  logo="   ___              __     __ __   __           _
  / _ |  ____ ____ / /   _/_// /  / /_ _    __ | |
 / __ | / __// __// _ \\ / / / _ \\/ __/| |/|/ / / /
/_/ |_|/_/   \\__//_//_// / /_.__/\\__/ |__,__/_/_/
                       |_|                  /_/   "
  ;;
void)
  logo=" _   __       _     __
| | / /___   (_)___/ /
| |/ // _ \\ / // _  /
|___/ \\___//_/ \\_,_/
                     "
  ;;
nixos)
  logo="   _  __ _        ____   ____
  / |/ /(_)__ __ / __ \\ / __/
 /    // / \\ \\ // /_/ /_\\ \\
/_/|_//_/ /_\\_\\ \\____//___/
                             "
  ;;
gentoo)
  logo="  _____           __
 / ___/___  ___  / /_ ___  ___
/ (_ // -_)/ _ \\/ __// _ \\/ _ \\
\\___/ \\__//_//_/\\__/ \\___/\\___/
                               "
  ;;
*)
  logo="   _    ____
  (_)__/ / /__
 / / _  /  '_/
/_/\\_,_/_/\\_\\
              "
  ;;
esac

if [ "$os_id" = "darwin" ]; then
  memory=$(vm_stat | awk '/Pages active/{print $3*4096/1024/1024}' | xargs printf "%.0fM")
  mem_info="$memory"
else
  mem_info=$(free -m | awk '/Mem:/{print $3"M / "$2"M"}')
fi

info="os     $os_name
kernel $(uname -r)
uptime $(uptime | sed 's/.*up //' | sed 's/,.*//')
shell  $(basename $SHELL)
memory $mem_info"

paste <(printf '%s\n' "$logo") <(printf '%s\n' "$info")
