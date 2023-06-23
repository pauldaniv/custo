#!/usr/bin/env sh

SHELL_TYPE=

#TODO: optimize me!!!
if [[ $SHELL == *"zsh"* ]]; then
  SHELL_TYPE="zsh"
  SHELL_SOURCE_FILE="$HOME/.zshrc"
elif [[ $SHELL == *"fish"* ]]; then
  SHELL_TYPE="fish"
  SHELL_SOURCE_FILE="$HOME/.config/fish/config.fish"
fi

source $HOME/.custo/bin/common/commons.sh
env_zsh() {
  for i in "${extensions[@]}"; do
    source $HOME/.custo/bin/extensions/${i}.sh
  done
}

env_fish() {
  for i in $extensions; do
    source $HOME/.custo/bin/extensions/${i}.sh
  done
}

env_func
