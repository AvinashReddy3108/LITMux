#!/bin/bash
# Credits: https://www.unix.com/303021070-post6.html

clear
echo "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
echo "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
echo "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
echo "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
echo "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
echo "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
echo "";
echo "   Preparing the list of themes, please wait.      ";
echo ""
echo ""

COLORS_DIR="$HOME/.oh-my-zsh/custom/misc/LitMux/.termux/colors"

i=1 # Index counter for adding to array.
j=1 # Option menu value generator.
count=1 # The 'actual' array of files.

# Dynamic dialogs require an array that has a staggered structure
# array[1]=1
# array[2]=First_Menu_Option
# array[3]=2
# array[4]=Second_Menu_Option

declare -a array
for colors in "$COLORS_DIR"/*.colors; do
    colors_name[count]=$( echo "$colors" | awk -F'/' '{print $NF}' )
    count=$(( count + 1 ))
    array[ $i ]=$j
    (( j++ ))
    array[ ($i + 1) ]=$( echo "$colors" | awk -F'/' '{print $NF}' )
    (( i=(i+2) ))
done

## FOR DEBUGGNG ONLY! 
# printf '%s\n' "${array[@]}"
# read -rsp "Press any key to continue..." -n1 key

# Build the menu with dynamic content
TERMINAL=$(tty) # Gather current terminal session for appropriate redirection
HEIGHT=20
WIDTH=76
CHOICE_HEIGHT=16
BACKTITLE="https://github.com/AvinashReddy3108/LitMux"
TITLE="LITMUX - Spice up your Termux!"
MENU="Choose a color scheme from the list below."

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${array[@]}" \
                2>&1 >"$TERMINAL")
clear
echo "Applying color scheme: ${colors_name[$CHOICE]}"
if cp -fr "$COLORS_DIR/${colors_name[$CHOICE]}" "$HOME/.termux/colors.properties"; then
    termux-reload-settings
    clear
else
    echo "Failed to apply color scheme."
fi
