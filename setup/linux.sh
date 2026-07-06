#!/usr/bin/env bash
set -euo pipefail

CUSTO_HOME="${CUSTO_HOME:-$HOME/.custo}"

sudo apt-get update
xargs -a "$CUSTO_HOME/apt.list" sudo apt-get install -y

# Linuxbrew for parity with mac (mise, starship, etc.)
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew bundle --file="$CUSTO_HOME/Brewfile"

FISH_BIN="$(command -v fish)"
if ! grep -qx "$FISH_BIN" /etc/shells; then
  echo "$FISH_BIN" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$SHELL" != "$FISH_BIN" ]]; then
  chsh -s "$FISH_BIN"
fi
