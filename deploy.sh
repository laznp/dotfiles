#!/usr/bin/env bash

NVIM_DIR="$HOME/.config/nvim"

# NVIM Automation
sudo pip3 install pynvim # NeoVim Python3 Support
if [ ! -d "$NVIM_DIR" ]; then mkdir -p "$NVIM_DIR"; fi
if [ ! -f "$NVIM_DIR/init.vim" ]; then ln -s $(pwd)/vim/vimrc $NVIM_DIR/init.vim; fi
if [ ! -d "$NVIM_DIR/template" ]; then ln -s $(pwd)/vim/template $NVIM_DIR/; fi

# ZSH
if [ ! -f "$HOME/.zsh_alias" ]; then ln -s $(pwd)/zsh/zsh_alias $HOME/.zsh_alias; fi
if [ "$(grep ".local/bin" ~/.zshrc | wc -l)" == "0" ]; then echo "export PATH=$PATH:~/.local/bin" >> ~/.zshrc; fi

# Utils
if [ ! -d "$HOME/.local/bin" ]; then mkdir -p $HOME/.local/bin; fi
ln -s $(pwd)/utils/* "$HOME/.local/bin/"

# ZSH Alias
if [ "$(grep "zsh_alias" ~/.zshrc | wc -l)" == "0" ]; then echo "source ~/.zsh_alias" >> ~/.zshrc; fi

# Automate Config
if [ ! -d "$HOME/.config" ]; then mkdir -p "$HOME/.config"; fi
ln -s $(pwd)/i3 "$HOME/.config/i3"
ln -s $(pwd)/i3blocks "$HOME/.config/i3blocks"
ln -s $(pwd)/alacritty "$HOME/.config/alacritty"
ln -s $(pwd)/rofi "$HOME/.config/rofi"
ln -s $(pwd)/picom "$HOME/.config/picom"
ln -s $(pwd)/polybar "$HOME/.config/polybar"
ln -s $(pwd)/libinput-gestures/libinput-gestures.conf "$HOME/.config/libinput-gestures.conf"
ln -s $(pwd)/wallpaper.png "$HOME/.wallpaper.png"
