# Contributing to /ideate

Thank you for helping make /ideate better. This document covers how to contribute modes, goal types, evidence sources, and bug fixes.

## Ground Rules

- No fabricated examples in any template or mode file
- No competitor product names in templates or examples (data-source names like Reddit, HN, G2 are fine)
- Weight columns in `goal-variants.md` must each sum to exactly 10.0
- Every new mode must have a corresponding eval case in `evals/cases/`
- Changes to scoring anchors or thresholds require updating `evals/run-evals.md`

## Adding a New Mode

1. Create `modes/<mode-name>.md` following the structure of an existing mode
2. Add a row to the Modes table in `SKILL.md`
3. Add routing logic in SKILL.md's Routing section
4. Add an eval case in `evals/cases/` with expected verdict and key checks
5. Update `evals/run-evals.md` to include the new case
6. Update `CHANGELOG.md`

## Adding a Goal Type

1. Add a column to the weight table in `modes/goal-variants.md`
2. Verify the new column sums to exactly 10.0 (add a sum-check row)
3. Add success criteria, red flags, and an example idea for the new type
4. Add Goal Fit anchor for the new type in `modes/_scoring.md`
5. Add an eval case for the new goal type

## Adding Evidence Sources

1. Add the source to the relevant signal-type section in `modes/evidence-sources.md`
2. Add at least 2 query patterns for the new source
3. Note any ToS or access restrictions

## Pull Request Checklist

- [ ] No fabricated quotes, URLs, or examples
- [ ] No competitor product names in templates or examples
- [ ] Weight columns verified to sum to 10.0 (if goal-variants.md changed)
- [ ] Eval case added or updated
- [ ] `CHANGELOG.md` updated

## Reporting Issues

Use `.github/ISSUE_TEMPLATE/bug_report.md` for broken mode behavior.
Use `.github/ISSUE_TEMPLATE/new_mode.md` for proposing new modes.
