# /ideate

An evidence-backed idea validation skill for Claude Code. Takes you from blank page to a BUILD / NARROW / PIVOT / KILL verdict and scoped MVP — without opinion, flattery, or made-up data.

[![Version](https://img.shields.io/badge/version-0.1.0-blue)](CHANGELOG.md)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Stars](https://img.shields.io/github/stars/rutvij26/ideate?style=flat)](https://github.com/rutvij26/ideate/stargazers)

## Why

Most ideation advice is vibes. /ideate forces every claim about demand, competitors, or pricing to have a source — or be labelled `ASSUMPTION`. It tries to kill your idea first, then validates what survives.

Works for founders, OSS devs, internal-tool builders, researchers, and learners. Works offline too (with honest confidence caps).

## Install

```bash
npx rutvij26/ideate
```

Works on Unix, macOS, and Windows. Re-run to update.

<details>
<summary>No Node? Use curl / PowerShell instead</summary>

**Unix / macOS**
```bash
curl -fsSL https://raw.githubusercontent.com/rutvij26/ideate/main/install.sh | bash
```

**Windows (PowerShell)**
```powershell
irm https://raw.githubusercontent.com/rutvij26/ideate/main/install.ps1 | iex
```

</details>

## Quick Start

```
/ideate
```

That's it. The skill detects your intent and asks only what it needs.

**Or be explicit:**

| Command | What it does |
|---|---|
| `/ideate` | Auto-detect intent from context |
| `/ideate validate` | Score a specific idea against demand/competition |
| `/ideate ideate` | Generate ideas from pain signals |
| `/ideate compete` | Map competitors and find gaps |
| `/ideate scope` | Define MVP after a BUILD/NARROW verdict |
| `/ideate compare` | Score 2–4 ideas side-by-side |
| `/ideate full` | End-to-end pipeline with stage gates |

## Sample Run (Offline Mode)

```
> /ideate validate "a CLI tool that explains git diffs in plain English"

Goal type: Commercial

[OFFLINE MODE — no search tools available]
Confidence cap: LOW. All demand claims labelled ASSUMPTION.

--- ADVERSARIAL PASS ---
1. GitHub Copilot and similar tools already explain code inline; users won't switch for a standalone CLI
2. The addressable market is developers comfortable enough with git to use a CLI but confused by diffs — this overlap may be small
3. ASSUMPTION: developers will pay for this vs using a free LLM wrapper

--- VERDICT ---
NARROW — LOW confidence
Weighted score: 3.2/5

What would change this: find 3 independent posts where developers express frustration with understanding git diffs despite using existing tools. Use search string: "git diff confusing site:reddit.com"

Files written: ideate/cli-git-diff-explainer/validation.md
```

## Philosophy

**Evidence > Opinion.** Every claim about demand, competitors, or pricing needs a source URL, a short quote, and a date — or it is labelled `ASSUMPTION`.

**Try to kill first.** The adversarial pass runs before any positive verdict. BUILD is only possible if the case for outweighs the case against.

**No flattery, no hedging.** Verdicts are BUILD / NARROW / PIVOT / KILL. Confidence is HIGH / MEDIUM / LOW. The cheapest next experiment always has a pass/fail threshold.

## Output

All output is saved to `ideate/<slug>/` in your working directory. Each mode writes its own file:
- `brief.md` — idea summary
- `evidence.md` — evidence log with sources
- `validation.md` — full verdict with score breakdown
- `competitors.md` — competitive landscape
- `mvp.md` — MVP scope and handoff prompt
- `kill-debrief.md` — failure analysis and pivot hypotheses

## User Config (Optional)

Copy the templates and fill them in:
```bash
mkdir -p ~/.config/ideate
cp modes/_profile.template.md ~/.config/ideate/_profile.md
cp modes/_custom.template.md ~/.config/ideate/_custom.md
```

These files are not tracked by git (`git clean` safe).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). All contributions welcome — new modes, new goal types, new evidence sources, eval cases.

## License

MIT — see [LICENSE](LICENSE).
