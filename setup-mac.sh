#!/usr/bin/env bash
# ── macOS Bootstrap ──
set -euo pipefail

echo "→ Installing Homebrew..."
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "→ Installing packages..."
brew install \
    zsh \
    git \
    stow \
    neovim \
    bat \
    lsd \
    ripgrep \
    fzf \
    starship \
    k9s \
    kubectl \
    helm \
    terraform \
    terragrunt \
    awscli \
    google-cloud-sdk \
    jq \
    tmux \
    alacritty \
    aerospace \
    sketchybar \
    gh \
    wireguard-tools \
    openssh \
    rsync \
    coreutils \
    findutils \
    gnu-sed \
    gnu-tar \
    wget \
    htop \
    tree \
    bc \
    unzip \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    vivid

echo "→ Installing Nerd Fonts..."
brew install --cask font-jetbrains-mono-nerd-font font-fira-sans font-d2coding

echo "→ Setting up dotfiles..."
cd "$(dirname "$0")"
stow -t ~ -d all zsh git tmux bat starship k9s ai-agent fonts
stow -t ~ -d mac nvim aerospace sketchybar alacritty

echo "→ Setting up zsh..."
echo "→ Setting default shell to zsh (may require password)..."
chsh -s "$(which zsh)" 2>/dev/null || sudo chsh -s "$(which zsh)" || echo "  Skipped. Run manually: chsh -s $(which zsh)"

echo "→ Installing npm globals..."
npm install -g neovim

echo "→ Configuring git..."
git config --global core.hooksPath ~/.git-hooks

echo "→ Done. Restart shell. Populate ~/.config/zsh/secrets manually."
