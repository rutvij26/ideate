# /ideate — VALIDATE Mode

Produces an evidence-backed BUILD / NARROW / PIVOT / KILL verdict on a single idea.

**Load before running:** `modes/_shared.md`, `modes/_scoring.md`, `modes/goal-variants.md`, `modes/evidence-sources.md`, `modes/templates.md`.

---

## Step 1 — Startup

Check `ideate/<slug>/` for prior output files.

If `evidence.md` exists: use `AskUserQuestion` — "Resume from prior evidence?" / "Start fresh"

If `validation.md` exists and has a verdict: offer to re-run (evidence may be stale).

---

## Step 2 — Intake

Use `AskUserQuestion` widgets for anything not already known:

1. Idea description (open text if not stated)
2. Goal type (single-select): Commercial / OSS / Internal tool / Research / Learning
3. Constraints (single-select): Lean (solo, ≤2 weeks) / Standard (solo, ≤3 months) / Resourced
4. Target user (open text, skip if clear)

---

## Step 3 — Capability Check

Follow the capability detection protocol from `SKILL.md`. If offline mode: declare it now and proceed per `_shared.md` offline protocol. Do not proceed silently — the user must know.

---

## Step 4 — Evidence Gathering

Load query patterns from `modes/evidence-sources.md`.

Run searches across the following signal types. Log each source in `evidence.md` as you go (write to file after every 3 entries — do not wait until the end):

**Required signal types to attempt:**
1. Pain evidence — community complaints and frustrations
2. Demand evidence — existing solutions, workarounds, explicit requests
3. Willingness to pay / adopt — pricing signals, purchase intent
4. Counter-evidence — posts defending the status quo, satisfied users

**Minimum before scoring:** attempt at least 3 different source types. If blocked on all 3, enter offline mode.

Apply the freshness model from `_shared.md`:
- > 18 months: label `[HISTORICAL]`, use as context only
- 12–18 months: label `[OLDER SOURCE]`, count at half weight

---

## Step 5 — Score 8 Dimensions

Load anchors from `modes/_scoring.md`. Load weights from `modes/goal-variants.md` for the stated goal type.

Score each dimension 0–5. Rules:
- No cited evidence → max score 2, label `ASSUMPTION`
- Apply freshness weighting to evidence used

Show scoring table:
```
Dimension          | Raw | Weight | Weighted | Evidence
Pain severity      | X   | X.X    | X.XX     | "[quote ≤125]" URL YYYY-MM
Frequency          | X   | X.X    | X.XX     | ...
...
TOTAL              |     | 10.0   | X.XX     |
```

Apply Learning goal guard: if Build Feasibility + Goal Fit weighted contribution alone would push total ≥ 3.8 but raw pain ≤ 2 and raw demand ≤ 2: cap at NARROW.

---

## Step 6 — Adversarial Pass (Mandatory)

Run this before stating the verdict. Do not pad with generic statements.

1. **Top 3 concrete failure reasons** (specific to this idea and this market)
2. **Strongest incumbent or substitute** + named reason users won't switch to something new
3. **Riskiest assumption** — the one thing that, if wrong, kills the idea
4. **Real pain vs stated want** — is this a daily costly frustration or a nice-to-have?

If the case against equals or outweighs the case for: verdict is KILL regardless of weighted score.

---

## Step 7 — Verdict

Apply thresholds from `_shared.md`:

| Verdict | Condition |
|---|---|
| BUILD | Weighted ≥ 3.8 AND raw pain ≥ 3 AND raw demand ≥ 3 |
| NARROW | Weighted 3.0–3.7, or one fixable weak dimension |
| PIVOT | Raw pain ≥ 3, but weak gap/reachability/goal fit |
| KILL | Weighted < 3.0, or raw pain ≤ 1, or raw demand ≤ 1 |

State:
- Verdict (BUILD / NARROW / PIVOT / KILL)
- Confidence tier (HIGH / MEDIUM / LOW)
- 2-line why
- Cheapest next experiment: specific action + pass threshold + fail action + timeframe

For NARROW: name the specific weak dimension and what would need to change for BUILD.
For PIVOT: suggest the specific pivot direction based on where the scores are strong.
For KILL: trigger `modes/kill-debrief.md` protocol.

---

## Step 8 — Unverified Claims List

List all claims that could not be verified (labelled `ASSUMPTION`). Be specific — not "market size is uncertain" but "no evidence found that [specific claim]".

---

## Step 9 — Sources

List all URLs cited with a one-line description of what each source provides.

---

## Output

Write to `ideate/<slug>/validation.md` using the template from `modes/templates.md`.

Print the Chat Reply Shape in chat (from `modes/templates.md`).
