#!/usr/bin/env fish

alias watch="watch "
alias k="kubectl"
alias grsh="git reset --soft HEAD^"

function nvenv
  set name $argv[1]
  if test -z name
      set name "venv"
  end
  # Use the local_name variable within this function
  python -m venv $name
end

function whoah_dude
  echo "DUdeee!"
end

function anothen_one
  echo "another..."
end
