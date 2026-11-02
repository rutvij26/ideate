# Eval 03 — Feasibility is the Weak Dimension (NARROW)

## Idea

"A real-time collaborative code review tool that uses LLMs to suggest improvements inline as the reviewer types their comments, deeply integrated into GitHub's PR interface."

## Goal type

Commercial

## Constraints

Lean (solo, ≤2 weeks) — deliberately restrictive

## Simulated evidence

| Claim | Quote | URL | Date | Type | Supports |
|---|---|---|---|---|---|
| Code review quality varies widely | "Our reviews are inconsistent — different reviewers catch completely different things" | https://news.ycombinator.com/item?id=example | 2024-04 | complaint | + |
| Reviewers want LLM assistance | "I use ChatGPT separately while reviewing — wish it was integrated" | https://reddit.com/r/programming/example | 2024-02 | complaint | + |
| Paying for code quality tools | "We pay for multiple code quality tools — review quality is worth investing in" | https://reddit.com/r/devops/example | 2023-12 | purchase-signal | + |

## Expected verdict

**NARROW — MEDIUM confidence**

Reason: feasibility dimension should score ≤ 2 given the Lean constraint (deep GitHub integration + LLM infrastructure cannot be shipped in 2 weeks solo). All other dimensions may be strong.

## Behavioral checks

- [REQUIRED] Verdict is NARROW (not BUILD)
- [REQUIRED] Score table shows Build Feasibility ≤ 2 with explanation citing the constraint
- [REQUIRED] NARROW explanation names Build Feasibility as the specific weak dimension
- [REQUIRED] Next experiment is specific to what would change for BUILD
- Adversarial pass present
- `ideate/<slug>/validation.md` written
