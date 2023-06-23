#!/usr/bin/env fish

set auto_venv_config $HOME/.config/custom/auto_venv.txt

if test -e "./venv/bin/activate" && test -e $auto_venv_config && test (cat $auto_venv_config) = "yes"
  source ./venv/bin/activate.fish
  echo -e "Activated venv: $CYAN$(which python)$NC"
end

function pyctivate
  if test (cat $auto_venv_config) = "yes"
    echo "no" >$auto_venv_config
    echo -e "$Red*disabled*$NC"
  else if test (cat $auto_venv_config) = "no"
    echo "yes" >$auto_venv_config
    echo -e "$Green*enabled*$NC"
  else
    echo -e "$Red!unexpected state!"
    echo -e "*disabled*$NC"
    echo "no" >$auto_venv_config
  end
end
