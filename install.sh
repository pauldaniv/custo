#!/usr/bin/env sh

CUSTO_HOME=".custo"
SHELL_TYPE=

if [[ $SHELL == *"zsh"* ]]; then
  SHELL_TYPE="zsh"
  SHELL_SOURCE_FILE="$HOME/.zshrc"
elif [[ $SHELL == *"fish"* ]]; then
  SHELL_TYPE="fish"
  SHELL_SOURCE_FILE="$HOME/.config/fish/config.fish"
fi

if [[ -d ~/$CUSTO_HOME ]]; then
  cd ~/.custo
  git pull
else
  git -C ~ clone -b master https://github.com/pauldaniv/custo.git $CUSTO_HOME
  cd ~/.custo
fi

populate_fish() {
  tee -a $SHELL_SOURCE_FILE <<EOF
set extensions python
set --append extensions alias
source ~/$CUSTO_HOME/bin/env.fish
EOF
}

populate_zsh() {
  tee -a $SHELL_SOURCE_FILE <<EOF
extensions=(
        python
        alias
)
source ~/$CUSTO_HOME/bin/env.sh
EOF
}

if ! grep -q "$CUSTO_HOME/bin/env" "$SHELL_SOURCE_FILE"; then
  tee -a $SHELL_SOURCE_FILE <<EOF
#CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Add extensions bellow
EOF

  populate_func=populate_$SHELL_TYPE
  $populate_func

  tee -a $SHELL_SOURCE_FILE <<EOF
#END CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EOF
fi
