# Project LitMux (I need a better name for this, lol.)
## Bored with plain old black and white Termux ? Let's make it 🔥.

This is a simple script for [Termux](https://play.google.com/store/apps/details?id=com.termux) to switch from boring BASH shell and use [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) along with some basic [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) on your device, as well as some color schemes (most are from [Gogh](https://github.com/Mayccoll/Gogh)). This also installs the fast powerful, and highly customizable [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme for ZSH.

## Install:
```shell
sh -c "$(curl -fsSL https://github.com/AvinashReddy3108/LitMux/raw/master/install.sh)"
```

## Change color scheme:
Run `chcolor` to change color scheme, or run:
```shell
~/.termux/litmux_colors.sh
```

## Requirements:
 - A device running Android 5.0 or above.
 - Termux app, duh (Install from [Google Play](https://play.google.com/store/apps/details?id=com.termux) or [F-Droid](https://f-droid.org/packages/com.termux/))
 - `wget` or `curl` installed in Termux via the `pkg` utility.


## Credits/Thanks:
 - [Cabbagec](https://github.com/Cabbagec) for his [termux-ohmyzsh](https://github.com/Cabbagec/termux-ohmyzsh) script.
 - [romkatv](https://github.com/romkatv) for the awesome [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme for ZSH.
