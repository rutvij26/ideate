# /ideate — Evidence Sources

Loaded during evidence gathering. Contains source map, query patterns, ethics, and offline protocol.

---

## Source Map by Signal Type

### Pain Evidence (VALIDATE, IDEATE)
Best sources for finding real complaints and frustrations:
- Reddit (specific subreddits for the domain)
- Hacker News (search.ycombinator.com)
- Stack Overflow (questions tagged with the relevant technology)
- Indie Hackers (community discussions)
- Discord servers for the target community
- Niche forums specific to the domain (e.g., ProductHunt discussions, Slack communities)
- GitHub Issues (for technical products: search for issues labelled "enhancement" or "pain")

### Willingness to Pay / Adoption Evidence (VALIDATE)
Sources for pricing signals and purchase intent:
- Pricing pages of existing tools in the space
- G2, Capterra, Trustpilot reviews (look for pricing complaints or praise)
- App store reviews (iOS App Store, Google Play, Chrome Web Store)
- Job postings mentioning specific tools (budget signals)
- ProductHunt comments ("would pay for this", "pricing is too high")
- Indie Hackers revenue threads (what similar tools charge)

### Competitive Landscape (COMPETE)
Sources for finding competitors:
- GitHub search (by topic, description, or README keywords)
- npm, PyPI, crates.io, hex.pm registries (search by problem keyword)
- ProductHunt (filter by category and launch date)
- G2 and Capterra categories
- "Awesome [topic]" lists on GitHub
- VC portfolio pages (funded = validated market signal)
- AlternativeTo.net

### Timing Signals (IDEATE, VALIDATE)
Sources for demand timing:
- Google Trends (topic rising vs declining)
- ProductHunt launch volume (how many similar tools launched in the last 12 months)
- Job posting volume (LinkedIn, Indeed: count postings mentioning the tool or skill)
- Recent VC investments in the category (Crunchbase, TechCrunch)

### Failure Patterns (IDEATE adversarial, VALIDATE)
Sources for why similar ideas failed:
- Hacker News "Ask HN: Why did X fail?" threads
- Post-mortems on Indie Hackers
- Reddit r/startups and r/entrepreneur failure posts
- Twitter/X threads on shut-down tools (search "[tool name] shut down")

---

## Query Patterns

Use these as starting points. Adapt to the specific idea. Do not repeat the same query.

### Pain Mining
- `"[problem] frustrating" site:reddit.com`
- `"is there a tool for [X]" site:reddit.com`
- `"I wish there was [X]"`
- `"anyone else annoyed by [X]"`
- `"[tool] missing feature"`
- `"[problem] workaround"`
- `"[problem] alternative"`
- `"[tool] limitations"`

### Demand Signals
- `"switched from [tool] to"`
- `"[tool] too expensive"`
- `"[tool] alternative" site:reddit.com`
- `"replaced [tool] with"`
- `"[tool] not worth it"`
- `"[problem] how do you handle"`

### Competitor Research
- `"[tool] vs [tool]"`
- `"best [category] tool"`
- `"[category] tools comparison"`
- `"[tool] review" site:g2.com`
- `"[category] site:github.com"`
- `"awesome [topic] site:github.com"`

### Timing
- `site:news.ycombinator.com [topic] 2024`
- `site:producthunt.com [category]`
- `"[topic]" site:techcrunch.com 2024`

---

## Evidence Quality Rules

1. **Broad then narrow.** Start with category-level queries, then narrow to specific pains. Do not start narrow and miss the broader picture.
2. **No repeated queries.** Log all queries run. Skip a query if it has already been run in this session.
3. **Prefer primary sources.** A Reddit post > a blog post summarising Reddit posts. A GitHub issue > an article mentioning GitHub issues.
4. **Apply the freshness model from `_shared.md`.** Check dates. > 18 months = `[HISTORICAL]`.
5. **1 source = anecdote. 3 independent source types = signal.** Do not call something "validated" based on a single post.
6. **Read dissenting comments.** Every complaint thread has counter-evidence. Log it under `supports: -`.
7. **Native language.** If the target market is primarily non-English speaking, search in their language. If language is unclear, ask the user once: "Is your target market primarily English-speaking?"

---

## Offline Mode

Full protocol is defined in `_shared.md`. When offline mode is active:

**Emit these 5 search strings** (copy-paste ready, adapted to the idea):
1. `"[core problem] frustrating" site:reddit.com`
2. `"[category] alternative" site:reddit.com`
3. `"[core problem] tool" site:news.ycombinator.com`
4. `"[category]" site:github.com` (filter by stars, recent commits)
5. `"[core problem] workaround"`

**Name 3 competitor categories to check manually:**
1. [Most likely direct competitor type]
2. [Most likely OSS alternative category]
3. [Most likely DIY workaround category]

**Evidence re-entry template is in `modes/templates.md`.**

---

## Ethics

- Respect each site's `robots.txt` and Terms of Service
- Do not bypass login walls, paywalls, or rate limits
- Do not use workarounds to access blocked content
- Do not collect personal data about private individuals
- Quotes must be ≤ 125 characters and include the source URL
- Log access failures: "blocked: [site]" — try another source and move on
- Never fabricate access or invent source content
