# Project LitMux.
## Bored with plain old black and white Termux? Let's make it 🔥.

This is a simple script for [Termux](https://play.google.com/store/apps/details?id=com.termux) to switch from boring BASH shell and use [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) along with some basic [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) on your device, as well as some color schemes (Ported by me from [Gogh](https://github.com/Mayccoll/Gogh)). This also installs the fast, powerful, and highly customizable [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme for ZSH.

## Requirements:
 - A device running Android 5.0 or above. (Recommended to have Android 7.0+ coz of [this](https://www.reddit.com/r/termux/comments/dnzdbs/end_of_android56_support_on_20200101/))
 - Termux app, duh. (Install from [Google Play](https://play.google.com/store/apps/details?id=com.termux) or [F-Droid](https://f-droid.org/packages/com.termux/))


## Install:

Installing this is as easy as running the command below. (Recommended this on a clean Termux install)

```shell
bash -c "$(curl -fsSL https://git.io/Jei6P)"
```

## Getting Updates:

By default, you will be prompted to check for upgrades every few weeks. If you would like LitMux to automatically upgrade itself without prompting you, set the following in your `~/.zshrc`:

```shell
DISABLE_UPDATE_PROMPT=true
```

To disable automatic upgrades, set the following in your `~/.zshrc`:

```shell
DISABLE_AUTO_UPDATE=true
```

### Manual Updates

If you'd like to upgrade the shell and it's plugins at any point in time you just need to run:
```shell
litmux-upgrade
```

## Uninstalling LitMux

I get it. LitMux isn't for everyone. (TODO: Add a good farewell line here.)

If you want to uninstall LitMux, just run `litmux-purge` from the command-line. It will remove itself and revert to the plain old BASH shell and the default black and white color scheme.

## Credits/Thanks:
 - [Cabbagec](https://github.com/Cabbagec) for his [termux-ohmyzsh](https://github.com/Cabbagec/termux-ohmyzsh) script.
 - [icy](https://github.com/icy) for his [pacapt](https://github.com/icy/pacapt) wrapper.
 - The contributors of the [ohmyzsh](https://ohmyz.sh/) community to maintain such an awesome project.
 - All of the color schemes are ported by me from [Gogh](https://github.com/Mayccoll/Gogh), they deserve their kudos.
 - [romkatv](https://github.com/romkatv) for the awesome [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme for ZSH.
