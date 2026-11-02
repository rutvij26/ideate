# /ideate — COMPARE Mode

Scores 2-4 ideas side-by-side and recommends a winner.

**Load before running:** `modes/_shared.md`, `modes/_scoring.md`, `modes/goal-variants.md`, `modes/evidence-sources.md`, `modes/templates.md`.

---

## Step 1 — Trigger

Triggered when:
- User provides 2+ ideas in one message
- User types "compare" after the IDEATE shortlist
- User explicitly invokes `/ideate compare`

Maximum 4 ideas per comparison run.

---

## Step 2 — Intake

Use `AskUserQuestion`:

1. Confirm all ideas to compare (show list, offer to edit)
2. Goal type: single-select — "Use one goal type for all ideas (fair comparison)" / "Score each idea under its own goal type (note incomparability)"
3. Constraints (single-select): Lean / Standard / Resourced

If goal types differ per idea and user chooses per-idea: note in output "These ideas are scored under different goal types and the comparison is approximate."

---

## Step 3 — Evidence Gathering

For each idea: gather evidence for the 8 scoring dimensions. Use query patterns from `modes/evidence-sources.md`.

This is parallel research — gather for all ideas before scoring any. Log evidence for each idea in its own evidence section.

If online: run evidence gathering for all ideas.
If offline: enter offline mode for all ideas simultaneously. Emit one combined offline evidence template covering all ideas.

---

## Step 4 — Score All Ideas

Score each idea on all 8 dimensions using anchors from `_scoring.md` and weights from `goal-variants.md`.

Apply the same rules as VALIDATE:
- No cited evidence → max 2 + ASSUMPTION
- Apply Learning goal guard
- Show raw scores and weighted totals for each idea

---

## Step 5 — Adversarial Pass (All Ideas)

For each idea: 3 concrete failure reasons (non-padded).

One cross-cutting risk that applies to all ideas in this comparison (e.g., "All three depend on the same unproven assumption: [X]").

---

## Step 6 — Comparison Matrix

| Dimension | [Idea 1] | [Idea 2] | [Idea 3] |
|---|---|---|---|
| Pain severity | [score] — [evidence 1-line] | | |
| ... | | | |
| **Weighted total** | | | |
| **Confidence** | | | |

---

## Step 7 — Winner

Conditions for a winner:
- Highest weighted score
- Raw pain ≥ 3 and raw demand ≥ 3

Tiebreaker: higher Build Feasibility score (ships faster).
If Build Feasibility also tied: present both ideas as co-winners with explicit note.

**All-KILL path:** If all ideas score KILL (weighted < 3.0, or pain ≤ 1, or demand ≤ 1):
- Trigger `modes/kill-debrief.md` protocol for the highest-scoring idea
- Offer loop-back to IDEATE using widget: "Loop back to IDEATE with combined failure lessons?" / "Stop here"
- Carry all failure lessons from all killed ideas into the next IDEATE run

---

## Step 8 — Runner-Up

State the second-best idea and the specific conditions under which it would beat the winner:
"[Idea 2] wins if: [specific condition, e.g., 'the builder already has relationships in [community]']"

---

## Step 9 — Per-Idea Validation Files

Write individual validation files for each idea so the builder can deep-dive on the winner:
`ideate/compare-<slug>/idea-1-validation.md`
`ideate/compare-<slug>/idea-2-validation.md`
etc.

Use the `validation.md` template from `modes/templates.md`.

---

## Output

Write to `ideate/compare-<slug>/compare.md` using the template from `modes/templates.md`.

Print summary in chat: comparison matrix, winner recommendation, runner-up condition.
