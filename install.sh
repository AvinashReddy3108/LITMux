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

# Giving Storage permision to Termux App.
termux-setup-storage

# Updating package repositories 
# and installing requirements.
apt update
apt install -y git zsh

if [ -d "$HOME/.LitMux" ]; then
rm -rf "$HOME/.LitMux"
fi

git clone https://github.com/AvinashReddy3108/LitMux.git "$HOME/.LitMux" --depth 1

# Making a backup of Termux config directory,
# just in case you want to revert.
mv "$HOME/.termux" "$HOME/.termux.bak.$(date +%Y.%m.%d-%H:%M:%S)"
cp -R "$HOME/.LitMux/.termux" "$HOME/.termux"

# Installing Oh My ZSH as a replacement of BASH,
# plus setting up .zshrc file, and adding aliases.

if [ -d "$HOME/.oh-my-zsh" ]; then
rm -rf "$HOME/.oh-my-zsh"
fi

git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" --depth 1
mv "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)"
cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"
sed -i '/^ZSH_THEME/d' "$HOME/.zshrc"
sed -i '1iZSH_THEME="agnoster"' "$HOME/.zshrc"
echo "alias chcolor='$HOME/.termux/litmux_colors.sh'" >> "$HOME/.zshrc"

# Installing Syntax Highlighting addon for ZSH,
# and sourcing it in the .zshrc file.

if [ -d "$HOME/.zsh-syntax-highlighting" ]; then
rm -rf "$HOME/.zsh-syntax-highlighting"
fi

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"

# Installing powerlevel10k theme for ZSH,
# and sourcing it in the .zshrc file.

if [ -d "$HOME/.powerlevel10k" ]; then
rm -rf "$HOME/.powerlevel10k"
fi

git clone https://github.com/romkatv/powerlevel10k.git "$HOME/.powerlevel10k" --depth 1
curl -fsSL -o ~/.termux/font.ttf 'https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf'
echo "source $HOME/.powerlevel10k/powerlevel10k.zsh-theme" >> "$HOME/.zshrc"

# Changing default shell to ZSH,
# goodbye boring BASH.
chsh -s zsh

# Choosing a cool color scheme for ZSH.
clear
echo "Let's choose a good color scheme for the shell, shall we ?"
echo "NOTE: use 'chcolor' to change shell colors anytime later."
echo ""
$HOME/.termux/litmux_colors.sh

clear
termux-reload-settings
echo "LitMux Installed successfully, gimme cookies !"
echo "Restart the Termux app to enjoy the LIT experience."
echo "NOTE: use 'p10k configure' to configure your terminal prompt anytime later."
exit
