#!/bin/bash
# Credits: https://www.unix.com/303021070-post6.html

# Credits: https://gist.github.com/TrinityCoder/911059c83e5f7a351b785921cf7ecdaa#how-to-do-it
print_centered() {
     [[ $# == 0 ]] && return 1

     declare -i TERM_COLS="$(tput cols)"
     declare -i str_len="${#1}"
     [[ $str_len -ge $TERM_COLS ]] && {
          echo "$1";
          return 0;
     }

     declare -i filler_len="$(( (TERM_COLS - str_len) / 2 ))"
     [[ $# -ge 2 ]] && ch="${2:0:1}" || ch=" "
     filler=""
     for (( i = 0; i < filler_len; i++ )); do
          filler="${filler}${ch}"
     done

     printf "%s%s%s" "$filler" "$1" "$filler"
     [[ $(( (TERM_COLS - str_len) % 2 )) -ne 0 ]] && printf "%s" "${ch}"
     printf "\n"

     return 0
}

clear
print_centered "██╗     ██╗████████╗███╗   ███╗██╗   ██╗██╗  ██╗";
print_centered "██║     ██║╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝";
print_centered "██║     ██║   ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ";
print_centered "██║     ██║   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ";
print_centered "███████╗██║   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗";
print_centered "╚══════╝╚═╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝";
print_centered "";
print_centered "   Preparing the list of themes, please wait!    ";
print_centered ""
print_centered ""

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
    array[ ($i + 1) ]=$( echo -e "${colors%".colors"}" | awk -F'/' '{print $NF}' )
    (( i=(i+2) ))
done

## FOR DEBUGGNG ONLY! 
# printf '%s\n' "${array[@]}"
# read -rsp "Press any key to continue..." -n1 key

# Build the menu with dynamic content
TERMINAL=$(tty) # Gather current terminal session for appropriate redirection
HEIGHT=25
WIDTH=50
CHOICE_HEIGHT=15
TITLE="LITMUX - Spice up your Termux!"
MENU="Choose a color scheme from the list below."

CHOICE=$(dialog --clear \
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
