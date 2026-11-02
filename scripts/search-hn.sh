#!/usr/bin/env bash
# Search Hacker News via Algolia API and output evidence log rows.
# Usage: bash scripts/search-hn.sh "query string"
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

URL="https://hn.algolia.com/api/v1/search?query=${ENCODED_QUERY}&tags=story&hitsPerPage=10"

RESPONSE=$(curl -s "$URL")

if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -q '"error"'; then
  echo "# blocked: hn.algolia.com — try manually: https://news.ycombinator.com/search?q=${ENCODED_QUERY}" >&2
  exit 1
fi

echo "# HN search: $QUERY"
echo "# $(date +%Y-%m-%d)"

echo "$RESPONSE" | jq -r '
  .hits[] |
  select(.title != null and .objectID != null) |
  [
    ("HN discussion: " + (.title | .[0:80])),
    ("\"" + (.title | .[0:120]) + "\""),
    ("https://news.ycombinator.com/item?id=" + .objectID),
    ((.created_at // "") | .[0:7]),
    "complaint",
    "+"
  ] | join(" | ")
' 2>/dev/null || echo "# parse error — check /tmp/ideate-hn-debug.json"

echo "$RESPONSE" > /tmp/ideate-hn-debug.json 2>/dev/null || true
