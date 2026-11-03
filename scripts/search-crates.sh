#!/usr/bin/env bash
# Search crates.io for Rust crates matching a query and output evidence log rows.
# Usage: bash scripts/search-crates.sh "query string"

set -euo pipefail

QUERY="${1:-}"
if [ -z "$QUERY" ]; then
  echo "Usage: $0 \"search query\"" >&2
  exit 1
fi

ENCODED_QUERY=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$QUERY" 2>/dev/null || \
  node -e "process.stdout.write(encodeURIComponent(process.argv[1]))" "$QUERY" 2>/dev/null || \
  echo "$QUERY" | sed 's/ /%20/g; s/"/%22/g')

URL="https://crates.io/api/v1/crates?q=${ENCODED_QUERY}&per_page=10&sort=downloads"

# crates.io requires a User-Agent header (returns 403 without one)
RESPONSE=$(curl -s -A "ideate-skill/0.1 evidence-collector" "$URL")

if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -q '"errors"'; then
  echo "# blocked: crates.io — try manually: https://crates.io/search?q=${ENCODED_QUERY}" >&2
  exit 1
fi

echo "# crates.io search: $QUERY"
echo "# $(date +%Y-%m-%d)"

echo "$RESPONSE" | jq -r '
  .crates[] |
  select(.name != null) |
  [
    ("crate: " + .name + " (" + (.downloads | tostring) + " dl)"),
    ("\"" + (.description // "No description" | .[0:110]) + "\""),
    ("https://crates.io/crates/" + .name),
    ((.updated_at // "") | .[0:7]),
    "competitor",
    "0"
  ] | join(" | ")
' 2>/dev/null || echo "# parse error — check /tmp/ideate-crates-debug.json"

echo "$RESPONSE" > /tmp/ideate-crates-debug.json 2>/dev/null || true
