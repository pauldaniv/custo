#!/usr/bin/env sh

REPO_NAME="fresh-setup"

if [[ -d $REPO_NAME ]]; then
  cd .custo
  git pull
else
  git clone git@github.com:pauldaniv/$REPO_NAME.git
  mv $REPO_NAME .custo
  cd .custo
fi

if ! grep -q ".custo/env" "$HOME/.zshrc"; then
  tee -a $HOME/.zshrc <<EOF
#CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
source ~/.custo/env.sh
#END CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EOF
fi
