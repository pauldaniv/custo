#!/usr/bin/env fish

alias watch="watch "
alias k="kubectl"
alias grsh="git reset --soft HEAD^"
alias gpf='git push --force-with-lease --force-if-includes'
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls -G'
alias lsa='ls -lah'
alias md='mkdir -p'

function nvenv
  set name $argv[1]
  test -n "$XYZ"; or set XYZ "venv"
  # Use the local_name variable within this function
  python -m venv $name
end

function whoah_dude
  echo "DUdeee!"
end

function anothen_one
  echo "another..."
end
