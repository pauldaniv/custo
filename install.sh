#!/usr/bin/env sh

function upgrade() {
  cp home/* $HOME
}

if [[ $1 == "upgrade" ]]; then
  upgrade
fi
