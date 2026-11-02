# Changelog

All notable changes to /ideate will be documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] — Initial release

### Added
- SKILL.md router with trigger `/ideate` and 6 modes
- IDEATE mode: six lenses, hard-cut filter, shortlist of 3
- VALIDATE mode: 8-dimension scoring, adversarial pass, BUILD/NARROW/PIVOT/KILL verdicts
- COMPETE mode: 5 competitor buckets, gap analysis, positioning statement
- SCOPE mode: Now/Next/Later, success metrics, tool-agnostic handoff prompt
- COMPARE mode: side-by-side scoring of 2–4 ideas
- FULL mode: end-to-end pipeline with stage gates
- KILL debrief: pivot hypotheses + domain-tagged loop-back
- 5 goal types with verified weight tables (Commercial, OSS, Internal, Research, Learning)
- Online + offline evidence modes with re-entry protocol
- `AskUserQuestion` widgets at every decision point
- `scripts/`: Reddit, HN, GitHub evidence collectors
- `evals/`: 10 eval cases covering all verdicts and edge cases
- `~/.config/ideate/` user config path (survives `git clean`)
