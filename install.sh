#!/usr/bin/env bash

# Updating package repositories and installing packages.
echo -n -e "Syncing repositories and installing packages. \033[0K\r"
(pkg update && pkg install -y git zsh) &> /dev/null
sleep 2

# Giving Storage permision to Termux App.
if [ ! -d ~/storage ]; then
    echo -n -e "Setting up storage access for Termux. \033[0K\r"
    termux-setup-storage
    sleep 2
fi

if [ ! -f ~/.zshrc ]; then
    echo -n -e "Backing up current ZSH configuration. \033[0K\r"
    mkdir -p ~/storage/LITMux/backups
    mv ~/.zshrc ~/storage/LITMux/backup/zshrc.bak
    sleep 2
fi

# Installing ZInit.
echo -n -e "Installing ZInit framework for ZSH. \033[0K\r"
(echo 'Y' | sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)") &> /dev/null
sleep 2

# Changing default shell to ZSH.
chsh -s zsh

# Syntax highlighting, completions and suggestions.
echo -n -e "Setting up Syntax highlighting, completions and auto-suggestions for ZInit. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Syntax highlighting, completions and auto-suggestions.
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
EOF
sleep 2

# Installing powerlevel10k theme for ZSH.
echo -n -e "Setting up powerlevel10k theme for ZInit. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Powerlevel10k Theme.
zinit ice depth=1; zinit light romkatv/powerlevel10k
EOF
sleep 2

# Fix some keybinds for Termux.
echo -n -e "Fixing some common keybinds for ZSH. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Fixed common keybinds, thank me later.
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
EOF
sleep 2

# Shell aliases/functions.
echo -n -e "Adding some shell aliases to make life easier. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Add your aliases/functions here!
alias lit-colors='bash -c "$(curl -fsSl 'https://git.io/JURDN')"'
EOF
sleep 2

# Installing the Powerline font for Termux.
if [ ! -f ~/.termux/font.ttf ]; then
    echo -n -e "Installing Powerline patched font. \033[0K\r"
    curl -fsSL -o ~/.termux/font.ttf 'https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf' &> /dev/null
    sleep 2
fi

# Set a default color scheme.
if [ ! -f ~/.termux/colors.properties ]; then
    echo -n -e "Setting up a new color scheme. \033[0K\r"
    curl -fsSL -o ~/.termux/colors.properties 'https://raw.githubusercontent.com/AvinashReddy3108/Gogh4Termux/master/_base.properties' &> /dev/null
    sleep 2
fi

# Add new buttons to the Termux bottom bar.
if [ ! -f ~/.termux/termux.properties ]; then
    echo -n -e "Setting up some extra keys in Termux. \033[0K\r"
    curl -fsSL -o ~/.termux/termux.properties 'https://raw.githubusercontent.com/AvinashReddy3108/LitMux/master/.termux/termux.properties' &> /dev/null
    sleep 2
fi

# Reload Termux settings.
termux-reload-settings

# Run a ZSH shell, opens the p10k config wizard.
echo -n -e "Installation complete, gimme cookies! \033[0K\r"
sleep 3
if ! grep -q "zsh" "$SHELL"; then
    exec zsh -l
fi
exit
