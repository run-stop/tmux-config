# tmux config

Personal tmux configuration with [TPM](https://github.com/tmux-plugins/tpm).

## Plugins

| Plugin | Purpose |
|--------|---------|
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | Sensible defaults |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Save/restore sessions |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Auto-save sessions |
| [catppuccin/tmux](https://github.com/catppuccin/tmux) | Mocha color theme |
| [tmux.nvim](https://github.com/aserowy/tmux.nvim) | Seamless tmux/Neovim navigation |
| [tmux-yank](https://github.com/tmux-plugins/tmux-yank) | Copy to system clipboard |
| [tmux-cpu](https://github.com/tmux-plugins/tmux-cpu) | CPU stats in status bar |

## Install

```bash
git clone <this-repo> ~/tmux-config
cd ~/tmux-config
bash install.sh
```

Skip the tmux installation step (if tmux is already installed):

```bash
bash install.sh --config-only
```

## Key bindings

| Key | Action |
|-----|--------|
| `Ctrl+b` | Prefix |
| `C-h/j/k/l` | Navigate panes (shared with Neovim) |
| `M-h/j/k/l` | Resize panes |
