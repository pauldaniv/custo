#!/usr/bin/env sh

alias watch="watch "
alias k="kubectl"
alias grsh="git reset --soft HEAD^"

nvenv() {
  local name=${1:-venv}
  python -m venv $name
}

whoah_dude() {
  echo "DUdeee!"
}
