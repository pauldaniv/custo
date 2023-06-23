#!/usr/bin/env bash

CYAN='\033[1;36m'
NC='\033[0m'

auto_venv_config=$HOME/.config/custom/auto_venv.txt

if [[ -f "./venv/bin/activate" && -f $auto_venv_config && $(cat $auto_venv_config) == "yes" ]]; then
  source ./venv/bin/activate
  echo "Activated venv: ${CYAN}$(which python)${NC}"
fi

pyctivate() {
  if [[ "$(cat $auto_venv_config)" = "yes" ]]; then
    echo "no" >$auto_venv_config
  elif [[ "$(cat $auto_venv_config)" = "no" ]]; then
    echo "yes" >$auto_venv_config
  else
    echo "no" >$auto_venv_config
  fi
}
