# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).
These configs power an Arch Linux desktop (Hyprland/bspwm) and macOS laptop, sharing a common cross-platform shell environment.

## Structure

```
.
├── all/          # Cross-platform — works on both Linux and macOS
├── linux/        # Linux-specific (WM, compositor, bar, notifications, etc.)
├── mac/          # macOS-specific
└── setup-arch.sh # Bootstrap script for Arch Linux
```

Each directory is a Stow package containing the exact filesystem tree relative to `$HOME`.
Running `stow -t ~ <package>` creates symlinks from `$HOME` into the repo.

### Packages

| Platform | Packages                                                                                                                                                                           |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **all**      | zsh, git, tmux, bat, starship, k9s, opencode, fonts                                                                                                                                |
| **linux**    | Hyprland, bspwm, waybar, nvim, rofi, polybar, alacritty, dunst, ly, pipewire, ranger, systemd, tofi, vivid, wallpapers, wireplumber, xremap, picom, swaylock, swappy, sxhkd, utils |
| **mac**      | aerospace, sketchybar, nvim, alacritty, utils                                                                                                                                      |

### What's configured

- **zsh** — modular shell config (`env` / `alias` split), secrets isolation, starship prompt
- **git** — multi-profile setup (personal, work, autobahn) with conditional includes and LFS hooks
- **tmux** — status bar, keybinds, mouse support, persistent sessions via continuum/resurrect
- **starship** — custom prompt with git/K8s status, docker/python context
- **k9s** — Kubernetes TUI theme and keybind overrides
- **opencode** — AI-assisted dev tool with custom agent definitions and MCP servers (K8s, Slack, GitHub, Grafana)
- **Desktop (Linux)** — Hyprland (Wayland compositor) or bspwm (X11), waybar/polybar status bars, rofi launcher, dunst notifications, alacritty terminal, ly login manager
- **nvim** — editor config (separate per platform for UI differences)
- **macOS** — aerospace tiling WM, sketchybar menu bar

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
- Git

## Installation

```bash
git clone git@github.com:laznp/dotfiles.git ~/Projects/personal/dotfiles
cd ~/Projects/personal/dotfiles

# Cross-platform configs
stow -t ~ -d all zsh git tmux bat starship k9s opencode

# Linux desktop
stow -t ~ -d linux nvim hyprland waybar rofi alacritty dunst ly

# macOS
stow -t ~ -d mac nvim aerospace sketchybar alacritty
```

### Arch Linux fresh install

```bash
./setup-arch.sh
```

This installs system packages, AUR packages (via paru), and core tooling.

## Secrets

Tokens and API keys (GitHub, Slack, Grafana, etc.) are stored in `~/.config/zsh/secrets`, which is excluded from git via `.gitignore`. The `.zshrc` sources it automatically:

```zsh
[ -f $HOME/.config/zsh/secrets ] && source $HOME/.config/zsh/secrets
```

Machine-specific PATHs and generated completions can go directly in `.zshrc` — only the secrets file is gitignored.

## Screenshots

![Desktop](.screenshot2.png)