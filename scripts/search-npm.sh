#!/usr/bin/env bash
# Search npm registry for packages matching a query and output evidence log rows.
# Usage: bash scripts/search-npm.sh "query string"

set -euo pipefail

QUERY="${1:-}"
if [ -z "$QUERY" ]; then
  echo "Usage: $0 \"search query\"" >&2
  exit 1
fi

ENCODED_QUERY=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$QUERY" 2>/dev/null || \
  node -e "process.stdout.write(encodeURIComponent(process.argv[1]))" "$QUERY" 2>/dev/null || \
  echo "$QUERY" | sed 's/ /%20/g; s/"/%22/g')

URL="https://registry.npmjs.org/-/v1/search?text=${ENCODED_QUERY}&size=10"

RESPONSE=$(curl -s "$URL")

if [ -z "$RESPONSE" ]; then
  echo "# blocked: registry.npmjs.org — try manually: https://www.npmjs.com/search?q=${ENCODED_QUERY}" >&2
  exit 1
fi

echo "# npm search: $QUERY"
echo "# $(date +%Y-%m-%d)"

echo "$RESPONSE" | jq -r '
  .objects[] |
  select(.package.name != null) |
  [
    ("npm package: " + .package.name),
    ("\"" + (.package.description // "No description" | .[0:110]) + "\""),
    ("https://www.npmjs.com/package/" + .package.name),
    ((.package.date // "") | .[0:7]),
    "competitor",
    "0"
  ] | join(" | ")
' 2>/dev/null || echo "# parse error — check /tmp/ideate-npm-debug.json"

echo "$RESPONSE" > /tmp/ideate-npm-debug.json 2>/dev/null || true
