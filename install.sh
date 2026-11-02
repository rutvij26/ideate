#!/usr/bin/env bash
set -euo pipefail

TARGET="$HOME/.claude/skills/ideate"
REPO="https://github.com/rutvij26/ideate"
BRANCH="main"

# ── Update path ────────────────────────────────────────────────────────────────
if [ -d "$TARGET/.git" ]; then
  echo "/ideate is already installed at $TARGET"
  printf "Update to latest? [Y/n] "
  read -r answer
  case "${answer:-Y}" in
    [nN]) echo "No changes made." && exit 0 ;;
    *)
      git -C "$TARGET" pull --ff-only
      echo "Updated. Restart Claude Code to pick up changes."
      exit 0
      ;;
  esac
fi

# ── Fresh install ───────────────────────────────────────────────────────────────
if [ -e "$TARGET" ]; then
  printf "%s already exists. Overwrite? [y/N] " "$TARGET"
  read -r answer
  case "$answer" in
    [yY]) rm -rf "$TARGET" ;;
    *) echo "Install cancelled." && exit 0 ;;
  esac
fi

if command -v git &>/dev/null; then
  git clone --depth=1 --branch "$BRANCH" "$REPO" "$TARGET"
else
  echo "git not found — downloading zip instead..."
  TMP=$(mktemp -d)
  trap 'rm -rf "$TMP"' EXIT
  curl -fsSL "$REPO/archive/refs/heads/$BRANCH.zip" -o "$TMP/ideate.zip"
  unzip -q "$TMP/ideate.zip" -d "$TMP"
  mv "$TMP/ideate-$BRANCH" "$TARGET"
fi

echo ""
echo "Done. Restart Claude Code and run /ideate to get started."
