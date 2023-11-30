#!/usr/bin/env bash

CUSTO_HOME=".custo"
SHELL_TYPE=

if [[ $SHELL == *"zsh"* ]]; then
  SHELL_TYPE="zsh"
  SHELL_SOURCE_FILE="$HOME/.zshrc"
elif [[ $SHELL == *"fish"* ]]; then
  SHELL_TYPE="fish"
  SHELL_SOURCE_FILE="$HOME/.config/fish/config.fish"
elif [[ $SHELL == *"bash"* ]]; then
  SHELL_TYPE="bash"
  SHELL_SOURCE_FILE="$HOME/.bashrc"
else
  SHELL_TYPE="bash"
  SHELL_SOURCE_FILE="$HOME/.bashrc"
fi

branch=master
if [[ $CUSTO_EARLY_ACCESS == true ]]; then
  branch=develop
  echo -e "${Purple}Using experimental mode${NC}"
fi

if [[ -d ~/$CUSTO_HOME ]]; then
  cd ~/.custo
  git checkout $branch
  git pull
else
  git -C ~ clone -b $branch https://github.com/pauldaniv/custo.git $CUSTO_HOME
  echo "Cloned"
  cd ~/.custo
fi

populate_fish() {
  tee -a $SHELL_SOURCE_FILE <<EOF
set extensions python
set --append extensions alias
source ~/$CUSTO_HOME/bin/env.fish
touch ~/.custo_profile.fish
source ~/.custo_profile.fish
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

populate_bash() {
  tee -a $SHELL_SOURCE_FILE <<EOF
extensions=(
        python
        alias
)
. ~/$CUSTO_HOME/bin/env.sh
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
