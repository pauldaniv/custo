#!/usr/bin/env fish

alias watch="watch "
alias k="kubectl"
alias grsh="git reset --soft HEAD^"
alias gpf='git push --force-with-lease --force-if-includes'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gbd='git branch --delete'
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls -G'
alias lsa='ls -lah'
alias md='mkdir -p'



function whoah_dude
  echo "DUdeee!"
end

function anothen_one
  echo "another..."
end

function gbdr
  set branch_name $argv[1]
  git branch -D $branch_name && git push origin --delete $branch_name
end
