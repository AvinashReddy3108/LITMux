#!/data/data/com.termux/files/usr/bin/bash

# Giving Storage permision to Termux App.
termux-setup-storage

# Updating package repositories 
# and installing requirements.
apt update
apt install -y git zsh
git clone https://github.com/AvinashReddy3108/LitMux.git "$HOME/LitMux" --depth 1

# Making a backup of Termux config directory,
# just in case you want to revert.
mv "$HOME/.termux" "$HOME/.termux.bak.$(date +%Y.%m.%d-%H:%M:%S)"
cp -R "$HOME/LitMux/.termux" "$HOME/.termux"

# Installing Oh My ZSH as a replacement of BASH,
# plus setting up .zshrc file, and adding aliases.
git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" --depth 1
mv "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)"
cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"
sed -i '/^ZSH_THEME/d' "$HOME/.zshrc"
sed -i '1iZSH_THEME="agnoster"' "$HOME/.zshrc"
echo "alias chcolor='$HOME/.termux/litmux_colors.sh'" >> "$HOME/.zshrc"

# Installing Syntax Highlighting addon for ZSH,
# and sourcing it in the .zshrc file.
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"

# Installing powerlevel10k theme for ZSH,
# and sourcing it in the .zshrc file.
git clone https://github.com/romkatv/powerlevel10k.git "$HOME/.powerlevel10k" --depth 1
echo "source $HOME/.powerlevel10k/powerlevel10k.zsh-theme" >> "$HOME/.zshrc"

# Changing default shell to ZSH,
# goodbye boring BASH.
chsh -s zsh

echo "Let's choose a good color scheme for the shell, shall we ?"
echo "NOTE: use 'chcol' to change shell colors anytime later."
$HOME/.termux/litmux_colors.sh

echo "Restart the Termux app to enjoy the LIT experience."
exit
