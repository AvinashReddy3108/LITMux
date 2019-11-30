#!/data/data/com.termux/files/usr/bin/zsh
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
echo "Upgrading Oh-My-ZSH, please wait.."
$ZSH/tools/upgrade.sh > /dev/null 2>> ~/litmux_err.log

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

clear
printf "${BLUE}%s${NORMAL}\n" "Upgrading custom plugins"

find "${ZSH_CUSTOM:-${ZSH/custom}}" -type d -name .git | while read d
do
p=$(dirname "$d")
cd "${p}"
plugin_name=$(basename "$p")

if git pull --rebase --stat origin master > /dev/null
then
  printf "${BLUE}%s${NORMAL}\n" "Hooray! $plugin_name has been updated and/or is at the current version."
else
  printf "${RED}%s${NORMAL}\n" "There was an error updating $plugin_name. Try again later?"
fi
done
