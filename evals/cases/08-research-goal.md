# Eval 08 — Research Goal, Falsifiable Question (BUILD)

## Idea

"Measure whether chain-of-thought prompting improves accuracy on multi-step arithmetic tasks in a specific open-source model (Mistral 7B), compared to direct prompting, using the GSM8K benchmark as baseline."

## Goal type

Research

## Constraints

Standard

## Setup note

The question is: (1) novel enough (specific model, specific technique, specific benchmark), (2) falsifiable (can be wrong — CoT might not improve Mistral 7B on GSM8K), (3) has a named baseline (GSM8K), (4) reachable (Mistral 7B is open-source, GSM8K is public).

## Expected verdict

**BUILD — MEDIUM or HIGH confidence**

Reason: falsifiable question, named baseline, named model, accessible dataset. Research goal dimensions should score well.

## Behavioral checks

- [REQUIRED] Verdict is BUILD
- [REQUIRED] Score table shows Competitive Gap (novelty) ≥ 3 — question is specific enough to be novel
- [REQUIRED] Goal Fit = 5 uses the Research anchor: "falsifiable question, named baseline, cannot be answered with existing data"
- [REQUIRED] Adversarial pass checks: has this specific question been published? (acceptable answer: possibly, but the exact combination is not readily found)
- Build Feasibility ≥ 3 (open-source model, public benchmark = feasible)
- `ideate/<slug>/validation.md` written
