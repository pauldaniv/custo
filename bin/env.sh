#!/usr/bin/env sh

source $HOME/.custo/bin/common/commons.sh

for i in "${extensions[@]}"; do
  source $HOME/.custo/bin/extensions/${i}.sh
done