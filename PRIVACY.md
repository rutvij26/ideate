# Privacy Policy

**Last updated: November 2026**

## Summary

`/ideate` is a Claude Code skill that runs entirely within your local Claude Code session. It collects no personal data, sends no telemetry, and stores nothing outside your machine.

## What this skill does

- Reads your query and passes it to Claude Code's context
- Optionally runs shell scripts (`scripts/`) that make read-only HTTP requests to public APIs (Reddit, Hacker News, GitHub, Stack Overflow, npm, crates.io, DEV.to) using query terms you supply
- Writes output files to `ideate/<slug>/` in your current working directory

## Data not collected

- No usage analytics
- No crash reporting
- No user identifiers
- No API keys or credentials (optional env vars stay on your machine)

## Third-party services

When evidence scripts are run, queries are sent to the following public APIs under their respective terms:

- Reddit JSON API
- Hacker News Algolia API
- GitHub Search API
- Stack Exchange API
- npm Registry API
- DEV.to API
- crates.io API

No account or authentication is required. Optional tokens (`GITHUB_TOKEN`, `STACKAPPS_KEY`) are read from your environment and never transmitted to any service other than the intended API.

## Contact

For questions: [github.com/rutvij26/ideate/issues](https://github.com/rutvij26/ideate/issues)
