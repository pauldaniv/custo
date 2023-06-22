#!/usr/bin/env sh

if [[ -d ~/.custo ]]; then
  cd ~/.custo
  git pull
else
  git -C ~ clone https://github.com/pauldaniv/custo.git .custo
  cd ~/.custo
fi

if ! grep -q ".custo/bin/env" "$HOME/.zshrc"; then
  tee -a $HOME/.zshrc <<EOF
#CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
source ~/.custo/bin/env.sh
#END CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EOF
fi
