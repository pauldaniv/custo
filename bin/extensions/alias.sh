#!/usr/bin/env bash

alias watch="watch "
alias k="kubectl"
alias grsh="git reset --soft HEAD^"

function nvenv() {
  local name=${1:-venv}
  python -m venv $name
}

function whoah_dude() {
  echo "DUdeee!"
}

function anothen_one() {
  echo "another..."
}
