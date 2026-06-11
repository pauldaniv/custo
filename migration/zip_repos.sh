#!/usr/bin/env bash
# Pack all subdirectory sources into one archive, preserving structure.
# Respects .gitignore per repo. Includes .git/ dirs.
#
# Usage: ./zip_repos.sh [-f <output-path>]
#   Default output: ./byod-sources.tar.zst
#   Format chosen from extension: .zip | .tar | .tar.gz | .tgz | .tar.zst | .tar.xz

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
OUT="$ROOT/byod-sources.tar.zst"

while getopts "f:h" opt; do
  case "$opt" in
    f) OUT="$OPTARG" ;;
    h) sed -n '2,8p' "$0"; exit 0 ;;
    *) exit 2 ;;
  esac
done

case "$OUT" in
  /*) ;;                       # absolute
  *)  OUT="$PWD/$OUT" ;;       # relative -> absolute
esac

case "$OUT" in
  *.zip)     FMT=zip ;;
  *.tar)     FMT=tar ;;
  *.tar.gz|*.tgz)  FMT=tgz ;;
  *.tar.zst) FMT=tzst ;;
  *.tar.xz)  FMT=txz ;;
  *) echo "Unknown extension: $OUT" >&2; exit 2 ;;
esac

rm -f "$OUT"
LIST="$(mktemp)"
trap 'rm -f "$LIST"' EXIT

EXCLUDES=(
  'node_modules' '.venv' 'venv' '__pycache__'
  'dist' 'build' '.next' 'target' '.cache'
  '.mypy_cache' '.pytest_cache' '.ruff_cache' '.terraform'
)

for d in "$ROOT"/*/; do
  name="$(basename "$d")"
  case "$name" in
    _zips|.claude|.ruff_cache) continue ;;
  esac
  echo ">>> $name"

  if [ -d "$d/.git" ]; then
    # Tracked + untracked-not-ignored, minus locally-deleted, prefixed with "<name>/".
    ( cd "$d" && comm -23 \
        <(git ls-files -co --exclude-standard | sort -u) \
        <(git ls-files --deleted | sort -u) ) \
      | sed "s|^|$name/|" >> "$LIST"
    # Plus .git dir (recursively listed).
    find "$name/.git" -type f >> "$LIST" 2>/dev/null || true
  else
    # Non-git dir: enumerate, applying excludes.
    find_args=( "$name" -type f )
    for e in "${EXCLUDES[@]}"; do
      find_args+=( -not -path "*/$e/*" )
    done
    ( cd "$ROOT" && find "${find_args[@]}" ) >> "$LIST"
  fi
done

cd "$ROOT"
case "$FMT" in
  zip)  zip -q "$OUT" -@ < "$LIST" ;;
  tar)  tar -cf  "$OUT" -T "$LIST" ;;
  tgz)  tar -czf "$OUT" -T "$LIST" ;;
  tzst) tar --zstd -cf "$OUT" -T "$LIST" ;;
  txz)  tar -cJf "$OUT" -T "$LIST" ;;
esac

echo "Done: $OUT ($(du -h "$OUT" | cut -f1))"
