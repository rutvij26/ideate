#!/usr/bin/env bash
# Search Stack Overflow for questions matching a query and output evidence log rows.
# Usage: bash scripts/search-stackoverflow.sh "query string"
# Set STACKAPPS_KEY env var to raise quota from 300 to 10,000 requests/day.

set -euo pipefail

QUERY="${1:-}"
if [ -z "$QUERY" ]; then
  echo "Usage: $0 \"search query\"" >&2
  exit 1
fi

ENCODED_QUERY=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$QUERY" 2>/dev/null || \
  node -e "process.stdout.write(encodeURIComponent(process.argv[1]))" "$QUERY" 2>/dev/null || \
  echo "$QUERY" | sed 's/ /%20/g; s/"/%22/g')

KEY_PARAM=""
if [ -n "${STACKAPPS_KEY:-}" ]; then
  KEY_PARAM="&key=${STACKAPPS_KEY}"
fi

URL="https://api.stackexchange.com/2.3/search?order=desc&sort=votes&intitle=${ENCODED_QUERY}&site=stackoverflow&pagesize=10${KEY_PARAM}"

RESPONSE=$(curl -s "$URL")

if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -q '"error_id"'; then
  echo "# blocked: api.stackexchange.com — try manually: https://stackoverflow.com/search?q=${ENCODED_QUERY}" >&2
  exit 1
fi

echo "# Stack Overflow search: $QUERY"
echo "# $(date +%Y-%m-%d)"

echo "$RESPONSE" | jq -r '
  .items[] |
  select(.title != null and .link != null) |
  [
    ("SO question: " + (.title | .[0:80])),
    ("\"" + (.title | .[0:120]) + "\""),
    .link,
    ((.creation_date | todate) | .[0:7]),
    "complaint",
    "+"
  ] | join(" | ")
' 2>/dev/null || echo "# parse error — check /tmp/ideate-stackoverflow-debug.json"

echo "$RESPONSE" > /tmp/ideate-stackoverflow-debug.json 2>/dev/null || true
