# /ideate — Eval Protocol

How to run eval cases and score the output.

---

## Protocol

For each case:

1. Open a new Claude Code session (to avoid context contamination between cases)
2. Type `/ideate` to activate the skill
3. Follow the case's **Setup** instructions
4. When the skill produces output, check each item in the case's **Behavioral checks** list
5. Record pass/fail for each check
6. Record the overall verdict and confidence tier

---

## Scoring

A case passes if:
- The verdict matches the expected verdict (exact)
- The confidence tier matches
- All behavioral checks pass

A case fails if:
- The verdict is wrong
- The confidence tier is wrong
- Any behavioral check marked `[REQUIRED]` fails
- The adversarial pass is missing (always `[REQUIRED]`)

---

## Reporting

When a case fails, note:
- Which check failed
- What the skill produced instead
- Which file or rule governs the expected behavior

Open a GitHub issue using the bug_report template with the failed case details.

---

## Adding New Cases

Each new mode or scoring change must include a new eval case. Case format is defined in `cases/01-strong-build.md` — use it as a template.

Naming: `##-descriptive-name.md` where ## is the next sequential number.
