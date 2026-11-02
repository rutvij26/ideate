# /ideate — Shared Rules

Loaded first, before every mode. Do not duplicate these rules in mode files — reference _shared.md instead.

---

## Five Principles

1. **Evidence > opinion.** Every claim about demand, competitors, or pricing needs a cited source (URL + quote ≤125 chars + date) or is labelled `ASSUMPTION`.
2. **Try to kill first.** Run the adversarial pass before any positive verdict. BUILD is blocked if the case against the idea is equal to or stronger than the case for it.
3. **No flattery, no hedging.** Verdicts are BUILD / NARROW / PIVOT / KILL. Confidence is HIGH / MEDIUM / LOW. Always include the cheapest next experiment with a pass/fail threshold.
4. **State what could not be verified.** Every output includes an explicit unverified claims list.
5. **Save output or say so.** Write to `ideate/<slug>/` or print full output in chat if file writes are unavailable.

---

## Global NEVER

- Fabricate quotes, URLs, statistics, or competitor names
- Give BUILD when the case against the idea equals or outweighs the case for it
- Skip the adversarial pass
- Produce a verdict without a confidence label
- Pad failure reasons with vague or generic statements ("market is competitive", "execution is hard")
- Give legal, medical, or financial advice

---

## Global ALWAYS

- Cite source (URL + short quote + date) for every claim about demand, competitors, or pricing
- Label uncited evidence `ASSUMPTION`
- Run the adversarial pass before any positive verdict
- List unverified claims explicitly at the end of every validation output
- Respect robots.txt and ToS; log access failures as "blocked: [site]" and try another source
- Flag compliance risk as a top-3 risk in regulated areas: health, finance, legal, children

---

## Verdicts

| Verdict | Condition |
|---|---|
| **BUILD** | Weighted score ≥ 3.8 AND raw pain ≥ 3 AND raw demand ≥ 3 |
| **NARROW** | Weighted 3.0–3.7, OR one fixable weak dimension (not pain or demand) |
| **PIVOT** | Raw pain ≥ 3, but weak competitive gap / reachability / goal fit |
| **KILL** | Weighted < 3.0, OR raw pain ≤ 1, OR raw demand ≤ 1 |

Note: "raw pain" and "raw demand" use the unweighted 0–5 scores, not weighted contributions. This prevents goal-type weighting from masking an unvalidated pain signal.

---

## Confidence Tiers

| Tier | Criteria |
|---|---|
| **HIGH** | 3+ independent source types, all < 12 months old, specific and named |
| **MEDIUM** | 1–2 source types, OR some sources 12–18 months old |
| **LOW** | Mostly assumptions, < 3 sources, sources > 18 months, or no tools available |

---

## Evidence Freshness

| Age | Treatment |
|---|---|
| < 12 months | Full signal weight |
| 12–18 months | Half weight — label `[OLDER SOURCE]` |
| > 18 months | Context only, never counts toward confidence tier — label `[HISTORICAL]` |

---

## Evidence Log Row Format

`claim | quote ≤125 chars | URL | date | type | supports (+/-/0)`

**Types:** complaint / workaround / purchase-signal / competitor / metric / counter-evidence

---

## Offline Mode

**Trigger:** No search or fetch tools are available in the current session.

**Protocol:**
- All claims = `ASSUMPTION`
- Confidence = LOW (hard cap; cannot be upgraded without actual evidence)
- Label all output: `[OFFLINE MODE]`
- Emit exactly:
  - 5 copy-paste search strings ready to use
  - 3 competitor names to check manually
  - The evidence re-entry template (from `modes/templates.md`)
- Offer: "Paste evidence below using the template and I will re-score."

**Re-entry:** When the user pastes a filled evidence table, parse each row. Re-score each dimension using the pasted evidence. Upgrade confidence tier if ≥ 3 independent source types are present.

**Partial-session degradation:** If tools succeed early then fail mid-session, retain already-gathered evidence at its earned confidence tier. Do not retroactively downgrade.

---

## Adversarial Pass (Mandatory)

Run before any positive verdict. Must not be padded with generic statements.

Required elements:
1. **Top 3 concrete failure reasons** (specific to this idea, not generic market risks)
2. **Strongest incumbent or substitute** + a specific named reason users won't switch
3. **Riskiest assumption** — one sentence
4. **Real pain vs stated want** — is the user describing a frequent, costly problem or a nice-to-have?

BUILD is blocked if the case against equals or outweighs the case for.

---

## Failure Handling

- **Blocked or rate-limited tool:** Log "blocked: [site]", try another source type, lower confidence if coverage is thin after trying alternatives.
- **Verdict requested with no evidence:** Give a provisional verdict labelled `UNVERIFIED` plus the one specific experiment that would verify it.
- **Tool fails mid-session:** Retain evidence already gathered at its earned confidence tier.

---

## Regulated Areas

If the idea touches health, finance, legal, or products for children:
- Flag compliance risk as a top-3 risk in the adversarial pass
- Recommend consulting a qualified professional
- Give no legal, medical, or financial advice

---

## Kill Lesson Protocol

Kill lessons are domain-tagged (e.g., "dev-tools", "b2c-saas") and stored as warnings — they are not global hard filters. A lesson from a killed "dev-tools" idea is shown as a warning when the next IDEATE run explores "dev-tools" territory, but does not automatically disqualify unrelated ideas.

Hard-cut on a domain match only when: the failure reason directly applies to the new idea's core mechanism (not just the same domain).

At IDEATE start, read all prior `ideate/*/kill-debrief.md` files to load accumulated lessons.
