#!/usr/bin/env bash
# Search Reddit for posts matching a query and output evidence log rows.
# Usage: bash scripts/search-reddit.sh "query string"
# Output: evidence.md rows (pipe to your evidence file)

set -euo pipefail

QUERY="${1:-}"
if [ -z "$QUERY" ]; then
  echo "Usage: $0 \"search query\"" >&2
  exit 1
fi

ENCODED_QUERY=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$QUERY" 2>/dev/null || \
  node -e "process.stdout.write(encodeURIComponent(process.argv[1]))" "$QUERY" 2>/dev/null || \
  echo "$QUERY" | sed 's/ /%20/g; s/"/%22/g')

URL="https://www.reddit.com/search.json?q=${ENCODED_QUERY}&sort=relevance&limit=10&type=link"

RESPONSE=$(curl -s -A "ideate-skill/0.1 evidence-collector" "$URL")

if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -q '"error"'; then
  echo "# blocked: reddit.com — try manually: https://www.reddit.com/search/?q=${ENCODED_QUERY}" >&2
  exit 1
fi

echo "# Reddit search: $QUERY"
echo "# $(date +%Y-%m-%d)"

echo "$RESPONSE" | jq -r '
  .data.children[] |
  .data |
  select(.title != null and .url != null) |
  [
    ("Reddit users discuss: " + (.title | .[0:80])),
    ("\"" + (.title | .[0:120]) + "\""),
    ("https://reddit.com" + .permalink),
    ((.created_utc | tonumber | strftime("%Y-%m")) // "unknown"),
    "complaint",
    "+"
  ] | join(" | ")
' 2>/dev/null || echo "# parse error — raw response saved to /tmp/ideate-reddit-debug.json"

echo "$RESPONSE" > /tmp/ideate-reddit-debug.json 2>/dev/null || true
