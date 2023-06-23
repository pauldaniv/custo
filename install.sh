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
  git -C ~ clone https://github.com/pauldaniv/custo.git $CUSTO_HOME
  cd ~/.custo
fi

populate_fish() {
  tee -a $HOME/.zshrc <<EOF
set extensions python
set --append extensions alias
EOF
}

populate_zsh() {
  tee -a $HOME/.zshrc <<EOF
extensions=(
        python
        alias
)
EOF
}

if ! grep -q "$CUSTO_HOME/bin/env" "$HOME/$SHELL_SOURCE_FILE"; then
  tee -a $HOME/.zshrc <<EOF
#CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Add extensions bellow
EOF

  populate_func=populate_$SHELL_TYPE
  $populate_func

  tee -a $HOME/$SHELL_SOURCE_FILE <<EOF
source ~/$CUSTO_HOME/bin/env.sh
#END CUSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EOF
fi
