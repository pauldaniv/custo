#!/usr/bin/env bash
set -euo pipefail

CUSTO_HOME="${CUSTO_HOME:-$HOME/.custo}"
ENV_FILE="$HOME/.custo.env"

if [[ ! -f "$ENV_FILE" ]]; then
  cat >"$ENV_FILE" <<'EOF'
# Filled out per machine. Gitignored.
PERSONAL_NAME=""
PERSONAL_EMAIL=""
PERSONAL_SIGNINGKEY=""
WORK_NAME=""
WORK_EMAIL=""
WORK_SIGNINGKEY=""
EOF
  echo "Created $ENV_FILE — fill it in and re-run setup/git.sh"
  exit 0
fi

# shellcheck disable=SC1090
source "$ENV_FILE"

render() {
  local tmpl="$1" out="$2"
  PERSONAL_NAME="$PERSONAL_NAME" PERSONAL_EMAIL="$PERSONAL_EMAIL" \
  PERSONAL_SIGNINGKEY="$PERSONAL_SIGNINGKEY" \
  WORK_NAME="$WORK_NAME" WORK_EMAIL="$WORK_EMAIL" \
  WORK_SIGNINGKEY="$WORK_SIGNINGKEY" \
    envsubst <"$tmpl" >"$out"
}

render "$CUSTO_HOME/dotfiles/git/.gitconfig-personal.tmpl" "$HOME/.gitconfig-personal"
render "$CUSTO_HOME/dotfiles/git/.gitconfig-work.tmpl"     "$HOME/.gitconfig-work"
