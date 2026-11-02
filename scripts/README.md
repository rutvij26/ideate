# /ideate — Evidence Collection Scripts

These scripts collect evidence from public APIs and output rows in the `/ideate` evidence log format:

```
claim | quote (≤125 chars) | URL | date | type | supports
```

Pipe output directly into your `ideate/<slug>/evidence.md` file.

## Usage

```bash
# Reddit
bash scripts/search-reddit.sh "git diff confusing" >> ideate/my-idea/evidence.md

# Hacker News
bash scripts/search-hn.sh "developer tooling frustrating" >> ideate/my-idea/evidence.md

# GitHub (search repos by topic)
bash scripts/search-github.sh "git-diff-tool" >> ideate/my-idea/evidence.md
```

## Output Format

Each script outputs 3-5 rows in this format (tab-separated values):

```
[claim] | "[quote]" | [url] | [YYYY-MM] | complaint | +
```

Then paste into your evidence.md table.

## Requirements

- `curl` and `jq` must be installed
- No API keys required (uses unauthenticated public APIs)
- Reddit: uses the Reddit JSON API (`reddit.com/.json`)
- HN: uses the Algolia HN Search API (`hn.algolia.com/api/v1/search`)
- GitHub: uses the GitHub Search API (`api.github.com/search/repositories`)

## Rate Limits

- Reddit: ~60 requests/min unauthenticated
- HN Algolia: no documented limit for read-only search
- GitHub: 10 requests/min unauthenticated (60/min with a token — set `GITHUB_TOKEN` env var)

## Adding Sources

To add a new evidence source script, follow the same pattern:
1. Call the public API with `curl`
2. Parse with `jq`
3. Output rows in the evidence log format
4. Add a usage example to this README
