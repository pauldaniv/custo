#!/usr/bin/env bash
set -euo pipefail

CUSTO_HOME="${CUSTO_HOME:-$HOME/.custo}"

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

brew bundle --file="$CUSTO_HOME/Brewfile"
brew bundle --file="$CUSTO_HOME/Brewfile.mac"

# Make fish a login shell
FISH_BIN="$(command -v fish)"
if ! grep -qx "$FISH_BIN" /etc/shells; then
  echo "$FISH_BIN" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$SHELL" != "$FISH_BIN" ]]; then
  chsh -s "$FISH_BIN"
fi
