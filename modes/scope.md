# /ideate — SCOPE Mode

Defines the MVP and produces a tool-agnostic handoff prompt. Only runs after BUILD or NARROW.

**Load before running:** `modes/_shared.md`, `modes/templates.md`.

---

## Step 1 — Prerequisite Gate

Check `ideate/<slug>/validation.md`. If not present or verdict is PIVOT or KILL:

Use `AskUserQuestion`: "No BUILD or NARROW verdict found. Run VALIDATE first?" / "Skip prerequisite check (I know the verdict)"

If COMPETE has not run (no `competitors.md`):

Use `AskUserQuestion`: "Competitive landscape not mapped. Run COMPETE first (recommended) or go straight to SCOPE?"

---

## Step 2 — Intake

Use `AskUserQuestion` for anything not known:

1. Idea name (open text if not stated)
2. Target user (open text)
3. Primary job-to-be-done (open text): "What is the one thing this must do for the user?"
4. Constraints (single-select): Lean / Standard / Resourced

---

## Step 3 — One-Job Sentence

Draft: "[target user] needs to [one job-to-be-done]."

Test: could this be split into two separately valuable outcomes? If yes, it contains two jobs.

Use `AskUserQuestion` to present both:
- "Outcome A: [first job]"
- "Outcome B: [second job]"
- "Both (proceed with compound scope — I understand the risk)"

Default to picking one. Compound scopes fail more often.

---

## Step 4 — Now / Next / Later / Not-Doing

Now: maximum 5 features. Sequenced by: test the riskiest assumption first.

For each Now feature: one line, active voice ("User can X", not "System will X").

Next: features for the second iteration, after the first success metric is hit.

Later: features requiring validation or resources not yet available.

Not-Doing: explicit list of features that might be expected but are out of scope. Saying "not doing" is as important as saying "doing."

---

## Step 5 — Success Metric

Define exactly: a numeric threshold + a specific date + a kill/pivot trigger.

Examples of good metrics:
- "10 signups from [community] within 14 days of launch. If not reached: kill."
- "3 paying users within 30 days at $X/month. If not reached: pivot pricing."
- "1 external contributor to the repo within 60 days. If not: rethink OSS positioning."

Reject vague metrics: "get users", "find product-market fit", "see if people like it."

---

## Step 6 — First 10 Users

Name them. Not "developers on Reddit" — "the 10 developers in [specific community/Slack/Discord/network]."

If the builder can't name 10, that's a reachability problem to solve before building.

---

## Step 7 — Tech Sketch

Consistent with the builder's stated skills. One paragraph maximum. If Learning goal: prefer no-code or a framework already known.

Note: this is a sketch, not an architecture. If the builder needs a full technical spec, that is the output of a different tool.

---

## Step 8 — Risk Register

| Assumption | How to test | Pass signal | Fail signal |
|---|---|---|---|
| [assumption 1] | [specific test] | [what pass looks like] | [what fail looks like] |
| [assumption 2] | | | |
| [assumption 3] | | | |

First row: the riskiest assumption (the one whose failure kills the idea fastest).

---

## Step 9 — Handoff Prompt

Generate a tool-agnostic handoff prompt the builder can paste into any coding agent:

```
NAME: [idea name]
USER & JOB: [target user] needs to [job-to-be-done]
NOW SCOPE (max 5):
1. [feature — active voice]
2. [feature]
OUT OF SCOPE: [explicit exclusions, one line each]
CONSTRAINTS: [time / budget / skills]
RISKIEST ASSUMPTION: [one sentence]
SUCCESS METRIC: [number + specific date + kill trigger]
ACCEPTANCE CRITERIA:
1. [specific, testable criterion]
2. [specific, testable criterion]
3. [specific, testable criterion]
```

---

## Output

Write to `ideate/<slug>/mvp.md` using the template from `modes/templates.md`.

Print a summary in chat: one-job sentence, Now scope (5 features), success metric, and handoff prompt block.
