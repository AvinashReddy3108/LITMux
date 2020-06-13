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

show_banner() {
    clear
    print_centered ""
    print_centered ""
    print_centered "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
    print_centered "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
    print_centered "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
    print_centered "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
    print_centered "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
    print_centered "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
    print_centered "";
    print_centered "      Ditch the boring BASH and get LIT !!      ";
    print_centered ""
    print_centered ""
}

current_dir=$(pwd)
clear

# Updating package repositories.
echo "Checking repositories for updated packages, please wait..."
pkg upgrade

install_pkg() {
    for package in "$@"
    do
        if ! pkg list-installed 2> /dev/null | grep -q "$package"; then
            pkg install "$package"
        fi
    done
}

# We need this for 'tput'
install_pkg ncurses-utils
tput civis

git_handle_plugin_repo () {
    if [ -d "$2" ]; then
        cd "$2"
        git pull --ff-only
        cd $current_dir
    else
        git clone --depth 1 "$1" "$2"
    fi
}

sed_handle_plugin_zshrc () {
    if grep "plugins=" ~/.zshrc | sed -n 2p | grep "$1" ; then
        echo "The ZSH plugin '$1' is already installed in the .zshrc file."
    else
        sed -i "s/\(^plugins=([^)]*\)/\1 $1/" ~/.zshrc
    fi
}

sed_handle_alias_zshrc () {
    if grep "^alias $1=*" ~/.zshrc ; then
        true
    else
        sed -i "/^alias $1=*/d" ~/.zshrc
        echo "alias $1=$2" >> ~/.zshrc
    fi
}

# Welcome.
show_banner
sleep 3

# Giving Storage permision to Termux App.
if [ -d ~/storage ]; then
    termux-setup-storage
fi

show_banner
echo "Installing required packages, please wait...."
install_pkg git zsh dialog tsu proot

show_banner
echo "Installing pacman wrapper for Termux..."
sudo curl -fsSL https://raw.githubusercontent.com/icy/pacapt/ng/pacapt > $PREFIX/bin/pacapt
sudo chmod 755 $PREFIX/bin/pacapt
sudo ln -sv $PREFIX/bin/pacapt $PREFIX/bin/pacman || true

# Installing Oh My ZSH as a replacement of BASH.
show_banner
echo "Installing Oh-My-ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended" > /dev/null

# Changing default shell to ZSH, goodbye boring BASH.
chsh -s zsh

# Adding aliases for LITMUX stuff.
sed_handle_alias_zshrc "litmux-color" "'~/.oh-my-zsh/custom/misc/LitMux/.termux/colors.sh'"
sed_handle_alias_zshrc "litmux-style" "'p10k configure'"
sed_handle_alias_zshrc "litmux-upgrade" "'~/.oh-my-zsh/custom/misc/LitMux/upgrade.zsh'"
sed_handle_alias_zshrc "litmux-purge" "'~/.oh-my-zsh/custom/misc/LitMux/uninstall.sh'"

# Installing "Syntax Highlighting" addon for ZSH, and appending that to the plugins list.
show_banner
echo "Installing 'Syntax Highlighting' addon for Oh-My-ZSH..."
git_handle_plugin_repo "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
sed_handle_plugin_zshrc "zsh-syntax-highlighting"

# Installing "Auto Suggestions" addon for ZSH, and appending that to the plugins list.
show_banner
echo "Installing 'Auto Suggestions' addon for Oh-My-ZSH..."
git_handle_plugin_repo "https://github.com/zsh-users/zsh-autosuggestions.git" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
sed_handle_plugin_zshrc "zsh-autosuggestions"

# Installing "Custom Plugins Updater" addon for ZSH, and appending that to the plugins list.
show_banner
echo "Installing 'Custom Plugins Updater' addon for Oh-My-ZSH..."
git_handle_plugin_repo "https://github.com/TamCore/autoupdate-oh-my-zsh-plugins" "$HOME/.oh-my-zsh/custom/plugins/autoupdate"
sed_handle_plugin_zshrc "autoupdate"

# Cloning the LITMUX repo, to be handled by the updater.
git_handle_plugin_repo "https://github.com/AvinashReddy3108/LitMux.git" "$HOME/.oh-my-zsh/custom/misc/LitMux"

# Installing powerlevel10k theme for ZSH, and making it the current theme in .zshrc file.
show_banner
echo "Installing 'Powerlevel10K' theme for ZSH..."
git_handle_plugin_repo "https://github.com/romkatv/powerlevel10k.git" "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
sed -i 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1powerlevel10k/powerlevel10k\2~' ~/.zshrc

# Installing the Powerline font for Termux.
if [ ! -f ~/.termux/font.ttf ]; then
    show_banner
    echo "Installing the Powerline patched font for Termux..."
    curl -fsSL -o ~/.termux/font.ttf 'https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf' > /dev/null
fi

# Set 'Tango' as the default color scheme for the shell.
if [ ! -f ~/.termux/colors.properties ]; then
    show_banner
    echo "Changing default color scheme for Termux..."
    cp -fr "$HOME/.oh-my-zsh/custom/misc/LitMux/.termux/colors/_base.colors" ~/.termux/colors.properties
    termux-reload-settings
else
    show_banner
    echo "Using existing custom color scheme for Termux."
    termux-reload-settings
fi

# Add new buttons to the Termux bottom bar.
if [ ! -f ~/.termux/termux.properties ]; then
    show_banner
    echo "Adding extra buttons to Termux Keyboard..."
    cp -fr "$HOME/.oh-my-zsh/custom/misc/LitMux/.termux/termux.properties" ~/.termux/termux.properties
    termux-reload-settings
else
    show_banner
    echo "Using existing custom keyboard layout for Termux."
    termux-reload-settings
fi

# Replace the default welcome text with a customized one.
cp -fr "$HOME/.oh-my-zsh/custom/misc/LitMux/motd-lit" "$PREFIX/etc/motd"

# Run a ZSH shell, opens the p10k config wizard if not set up already.
clear
print_centered ""
print_centered ""
print_centered "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
print_centered "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
print_centered "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
print_centered "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
print_centered "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
print_centered "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
print_centered "";
print_centered "     Installation Complete, gimme cookies :P    ";
print_centered ""
print_centered ""
sleep 3

if [ ! -f ~/.p10k.zsh ]; then
    sed -i "/.p10k.zsh/d" ~/.zshrc
fi

if ! grep -q "zsh" "$SHELL"; then
    exec zsh -l
fi

tput cnorm
exit
