#!/usr/bin/env sh

CYAN='\033[1;36m'
NC='\033[0m'

if [[ -f "./venv/bin/activate" && -f $auto_venv_config && $(cat $auto_venv_config) == "yes" ]]; then
  source ./venv/bin/activate
  echo "Activated venv: ${CYAN}`which python`${NC}"
fi
