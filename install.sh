#!/usr/bin/env sh

if [[ -d ~/.custo ]]; then
  cd ~/.custo
  git pull
else
  git -C ~ clone git@github.com:pauldaniv/$REPO_NAME.git .custo
  cd ~/.custo
fi

if ! grep -q ".custo/env" "$HOME/.zshrc"; then
  tee -a $HOME/.zshrc <<EOF
#CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
source ~/.custo/env.sh
#END CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EOF
fi
