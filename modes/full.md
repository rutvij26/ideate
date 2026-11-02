# /ideate — FULL Mode

Runs the complete pipeline: IDEATE → VALIDATE → COMPETE → SCOPE, with stage gates.

**Load:** `modes/_shared.md` first. Each stage loads only its own required files.

---

## Stage Sequence

```
[IDEATE if no idea] → [VALIDATE] → [COMPETE] → [SCOPE]
```

If the user already has an idea: skip IDEATE.
If the user already has a BUILD or NARROW verdict: offer to skip VALIDATE.

---

## Stage Gate Protocol

After each stage completes, print a 3-line gate summary and ask to continue.

Gate summary format:
```
Stage [N]/[total] complete: [STAGE NAME]
Verdict: [verdict or key finding]
Top risk: [one specific risk]
```

Then use `AskUserQuestion`:
- "Continue to [next stage name]"
- "Skip [next stage name]"
- "Stop here"

Never proceed to the next stage without explicit user confirmation.

---

## Stage 1: IDEATE (conditional)

Run if the user has no idea. Follow `modes/ideate.md` fully.

Gate output: "Stage 1/4 complete: IDEATE — Shortlisted [N] ideas. Top pick: [name] (score [X]/5)"

If user picks an idea: carry the slug and evidence log into Stage 2.

---

## Stage 2: VALIDATE

Follow `modes/validate.md` fully for the chosen idea.

Progress indicator shown during evidence gathering: `[Stage 2/4: VALIDATE — evidence gathering in progress]`

Gate output: "Stage 2/4 complete: VALIDATE — Verdict: [BUILD | NARROW | PIVOT | KILL] — [confidence]"

**KILL handling:** If verdict is KILL, do not proceed to COMPETE or SCOPE. Trigger `modes/kill-debrief.md`. After debrief:

Use `AskUserQuestion`: "Loop back to Stage 1 (IDEATE) with lessons applied?" / "Stop here"

If PIVOT: ask user if they want to pivot and re-run VALIDATE with the adjusted idea, or stop.

---

## Stage 3: COMPETE

Follow `modes/compete.md` fully.

Progress indicator: `[Stage 3/4: COMPETE — mapping competitor landscape]`

Gate output: "Stage 3/4 complete: COMPETE — [N] competitors mapped. Key gap: [one-line summary]"

---

## Stage 4: SCOPE

Follow `modes/scope.md` fully.

Progress indicator: `[Stage 4/4: SCOPE — defining MVP]`

Final output: "Pipeline complete. Files written: [list]"

---

## Context Carry-Forward Rules

- Do not re-ask questions already answered in prior stages
- Pass slug, evidence log, goal type, and constraints through all stages
- If evidence gathered in VALIDATE covers COMPETE questions: use it, don't re-query

---

## Skip Logic

If user has an existing BUILD/NARROW verdict in `ideate/<slug>/validation.md`:

Use `AskUserQuestion`: "Existing BUILD/NARROW verdict found. Jump to:" / "COMPETE" / "SCOPE" / "Run VALIDATE again (evidence may be stale)"
