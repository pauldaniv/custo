#!/usr/bin/env sh

alias watch="watch "
alias k="kubectl"
alias grsh="git reset --soft HEAD^"

function nvenv
  local name=${1:-venv}
  python -m venv $name
end

function whoah_dude
  echo "DUdeee!"
end

function anothen_one
  echo "another..."
end
