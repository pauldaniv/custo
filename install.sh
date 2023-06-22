#!/usr/bin/env sh

REPO_NAME="fresh-setup"

mkdir -p ~/.custo
cd ~/.custo
git clone git@github.com:pauldaniv/$REPO_NAME.git
cd $REPO_NAME

cp -r home/ $HOME

if ! grep -q "config/custo/env" "~/.zshrc"; then
  tee -a ~/.zshrc <<EOF
#CUSTOM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
extensions=(
        python
        alias
)
source $HOME/.config/custo/env.sh
#END CUSTOM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
EOF
fi
