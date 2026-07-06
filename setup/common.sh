#!/usr/bin/env bash
set -euo pipefail

# sdkman — keep alongside mise for JVM-heavy workflows
if [[ ! -d "$HOME/.sdkman" ]]; then
  curl -s "https://get.sdkman.io" | bash
fi

# mise — language runtime manager (replaces pyenv/nvm/asdf)
if command -v mise &>/dev/null; then
  mise trust "$HOME/.config/mise/config.toml" || true
  mise install || true
fi
