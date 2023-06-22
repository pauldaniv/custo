#!/usr/bin/env sh

function custo() {
  cp -r home/ $HOME
}

if [[ $1 == "upgrade" ]]; then
  custo
fi
