#!/usr/bin/env bash


# NVIM Automation
sudo pip3 install pynvim # NeoVim Python3 Support

if [ "$1" == "mac" ]; then
    if [ ! -d "$HOME/.config" ]; then mkdir -p "$HOME/.config"; fi
    ln -sf $(pwd)/alacritty "$HOME/.config/alacritty"
    ln -sf $(pwd)/nvim-lua/ "$HOME/.config/nvim"
    ln -sf $(pwd)/wallpaper.png "$HOME/.wallpaper.png"
    ln -sf $(pwd)/wallpaper-light.png "$HOME/.wallpaper-light.png"
    ln -sf $(pwd)/zsh/zsh_alias "$HOME/.zsh_alias"
    ln -sf $(pwd)/zsh/zshenv "$HOME/.zshenv"
    if [ "$(grep "zsh_alias" ~/.zshrc | wc -l)" == "0" ]; then echo "source ~/.zsh_alias" >> ~/.zshrc; fi
    if [ "$(grep "zshenv" ~/.zshrc | wc -l)" == "0" ]; then echo "source ~/.zshenv" >> ~/.zshrc; fi
else
    # Utils
    if [ ! -d "$HOME/.local/bin" ]; then mkdir -p $HOME/.local/bin; fi
    ln -sf $(pwd)/utils/* "$HOME/.local/bin/"

    # Automate Config
    if [ ! -d "$HOME/.config" ]; then mkdir -p "$HOME/.config"; fi
    ln -sf $(pwd)/alacritty "$HOME/.config/alacritty"
    ln -sf $(pwd)/betterlockscreen/betterlockscreenrc "$HOME/.config/betterlockscreenrc"
    ln -sf $(pwd)/bspwm "$HOME/.config/bspwm"
    ln -sf $(pwd)/dunst "$HOME/.config/dunst"
    ln -sf $(pwd)/i3 "$HOME/.config/i3"
    ln -sf $(pwd)/i3blocks "$HOME/.config/i3blocks"
    ln -sf $(pwd)/libinput-gestures/libinput-gestures.conf "$HOME/.config/libinput-gestures.conf"
    ln -sf $(pwd)/nvim-lua/ "$HOME/.config/nvim"
    ln -sf $(pwd)/picom "$HOME/.config/picom"
    ln -sf $(pwd)/polybar "$HOME/.config/polybar"
    ln -sf $(pwd)/ranger "$HOME/.config/ranger"
    ln -sf $(pwd)/rofi "$HOME/.config/rofi"
    ln -sf $(pwd)/sxhkd "$HOME/.config/sxhkd"
    ln -sf $(pwd)/vivid/ "$HOME/.config/vivid"
    ln -sf $(pwd)/wallpaper.png "$HOME/.wallpaper.png"
    ln -sf $(pwd)/wallpaper-light.png "$HOME/.wallpaper-light.png"
    ln -sf $(pwd)/xinit/xinitrc "$HOME/.xinitrc"
    ln -sf $(pwd)/zsh/zsh_alias "$HOME/.zsh_alias"
    ln -sf $(pwd)/zsh/zshenv "$HOME/.zshenv"

    # Fonts
    if [ ! -d "$HOME/.local/share" ]; then mkdir -p $HOME/.local/share; fi
    ln -sf $(pwd)/fonts "$HOME/.local/share/"

    # Systemd User
    if [ ! -d "$HOME/.config/systemd/user" ]; then mkdir -p $HOME/.config/systemd/user; fi
    ln -sf $(pwd)/systemd/* "$HOME/.config/systemd/user"

    # ZSH Alias
    if [ "$(grep "zsh_alias" ~/.zshrc | wc -l)" == "0" ]; then echo "source ~/.zsh_alias" >> ~/.zshrc; fi

    # ZSH ENV
    if [ "$(grep "zshenv" ~/.zshrc | wc -l)" == "0" ]; then echo "source ~/.zshenv" >> ~/.zshrc; fi
fi
