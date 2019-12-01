#!/data/data/com.termux/files/usr/bin/bash

show_banner() {
clear
echo "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
echo "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
echo "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
echo "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
echo "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
echo "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
echo "";
echo "      Ditch the boring BASH and get LIT !!      ";
echo ""
echo ""
}

git_force_clone_shallow () {
   if [ -d "$2" ]; then
   rm -rf "$2"
   fi
   git clone --depth 1 "$1" "$2"
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
termux-setup-storage

# Updating package repositories and installing requirements.
echo "Checking repositories for updated packages, please wait..."
pkg update > /dev/null 2>> ~/litmux_err.log

show_banner
echo "Installing required packages, please wait...."
pkg install -y git zsh

# Installing Oh My ZSH as a replacement of BASH.
show_banner
echo "Installing Oh-My-ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended" > /dev/null

# Changing default shell to ZSH, goodbye boring BASH.
chsh -s zsh

# Adding aliases for LITMUX stuff.
sed_handle_alias_zshrc "litmux-color" "'$HOME/.oh-my-zsh/custom/misc/LitMux/.termux/colors.sh'"
sed_handle_alias_zshrc "litmux-style" "'p10k configure'"
sed_handle_alias_zshrc "litmux-upgrade" "'$HOME/.oh-my-zsh/custom/misc/LitMux/upgrade.zsh'"
sed_handle_alias_zshrc "litmux-purge" "'$HOME/.oh-my-zsh/custom/misc/LitMux/uninstall.sh'"

# Installing "Syntax Highlighting" addon for ZSH, and appending that to the plugins list.
show_banner
echo "Installing 'Syntax Highlighting' addon for Oh-My-ZSH..."
git_force_clone_shallow https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" > /dev/null
sed_handle_plugin_zshrc "zsh-syntax-highlighting"

# Installing "Custom Plugins Updater" addon for ZSH, and appending that to the plugins list.
show_banner
echo "Installing 'Custom Plugins Updater' addon for Oh-My-ZSH..."
git_force_clone_shallow https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "$HOME/.oh-my-zsh/custom/plugins/autoupdate" > /dev/null
sed_handle_plugin_zshrc "autoupdate"

# Cloning the LITMUX repo, to be handled by the updater.
git_force_clone_shallow https://github.com/AvinashReddy3108/LitMux.git "$HOME/.oh-my-zsh/custom/misc/LitMux" > /dev/null

# Installing powerlevel10k theme for ZSH, and making it the current theme in .zshrc file.
show_banner
echo "Installing 'Powerlevel10K' theme for ZSH..."
git_force_clone_shallow https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" > /dev/null
sed -i 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1powerlevel10k/powerlevel10k\2~' ~/.zshrc

# Installing the Powerline font for Termux.
show_banner
echo "Installing the Powerline patched font for Termux..."
curl -fsSL -o ~/.termux/font.ttf 'https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf' > /dev/null

# Set 'Tango' as the default color scheme for the shell.
if [ ! -e ~/.termux/colors.properties ]; then
show_banner
echo "Changing default color scheme for Termux..."
cp -fr "$HOME/.oh-my-zsh/custom/misc/LitMux/.termux/colors.properties" ~/.termux/colors.properties
termux-reload-settings
else
show_banner
echo "Using existing custom color scheme for Termux."
termux-reload-settings
fi

# Replace the default welcome text with a customized one.
cp -fr "$HOME/.oh-my-zsh/custom/misc/LitMux/motd-lit" "$PREFIX/etc/motd"

# Run a ZSH shell, opens the p10k config wizard if not set up already.
clear
echo "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
echo "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
echo "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
echo "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
echo "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
echo "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
echo "";
echo "      Installation Complete, gimme cookies.     ";
sleep 3

if [ ! -f ~/.p10k.zsh ]; then
sed -i "/.p10k.zsh/d" ~/.zshrc
fi

if ! grep -q "zsh" "$SHELL"; then
exec zsh -l
fi

exit
