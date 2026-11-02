# /ideate — Architecture Guide

A reference for contributors and users who want to understand how /ideate works internally.

---

## Philosophy

/ideate exists because most idea validation is vibes. Someone describes an idea, gets told "that sounds interesting" or "the market is competitive," and leaves with nothing actionable.

/ideate enforces a different contract: every claim about demand, competitors, or pricing needs a source URL, a short quote, and a date — or it is labelled `ASSUMPTION`. The skill tries to kill your idea before validating it. BUILD is not a default or a reward; it is a specific outcome of evidence clearing specific thresholds.

**What /ideate is not:**
- An encouragement machine. Verdicts are BUILD / NARROW / PIVOT / KILL — not "interesting idea worth exploring."
- A market research report generator. Evidence is gathered from primary community sources, not synthesised into consultant-style prose.
- A product roadmap tool. SCOPE produces a minimal handoff, not an engineering spec.
- A replacement for talking to users. The cheapest experiment always points outward — to real conversations with real people.

---

## Load Order and Token Budget

Every mode follows a selective loading discipline. Loading all files simultaneously before a short question wastes context and increases latency. The order:

1. `modes/_shared.md` — always first; contains the rules that govern all outputs
2. The specific mode file (e.g., `modes/validate.md`) — only the active mode
3. `modes/_scoring.md` — only when scoring (VALIDATE, COMPARE, IDEATE shortlist)
4. `modes/goal-variants.md` — only when applying dimension weights
5. `modes/evidence-sources.md` — only during evidence gathering
6. `modes/templates.md` — only when writing output files

This keeps the active instruction set to ~600-900 lines for most requests, rather than loading all 14 mode files simultaneously.

---

## Mode Architecture

### Routing

SKILL.md detects the user's intent from their message:
- ≥ 2 ideas given → COMPARE
- Single idea + "validate" / "demand" / "good idea" → VALIDATE
- "competitors" / "gaps" / "landscape" → COMPETE
- "scope" / "MVP" / "build plan" → SCOPE (gates on BUILD or NARROW)
- "ideate" / "what to build" / blank → IDEATE
- Ambiguous → FULL

### Stage Gates

FULL mode uses explicit stage gates. After each stage, a 3-line summary is printed and the user must confirm before the next stage starts. This prevents wasted work — if VALIDATE returns KILL, there is no point running COMPETE and SCOPE.

### Skip Logic

If prior output files exist in `ideate/<slug>/`, modes offer to resume rather than restart. This supports multi-session workflows: validate on Monday, scope on Wednesday, without re-running evidence gathering.

---

## Scoring System

### The 8 Dimensions

The dimensions were chosen to cover the three most common ways ideas fail:

**No real pain:** Dimensions 1 (Pain severity) and 2 (Frequency) detect whether the problem is real and frequent. The BUILD gate requires raw pain ≥ 3 for exactly this reason — weighted scoring alone can produce high totals from feasibility and goal fit even when pain is unvalidated.

**No real market:** Dimensions 3 (Demand evidence) and 4 (Willingness to pay/adopt) detect whether people will actually use and pay for a solution. Demand ≥ 3 is also a BUILD gate requirement.

**No real opening:** Dimensions 5 (Competitive gap) and 6 (Reachability) detect whether the builder can win entry.

**Not executable:** Dimensions 7 (Build feasibility) and 8 (Goal fit) detect whether this idea is right for this builder at this time.

### The BUILD Gate

BUILD requires:
- Weighted score ≥ 3.8
- Raw pain ≥ 3 (not ≤ 1 for KILL)
- Raw demand ≥ 3 (not ≤ 1 for KILL)

The raw gates exist because weighted scoring can mask weak pain if other dimensions are strong — particularly for Learning goal (Build Feasibility weight 3.0, Goal Fit weight 4.5). The Learning goal guard explicitly prevents this.

### Weight Rationale

Weights reflect what matters most for each goal type:

