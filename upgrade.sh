#!/data/data/com.termux/files/usr/bin/bash
clear
echo "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
echo "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
echo "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
echo "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
echo "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
echo "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
echo "";
echo "      Preparing to upgrade, please wait !!      ";
sleep 3

clear

# Upgrade Oh-My-ZSH using native updater.
upgrade_oh_my_zsh

# Upgrade all ZSH custom plugins and themes.
# A forced version of TamCore's autoinstall plugin for ZSH.
# https://github.com/TamCore/autoupdate-oh-my-zsh-plugins/blob/master/autoupdate.plugin.zsh

if which tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  BLUE="$(tput setaf 4)"
  NORMAL="$(tput sgr0)"
else
  BLUE=""
  BOLD=""
  NORMAL=""
fi

printf "${BLUE}%s${NORMAL}\n" "Upgrading custom plugins"

find "${ZSH_CUSTOM}" -type d -name .git | while read d
do
p=$(dirname "$d")
cd "${p}"

if git pull --rebase --stat origin master
then
  printf "${BLUE}%s${NORMAL}\n" "Hooray! $d has been updated and/or is at the current version."
else
  printf "${RED}%s${NORMAL}\n" 'There was an error updating. Try again later?'
fi
done
