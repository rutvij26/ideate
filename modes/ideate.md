# /ideate — IDEATE Mode

Generates ideas when the user has none, or wants new angles.

**Load before running:** `modes/_shared.md`, `modes/_scoring.md` (for scoring survivors), `modes/goal-variants.md` (for weights), `modes/evidence-sources.md` (for queries).

---

## Step 1 — Startup

Check `ideate/` for any prior `kill-debrief.md` files. If found, load domain-tagged lessons as warnings.

Show prior lessons to user: "Prior session killed a [domain] idea because [reason]. I'll watch for this."

These are warnings — they do not automatically disqualify ideas. Hard-cut only if the failure reason directly applies to the new idea's core mechanism.

---

## Step 2 — Intake

Use `AskUserQuestion` widgets. Skip anything already known.

1. Goal type (single-select): Commercial / OSS / Internal tool / Research / Learning
2. Constraints (single-select): Lean (solo, ≤2 weeks) / Standard (solo, ≤3 months) / Resourced (team/budget available)
3. Domain or space (open text): "What area should I explore ideas in? (Leave blank for open exploration)"
4. Ambition (single-select): Side project / Startup / Research project / Portfolio piece
5. Any hard constraints (open text): "Anything that must be true for you to pursue an idea? (e.g., open source, no infra costs)"

---

## Step 3 — Six Lenses

Generate 1-2 idea stubs per lens. **Each stub requires at least one real cited signal** (a named forum thread, GitHub issue, or community complaint) before it can be included. Do not fabricate signals.

If no signal can be found for a lens in online mode: note "No signal found for this lens" and skip it.

### Lens 1: Pain Mining
Source: community complaints, forum threads, "I wish there was" posts.
Find a specific, frequently cited frustration in the target domain. The idea: build a direct solution.
Signal required: a named post or thread with ≥ 3 upvotes/replies.

### Lens 2: Workflow Gaps
Source: posts describing manual steps between tools, "I spend X hours doing Y manually".
Find a workflow where two tools don't talk to each other, or a step that requires manual copying.
The idea: automate or bridge the gap.
Signal required: a specific workflow description from a real source.

### Lens 3: Tech Shift
Source: "X is now cheap/fast/accessible" — look for API price drops, new model capabilities, new open libraries in the last 12-24 months.
The idea: something that was impractical last year but is now feasible.
Signal required: a named technology change or price drop with a date.

### Lens 4: Unbundle / Rebundle
Unbundle: find one feature of a complex tool that a niche of users needs in isolation.
Rebundle: find 2-3 niche tools that target users always use together and bundle them.
Signal required: posts asking for the specific feature as a standalone, or threads showing users using the tools together.

### Lens 5: Underserved Segment
Source: a mainstream tool that ignores a specific niche with unique needs.
Find a niche whose requirements are dismissed or deprioritised by the dominant tool.
Signal required: posts from that niche expressing frustration with the mainstream tool's limitations.

### Lens 6: OSS Gap
Source: GitHub search, npm/PyPI registries, "awesome-X" lists.
Find an important use case with no maintained OSS solution — only commercial tools or nothing.
Signal required: GitHub search showing 0 relevant maintained projects (last commit > 12 months or no projects found).

---

## Step 4 — Hard-Cut Filter

Apply to every candidate. Automatic disqualification if any condition is true:

1. **No identifiable user.** There is no one the builder could talk to this week.
2. **Free good-enough workaround.** A free tool or built-in feature solves this adequately and users are happy with it.
3. **Inaccessible distribution.** The channel to reach users requires resources or access the builder doesn't have within their constraints.
4. **Can't ship v1 in time.** Given the stated constraints (time, budget, skills), a v1 cannot ship within the stated timeframe.
5. **Unclearable legal blocker.** There is a regulatory, IP, or compliance issue that cannot be addressed without significant legal resources.

Additionally: if a kill lesson from a prior session matches this idea's domain AND core mechanism, show it as a warning. Hard-cut only if the lesson directly applies (not just same domain).

---

## Step 5 — Score Survivors

For each idea that passes the hard-cut filter, run a quick 5-dimension score:
- Pain severity (from `_scoring.md`)
- Demand evidence (from `_scoring.md`)
- Competitive gap (from `_scoring.md`)
- Build feasibility (from `_scoring.md`)
- Goal fit (from `_scoring.md`)

Apply the relevant weights from `goal-variants.md` for the 5 scored dimensions only (re-normalise to sum to 10 for the 5 dimensions).

Show the score per surviving idea.

---

## Step 6 — Shortlist 3

Rank survivors by score. Shortlist the top 3. Include at least one idea shippable in ≤ 2 weeks.

If fewer than 3 pass the hard-cut: show the disqualified ideas with the specific reason for each cut.

**Per-idea output block:**

```
## [Idea Name]

**Pitch:** [one sentence]
**Lens:** [which of the 6]
**Who:** [specific user type]
**Problem:** [what they experience today] — Source: [URL]
**Current workaround:** [how they cope now]
**Wedge:** [why the builder could win entry into this market or community]
**Biggest risk:** [specific, not generic]
**Quick score:** [X.X/5]
**Next step:** [one concrete action to validate further]
```

---

## Step 7 — Guard

Before including any idea: if the pitch is "AI [noun] for [X]" or "AI-powered [X]", verify there is a specific cited unmet need that AI uniquely addresses. If the need is not cited, do not include the idea.

---

## Step 8 — Handoff Widget

After presenting the shortlist, use `AskUserQuestion`:
- Option A: "Go deep on [Idea 1 name]" → route to VALIDATE
- Option B: "Go deep on [Idea 2 name]" → route to VALIDATE
- Option C: "Go deep on [Idea 3 name]" → route to VALIDATE
- Option D: "Compare all 3 ideas" → route to COMPARE
- Option E: "Stop here"

---

## Output

Write to:
- `ideate/<slug>/brief.md` (use template from `modes/templates.md`)
- `ideate/<slug>/evidence.md` (evidence log for all signals gathered)

Print shortlist in chat.