- **Commercial:** Willingness to pay (2.0) is highest because it is the most commonly skipped validation step. Founders often verify pain without verifying payment intent.
- **OSS:** Competitive gap (1.5) and Reachability (1.5) share the top — OSS succeeds through community adoption, not payment.
- **Internal:** Pain severity (2.0) is highest — internal tools exist to solve a specific known problem for a known team. If the pain is not severe and frequent, the tool won't be used.
- **Research:** Competitive gap (2.0) means novelty — research value comes from answering a question that isn't already answered.
- **Learning:** Build feasibility (3.0) and Goal fit (4.5) dominate — a learning project must be finishable and must produce the intended skill gains.

---

## Evidence System

### Source Hierarchy

Primary sources (used directly): Reddit posts, HN threads, GitHub issues, Stack Overflow questions, forum posts, review site entries, pricing pages.

Secondary sources (aggregated from primary): blog posts citing primary sources, "best of" lists, comparison pages.

Rule: prefer primary. A Reddit complaint > a blog summarising Reddit complaints.

### Confidence Tiers

Three tiers prevent false precision:

- **HIGH**: requires 3+ independent source types, all < 12 months. Example: Reddit complaints + GitHub issues + app store reviews, all from the past year.
- **MEDIUM**: 1-2 source types, or older data. Sufficient for most real decisions.
- **LOW**: mostly assumptions, < 3 sources, stale data, or no tools. A provisional verdict only — always includes a specific experiment to upgrade to MEDIUM.

### Offline Degradation

When no search or fetch tools are available, the skill does not silently proceed with fabricated evidence. It:
1. Declares OFFLINE MODE explicitly
2. Labels every claim `ASSUMPTION`
3. Caps confidence at LOW
4. Emits 5 ready-to-use search strings and 3 competitor names for manual checking
5. Accepts a paste-back of a filled evidence table to re-score

This makes offline mode useful rather than deceptive.

### Evidence Re-Entry

When the user pastes filled evidence rows, the skill parses each row's `supports` field (+/-/0) and re-scores:
- + rows count as supporting evidence for the relevant dimension
- - rows count as counter-evidence (lower the score)
- 0 rows are neutral (noted but do not change scores)
- Confidence upgrades if ≥ 3 independent source types are present in the pasted data

---

## Adversarial System

### Why Kill-First

The adversarial pass exists because positive evidence is easier to find than negative evidence. Searching for "people frustrated by X" will always find complaints — there are complaints about everything. The adversarial pass forces the skill to actively seek the strongest case against the idea before stating a verdict.

### What Counts as Padding

The NEVER rule against padding is specific: "do not pad failure reasons with vague or generic statements."

Examples of padding:
- "The market is competitive" — this is not a failure reason; it is an observation true of all markets.
- "Execution is hard" — true of all ideas; useless.
- "Users might not adopt it" — tautological.

Examples of non-padded failure reasons:
- "The top OSS project in this category ([name]) has 8,000 GitHub stars and was updated last month — users have a working, free alternative."
- "The only communities where target users congregate ([specific community]) have strict self-promotion rules, making direct outreach infeasible."
- "The riskiest assumption — that users will pay $X for Y — has no supporting evidence. The closest comparable tool offers this feature for free."

---

## Slug System

A slug is the idea name converted to lowercase kebab-case, max 40 characters, truncated at a word boundary.

Rules:
- Spaces → hyphens
- Remove special characters except hyphens
- All lowercase
- Max 40 characters, truncated at the last hyphen before the limit
- Collision: append -2, -3, etc.
- The user confirms or overrides the slug before any files are created

Multi-session discovery: at every mode start, the slug is checked against existing `ideate/` subdirectories. If a match is found, the user is offered to resume.

---

## Customisation Layer

### Loading Order

`_shared.md` → `~/.config/ideate/_profile.md` → `~/.config/ideate/_custom.md` → mode file

If profile/custom files are not at `~/.config/ideate/`, fall back to `modes/_profile.md` and `modes/_custom.md` in the working directory.

If neither exists: Goal Fit is scored as N/A; verbosity defaults to standard; file saves default to yes.

### Merge Semantics

- `_custom.md` NEVER rules: append to the global list (do not replace)
- `_custom.md` source preferences: add to or remove from the source map in `evidence-sources.md`
- `_custom.md` scoring overrides: replace the specific anchor description for the named dimension
- `_custom.md` output format: prepend to every output file written by the skill

