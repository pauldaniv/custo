#!/usr/bin/env sh

for i in "${extensions[@]}"; do
  source $HOME/.config/custom/extensions/${i}_extension.sh
done
