# Termux-ohmyzsh

A fork from [oh-my-termux](https://github.com/4679/oh-my-termux) 。让你的 Termux 变的五颜六色～

为 Termux 添加 [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) 终端环境，设置色彩样式（大部分来自 [Gogh](https://github.com/Mayccoll/Gogh) ）和 Powerline 字体（来自 [powerline/fonts](https://github.com/powerline/fonts)）。oh-my-zsh 主题默认为 agnoster，颜色样式默认为 Tango，字体默认为 Ubuntu。

**此 Repo 使用 Termux 官方源，在中国大陆可能需要将 Termux 应用添加到代理列表。**
## 使用：
```shell
sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)"
```

## 设置色彩样式：
运行更换色彩样式：
```shell
~/.termux/colors.sh
```

## 设置字体
运行更换字体：
```shell
~/.termux/fonts.sh
```

## 需要软件包：
 - curl

## 使用提示（参照Termux Wiki）
要调整字体大小，双指缩放即可。另外，Termux 使用音量键模拟一些 shell 功能：
* `音量减+C`：即 `Ctrl+C`，SIGINT 中断 shell 当前进程
* `音量减+D`：即 `Ctrl+D`，EOF 登出当前 shell
* `音量减+E`：即 `Ctrl+E`，移动 shell 光标至行尾
* `音量减+L`：即 `Ctrl+L`，清除屏幕内容
* `音量减+Z`：即 `Ctrl+Z`，SIGTSTP 暂停 shell 中当前进程

其他一些按键可以使用 `音量加+Q` 调出快捷小键盘，也可使用下列组合：
* `音量加+W`，`音量加+A`，`音量加+S`，`音量加+D`：移动光标上下左右
* `音量加+E`：ESC
* `音量加+T`：TAB
* `音量加+数字`：F1-F9，F10 使用数字 0
* `音量加+L`：管道符 “|”
* `音量加+H`：波浪符 “~"
* `音量加+U`：下划线 “_”
* `音量加+V`：控制音量

如需更好的打字输入支持，在 `音量加+Q` 的小键盘上向左滑动即可

## 示例
Tango 颜色主题 + oh-my-zsh agnoster 主题 + Ubuntu 字体：
![](./termux-ohmyzsh.png)
- - -

# Termux-ohmyzsh

A fork from [oh-my-termux](https://github.com/4679/oh-my-termux). It makes the app more colorful.

Termux-ohmyzsh implements oh-my-zsh on your Termux app, as well as some color schemes (most are from [Gogh](https://github.com/Mayccoll/Gogh)), and some Powerline fonts (ported from [powerline/fonts](https://github.com/powerline/fonts)). Default set is agnoster for oh-my-zsh, Tango for color scheme, and Ubuntu font.



**This repo requires Termux official repo. In mainland China, you may need to add Termux app to your proxy list in order to gain access to Termux official repository.**

## Install:
```shell
sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)"
```

## Change color scheme:
Run the script to change color scheme.
```shell
~/.termux/colors.sh
```
## Change font:
```shell
~/.termux/fonts.sh
```

## Requirements:
 - curl

## Tips (See Termux Wiki)
Use two-finger pinch to adjust font size. Termux use combination with volume keys to emulate some functions in shell:
* `VolDown+C`: `Ctrl+C`, send SIGINT to interrupt current process
* `VolDown+D`: `Ctrl+D`, EOF logout current session
* `VolDown+E`: `Ctrl+E`, move cursor to end of line in shell
* `VolDown+L`: `Ctrl+L`, clear terminal screen
* `VolDown+Z`: `Ctrl+Z`, send SIGTSTP to suspend current process

You can `VolUp+Q` to bring up an extra key bar, but you can also use combinations below:
* `VolUp+W/A/S/D`: Move cursor up/left/down/right
* `VolUp+E`: ESC
* `VolUp+T`: TAB
* `VolUp+Digits`: F1-F9, F10 is 0
* `VolUp+L`: pipe character "|"
* `VolUp+H`: tilt character "~"
* `VolUp+U`: underscore "_"
* `VolUp+V`: Volume control

For better text input experience, swipe left on the `VolUp+Q` key bar.


## Example
Tango color scheme + agnoster oh-my-zsh theme + Ubuntu font:

![](./termux-ohmyzsh.png)