#!/usr/bin/env bash

. $HOME/.custo/bin/common/commons.sh

for i in "${extensions[@]}"; do
  . $HOME/.custo/bin/extensions/${i}.sh
done
