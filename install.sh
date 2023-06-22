#!/usr/bin/env sh

CUSTO_HOME=".custo"

if [[ -d ~/$CUSTO_HOME ]]; then
  cd ~/.custo
  git pull
else
  git -C ~ clone https://github.com/pauldaniv/custo.git $CUSTO_HOME
  cd ~/.custo
fi

if ! grep -q "$CUSTO_HOME/bin/env" "$HOME/.zshrc"; then
  tee -a $HOME/.zshrc <<EOF
#CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Add extensions bellow
extensions=(
        python
        alias
)
source ~/$CUSTO_HOME/bin/env.sh
#END CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EOF
fi
