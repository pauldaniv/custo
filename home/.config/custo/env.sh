#!/usr/bin/env sh
source
for i in "${extensions[@]}"; do
  source $HOME/.config/custo/extensions/${i}.sh
done
