#!/usr/bin/env bash
# Run all evidence-collection scripts for a query and combine output.
# Usage: bash scripts/search-all.sh "query string" [--pain-only | --competitors-only]
# Requires bash (Git Bash, WSL, or macOS/Linux).

set -uo pipefail

QUERY="${1:-}"
MODE="${2:-}"

if [ -z "$QUERY" ]; then
  echo "Usage: $0 \"query string\" [--pain-only | --competitors-only]" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMPDIR_LOCAL=$(mktemp -d /tmp/ideate-all-XXXXXX)
trap 'rm -rf "$TMPDIR_LOCAL"' EXIT

PAIN_SCRIPTS=(
  "reddit:search-reddit.sh"
  "hn:search-hn.sh"
  "stackoverflow:search-stackoverflow.sh"
  "github-issues:search-github-issues.sh"
  "devto:search-devto.sh"
)

COMPETITOR_SCRIPTS=(
  "github:search-github.sh"
  "npm:search-npm.sh"
  "crates:search-crates.sh"
)

echo "# search-all: $QUERY"
echo "# $(date +%Y-%m-%d)"
echo "#"

run_script() {
  local name="$1"
  local script="$2"
  bash "$SCRIPT_DIR/$script" "$QUERY" \
    > "$TMPDIR_LOCAL/${name}.txt" \
    2> "$TMPDIR_LOCAL/${name}.err" || true
}

# Launch all scripts in parallel
if [ "$MODE" != "--competitors-only" ]; then
  for entry in "${PAIN_SCRIPTS[@]}"; do
    name="${entry%%:*}"
    script="${entry##*:}"
    run_script "$name" "$script" &
  done
fi

if [ "$MODE" != "--pain-only" ]; then
  for entry in "${COMPETITOR_SCRIPTS[@]}"; do
    name="${entry%%:*}"
    script="${entry##*:}"
    run_script "$name" "$script" &
  done
fi

wait

# Output pain sources first, then competitor sources
output_group() {
  local entries=("$@")
  for entry in "${entries[@]}"; do
    local name="${entry%%:*}"
    local out="$TMPDIR_LOCAL/${name}.txt"
    local err="$TMPDIR_LOCAL/${name}.err"
    if [ -s "$out" ] && ! grep -q "^# blocked:" "$out" 2>/dev/null && ! grep -q "^# rate limited:" "$out" 2>/dev/null; then
      cat "$out"
      echo "#"
    else
      [ -s "$err" ] && cat "$err" >&2
      [ -s "$out" ] && grep "^#" "$out" >&2 || true
    fi
  done
}

if [ "$MODE" != "--competitors-only" ]; then
  output_group "${PAIN_SCRIPTS[@]}"
fi

if [ "$MODE" != "--pain-only" ]; then
  output_group "${COMPETITOR_SCRIPTS[@]}"
fi
