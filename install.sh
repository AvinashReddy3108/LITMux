#!/data/data/com.termux/files/usr/bin/bash
termux-setup-storage

apt update
apt install -y git zsh
git clone https://github.com/Cabbagec/termux-ohmyzsh.git $HOME/termux-ohmyzsh

if [ -d "$HOME/.termux" ]; then
 mv $HOME/.termux $HOME/.termux.bak
fi

cp $HOME/termux-ohmyzsh/.termux $HOME/.termux

apt update
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i '/^ZSH_THEME/d' $HOME/.zshrc
sed -i '1iZSH_THEME="agnoster"' $HOME/.zshrc
chsh -s zsh

echo "oh-my-zsh install complete!\nChoose your color theme now~"
$HOME/.termux/colors.sh

echo "Please restart Termux app..."
sleep 2

exit