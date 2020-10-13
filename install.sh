#!/usr/bin/env bash

# Turn off cursor.
setterm -cursor off

clear
echo "                                      ";
echo "  _     ___  _____  __  __            ";
echo " | |   |_ _||_   _||  \/  | _  _ __ __";
echo " | |__  | |   | |  | |\/| || || |\ \ /";
echo " |____||___|  |_|  |_|  |_| \_,_|/_\_\\";
echo "                                      ";
echo "      Fast, beautiful, LIT AF!        ";
echo "                                      ";

# Handy function to silence stuff.
muzzle () {
    { "$@" || return $?; } | while read -r line; do
    sleep '0.1'
    done
}

# Get fastest mirrors.
echo -n -e "Syncing with fastest mirrors. \033[0K\r"
muzzle (echo 'n'|pkg update)
sleep 2

# Upgrade packages.
echo -n -e "Upgrading packages. \033[0K\r"
muzzle apt-get -o Dpkg::Options::="--force-confnew" upgrade -q -y
sleep 2

# Updating package repositories and installing packages.
echo -n -e "Installing required packages. \033[0K\r"
muzzle pkg install -y curl git zsh
sleep 2

# Giving Storage permision to Termux App.
if [ ! -d ~/storage ]; then
    echo -n -e "Setting up storage access for Termux. \033[0K\r"
    termux-setup-storage
    sleep 2
fi

if [ -f ~/.zshrc ]; then
    echo -n -e "Backing up current ZSH configuration. \033[0K\r"
    mkdir -p ~/storage/shared/LITMux/backup
    mv ~/.zshrc ~/storage/shared/LITMux/backup/zshrc.bak
    sleep 2
fi

# Installing ZInit.
echo -n -e "Installing ZInit framework for ZSH. \033[0K\r"
muzzle (echo 'Y' | sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)")
sleep 2

# Changing default shell to ZSH.
echo -n -e "Changing default shell to ZSH. \033[0K\r"
chsh -s zsh
sleep 2

# Importing some libs from Oh-My-ZSH
echo -n -e "Importing some libs from Oh-My-ZSH. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Loading some(?) Oh-My-ZSH libs with ZInit Turbo!
zinit wait lucid for \
    OMZ::lib/history.zsh \
    OMZ::lib/completion.zsh \
    OMZ::lib/key-bindings.zsh
EOF
sleep 2

# Addons for ZInit.
echo -n -e "Setting up ZInit addons. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Syntax highlighting, completions, auto-suggestions and some other plugins.
zinit wait lucid light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
      zdharma/fast-syntax-highlighting \
      OMZ::plugins/colored-man-pages \
      OMZ::plugins/git \
  atload"!_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions
EOF
sleep 2

# Installing powerlevel10k theme for ZSH.
echo -n -e "Setting up powerlevel10k theme. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Powerlevel10k Theme.
zinit ice depth=1; zinit light romkatv/powerlevel10k
EOF
sleep 2

# Shell aliases/functions.
echo -n -e "Adding some shell aliases to make life easier. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Add your aliases/functions here!
alias lit-colors='bash -c "$(curl -fsSL 'https://git.io/JURDN')"'
EOF
sleep 2

# Installing the Powerline font for Termux.
if [ ! -f ~/.termux/font.ttf ]; then
    echo -n -e "Installing Powerline patched font. \033[0K\r"
    muzzle curl -o ~/.termux/font.ttf 'https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf'
    sleep 2
fi

# Set a default color scheme.
if [ ! -f ~/.termux/colors.properties ]; then
    echo -n -e "Setting up a new color scheme. \033[0K\r"
    muzzle curl -o ~/.termux/colors.properties 'https://raw.githubusercontent.com/AvinashReddy3108/Gogh4Termux/master/_base.properties'
    sleep 2
fi

# Add new buttons to the Termux bottom bar.
if [ ! -f ~/.termux/termux.properties ]; then
    echo -n -e "Setting up some extra keys in Termux. \033[0K\r"
    muzzle curl -o ~/.termux/termux.properties 'https://raw.githubusercontent.com/AvinashReddy3108/LitMux/master/.termux/termux.properties'
    sleep 2
fi

# Reload Termux settings.
termux-reload-settings

# Run a ZSH shell, opens the p10k config wizard.
echo -n -e "Installation complete, gimme cookies! \033[0K\r"
sleep 3

# Restore cursor.
setterm -cursor on

if ! grep -q "zsh" "$SHELL"; then
    exec zsh -l
fi
exit
