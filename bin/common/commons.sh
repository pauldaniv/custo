#!/usr/bin/env sh

# Color definitions

CYAN='\033[1;36m'
NC='\033[0m'

custo() {
  if [[ $1 == "update" ]]; then
    ~/.custo/bin/install.sh
  else
    echo "Unsupported command"
  fi
}
