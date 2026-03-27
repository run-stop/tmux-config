# tmux + alacritty config

Personal terminal setup: [Alacritty](https://alacritty.org/) as the terminal emulator launching [tmux](https://github.com/tmux/tmux) automatically, with plugin management via [TPM](https://github.com/tmux-plugins/tpm).

## tmux Plugins

| Plugin | Purpose |
|--------|---------|
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | Sensible defaults |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Save/restore sessions |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Auto-save sessions |
| [catppuccin/tmux](https://github.com/catppuccin/tmux) | Mocha color theme |
| [tmux.nvim](https://github.com/aserowy/tmux.nvim) | Seamless tmux/Neovim navigation |
| [tmux-yank](https://github.com/tmux-plugins/tmux-yank) | Copy to system clipboard |
| [tmux-cpu](https://github.com/tmux-plugins/tmux-cpu) | CPU stats in status bar |

## Alacritty

Alacritty is configured with:

- **Theme**: Catppuccin Macchiato (Mocha variant also included)
- **Font**: [ComicShannsMono Nerd Font](https://www.nerdfonts.com/font-downloads), size 14
- **Shell**: tmux (launches automatically on terminal open)
- **Window**: 120×40, 95% opacity, blur enabled

> **Note:** The font must be installed separately before opening Alacritty.

## Install

```bash
git clone <this-repo> ~/tmux-config
cd ~/tmux-config
bash install.sh
```

This installs and configures both tmux and alacritty.

Skip the package installation step (deploy configs only):

```bash
bash install.sh --config-only
```

### Configs deployed

| Config | Destination |
|--------|-------------|
| `tmux.conf` | `~/.config/tmux/tmux.conf` |
| `alacritty/alacritty.toml` | `~/.config/alacritty/alacritty.toml` |
| `alacritty/catppuccin-macchiato.toml` | `~/.config/alacritty/catppuccin-macchiato.toml` |
| `alacritty/catppuccin-mocha.toml` | `~/.config/alacritty/catppuccin-mocha.toml` |

Existing configs are backed up with a `.bak` extension before being replaced.

## Key bindings

| Key | Action |
|-----|--------|
| `Ctrl+b` | Prefix |
| `C-h/j/k/l` | Navigate panes (shared with Neovim) |
| `M-h/j/k/l` | Resize panes |
