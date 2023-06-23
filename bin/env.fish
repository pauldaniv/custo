#!/usr/bin/env sh

source $HOME/.custo/bin/common/commons.sh

for i in $extensions
  source $HOME/.custo/bin/extensions/{$i}.sh
end


