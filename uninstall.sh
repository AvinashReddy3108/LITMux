#!/usr/bin/env bash

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
print_centered "";
print_centered "";
print_centered "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
print_centered "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
print_centered "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
print_centered "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
print_centered "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
print_centered "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
print_centered "";
print_centered "      Preparing to uninstall, please wait!      ";
print_centered "";
print_centered "";
sleep 3
clear

# Are you sure about that?
read -r -p "Are you sure you want to go back to plain old Termux? [y/N] " confirmation
if [ "$confirmation" != y ] && [ "$confirmation" != Y ]; then
    echo "Uninstall cancelled"
    exit
fi

# Restores stock welcome text.
cp -fr $HOME/.oh-my-zsh/custom/misc/LitMux/motd-default $PREFIX/etc/motd

# Restore the extra bells and whistles of touch keyboard.
rm -f ~/.termux/termux.properties

# Purge Oh-My-ZSH stuff.
rm -rf ~/.oh-my-zsh

# Restores stock color scheme.
rm -f ~/.termux/colors.properties

# Restores stock font.
rm -f ~/.termux/font.ttf

# Purges leftover stuff.
rm -f ~/.zshrc.pre-oh-my-zsh
rm -f ~/.zshrc.omz-uninstalled*
rm -f ~/.shell.pre-oh-my-zsh
rm -f ~/.p10k.zsh*
rm -f $PREFIX/tmp/.zshrc*

# Sets BASH as the default shell
chsh -s bash

# Uninstall ZSH
pkg uninstall zsh

# Reloads termux settings
termux-reload-settings

# Goodbye.
print_centered "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
print_centered "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
print_centered "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
print_centered "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
print_centered "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
print_centered "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
print_centered "";
print_centered "     Uninstall complete, sad to say goodbye!    ";
tput cnorm
exit 0
