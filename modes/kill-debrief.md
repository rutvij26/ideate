# /ideate — KILL Debrief

Runs when any VALIDATE or COMPARE verdict is KILL. Produces a structured post-mortem and manages the loop-back offer.

**Load before running:** `modes/_shared.md`, `modes/templates.md`.

---

## Step 1 — Identify Killer Dimensions

From the validation scoring table, identify which dimensions scored ≤ 2. These are the killers.

List each:
- Dimension name
- Raw score
- Why it scored low (specific evidence, or "no evidence found")

---

## Step 2 — Top 3 Failure Reasons

From the adversarial pass in the validation output. Must be non-padded and specific.

Format: one sentence each. Not "market is competitive" — but "the top-ranked OSS tool [name] already does [specific thing] and has [N] stars."

If the adversarial pass was not run (error case): run it now before proceeding.

---

## Step 3 — What Good Evidence Would Have Looked Like

For each killer dimension: describe the specific evidence that would have produced a score of 3+.

Examples:
- Pain severity killed it at 1: "Score 3 would require: 10+ complaints about [specific problem] across 2 independent sources. Suggested search: '[query]'"
- Demand killed it at 0: "Score 3 would require: evidence that people pay for a similar solution, e.g., pricing pages of tools in this category with active paying users."

This is the most actionable section — it tells the builder exactly what to validate before trying again.

---

## Step 4 — Pivot Hypotheses

Generate 1-2 pivot hypotheses. Must be specific — not "try a different market" but "if [specific assumption] were different, this could work as [concrete narrower idea]."

Format:
```
Pivot hypothesis 1:
If [specific assumption that failed], this could work as [concrete narrower version].
Next step: [specific action to test this pivot]
```

If the kill was due to a bad gap (strong incumbents), pivot toward a different segment or narrower job-to-be-done, not a different market entirely.

---

## Step 5 — Domain Tagging

Tag this kill with a domain (e.g., "dev-tools", "b2c-saas", "internal-tool-fintech", "oss-cli").

Extract a one-sentence lesson: "[domain] — [what failed] — [what would need to be true for this to work]"

This lesson will be shown as a warning on the next IDEATE run in the same domain.

---

## Step 6 — Loop-Back Offer

Use `AskUserQuestion`:
- "Loop back to IDEATE with these lessons applied"
- "Stop here"

If looping back:
- Load all accumulated kill lessons from prior `ideate/*/kill-debrief.md` files
- Pass them as domain-tagged warnings into the next IDEATE run
- Show the user: "Carrying [N] failure lessons from prior sessions. I'll warn you if a new idea risks the same failure modes."

If multiple ideas were killed in a COMPARE run: combine all lessons into one set before looping back.

---

## Output

Write to `ideate/<slug>/kill-debrief.md` using the template from `modes/templates.md`.

Print in chat: killer dimensions, top failure reason, best pivot hypothesis.
