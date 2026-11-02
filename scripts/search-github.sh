#!/usr/bin/env bash
# Search GitHub repositories by topic/keyword and output evidence log rows.
# Usage: bash scripts/search-github.sh "topic-or-keyword"
# Set GITHUB_TOKEN env var for higher rate limits (60/min vs 10/min).

set -euo pipefail

QUERY="${1:-}"
if [ -z "$QUERY" ]; then
  echo "Usage: $0 \"topic or keyword\"" >&2
  exit 1
fi

ENCODED_QUERY=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$QUERY" 2>/dev/null || \
  node -e "process.stdout.write(encodeURIComponent(process.argv[1]))" "$QUERY" 2>/dev/null || \
  echo "$QUERY" | sed 's/ /%20/g; s/"/%22/g')

AUTH_HEADER=""
if [ -n "${GITHUB_TOKEN:-}" ]; then
  AUTH_HEADER="-H \"Authorization: token $GITHUB_TOKEN\""
fi

URL="https://api.github.com/search/repositories?q=${ENCODED_QUERY}&sort=stars&order=desc&per_page=10"

RESPONSE=$(curl -s \
  -H "Accept: application/vnd.github+json" \
  ${GITHUB_TOKEN:+-H "Authorization: token $GITHUB_TOKEN"} \
  "$URL")

if echo "$RESPONSE" | grep -q '"message".*"rate limit"'; then
  echo "# rate limited: api.github.com — set GITHUB_TOKEN env var or try later" >&2
  exit 1
fi

if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -q '"message"'; then
  echo "# blocked: api.github.com — try manually: https://github.com/search?q=${ENCODED_QUERY}&type=repositories" >&2
  exit 1
fi

echo "# GitHub search: $QUERY"
echo "# $(date +%Y-%m-%d)"

echo "$RESPONSE" | jq -r '
  .items[] |
  select(.full_name != null) |
  [
    ("OSS project: " + .full_name + " (" + (.stargazers_count | tostring) + " stars)"),
    ("\"" + (.description // "No description" | .[0:110]) + "\""),
    ("https://github.com/" + .full_name),
    ((.pushed_at // "") | .[0:7]),
    "competitor",
    "0"
  ] | join(" | ")
' 2>/dev/null || echo "# parse error — check /tmp/ideate-github-debug.json"

echo "$RESPONSE" > /tmp/ideate-github-debug.json 2>/dev/null || true
