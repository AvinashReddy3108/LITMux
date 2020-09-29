#!/usr/bin/env bash

# Turn off cursor.
setterm -cursor off


echo "                                      ";
echo "  _     ___  _____  __  __            ";
echo " | |   |_ _||_   _||  \/  | _  _ __ __";
echo " | |__  | |   | |  | |\/| || || |\ \ /";
echo " |____||___|  |_|  |_|  |_| \_,_|/_\_\\";
echo "                                      ";
echo "      Fast, beautiful, LIT AF!        ";
echo "                                      ";

# Get fastest mirrors/sync.
echo -n -e "Syncing with fastest package mirrors. \033[0K\r"
(echo 'n' | pkg update) &> /dev/null
sleep 2

# Upgrade ALL packages to their latest versions.
echo -n -e "Upgrading current packages, please wait. \033[0K\r"
(apt-get -o Dpkg::Options::="--force-overwrite" upgrade -y) &> /dev/null
sleep 2

# Updating package repositories and installing packages.
echo -n -e "Installing required packages. \033[0K\r"
(pkg install -y git zsh) &> /dev/null
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
(echo 'Y' | sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)") &> /dev/null
sleep 2

# Changing default shell to ZSH.
echo -n -e "Changing default shell to ZSH. \033[0K\r"
chsh -s zsh
sleep 2

# Addons for ZInit.
echo -n -e "Setting up ZInit addons. \033[0K\r"
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
echo -n -e "Setting up powerlevel10k theme. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Powerlevel10k Theme.
zinit ice depth=1; zinit light romkatv/powerlevel10k
EOF
sleep 2

# Fix some keybinds for Termux.
echo -n -e "Fixing some common keybinds for ZSH. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Fixed common keybinds, thank me later.
# HOME/END keys
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# PAGEUP/PAGEDN keys
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# DELETE key
bindkey "^[[3~" delete-char
EOF
sleep 2

# ZSH does not save history by default, let's fix that.
echo -n -e "Enabling history across sessions for ZSH. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# History configuration.
HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

# record timestamp of command in HISTFILE
setopt extended_history

# delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_expire_dups_first

# ignore duplicated commands history list
setopt hist_ignore_dups

# ignore commands that start with space
setopt hist_ignore_space

# show command with history expansion to user before running it
setopt hist_verify

# share command history data
setopt share_history
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

# Restore cursor.
setterm -cursor on

if ! grep -q "zsh" "$SHELL"; then
    exec zsh -l
fi
exit
