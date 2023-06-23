#!/usr/bin/env sh

CYAN='\033[1;36m'
NC='\033[0m'

if test -e "./venv/bin/activate" && test -e $auto_venv_config && $(cat $auto_venv_config) == "yes"
  source ./venv/bin/activate
  echo "Activated venv: ${CYAN}$(which python)${NC}"
end

pyctivate() {
  if [ "$(cat $auto_venv_config)" = "yes" ]
    echo "no" >$auto_venv_config
  else if  [ "$(cat $auto_venv_config)" = "no" ]
    echo "yes" >$auto_venv_config
  else
    echo "no" >$auto_venv_config
  end
}
