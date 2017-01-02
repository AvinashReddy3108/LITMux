#!/data/data/com.termux/files/usr/bin/bash
termux-setup-storage

apt update
apt install -y git zsh
git clone https://github.com/Cabbagec/termux-ohmyzsh.git $HOME/termux-ohmyzsh

mv $HOME/.termux $HOME/.termux.bak

mv $HOME/termux-ohmyzsh/.termux $HOME/.termux

git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
sed -i '/^ZSH_THEME/d' $HOME/.zshrc
sed -i '1iZSH_THEME="agnoster"' $HOME/.zshrc
chsh -s zsh

echo "oh-my-zsh install complete!\nChoose your color theme now~"
$HOME/.termux/colors.sh

echo "Please restart Termux app..."

exit