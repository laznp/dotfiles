#!/usr/bin/env bash


# NVIM Automation
sudo pip3 install pynvim # NeoVim Python3 Support

# Utils
if [ ! -d "$HOME/.local/bin" ]; then mkdir -p $HOME/.local/bin; fi
ln -s $(pwd)/utils/* "$HOME/.local/bin/"

# Automate Config
if [ ! -d "$HOME/.config" ]; then mkdir -p "$HOME/.config"; fi
ln -s $(pwd)/alacritty "$HOME/.config/alacritty"
ln -s $(pwd)/betterlockscreen/betterlockscreenrc "$HOME/.config/betterlockscreenrc"
ln -s $(pwd)/alacritty "$HOME/.config/bspwm"
ln -s $(pwd)/dunst "$HOME/.config/dunst"
ln -s $(pwd)/i3 "$HOME/.config/i3"
ln -s $(pwd)/i3blocks "$HOME/.config/i3blocks"
ln -s $(pwd)/libinput-gestures/libinput-gestures.conf "$HOME/.config/libinput-gestures.conf"
ln -s $(pwd)/nvim-vim/ "$HOME/.config/nvim"
ln -s $(pwd)/picom "$HOME/.config/picom"
ln -s $(pwd)/polybar "$HOME/.config/polybar"
ln -s $(pwd)/rofi "$HOME/.config/ranger"
ln -s $(pwd)/rofi "$HOME/.config/rofi"
ln -s $(pwd)/rofi "$HOME/.config/sxhkd"
ln -s $(pwd)/vivid/ "$HOME/.config/vivid"
ln -s $(pwd)/wallpaper.png "$HOME/.wallpaper.png"
ln -s $(pwd)/wallpaper-light.png "$HOME/.wallpaper-light.png"
ln -s $(pwd)/xinit/xinitrc "$HOME/.xinitrc"
ln -sf $(pwd)/zsh/zsh_alias "$HOME/.zsh_alias"
ln -sf $(pwd)/zsh/zshenv "$HOME/.zshenv"

# ZSH Alias
if [ "$(grep "zsh_alias" ~/.zshrc | wc -l)" == "0" ]; then echo "source ~/.zsh_alias" >> ~/.zshrc; fi

# ZSH ENV
if [ "$(grep "zshenv" ~/.zshrc | wc -l)" == "0" ]; then echo "source ~/.zshenv" >> ~/.zshrc; fi