### Why `~/.config/ideate/`

User profile and custom rules contain personal information (skills, domain, constraints) and house rules that are not appropriate to commit to a shared git repository. Placing them at `~/.config/ideate/` ensures they survive `git clean -fdx` and are not accidentally committed or exposed.

---

## Kill Lesson Domain-Tagging

Kill lessons are tagged with a domain label (e.g., "dev-tools", "b2c-saas", "internal-fintech") and stored in `ideate/<slug>/kill-debrief.md`.

On each new IDEATE run, the skill reads all prior kill-debrief.md files and collects domain-tagged lessons. These appear as warnings — not as hard-cut filters — unless the domain matches AND the failure reason directly applies to the new idea's core mechanism.

This prevents false negatives: a killed "dev-tools API wrapper" idea should not automatically kill an unrelated "dev-tools documentation generator" idea. The lesson is shown; the decision is the user's.

Accumulation across sessions: lessons stack. After 3+ kills in the same domain, the warnings become more prominent: "3 prior ideas in dev-tools were killed due to [pattern]."

---

## Output Architecture

All output is written to `ideate/<slug>/` in the working directory. Files:

| File | Written by | Content |
|---|---|---|
| `brief.md` | IDEATE | Idea summary, status |
| `evidence.md` | VALIDATE, IDEATE | Evidence log table |
| `validation.md` | VALIDATE | Full verdict with score breakdown |
| `competitors.md` | COMPETE | Competitor matrix, gap analysis |
| `mvp.md` | SCOPE | MVP scope, handoff prompt |
| `kill-debrief.md` | Any KILL verdict | Post-mortem, pivot hypotheses |
| `compare-<slug>/compare.md` | COMPARE | Side-by-side matrix |
| `compare-<slug>/idea-N-validation.md` | COMPARE | Per-idea validation |

The `ideate/` directory is gitignored (except `.gitkeep`) to prevent user idea data from being committed to the public skill repository.

---

## Scripts

The `scripts/` directory contains three lightweight bash scripts for offline evidence collection:

- `search-reddit.sh`: Queries the Reddit JSON API (no auth required). Outputs evidence log rows.
- `search-hn.sh`: Queries the HN Algolia API. Outputs evidence log rows.
- `search-github.sh`: Queries the GitHub Search API. Outputs evidence log rows. Set `GITHUB_TOKEN` for higher rate limits.

Scripts are thin wrappers — they do not process or score evidence. They produce evidence.md rows for the user to review and append manually.

---

## Evals

The `evals/` directory contains 10 structured test cases. Each case specifies:
- An idea and goal type
- Available evidence (or "no tools")
- Expected verdict and confidence tier
- Key behavioral checks

These are not automated tests. They are structured human-run checks. See `evals/run-evals.md` for the protocol.

Use evals before submitting a PR that changes scoring anchors, thresholds, or adversarial pass rules.

---

## Extending /ideate

### Adding a Mode

1. Create `modes/<mode-name>.md` following the structure of an existing mode (ideate.md is the best template)
2. Add a row to the Modes table in `SKILL.md`
3. Add routing logic in the Routing section of `SKILL.md`
4. Add an eval case in `evals/cases/`
5. Update `evals/run-evals.md`
6. Update `CHANGELOG.md`

### Adding a Goal Type

1. Add a column to the weight table in `modes/goal-variants.md`
2. Verify the new column sums to exactly 10.0
3. Add success criteria, red flags, and an example
4. Add a Goal Fit anchor for the new type in `modes/_scoring.md`
5. Add an eval case

### Adding Evidence Sources

1. Add the source to the relevant signal-type section in `modes/evidence-sources.md`
2. Add ≥ 2 query patterns
3. Note ToS or access restrictions
4. Optionally add a script to `scripts/`

---

## Contribution Guide

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full process. The short version:
- No fabricated examples in any file
- No competitor product names in templates or examples
- Weight columns must sum to 10.0
- Every new mode needs an eval case
- Every scoring change needs an updated `evals/run-evals.md`
