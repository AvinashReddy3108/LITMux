# LITMux - Termux made [LIT AF](https://www.urbandictionary.com/define.php?term=lit&defid=7514041)!

This is a simple, personal bootstrap script for [Termux](https://play.google.com/store/apps/details?id=com.termux) to switch away from the boring BASH shell it comes with as the default.

## Features
- A minimal ZSh setup, consisting of:
    - Ultra-flexible and fast [plugin manager](https://github.com/zdharma/zinit), compatible with most of the plugins in the wild.
    - A really fast and reliable [syntax-highlighter](https://github.com/zdharma/fast-syntax-highlighting).
    - Reliable [shell completions](https://github.com/zsh-users/zsh-completions) and [automatic suggestions](https://github.com/zsh-users/zsh-autosuggestions).
    - A color-scheme chooser with large library of themes (Ported from [Gogh](https://github.com/Mayccoll/Gogh), and hosted [here](https://github.com/AvinashReddy3108/Gogh4Termux) by yours truly).
    - A huge library of fonts from the [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) project.
    - The fast, powerful, and highly customizable [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme.

## Requirements:
 - A device running Android 5.0 or above. (Recommended to have Android 7.0+ coz of [this](https://www.reddit.com/r/termux/comments/dnzdbs/end_of_android56_support_on_20200101/))
 - Termux app, __duh__. (Install from [Google Play](https://play.google.com/store/apps/details?id=com.termux) or [F-Droid](https://f-droid.org/packages/com.termux/))


## Install:
Installing this is as easy as running the command below in Termux.
```shell
bash -c "$(curl -fsSL https://git.io/Jei6P)"
```

Don't worry, the existing `.zshrc` file will be backed up in your storage for later. You can find it in the `backup` directory at the location below.
> Internal Storage (`/sdcard` [or] `/storage/emulated/0`) -> `LITMux` -> `backup` -> `zshrc.bak`

## Credits/Thanks:
 - [Cabbagec](https://github.com/Cabbagec) for his [termux-ohmyzsh](https://github.com/Cabbagec/termux-ohmyzsh) script.
 - The contributors of the [ZInit](https://github.com/zdharma/zinit) framework to maintain such an awesome project.
 - All of the color schemes are ported by me from [Gogh](https://github.com/Mayccoll/Gogh), they deserve their kudos.
 - The [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) project, for the awesome fonts.
 - [romkatv](https://github.com/romkatv) for the awesome [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme for ZSH.
