#!/usr/bin/env bash
# Zip all subdirectory sources into ONE archive, preserving structure.
# Respects .gitignore per repo. Output: ./sources.zip
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
OUT="$ROOT/sources.zip"
rm -f "$OUT"

EXCLUDES=(
  '*/node_modules/*' '*/.venv/*' '*/venv/*' '*/__pycache__/*'
  '*/dist/*' '*/build/*' '*/.next/*' '*/target/*' '*/.cache/*'
  '*/.mypy_cache/*' '*/.pytest_cache/*' '*/.ruff_cache/*'
  '*/.terraform/*' '*.pyc' '*.pyo' '*.log' '.DS_Store' '*/.DS_Store'
)

for d in "$ROOT"/*/; do
  name="$(basename "$d")"
  case "$name" in
    _zips|.claude|.ruff_cache) echo "skip $name"; continue ;;
  esac
  echo ">>> $name"

  if [ -d "$d/.git" ]; then
    # Tracked + untracked-not-ignored, prefixed with "<name>/".
    ( cd "$d" && git ls-files -co --exclude-standard ) \
      | sed "s|^|$name/|" \
      | ( cd "$ROOT" && zip -q "$OUT" -@ )
    # Plus the .git dir itself (history, config, hooks).
    ( cd "$ROOT" && zip -qr "$OUT" "$name/.git" )
  else
    ( cd "$ROOT" && zip -qr "$OUT" "$name" -x "${EXCLUDES[@]}" )
  fi
done

echo "Done: $OUT ($(du -h "$OUT" | cut -f1))"
