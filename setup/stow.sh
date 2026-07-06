#!/usr/bin/env bash
set -euo pipefail

CUSTO_HOME="${CUSTO_HOME:-$HOME/.custo}"

cd "$CUSTO_HOME/dotfiles"
for pkg in */; do
  pkg="${pkg%/}"

  # Machines set up before `stow` was in the pipeline may have real files
  # (not symlinks) sitting where stow wants to place its links. Stow refuses
  # to touch those. Self-heal: if the real file already matches what stow
  # would link, drop it; otherwise back it up so `--restow` doesn't abort.
  while IFS= read -r -d '' src; do
    rel="${src#"$pkg"/}"
    target="$HOME/$rel"
    if [[ -e "$target" && ! -L "$target" ]]; then
      if cmp -s "$src" "$target"; then
        rm "$target"
      else
        backup="$target.pre-stow.bak"
        echo "stow: $target differs from $pkg/$rel — backing up to $backup"
        mv "$target" "$backup"
      fi
    fi
  done < <(find "$pkg" -type f -print0)

  echo "stow -> $pkg"
  stow --target="$HOME" --restow "$pkg"
done
