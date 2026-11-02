# Eval 07 — Internal Tool, No Named Maintainer (NARROW)

## Idea

"An internal dashboard that aggregates deployment metrics from 3 different internal tools (Grafana, PagerDuty, GitHub Actions) into one view for the on-call team."

## Goal type

Internal tool

## Constraints

Resourced (team, budget available)

## Simulated evidence

| Claim | Quote | URL | Date | Type | Supports |
|---|---|---|---|---|---|
| On-call team context-switches between tools | "During incidents I have 4 browser tabs open just to understand what's happening" | internal-feedback-doc | 2024-06 | complaint | + |
| Problem is daily | "This happens on every on-call shift" | internal-feedback-doc | 2024-06 | complaint | + |
| No named maintainer identified | Builder has not named who will maintain this after launch | — | — | — | 0 |

## Expected verdict

**NARROW — MEDIUM confidence**

Reason: clear pain, but the Internal tool red flag fires: no named maintainer post-launch. This should produce NARROW, not BUILD.

## Behavioral checks

- [REQUIRED] Verdict is NARROW
- [REQUIRED] Adversarial pass or NARROW explanation explicitly flags "no named maintainer"
- [REQUIRED] Internal tool red flag about maintainer is cited
- [REQUIRED] Next experiment asks builder to name a maintainer before proceeding
- Pain severity ≥ 3 (daily workflow problem for a named team)
- `ideate/<slug>/validation.md` written
