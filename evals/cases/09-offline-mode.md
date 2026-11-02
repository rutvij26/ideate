# Eval 09 — Offline Mode (No Tools)

## Idea

"A subscription service that sends weekly curated newsletters about indie game development."

## Goal type

Commercial

## Constraints

Standard

## Setup

**This case must be run with no web search or fetch tools available.** To simulate: tell the skill "no search tools available" when it asks about capability, or run in an environment without tool access.

Do NOT paste any evidence. The skill must proceed in offline mode only.

## Expected output

- `[OFFLINE MODE]` label on all output
- All claims labelled `ASSUMPTION`
- Confidence = LOW (hard cap, cannot be upgraded)
- Exactly 5 copy-paste search strings emitted
- Exactly 3 competitor names/categories to check manually
- Evidence re-entry template provided
- A provisional UNVERIFIED verdict with the specific experiment that would verify it
- Offer to accept pasted evidence for re-scoring

## Behavioral checks

- [REQUIRED] `[OFFLINE MODE]` label appears at the top of the output
- [REQUIRED] At least 5 search strings emitted
- [REQUIRED] At least 3 competitor categories named
- [REQUIRED] Evidence re-entry template provided
- [REQUIRED] Every claim is labelled `ASSUMPTION` — no claims presented as fact
- [REQUIRED] Confidence is LOW
- [REQUIRED] Adversarial pass still runs (with ASSUMPTION labels on all failure reasons)
- A verdict is given (UNVERIFIED) — the skill does not refuse to produce output in offline mode
