#!/usr/bin/env sh

REPO_NAME="fresh-setup"

mkdir -p ~/.custo
cd ~/.custo
git clone git@github.com:pauldaniv/$REPO_NAME.git
cd $REPO_NAME

cp -r home/ $HOME

if ! grep -q "config/custo/env" "$HOME/.zshrc"; then
  tee -a $HOME/.zshrc <<EOF
#CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
extensions=(
        python
        alias
)
source $HOME/.config/custo/env.sh
#END CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EOF
fi

sed -i '/*.config/custo/env.sh*/$HOME/.config/custo/env.sh/' ~/.zshrc
