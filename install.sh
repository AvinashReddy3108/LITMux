#!/usr/bin/env bash

# Turn off cursor.
setterm -cursor off

banner () {
clear
echo "                                      ";
echo "  _     ___  _____  __  __            ";
echo " | |   |_ _||_   _||  \/  | _  _ __ __";
echo " | |__  | |   | |  | |\/| || || |\ \ /";
echo " |____||___|  |_|  |_|  |_| \_,_|/_\_\\";
echo "                                      ";
echo "      Fast, beautiful, LIT AF!        ";
echo "                                      ";
}
banner

# Handy function to silence stuff.
shutt () {
    { "$@" || return $?; } | while read -r line; do
        :
    done
}

# Get fastest mirrors.
echo -n -e "Syncing with fastest mirrors. \033[0K\r"
(echo 'n' | pkg update 2>/dev/null) | while read -r line; do
    :
done
sleep 2

# Upgrade packages.
echo -n -e "Upgrading packages. \033[0K\r"
shutt apt-get upgrade -o Dpkg::Options::='--force-confnew' -y 2>/dev/null
sleep 2

# Updating package repositories and installing packages.
echo -n -e "Installing required packages. \033[0K\r"
shutt apt update 2>/dev/null
shutt apt install -y curl git zsh man jq perl fzf 2>/dev/null
sleep 2

# Installing BetterSUDO.
echo -n -e "Installing agnostic-apollo's SUDO wrapper (as bsudo). \033[0K\r"
curl -fsSL 'https://github.com/agnostic-apollo/sudo/releases/latest/download/sudo' -o $PREFIX/bin/bsudo
owner="$(stat -c "%u" "$PREFIX/bin")"
chown "$owner:$owner" "$PREFIX/bin/bsudo"
chmod 700 "$PREFIX/bin/bsudo"
sleep 2

# Giving Storage permision to Termux App.
if [ ! -d ~/storage ]; then
    echo -n -e "Setting up storage access for Termux. \033[0K\r"
    termux-setup-storage
    sleep 2
fi

# Backing up some Termux/Shell stuff.
mkdir -p ~/storage/shared/LITMux/backup
for i in "~/.zshrc" "~/.termux/font.ttf" "~/.termux/colors.properties" "~/.termux/termux.properties"
do
    if [ -f $i ]; then
        echo -n -e "Backing up current $i file. \033[0K\r"
        mv -f $i ~/storage/shared/LITMux/backup/$(date +%Y_%m_%d_%H_%M)/$(basename $i)
        sleep 1
    fi
done
sleep 2

# Installing ZInit.
echo -n -e "Installing ZInit framework for ZSH. \033[0K\r"
(echo 'Y' | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)") &> /dev/null
sleep 2

# Installing AndroFetch (slim AF 'neofetch' replacement)
echo -n -e "Installing AndroFetch. \033[0K\r"
curl -fsSL -o $PREFIX/bin/androfetch https://raw.githubusercontent.com/laraib07/androfetch/main/androfetch
chmod u+x $PREFIX/bin/androfetch
sleep 2

# Changing default shell to ZSH.
echo -n -e "Changing default shell to ZSH. \033[0K\r"
chsh -s zsh
sleep 2

# Importing some libs from Oh-My-ZSH
echo -n -e "Importing some libs from Oh-My-ZSH. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Loading some(?) Oh-My-ZSH libs with ZInit Turbo!
zinit lucid light-mode for \
    OMZL::history.zsh \
    OMZL::completion.zsh \
    OMZL::key-bindings.zsh
EOF
sleep 2

# Addons for ZInit.
echo -n -e "Setting up ZInit addons. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Syntax highlighting, completions, auto-suggestions and some other plugins.
zinit wait lucid light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
      OMZP::colored-man-pages \
      OMZP::git \
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

# Setting up FZF (keybinds and completion).
echo -n -e "Setting up FZF keybinds and completion. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# FZF (keybinds and completion).
zinit wait lucid is-snippet for \
    $PREFIX/share/fzf/key-bindings.zsh \
    $PREFIX/share/fzf/completion.zsh

# Use 16 colors
export FZF_DEFAULT_OPTS='--color 16'
EOF
sleep 2

# Shell aliases/functions.
echo -n -e "Adding some shell aliases/functions to make life easier. \033[0K\r"
cat <<'EOF' >> ~/.zshrc

# Add your aliases/functions here!

#### FUNCTIONS #####
function lit-colors() {
    if [ $(curl -I https://git.io 2>&1 | awk '/HTTP\// {print $2}') -eq 200 ]; then
    echo "Loading color scheme menu, please wait."
    bash -c "$(curl -fsSL 'https://git.io/JURDN')"
    clear
  else
    echo "Can't connect to color schemes repository."
  fi
}

function lit-fonts() {
  if [ $(curl -I https://git.io 2>&1 | awk '/HTTP\// {print $2}') -eq 200 ]; then
    echo "Loading font style menu, please wait."
    bash -c "$(curl -fsSL 'https://git.io/JtHgC')"
    clear
  else
    echo "Can't connect to font styles repository."
  fi
}

function lit-update() {
    echo "Updating system packages."
    pkg upgrade -y
    clear
    
    echo "Updating ZSH/Zinit stuff.."
    zi update --all
    clear
    
    echo "Updating bSUDO..."
    curl -L 'https://github.com/agnostic-apollo/sudo/releases/latest/download/sudo' -o $PREFIX/bin/bsudo
    owner="$(stat -c "%u" "$PREFIX/bin")"
    chown "$owner:$owner" "$PREFIX/bin/bsudo"
    chmod 700 "$PREFIX/bin/bsudo"
    clear
    
    echo "Updating Androfetch...."
    curl -o $PREFIX/bin/androfetch https://raw.githubusercontent.com/laraib07/androfetch/main/androfetch
    clear
    
    echo "Updated succesfully, enjoy!"
    sleep 2
    clear
}

#### ALIASES #####
alias fetch='androfetch'

EOF
sleep 2

# Installing the Powerline font for Termux.
if [ ! -f ~/.termux/font.ttf ]; then
    echo -n -e "Installing Powerline patched font. \033[0K\r"
    curl -fsSL -o ~/.termux/font.ttf 'https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf'
    sleep 2
fi

# Set a default color scheme.
if [ ! -f ~/.termux/colors.properties ]; then
    echo -n -e "Setting up a new color scheme. \033[0K\r"
    curl -fsSL -o ~/.termux/colors.properties 'https://raw.githubusercontent.com/AvinashReddy3108/Gogh4Termux/master/monokai-pro.properties'
    sleep 2
fi

# Set up Termux config file.
if [ ! -f ~/.termux/colors.properties ]; then
    echo -n -e "Setting up Termux's global configuration. \033[0K\r"
    curl -fsSL -o ~/.termux/termux.properties 'https://raw.githubusercontent.com/AvinashReddy3108/LitMux/master/.termux/termux.properties'
    sleep 2
fi

# Reload Termux settings.
termux-reload-settings

# Run a ZSH shell, opens the p10k config wizard.
banner
echo -n -e "Installation complete, gimme cookies! \033[0K\r"
sleep 3

# Restore cursor.
setterm -cursor on

if ! grep -lq "zsh" "$SHELL"; then
    clear
    exec zsh -l
fi
exit
