# /ideate — Evidence Collection Scripts

These scripts collect evidence from public APIs and output rows in the `/ideate` evidence log format:

```
claim | quote (≤125 chars) | URL | date | type | supports
```

Pipe output directly into your `ideate/<slug>/evidence.md` file.

## Usage

**Run all sources at once (recommended):**
```bash
bash scripts/search-all.sh "your query" >> ideate/my-idea/evidence.md
```

**Or run individual scripts:**
```bash
# Pain signals
bash scripts/search-reddit.sh "git diff confusing" >> ideate/my-idea/evidence.md
bash scripts/search-hn.sh "developer tooling frustrating" >> ideate/my-idea/evidence.md
bash scripts/search-stackoverflow.sh "react state management" >> ideate/my-idea/evidence.md
bash scripts/search-github-issues.sh "slow jest tests" >> ideate/my-idea/evidence.md
bash scripts/search-devto.sh "rust-async" >> ideate/my-idea/evidence.md

# Competitor discovery
bash scripts/search-github.sh "git-diff-tool" >> ideate/my-idea/evidence.md
bash scripts/search-npm.sh "markdown parser" >> ideate/my-idea/evidence.md
bash scripts/search-crates.sh "cli argument parser" >> ideate/my-idea/evidence.md
```

**Filter by type:**
```bash
bash scripts/search-all.sh "idea validation tool" --pain-only
bash scripts/search-all.sh "idea validation tool" --competitors-only
```

## Signal Type Coverage

| Script | Signal types | Best for mode |
|---|---|---|
| `search-reddit.sh` | complaint | VALIDATE, IDEATE |
| `search-hn.sh` | complaint | VALIDATE, IDEATE |
| `search-stackoverflow.sh` | complaint | VALIDATE (technical ideas) |
| `search-github-issues.sh` | complaint | VALIDATE (technical ideas) |
| `search-devto.sh` | workaround | VALIDATE, COMPETE |
| `search-github.sh` | competitor | COMPETE |
| `search-npm.sh` | competitor, metric | COMPETE (JS ecosystem) |
| `search-crates.sh` | competitor, metric | COMPETE (Rust ecosystem) |
| `search-all.sh` | all of the above | Full pipeline |

## Output Format

Each script outputs rows in this format:

```
[claim] | "[quote ≤125 chars]" | [url] | [YYYY-MM] | [type] | [+/-/0]
```

## Requirements

- `curl` and `jq` must be installed
- No API keys required for basic usage (all scripts use public APIs unauthenticated)

**Optional environment variables for higher rate limits:**
- `GITHUB_TOKEN` — raises GitHub quota from 10 to 60 requests/min (used by `search-github.sh` and `search-github-issues.sh`)
- `STACKAPPS_KEY` — raises Stack Exchange quota from 300 to 10,000 requests/day (used by `search-stackoverflow.sh`)

## Rate Limits

| Script | Unauthenticated | With token |
|---|---|---|
| `search-reddit.sh` | ~60 req/min | — |
| `search-hn.sh` | No documented limit | — |
| `search-stackoverflow.sh` | 300 req/day | 10,000/day (`STACKAPPS_KEY`) |
| `search-github-issues.sh` | 10 req/min | 60/min (`GITHUB_TOKEN`) |
| `search-github.sh` | 10 req/min | 60/min (`GITHUB_TOKEN`) |
| `search-npm.sh` | No documented limit | — |
| `search-devto.sh` | No documented limit | — |
| `search-crates.sh` | 1 req/sec | — |

## DEV.to tag note

DEV.to uses tag slugs, not keyword search. The script converts your query to a hyphenated lowercase tag (`"rust async"` → `rust-async`). If fewer than 3 results come back, try a shorter/simpler tag (`rust` instead of `rust-async`).

## Adding Sources

To add a new evidence source script, follow the same pattern:
1. Call the public API with `curl`
2. Parse with `jq`
3. Output rows in the evidence log format above
4. Set executable: `git update-index --chmod=+x scripts/your-script.sh`
5. Add a usage example to this README and a row to the signal matrix
6. Add the script to `PAIN_SCRIPTS` or `COMPETITOR_SCRIPTS` in `search-all.sh`
