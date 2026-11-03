#!/usr/bin/env bash
# Search DEV.to articles by tag and output evidence log rows.
# Usage: bash scripts/search-devto.sh "tag or keyword"
# Note: DEV.to uses tag slugs (lowercase, hyphenated). "react hooks" → tag "react-hooks".
# If fewer than 3 results are returned, try a shorter/simpler tag.

set -euo pipefail

QUERY="${1:-}"
if [ -z "$QUERY" ]; then
  echo "Usage: $0 \"tag or keyword\"" >&2
  exit 1
fi

# DEV.to tags are lowercase and hyphenated — not percent-encoded
TAG=$(echo "$QUERY" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

URL="https://dev.to/api/articles?tag=${TAG}&per_page=10&top=7"

RESPONSE=$(curl -s "$URL")

if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -q '"error"'; then
  echo "# blocked: dev.to — try manually: https://dev.to/t/${TAG}" >&2
  exit 1
fi

RESULT_COUNT=$(echo "$RESPONSE" | jq 'length' 2>/dev/null || echo 0)
if [ "$RESULT_COUNT" -lt 3 ] 2>/dev/null; then
  echo "# warning: only $RESULT_COUNT results for tag '$TAG' — try a shorter tag (e.g. 'react' not 'react-hooks')" >&2
fi

echo "# DEV.to search (tag: $TAG): $QUERY"
echo "# $(date +%Y-%m-%d)"

echo "$RESPONSE" | jq -r '
  .[] |
  select(.title != null and .url != null) |
  [
    ("DEV.to article: " + (.title | .[0:80])),
    ("\"" + (.title | .[0:120]) + "\""),
    .url,
    ((.published_at // "") | .[0:7]),
    "workaround",
    "+"
  ] | join(" | ")
' 2>/dev/null || echo "# parse error — check /tmp/ideate-devto-debug.json"

echo "$RESPONSE" > /tmp/ideate-devto-debug.json 2>/dev/null || true
