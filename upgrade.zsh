#!/usr/bin/env zsh

# Credits: https://gist.github.com/TrinityCoder/911059c83e5f7a351b785921cf7ecdaa#how-to-do-it
print_centered() {
    [[ $# == 0 ]] && return 1

    declare -i TERM_COLS="$(tput cols)"
    declare -i str_len="${#1}"
    [[ $str_len -ge $TERM_COLS ]] && {
        echo "$1";
        return 0;
    }

    declare -i filler_len="$(( (TERM_COLS - str_len) / 2 ))"
    [[ $# -ge 2 ]] && ch="${2:0:1}" || ch=" "
    filler=""
    for (( i = 0; i < filler_len; i++ )); do
        filler="${filler}${ch}"
    done

    printf "%s%s%s" "$filler" "$1" "$filler"
    [[ $(( (TERM_COLS - str_len) % 2 )) -ne 0 ]] && printf "%s" "${ch}"
    printf "\n"

    return 0
}

clear
tput civis
print_centered ""
print_centered ""
print_centered "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
print_centered "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
print_centered "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
print_centered "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
print_centered "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
print_centered "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
print_centered "";
print_centered "      Preparing to upgrade, please wait !!      ";
print_centered ""
print_centered ""
sleep 3
clear

# Upgrade Oh-My-ZSH using native updater.
echo "Upgrading Oh-My-ZSH, please wait.."
$ZSH/tools/upgrade.sh > /dev/null

echo "Upgrading pacman wrapper, please wait!"
sudo curl -fsSL https://raw.githubusercontent.com/icy/pacapt/ng/pacapt > $PREFIX/bin/pacapt
sudo chmod 755 $PREFIX/bin/pacapt
sudo ln -sv $PREFIX/bin/pacapt $PREFIX/bin/pacman || true

# Upgrade all ZSH custom plugins and themes.
# A modified version of @TamCore's autoupdate plugin for ZSH.
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

    if git pull --ff-only
    then
        printf "${BLUE}%s${NORMAL}\n" "Hooray! $plugin_name has been updated and/or is at the current version."
    else
        printf "${RED}%s${NORMAL}\n" "There was an error updating $plugin_name. Try again later?"
    fi
done
tput cnorm
