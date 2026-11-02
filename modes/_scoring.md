# /ideate — Scoring Anchors

Loaded only when scoring. Contains dimension anchors and scoring rules.

---

## 8 Dimensions

### 1. Pain Severity — How much does this hurt?

| Score | Description |
|---|---|
| 0 | Speculative claim; no community evidence found |
| 1 | 1–2 anecdotal mentions; could be isolated |
| 2 | Multiple mentions but inconsistent framing |
| 3 | 10+ complaints across 2+ independent sources |
| 4 | Recurring complaint; named in how-to guides or workaround threads |
| 5 | Consistently top-ranked pain in the community; named in multiple top posts |

### 2. Frequency — How often does this happen?

| Score | Description |
|---|---|
| 0 | One-off or hypothetical event |
| 1 | Rare; less than monthly for most users |
| 2 | Occasional; a few times per month |
| 3 | Weekly mentions across multiple channels |
| 4 | Multiple times per week for the target user |
| 5 | Daily workflow problem with named workarounds; users hit it every session |

### 3. Demand Evidence — Do we have proof people want a solution?

| Score | Description |
|---|---|
| 0 | No signals found |
| 1 | 1 post type in 1 community; could be noise |
| 2 | Multiple posts in 1 community, or 1 post type across 2 communities |
| 3 | 1–2 source types with named examples (e.g., forum complaints + GitHub issues) |
| 4 | 2–3 source types; consistent framing across types |
| 5 | 3+ independent source types (forums + search trends + purchase signals); consistent |

### 4. Willingness to Pay / Adopt — Will they actually use or pay for this?

| Score | Description |
|---|---|
| 0 | No signal whatsoever |
| 1 | Users mention wanting free tools only |
| 2 | Some evidence of paying for adjacent solutions |
| 3 | Clear evidence they pay for a similar or adjacent tool |
| 4 | Strong evidence of paying for this exact job-to-be-done |
| 5 | Explicit purchase intent stated in community posts, OR OSS project with > 500 stars doing 80% of this |

### 5. Competitive Gap — Is there a real opening?

| Score | Description |
|---|---|
| 0 | Saturated; existing tools solve the problem well and users are satisfied |
| 1 | Tools exist; complaints are minor and being addressed |
| 2 | Real gaps exist but incumbents have stated roadmap items |
| 3 | Gaps exist and being addressed slowly; workarounds are common |
| 4 | Clear gap; no roadmap item; workarounds are clunky |
| 5 | Cited unmet gap with active clunky workarounds; no credible roadmap item from any incumbent |

### 6. Reachability — Can you actually reach the target users?

| Score | Description |
|---|---|
| 0 | No clear channel exists with stated constraints |
| 1 | Theoretical channel exists but no access |
| 2 | 1 channel identified with rough size estimate; access unclear |
| 3 | 1 clear channel with approximate size and a plausible approach |
| 4 | 2 channels; direct community presence or network access |
| 5 | Strong community presence + direct network access (you know 10+ target users personally) |

### 7. Build Feasibility — Can you actually build this?

| Score | Description |
|---|---|
| 0 | Requires a team, external funding, or expertise far outside stated skills |
| 1 | Solo possible but would take > 6 months or requires significant new skill acquisition |
| 2 | Solo 4–6 month build with some new skill acquisition |
| 3 | Solo 3-month build realistic with current skills |
| 4 | Solo 4–6 week build with current skills |
| 5 | Solo 2-week MVP achievable with stated skills right now |

### 8. Goal Fit — Does this serve the stated goal?

| Score | Description |
|---|---|
| 0 | Idea directly contradicts stated goal (e.g., learning goal but idea requires ML infra) |
| 1 | Weak alignment; significant trade-offs vs stated goal |
| 2 | Partial fit; achieves some goal outcomes |
| 3 | Reasonable fit with trade-offs |
| 4 | Strong fit; minor misalignments only |
| 5 | Direct alignment; success metrics for the idea and the stated goal are identical |

**Goal Fit Score 5 anchors by goal type** (prevents circular scoring):

| Goal | Score 5 requires |
|---|---|
| Commercial | Path to first dollar is clear and plausible within stated constraints |
| OSS | Clear adoption path + meaningful community value relative to existing projects |
| Internal | Named stakeholder would approve; directly solves their named problem |
| Research | Falsifiable question, named baseline, cannot be answered with existing data |
| Learning | Shippable demo + named skill gains achievable alone within stated time |

---

## Scoring Rules

1. No cited evidence → maximum score is 2, label `ASSUMPTION`
2. Show sub-scores first (all 8 raw scores)
3. Apply weights from `goal-variants.md` for the stated goal type
4. Show weighted contribution per dimension
5. Show weighted total and confidence tier

**Format:**
```
Dimension          | Raw | Weight | Weighted | Evidence
-------------------|-----|--------|----------|----------
Pain severity      | 3   | 1.5    | 0.45     | [citation]
...
TOTAL              |     |        | 3.4      |
Verdict: NARROW — MEDIUM confidence
```

---

## Learning Goal Guard

If Build Feasibility + Goal Fit combined weighted contribution would alone push the total ≥ 3.8, but raw pain ≤ 2 and raw demand ≤ 2: cap the verdict at NARROW. Learning-focused scoring must not produce BUILD on motivation alone.

---

## Worked Threshold Example (Commercial goal)

All dimensions score 3. Commercial weights applied:
- Pain (1.5 × 3) + Frequency (1.0 × 3) + Demand (1.5 × 3) + WTP (2.0 × 3) + Gap (1.5 × 3) + Reach (1.0 × 3) + Feasibility (1.0 × 3) + Goal Fit (0.5 × 3) = 30.0 / 10.0 = 3.0 weighted average → NARROW
- To reach BUILD (≥ 3.8), total weighted must be ≥ 38. With all weights summing to 10, you need an average raw score of ≥ 3.8 across all dimensions.
