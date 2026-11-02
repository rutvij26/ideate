#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.claude/skills/ideate"

echo "/ideate install"
echo "Source: $REPO_DIR"
echo "Target: $TARGET_DIR"

if [ -e "$TARGET_DIR" ]; then
  read -r -p "$TARGET_DIR already exists. Overwrite? [y/N] " answer
  case "$answer" in
    [yY]) rm -rf "$TARGET_DIR" ;;
    *) echo "Install cancelled." && exit 0 ;;
  esac
fi

ln -s "$REPO_DIR" "$TARGET_DIR"
echo "Done. Restart Claude Code and run /ideate to get started."
