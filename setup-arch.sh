#!/bin/bash

# Arch Linux Dotfiles Setup Script
# This script installs all necessary packages for the dotfiles configuration

set -e  # Exit on any error

echo "Starting Arch Linux dotfiles setup..."

# Update system first
sudo pacman -Syu --noconfirm

# Install git if not present
if ! command -v git &> /dev/null; then
    sudo pacman -S --noconfirm git
fi

# Check if paru is installed, if not install it
if ! command -v paru &> /dev/null; then
    if ! command -v yay &> /dev/null; then
        echo "Installing paru AUR helper..."
        git clone https://aur.archlinux.org/paru.git /tmp/paru
        cd /tmp/paru
        makepkg -si --noconfirm
        cd -
        rm -rf /tmp/paru
    else
        echo "Using yay as AUR helper..."
        AUR_HELPER="yay"
    fi
else
    AUR_HELPER="paru"
fi

# Base packages to install
BASE_PACKAGES=(
    # Shell and terminal
    "zsh" "alacritty" "lsd" "bat" "ripgrep" "bpytop" "axel" "duf" "fzf" "tldr" "doggo"
    
    # Text editor and development tools
    "neovim" "python-pip" "nodejs" "npm" "lua" "luarocks" "clang" "rust" "go"
    "python-language-server" "shellcheck" "python-pynvim" "python-lsp-server"
    
    # Window managers and desktop environment
    "hyprland" "bspwm" "sway" "rofi" "tofi" "waybar" "polybar" "xorg-server"
    "xorg-xrandr" "xorg-xinput" "xorg-xsetroot" "xorg-xset" "xclip" "xorg-xdpyinfo"
    
    # Audio and multimedia
    "pipewire" "pipewire-alsa" "pipewire-pulse" "pulseaudio" "pulseaudio-alsa"
    "pavucontrol" "mpd" "ncmpcpp" "playerctl" "mpv"
    
    # Compositor and visual effects
    "picom" "swaybg" "swaylock" "betterlockscreen"
    
    # File managers and utilities
    "ranger" "ueberzug" "lf" "thunar" "feh" "maim" "flameshot"
    
    # System utilities and monitoring
    "htop" "btop" "iftop" "iotop" "ncdu" "tree" "jq" "bc" "upower"
    "lm_sensors" "inxi"
    
    # Fonts and theming
    "ttf-jetbrains-mono-nerd" "ttf-roboto-mono-nerd" "ttf-d2coding-nerd"
    "ttf-firacode-nerd" "bibata-cursor-theme" "qt5ct" "qt6ct"
    
    # System and service tools
    "systemd" "polkit" "polkit-gnome" "gamemode" "syncthing" "openrazer-daemon"
    
    # Network and communication
    "networkmanager" "network-manager-applet" "bluez" "bluez-utils" "wireplumber"
    
    # Development and version control
    "git" "github-cli" "terraform" "terragrunt" "kubectl" "docker" "docker-compose"
    "aws-cli" "google-cloud-cli"
    
    # Hardware and input devices
    "libinput" "libinput-gestures"
    
    # Notifications and user interface
    "dunst" "libnotify" "mako"
    
    # Additional tools
    "noto-fonts-emoji" "xorg-xbacklight" "acpi" "acpid" "wireguard-tools"
    "openssh" "rsync" "unzip" "zip" "p7zip" "unrar" "file-roller"
    
    # Database tools
    "postgresql" "mariadb"
    
    # Python packages needed
    "python-black" "python-flake8" "python-mypy" "python-isort" "python-jedi"
)

# AUR packages to install
AUR_PACKAGES=(
    # AUR tools needed
    "zsh-syntax-highlighting" "zsh-autosuggestions" "betterlockscreen"
    "xremap" "kdeconnect" "cliphist" "vivid"
)

echo "Installing base packages..."
sudo pacman -S --noconfirm "${BASE_PACKAGES[@]}"

echo "Installing AUR packages..."
${AUR_HELPER} -S --noconfirm "${AUR_PACKAGES[@]}"

# Enable essential systemd services
echo "Enabling systemd services..."
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable openrazer-daemon
sudo systemctl enable syncthing@$(whoami)
sudo systemctl enable gamemode
sudo systemctl enable xremap  # if xremap service exists

# Install Python packages that might not be available as system packages
echo "Installing additional Python packages..."
pip install --user pynvim python-lsp-server black flake8 mypy isort jedi

# Install Node.js packages
echo "Installing global Node.js packages..."
npm install -g neovim

echo "Package installation completed!"

# Instructions for user
echo ""
echo "Setup complete! Next steps:"
echo "1. Install the dotfiles using GNU Stow (if not already installed): sudo pacman -S stow"
echo "2. Run 'stow -t ~ all' to symlink all dotfiles"
echo "3. Run 'stow -t ~ linux' to symlink Linux-specific dotfiles"
echo "4. Change your default shell to zsh: chsh -s \$(which zsh)"
echo "5. Restart your session to apply all changes"
echo "6. Run 'nvim' and execute ':Lazy sync' to install Neovim plugins"
