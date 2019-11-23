#!/data/data/com.termux/files/usr/bin/bash
clear
echo "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
echo "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
echo "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
echo "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
echo "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
echo "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
echo "";
echo "      Ditch the boring BASH and get LIT !!      ";
sleep 3

git_force_clone_shallow () {
   if [ -d "$2" ]; then
   rm -rf "$2"
   fi
   git clone --depth 1 $1 $2
}

# Giving Storage permision to Termux App.
termux-setup-storage

# Updating package repositories and installing requirements.
pkg update
pkg install -y git zsh

# Installing Oh My ZSH as a replacement of BASH.
echo "Installing oh-my-ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"

# Changing default shell to ZSH, goodbye boring BASH.
chsh -s zsh

# Adding aliases for stuff
echo "alias litmux-color='$HOME/.oh-my-zsh/custom/misc/LitMux/litmux_colors.sh'" >> ~/.zshrc
echo "alias litmux-style='p10k configure'"
echo "alias litmux-update='upgrade_oh_my_zsh'"

# Installing "Syntax Highlighting" addon for ZSH, and appending that to the plugins list.
git_force_clone_shallow https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
sed -i 's/\(^plugins=([^)]*\)/\1 zsh-syntax-highlighting/' ~/.zshrc

# Installing "Custom Plugins Updater" addon for ZSH, and appending that to the plugins list.
git_force_clone_shallow https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "$HOME/.oh-my-zsh/custom/plugins/autoupdate"
sed -i 's/\(^plugins=([^)]*\)/\1 autoupdate/' ~/.zshrc

# Cloning the LITMUX repo, to be handled by the Oh-My-ZSH updater.
git_force_clone_shallow https://github.com/AvinashReddy3108/LitMux.git "$HOME/.oh-my-zsh/custom/misc/LitMux"

# Installing powerlevel10k theme for ZSH, and making it the current theme in .zshrc file.
git_force_clone_shallow https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/zsh-syntax-highlighting"
sed -i 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1powerlevel10k/powerlevel10k\2~' ~/.zshrc

# Installing the Powerline font for Termux.
curl -fsSL -o ~/.termux/font.ttf 'https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf'

# set 'Tango' as the default color scheme for the shell.
cp -fr "$HOME/.oh-my-zsh/custom/misc/LitMux/.termux/colors.properties" ~/colors.properties

# Run a ZSH shell, atleast for the powerlevel10k wizard
exec zsh -l
