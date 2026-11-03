#!/usr/bin/env bash
# Search GitHub Issues by keyword and output evidence log rows.
# Usage: bash scripts/search-github-issues.sh "query string"
# Set GITHUB_TOKEN env var for higher rate limits (60/min vs 10/min).

set -euo pipefail

QUERY="${1:-}"
if [ -z "$QUERY" ]; then
  echo "Usage: $0 \"search query\"" >&2
  exit 1
fi

ENCODED_QUERY=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$QUERY" 2>/dev/null || \
  node -e "process.stdout.write(encodeURIComponent(process.argv[1]))" "$QUERY" 2>/dev/null || \
  echo "$QUERY" | sed 's/ /%20/g; s/"/%22/g')

URL="https://api.github.com/search/issues?q=${ENCODED_QUERY}+type:issue&sort=reactions&order=desc&per_page=10"

RESPONSE=$(curl -s \
  -H "Accept: application/vnd.github+json" \
  ${GITHUB_TOKEN:+-H "Authorization: token $GITHUB_TOKEN"} \
  "$URL")

if echo "$RESPONSE" | grep -q '"message".*"rate limit"'; then
  echo "# rate limited: api.github.com — set GITHUB_TOKEN env var or try later" >&2
  exit 1
fi

if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -q '"message"'; then
  echo "# blocked: api.github.com — try manually: https://github.com/search?q=${ENCODED_QUERY}&type=issues" >&2
  exit 1
fi

echo "# GitHub Issues search: $QUERY"
echo "# $(date +%Y-%m-%d)"

echo "$RESPONSE" | jq -r '
  .items[] |
  select(.title != null and .html_url != null) |
  [
    ("GitHub issue: " + (.title | .[0:80])),
    ("\"" + (.title | .[0:120]) + "\""),
    .html_url,
    ((.created_at // "") | .[0:7]),
    "complaint",
    "+"
  ] | join(" | ")
' 2>/dev/null || echo "# parse error — check /tmp/ideate-github-issues-debug.json"

echo "$RESPONSE" > /tmp/ideate-github-issues-debug.json 2>/dev/null || true
