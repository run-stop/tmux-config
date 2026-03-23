#!/usr/bin/env bash
set -euo pipefail

TMUX_CONFIG_DIR="${HOME}/.config/tmux"
TPM_DIR="${TMUX_CONFIG_DIR}/plugins/tpm"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_ONLY=false
for arg in "$@"; do
  [[ "$arg" == "--config-only" ]] && CONFIG_ONLY=true
done

# -----------------------------------------------------------------------------
# Install tmux
# -----------------------------------------------------------------------------
install_tmux() {
  if command -v tmux &>/dev/null; then
    echo "tmux already installed: $(tmux -V)"
    return
  fi

  echo "Installing tmux..."

  if [[ "$(uname)" == "Darwin" ]]; then
    if ! command -v brew &>/dev/null; then
      echo "ERROR: Homebrew not found. Install it from https://brew.sh first." >&2
      exit 1
    fi
    brew install tmux

  elif [[ -f /etc/os-release ]]; then
    # shellcheck source=/dev/null
    . /etc/os-release
    case "${ID_LIKE:-$ID}" in
      *arch*)   sudo pacman -S --noconfirm tmux ;;
      *debian*|*ubuntu*) sudo apt-get install -y tmux ;;
      *fedora*|*rhel*|*centos*)
        if command -v dnf &>/dev/null; then sudo dnf install -y tmux
        else sudo yum install -y tmux; fi ;;
      *) echo "ERROR: Unsupported distro '${ID}'. Install tmux manually." >&2; exit 1 ;;
    esac
  else
    echo "ERROR: Cannot detect OS. Install tmux manually." >&2
    exit 1
  fi

  echo "tmux installed: $(tmux -V)"
}

# -----------------------------------------------------------------------------
# Deploy config
# -----------------------------------------------------------------------------
deploy_config() {
  echo "Deploying config to ${TMUX_CONFIG_DIR}..."
  mkdir -p "${TMUX_CONFIG_DIR}"

  local src="${SCRIPT_DIR}/tmux.conf"
  local dst="${TMUX_CONFIG_DIR}/tmux.conf"

  if [[ -f "$dst" && ! -L "$dst" ]]; then
    echo "Backing up existing tmux.conf -> tmux.conf.bak"
    cp "$dst" "${dst}.bak"
  fi

  ln -sf "$src" "$dst"
  echo "Symlinked: $dst -> $src"
}

# -----------------------------------------------------------------------------
# Bootstrap TPM
# -----------------------------------------------------------------------------
bootstrap_tpm() {
  if [[ -d "$TPM_DIR" ]]; then
    echo "TPM already present, pulling latest..."
    git -C "$TPM_DIR" pull --ff-only
  else
    echo "Cloning TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  fi
}

# -----------------------------------------------------------------------------
# Install plugins via TPM
# -----------------------------------------------------------------------------
install_plugins() {
  echo "Installing tmux plugins via TPM..."
  local plugin_path="${TMUX_CONFIG_DIR}/plugins/"
  # TPM reads TMUX_PLUGIN_MANAGER_PATH via 'tmux show-environment -g', not the shell
  # environment, so we must register it in tmux's global environment store.
  tmux start-server
  tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "$plugin_path"
  "${TPM_DIR}/bin/install_plugins"
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
echo "==> tmux setup"

if [[ "$CONFIG_ONLY" == false ]]; then
  install_tmux
fi

deploy_config
bootstrap_tpm
install_plugins

echo ""
echo "Done! Start a new tmux session or reload config inside tmux with:"
echo "  prefix + r   (if already in tmux)"
