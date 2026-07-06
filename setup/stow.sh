#!/usr/bin/env bash
set -euo pipefail

CUSTO_HOME="${CUSTO_HOME:-$HOME/.custo}"

cd "$CUSTO_HOME/dotfiles"
for pkg in */; do
  pkg="${pkg%/}"
  echo "stow -> $pkg"
  stow --target="$HOME" --restow "$pkg"
done
