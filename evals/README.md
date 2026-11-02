# /ideate — Eval Cases

Structured test cases for verifying /ideate's behavior across all modes, verdicts, and edge cases.

## What These Are

These are not automated tests. They are structured human-run checks. Each case specifies:
- An idea and goal type
- Available evidence (simulated or real)
- Expected verdict and confidence tier
- Key behavioral checks to verify

## When to Run

- Before submitting a PR that changes scoring anchors or thresholds
- Before submitting a PR that changes adversarial pass rules
- After adding a new mode
- When debugging unexpected verdicts

## How to Run

See `run-evals.md` for the full protocol.

Quick version:
1. Open a Claude Code session
2. Run `/ideate validate` with the case's idea and evidence
3. Check the output against the expected verdict and behavioral checks
4. Mark pass/fail

## Case Index

| # | Case | Mode | Expected verdict |
|---|---|---|---|
| 01 | Strong commercial idea with cited evidence | VALIDATE | BUILD HIGH |
| 02 | No pain evidence | VALIDATE | KILL |
| 03 | Feasibility is the only weak dimension | VALIDATE | NARROW |
| 04 | Strong pain, weak competitive gap | VALIDATE | PIVOT |
| 05 | OSS goal, duplicates healthy project | VALIDATE | KILL |
| 06 | Learning goal, feasible scope | VALIDATE | BUILD HIGH |
| 07 | Internal tool, no named maintainer | VALIDATE | NARROW |
| 08 | Research goal, falsifiable question | VALIDATE | BUILD |
| 09 | Offline mode (no tools) | VALIDATE | ASSUMPTION labels + LOW + 5 search strings |
| 10 | 3-idea comparison | COMPARE | Comparison matrix + winner |
