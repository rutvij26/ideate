# /ideate — Goal Type Variants

Loaded only when applying dimension weights. Weights per goal type.

---

## Weight Table

Each column sums to exactly 10.0 (verified below).

| Dimension | Commercial | OSS | Internal | Research | Learning |
|---|---|---|---|---|---|
| Pain severity | 1.5 | 1.0 | 2.0 | 1.5 | 0.5 |
| Frequency | 1.0 | 1.0 | 1.5 | 0.5 | 0.5 |
| Demand evidence | 1.5 | 1.5 | 1.0 | 1.5 | 0.5 |
| Willingness to pay/adopt | 2.0 | 1.5 | 1.0 | 0.5 | 0.0 |
| Competitive gap | 1.5 | 1.5 | 1.0 | 2.0 | 0.5 |
| Reachability | 1.0 | 1.5 | 1.5 | 1.5 | 0.5 |
| Build feasibility | 1.0 | 1.0 | 1.5 | 1.5 | 3.0 |
| Goal fit | 0.5 | 1.0 | 0.5 | 1.0 | 4.5 |
| **Column sum** | **10.0** | **10.0** | **10.0** | **10.0** | **10.0** |

**Verification:** Commercial: 1.5+1.0+1.5+2.0+1.5+1.0+1.0+0.5 = 10.0 ✓ | OSS: 1.0+1.0+1.5+1.5+1.5+1.5+1.0+1.0 = 10.0 ✓ | Internal: 2.0+1.5+1.0+1.0+1.0+1.5+1.5+0.5 = 10.0 ✓ | Research: 1.5+0.5+1.5+0.5+2.0+1.5+1.5+1.0 = 10.0 ✓ | Learning: 0.5+0.5+0.5+0.0+0.5+0.5+3.0+4.5 = 10.0 ✓

---

## Commercial

**Why these weights:** Pain and willingness to pay dominate because a commercial product needs a real costly problem that people will actually pay to solve.

**Success criteria:**
- Users pay for it (not just sign up for free)
- There is a clear path to acquiring the first paying customer
- The unit economics are defensible at scale

**Red flags:**
- Users love it but won't pay — "I'd use this if it were free"
- Strong community interest but no monetisation path identified
- The wedge is price alone (no switching cost)

**Example idea that fits:** A niche B2B SaaS that automates a specific compliance report that costs > $500/hour to produce manually.

**Example idea that doesn't fit:** A social app for developers with no clear revenue model.

---

## OSS

**Why these weights:** Competitive gap and reachability matter most — an OSS project needs a real gap in the ecosystem and a community to adopt it. WTP means adopt-and-contribute rather than pay.

**Success criteria:**
- Meaningful adoption within 6 months (stars, forks, downstream dependencies)
- At least one external contributor within 3 months
- Solves a problem no healthy maintained project already solves

**Red flags:**
- Duplicates a healthy, actively maintained project (use forks or contributions instead)
- Heavy ongoing infrastructure operations burden (ops-heavy OSS rarely thrives without funding)
- GPL incompatibility with the target user's stack

**Example that fits:** A lightweight CLI tool that fills a gap in the existing ecosystem for a popular language or framework, with no current solution in the top 3 package registry results.

**Example that doesn't fit:** Yet another Markdown editor when dozens of maintained options exist.

---

## Internal Tool

**Why these weights:** Pain severity is highest — internal tools exist to solve a specific, frequent, costly problem for a known team. Build feasibility matters because internal tools often have no dedicated engineering budget.

**Success criteria:**
- Replaces a named existing tool or process the team uses today
- Saves measurable time (quantified in hours per week)
- Has a named person who will maintain it after launch

**Red flags:**
- No named maintainer post-launch (internal tools die without ownership)
- Build cost exceeds 6× the annual cost of the problem
- Available OSS solution is 80% of the way there — consider adapting it instead
- No stakeholder buy-in before you start building

**Build vs buy vs OSS:** Always ask this before scoping an internal tool: is there an existing commercial solution, a configurable SaaS, or an open-source project that solves 80%+ of this? If yes, adapting is usually faster than building.

**Example that fits:** An internal dashboard that aggregates data from 3 internal sources that no existing BI tool can connect without custom ETL work.

**Example that doesn't fit:** A custom Slack bot for team announcements when Slack's native features already do this.

---

## Research

**Why these weights:** Competitive gap (novelty) and reachability (to existing literature and data) dominate. WTP matters less because research output is knowledge, not a product.

**Success criteria:**
- The research question is novel (not already answered in accessible literature)
- There is a named, measurable baseline for comparison
- The question is falsifiable — there is a clear way to test whether the hypothesis is wrong

**Red flags:**
- The question is already answered in a paper from the last 3 years
- No way to measure success — results cannot be compared to a baseline
- The question is not falsifiable — it cannot be proven wrong by any possible result

**Example that fits:** Measuring the effect of a specific prompt engineering technique on a measurable task, where no published baseline exists.

**Example that doesn't fit:** "Exploring AI in education" — too broad, not falsifiable.

---

## Learning

**Why these weights:** Build feasibility (3.0) and goal fit (4.5) dominate because a learning project must be completable and must produce the intended skill gains. Demand and WTP matter least — the "user" is you.

**Success criteria:**
- A shippable demo exists at the end
- Named skills are gained (e.g., "understand Rust's ownership model", "build a full-stack app with authentication")
- The project can be finished alone within the stated time

**Red flags:**
- Scope is too large to finish alone in the stated time
- The project requires ML infrastructure setup that takes > 2 weeks before writing a single line of feature code
- "Learning" is a fig leaf for building something genuinely commercial — be honest about goal type

**Example that fits:** Build a small CLI tool in a new language to learn its standard library and tooling, completable in 2 weekends.

**Example that doesn't fit:** Build a production-grade distributed database to "learn distributed systems" — scope is unbounded.

---

## Mixed Goals

When a user has a primary and secondary goal type:
1. Score the idea under both goal types
2. The verdict follows the primary goal type's weighted score
3. Note any conflicts: "Under Commercial, this scores NARROW. Under Learning, this scores BUILD. Since your primary goal is Commercial, verdict is NARROW."
4. If the secondary goal score is significantly higher, ask the user: "Should we re-run with [secondary] as the primary goal?"
