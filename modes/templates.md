# /ideate — Output Templates

Canonical source of truth for all output file formats. If a mode file's inline format conflicts with this file, this file wins.

---

## brief.md

```
# [Idea Name] — Brief

**Slug:** [slug]
**Date:** [YYYY-MM-DD]
**Goal type:** [Commercial | OSS | Internal | Research | Learning]
**Target user:** [description]
**One-job sentence:** [who] needs to [what job-to-be-done]
**Constraints:** [time, budget, skills]
**Status:** [IDEATED | VALIDATING | VALIDATED — BUILD | VALIDATED — NARROW | VALIDATED — PIVOT | VALIDATED — KILL | SCOPED]
```

---

## evidence.md

```
# Evidence Log — [slug]

| Claim | Quote (≤125 chars) | URL | Date | Type | Supports |
|---|---|---|---|---|---|
| [claim] | "[quote]" | [url] | [YYYY-MM] | [complaint/workaround/purchase-signal/competitor/metric/counter-evidence] | [+/-/0] |
```

**Evidence Re-Entry Template (for offline mode — paste filled table back):**

```
# Evidence Paste-Back
Idea: [slug]
| Claim | Quote | URL | Date | Type | Supports |
|-------|-------|-----|------|------|----------|
|       |       |     |      |      |          |
```

---

## validation.md

```
# [Idea Name] — Validation

**Verdict:** [BUILD | NARROW | PIVOT | KILL] — [HIGH | MEDIUM | LOW] confidence
**Date:** [YYYY-MM-DD]
**Goal type:** [type]

## Score

| Dimension | Raw (0–5) | Weight | Weighted | Evidence |
|---|---|---|---|---|
| Pain severity | | | | |
| Frequency | | | | |
| Demand evidence | | | | |
| Willingness to pay/adopt | | | | |
| Competitive gap | | | | |
| Reachability | | | | |
| Build feasibility | | | | |
| Goal fit | | | | |
| **Total** | | **10.0** | **[total]** | |

## Strongest Evidence

1. [claim — source URL — date]
2. [claim — source URL — date]
3. [claim — source URL — date]

## Case Against (Adversarial Pass)

**Top 3 failure reasons:**
1. [specific reason]
2. [specific reason]
3. [specific reason]

**Strongest incumbent / substitute:** [name] — users won't switch because [specific reason]

**Riskiest assumption:** [one sentence]

**Real pain vs stated want:** [assessment]

## Unverified Claims

- [claim 1] — ASSUMPTION
- [claim 2] — ASSUMPTION

## Next Experiment

[Specific action] — pass threshold: [metric + number] in [timeframe]. Fail = [what to do if it fails].

## Sources

- [URL] — [one-line description]
```

---

## competitors.md

```
# [Idea Name] — Competitive Landscape

**Date:** [YYYY-MM-DD]

## Competitor Matrix

| Name | Type | Target User | Pricing | Strengths | Weaknesses | Activity | Source |
|---|---|---|---|---|---|---|---|
| | Direct commercial | | | | | | |
| | Adjacent commercial | | | | | | |
| | OSS/self-hosted | | | | | | |
| | DIY | | | | | | |
| | Substitute | | | | | | |

*Weaknesses: attributed quotes ≤ 125 chars from primary sources.*

## Complaint Themes

| Theme | Quote count | Example quote (≤125 chars) |
|---|---|---|
| | | |

## Gap Analysis

**Gap:** [description]
- Real need or deliberate trade-off? [assessment]
- Can an incumbent close this in one release? [yes/no + reason]
- Wedge type: [price | UX | segment | integration | speed]
- Defensibility horizon: [assessment]

## Positioning

For [target user] who [pain], [product] is the [category] that [differentiator]. Unlike [main competitor], we [key distinction].

## OSS Reuse Check

Before building from scratch: is there an existing project to fork / extend / contribute to / depend on?
- [project name] — [assessment: fork / extend / contribute / skip because X]
```

---

## mvp.md

