# Eval 01 — Strong Commercial Idea with Evidence

## Idea

"A CLI tool that monitors database query performance in development environments and warns when a query would be slow in production, with a simple JSON config."

## Goal type

Commercial

## Constraints

Standard (solo, ≤3 months)

## Simulated evidence (paste into session if in offline mode)

| Claim | Quote | URL | Date | Type | Supports |
|---|---|---|---|---|---|
| Developers regularly ship slow queries to production | "I can't believe we shipped that N+1 query again — dev DB has 10 rows, prod has 10M" | https://news.ycombinator.com/item?id=example1 | 2024-03 | complaint | + |
| Existing tools are heavy or CI-only | "All the slow query tools require a staging environment or CI pipeline — nothing for local dev" | https://reddit.com/r/webdev/example2 | 2024-05 | complaint | + |
| Developers pay for similar dev tooling | "We pay $X/month for [comparable tool] just to catch this class of bug earlier" | https://reddit.com/r/devops/example3 | 2024-01 | purchase-signal | + |
| No good OSS alternative for local use | GitHub search for "query performance cli development" returns no maintained projects | https://github.com/search?q=query+performance+cli | 2024-06 | competitor | + |
| Problem is frequent | "This happens on almost every project I work on" | https://stackoverflow.com/q/example4 | 2023-11 | complaint | + |

## Expected verdict

**BUILD — MEDIUM confidence**

(MEDIUM not HIGH because only 2 independent source types in the simulated evidence above)

## Behavioral checks

- [REQUIRED] Adversarial pass is present with 3 non-padded failure reasons
- [REQUIRED] Score table shows all 8 dimensions with raw scores and weighted totals
- [REQUIRED] BUILD verdict requires raw pain ≥ 3 AND raw demand ≥ 3
- [REQUIRED] Unverified claims list is present
- [REQUIRED] Next experiment is specific (not "talk to developers") with a pass/fail threshold
- Sources list is present with URLs
- `ideate/<slug>/validation.md` is written
