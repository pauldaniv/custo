#!/usr/bin/env fish

source $HOME/.custo/bin/common/commons.fish

for i in $extensions
  source $HOME/.custo/bin/extensions/{$i}.fish
end