```
# [Idea Name] — MVP

**Date:** [YYYY-MM-DD]
**Verdict prerequisite:** [BUILD | NARROW] from validation.md

## One Job

[who] needs to [job — one sentence, no "and"]

## Scope

### Now (≤5 features, riskiest assumption tested first)
1. [feature]
2. [feature]
3. [feature]

### Next
- [feature]

### Later
- [feature]

### Not Doing
- [explicit exclusion]

## Success Metric

[Numeric threshold] by [specific date]. If not reached: [kill/pivot action].

Example: 10 signups from [community] in 14 days. If not: kill.

## First 10 Users

[Named people, named community, or named first channel — not "social media"]

## Tech Sketch

[Brief description consistent with stated skills — no-code preferred for Learning goal type]

## Risk Register

| Assumption | How to test | Pass signal | Fail signal |
|---|---|---|---|
| [assumption 1] | [test] | [signal] | [signal] |
| [assumption 2] | [test] | [signal] | [signal] |
| [assumption 3] | [test] | [signal] | [signal] |

## Handoff Prompt

Paste this into any coding agent (Spec Kit, BMAD, etc.):

```
NAME: [idea name]
USER & JOB: [who] needs to [job-to-be-done]
NOW SCOPE (max 5):
1. [feature]
2. [feature]
OUT OF SCOPE: [explicit exclusions]
CONSTRAINTS: [time, budget, skills]
RISKIEST ASSUMPTION: [one sentence]
SUCCESS METRIC: [number + date + kill trigger]
ACCEPTANCE CRITERIA:
1. [criterion]
2. [criterion]
3. [criterion]
```
```

---

## compare.md

```
# Idea Comparison

**Date:** [YYYY-MM-DD]
**Goal type:** [shared type or per-idea note]
**Ideas compared:** [list]

## Comparison Matrix

| Dimension | [Idea 1] | [Idea 2] | [Idea 3] |
|---|---|---|---|
| Pain severity | [score] — [evidence] | | |
| Frequency | | | |
| Demand evidence | | | |
| Willingness to pay/adopt | | | |
| Competitive gap | | | |
| Reachability | | | |
| Build feasibility | | | |
| Goal fit | | | |
| **Weighted total** | | | |
| **Confidence** | | | |

## Adversarial Pass

### [Idea 1]
1. [failure reason]
2. [failure reason]
3. [failure reason]

### [Idea 2] ...

**Cross-cutting risk:** [one risk that applies to all ideas]

## Winner

[Idea name] — [weighted score] — [confidence]

Why: [2 lines]

## Runner-Up

[Idea name] — conditions under which it wins: [specific condition]

## Individual Validation Files

- [ideate/compare-[slug]/idea-1-validation.md](idea-1-validation.md)
- [ideate/compare-[slug]/idea-2-validation.md](idea-2-validation.md)
```

---

## kill-debrief.md

```
# [Idea Name] — Kill Debrief

**Verdict:** KILL
**Date:** [YYYY-MM-DD]

## Killer Dimensions

| Dimension | Raw Score | Why it killed |
|---|---|---|
| [dimension] | [score] | [reason] |

## Top 3 Failure Reasons

1. [specific, non-padded reason]
2. [specific, non-padded reason]
3. [specific, non-padded reason]

## What Good Evidence Would Have Looked Like

For [killer dimension]: [specific evidence that would have scored 3+]

## Pivot Hypotheses

1. If [specific assumption] were different, this could work as [narrower idea].
2. [Optional second hypothesis]

## Loop-Back Decision

[LOOPING BACK TO IDEATE with lessons applied | SESSION ENDED]

**Domain tag:** [e.g., dev-tools, b2c-saas, internal-tool]

**Lesson for future sessions:** [one-sentence takeaway applicable to this domain]
```

---

## Chat Reply Shape

For the in-chat final summary (not the file output):

```
**[VERDICT] — [CONFIDENCE]**

[2-line why]

**Evidence:**
1. [claim — URL — date]
2. [claim — URL — date]
3. [claim — URL — date]

**Top risks:**
1. [risk]
2. [risk]
3. [risk]

**Next experiment:** [action] — pass: [metric + threshold] in [timeframe]

**Files written:**
- ideate/[slug]/[file.md]
- ideate/[slug]/[file.md]
```

If file writes were unavailable: replace "Files written" with: "File write unavailable — full output above."
