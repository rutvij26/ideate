# /ideate — COMPETE Mode

Maps the competitive landscape, finds gaps, and produces a positioning statement.

**Load before running:** `modes/_shared.md`, `modes/evidence-sources.md`, `modes/templates.md`.

---

## Step 1 — Intake

Use `AskUserQuestion` for anything not already known:

1. Idea / product category (open text if not stated)
2. Target user (open text)
3. Goal type (single-select): Commercial / OSS / Internal tool / Research / Learning

---

## Step 2 — Build 5 Competitor Buckets

Research and populate each bucket. Cite sources. Apply freshness model from `_shared.md`.

### Bucket 1: Direct Commercial
Tools that do the same job-to-be-done, offered as paid products. Search: "[category] tool", "[category] software", "[category] SaaS".

For each: name, target user, pricing (free tier / paid tier / enterprise), last updated or last funding round.

### Bucket 2: Adjacent Commercial
Tools whose primary focus is different but that solve this problem as a secondary feature. Search: "[related workflow] software", "[broader category] tools".

Note: for each adjacent tool, does the user typically buy it for the adjacent feature or for this specific job?

### Bucket 3: OSS / Self-Hosted
Search: GitHub topics, awesome-X lists, package registries (npm, PyPI, crates.io, etc.).

For each: name, GitHub stars, last commit date, license, maintenance status (active/stale/archived).

### Bucket 4: DIY
How do users solve this today without a dedicated tool?
- Spreadsheets or scripts
- Automation workflows (Zapier, n8n, Make)
- Manual processes
- Combining multiple free tools

Source: search for "[problem] workaround", "[problem] how to", forum threads describing manual approaches.

### Bucket 5: Substitutes (including doing nothing)
What does the user do instead? What does "good enough" look like without a dedicated solution?
Include "do nothing" as an explicit option — for some users, the problem is not worth solving.

### Additional: Recently Funded Competitors
Search: "[category] funding 2024", "[category] seed round", relevant VC portfolios.
Recently funded = the market is being validated by investors. Note the funding amount and date.

### Additional: Shut-Down Competitors
Search: "[tool name] shut down", "[category] discontinued", HN discussions about failed tools in the category.
Shut-downs = market exists but execution failed. Note why they shut down if known.

---

## Step 3 — Competitor Matrix

Fill the matrix for the top 5-8 most relevant competitors (include at least 1 from each non-empty bucket):

| Name | Type | Target user | Pricing | Strengths | Weaknesses | Activity | Source |
|---|---|---|---|---|---|---|---|

Weaknesses: attributed quotes from primary sources, ≤ 125 characters each. Do not invent weaknesses.

---

## Step 4 — Complaint Clustering

Collect 5-10 attributed complaints from primary sources (Reddit, reviews, GitHub issues, HN).
- Each complaint: a short quote ≤ 125 chars + URL + date
- Group into ≤ 5 themes
- Count complaints per theme

Format:
```
Theme: [theme name] — [count] complaints
Example: "[quote ≤125 chars]" — [URL]
```

---

## Step 5 — Gap Analysis

For each significant gap identified:

1. **Is this a real need or a deliberate trade-off?** Did incumbents deprioritise this, or do they claim their approach is better? (Source required)
2. **Can an incumbent close this gap in one release?** Assess based on their architecture and stated roadmap.
3. **Wedge type:** price / UX / segment / integration / speed
4. **Defensibility horizon:** How long before an incumbent can match this? What prevents easy copying?

---

## Step 6 — Positioning Statement

One sentence:

> For [specific target user] who [specific pain], [product] is the [category] that [key differentiator]. Unlike [main competitor], we [specific distinction].

The distinction must be grounded in the gap analysis — not a generic claim.

---

## Step 7 — OSS Reuse Check

Before recommending building from scratch, assess:

- Is there an existing OSS project that solves 80%+ of this? → **Depend on it**
- Is there one that solves 50–80% with the right architecture? → **Fork or extend it**
- Is there one where the missing piece would benefit the existing community? → **Contribute to it**
- Is there none that fits? → **Build from scratch** (note: justify this)

---

## Output

Write to `ideate/<slug>/competitors.md` using the template from `modes/templates.md`.
Print a summary in chat: top 3 competitors, top complaint theme, positioning statement, OSS recommendation.
