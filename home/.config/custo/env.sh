#!/usr/bin/env sh

source $HOME/.config/custo/common/commons.sh

for i in "${extensions[@]}"; do
  source $HOME/.config/custo/extensions/${i}.sh
done
