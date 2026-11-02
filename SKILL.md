---
name: ideate
description: >-
  Idea validation engine: blank page to evidence-backed verdict and scoped MVP.
  Triggers: /ideate, "is this a good idea", "validate my idea", "what should I build",
  "who are my competitors", "is there demand for", "find gaps in", "should I build this",
  "help me ideate", "idea validation", "compare these ideas".
trigger: /ideate
---

# /ideate

## Load Order

Before executing any mode, read `modes/_shared.md` first. Then:
- Load `modes/_scoring.md` only when scoring (VALIDATE, COMPARE, IDEATE shortlist)
- Load `modes/goal-variants.md` only when applying dimension weights
- Load `modes/evidence-sources.md` only during evidence gathering
- Load `modes/templates.md` only when writing output files
- Never load all files simultaneously

## User Config

Check `~/.config/ideate/_profile.md` then `~/.config/ideate/_custom.md` if they exist.
Fall back to `modes/_profile.md` in CWD. If neither exists: score Goal Fit as N/A, verbosity = standard, save files = yes.

## Capability Detection

Check which search and fetch tools are available in the current session (from the tool list — do not make a test call). If search/fetch tools are present: **online mode**. If absent or unclear: ask the user once using a widget (options: "Web search available" / "No web search — offline mode"). Do not retry.

## Slug Definition

A slug is the idea name converted to lowercase kebab-case, max 40 characters, truncated at a word boundary. Example: "AI code review tool" → "ai-code-review-tool". On slug collision in `ideate/`: append `-2`, `-3`, etc. Confirm the slug with the user before creating any files (widget: "Accept slug: [slug]" / "Edit slug").

## Multi-Session Discovery

At every mode start, check `ideate/<slug>/` for prior output files. If found, offer to continue from the last completed stage (widget: "Resume from last stage" / "Start fresh").

## No-Argument / --help

If invoked with no context or `--help`: print the modes table below and show a 3-question intake widget, then wait.

## Modes

| Mode | Trigger |
|---|---|
| IDEATE | "help me ideate", "what should I build", no idea given |
| VALIDATE | "is this a good idea", "validate", specific idea given |
| COMPETE | "who are my competitors", "find gaps in" |
| SCOPE | "scope my MVP", after BUILD or NARROW verdict |
| COMPARE | "compare these ideas", 2+ ideas given |
| FULL | "full pipeline", ambiguous request, or explicit `/ideate full` |

## Intake

Ask max 5 questions using `AskUserQuestion` widgets. Skip anything already stated. Goal type is required before scoring begins.

**Intake widget sequence** (use only what is not already known):
1. What is your idea? (if not stated) — open text
2. Goal type — single-select: Commercial / OSS / Internal tool / Research / Learning
3. Constraints — single-select: Lean (solo, ≤2 weeks) / Standard (solo, ≤3 months) / Resourced (team/budget available)
4. Target user — open text (skip if clear from idea)
5. Ambition — single-select: Side project / Startup / Research / Portfolio

## Routing

- 2+ ideas given → COMPARE
- Single idea given + "validate" / "demand" / "is this good" → VALIDATE
- "competitors" / "gaps" / "landscape" → COMPETE
- "scope" / "MVP" / "build plan" → SCOPE (gates on BUILD or NARROW in `ideate/<slug>/validation.md`)
- "ideate" / "what to build" / blank → IDEATE
- Ambiguous → FULL

## Adversarial Gate

Top-3 failure reasons are mandatory before any positive verdict. BUILD is blocked if the case against the idea is equal to or stronger than the case for it.

## Output

Always write output to `ideate/<slug>/*.md` using templates from `modes/templates.md`. Print a summary in chat. If file writes are unavailable, print full output in chat with note: "File write unavailable — output printed below."

## Reference Files

- [modes/_shared.md](modes/_shared.md) — core rules, verdicts, confidence, offline protocol
- [modes/_scoring.md](modes/_scoring.md) — 8-dimension scoring anchors
- [modes/_profile.template.md](modes/_profile.template.md) — user profile template
- [modes/_custom.template.md](modes/_custom.template.md) — user customisation template
- [modes/ideate.md](modes/ideate.md) — IDEATE mode
- [modes/validate.md](modes/validate.md) — VALIDATE mode
- [modes/compete.md](modes/compete.md) — COMPETE mode
- [modes/scope.md](modes/scope.md) — SCOPE mode
- [modes/compare.md](modes/compare.md) — COMPARE mode
- [modes/full.md](modes/full.md) — FULL pipeline orchestrator
- [modes/kill-debrief.md](modes/kill-debrief.md) — KILL debrief + loop-back
- [modes/goal-variants.md](modes/goal-variants.md) — weights by goal type
- [modes/evidence-sources.md](modes/evidence-sources.md) — source map, query patterns, ethics
- [modes/templates.md](modes/templates.md) — canonical output templates
