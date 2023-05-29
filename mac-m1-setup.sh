#!/usr/bin/env sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/pavlodaniv/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

#brew required
brew install \
jq \
kubectl \
act \
pyenv

curl -s "https://get.sdkman.io" | bash
sdk install gradle

#todo: sdkman, gradle, pyenv, .ssh/config setup
source ~/.zshrc
