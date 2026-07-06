#!/usr/bin/env bash
set -euo pipefail

# auto-venv toggle state, read/written by bin/extensions/python.{sh,fish}
AUTO_VENV_CONFIG="$HOME/.config/custom/auto_venv.txt"
mkdir -p "$(dirname "$AUTO_VENV_CONFIG")"
[[ -f "$AUTO_VENV_CONFIG" ]] || echo "no" >"$AUTO_VENV_CONFIG"

# sdkman — keep alongside mise for JVM-heavy workflows
if [[ ! -d "$HOME/.sdkman" ]]; then
  curl -s "https://get.sdkman.io" | bash
fi

# mise — language runtime manager (replaces pyenv/nvm/asdf)
if command -v mise &>/dev/null; then
  mise trust "$HOME/.config/mise/config.toml" || true
  mise install || true
fi
