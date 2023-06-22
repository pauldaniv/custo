#!/usr/bin/env sh

REPO_NAME="fresh-setup"

mkdir -p ~/.custo
cd ~/.custo
if [[ -d $REPO_NAME ]]; then
  cd $REPO_NAME
  git pull
else
  git clone git@github.com:pauldaniv/$REPO_NAME.git
  cd $REPO_NAME
fi


cp -r home/ $HOME

if ! grep -q "config/custo/env" "$HOME/.zshrc"; then
  tee -a $HOME/.zshrc <<EOF
#CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
extensions=(
        python
        alias
)
source ~/.config/custo/env.sh
#END CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EOF
fi

sed 's%*.config/custo/env.sh*%$HOME/.config/custo/env11111.sh%' ~/.zshrc
