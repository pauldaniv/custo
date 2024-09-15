#!/usr/bin/env bash

GITHUB_USER="pauldaniv"
PERSONAL_EMAIL=
WORK_EMAIL=

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (
    echo
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
  ) >>.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

#brew required
brew install \
  jq \
  act \
  pyenv \
  gh

pyenv install 3.11.5


if ! command -v sdk &>/dev/null; then
  curl -s "https://get.sdkman.io" | bash
fi

sdk install gradle

#todo: sdkman, gradle, pyenv, .ssh/config setup
source ~/.config/fish/config.fish

echo "Populating .gitconfig-personal"
tee -a .gitconfig-personal >/dev/null <<EOF
[user]
        signingkey = B286731F71468F7BCF4E80F300B9131832CF5F5A
        name = Pavlo
        email = $PERSONAL_EMAIL
EOF

tee -a .gitconfig-work >/dev/null <<EOF
[user]
        signingkey = 2FB3A344CECD9DC353BCB55A245C609B300925CF
        name = Pavlo Daniv
        email = $WORK_EMAIL
EOF

echo "Populating .gitconfig"
tee -a .gitconfig >/dev/null <<EOF
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        ignorecase = true
        precomposeunicode = true
[remote "origin"]
        url = git@github.com:$GITHUB_USER/fresh-setup
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
EOF

mkdir $HOME/.config/custom
touch $HOME/.config/custom/auto_venv.txt
