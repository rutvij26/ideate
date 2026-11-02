# Eval 02 — No Pain Evidence (KILL)

## Idea

"A web app that generates personalized book recommendation lists using AI based on reading history."

## Goal type

Commercial

## Constraints

Standard

## Setup note

Run in online mode. If search tools are available, the skill should find that this space is heavily saturated (Goodreads, StoryGraph, Amazon, etc.) and should find minimal unmet pain evidence.

If running in offline mode: provide no evidence paste-back — the skill must proceed with ASSUMPTION labels only.

## Expected verdict

**KILL — LOW or MEDIUM confidence**

Reasons: saturated market, low competitive gap, low demand evidence (needs are already met), no clear wedge.

## Behavioral checks

- [REQUIRED] Verdict is KILL
- [REQUIRED] Adversarial pass names at least one specific existing solution
- [REQUIRED] Score table shows competitive gap ≤ 2 (saturated market)
- [REQUIRED] Kill debrief protocol is triggered (pivot hypothesis present)
- [REQUIRED] Loop-back offer is presented after debrief
- Unverified claims are listed
- `ideate/<slug>/kill-debrief.md` is written
