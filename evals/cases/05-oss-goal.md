# Eval 05 — OSS Goal, Duplicates Healthy Project (KILL)

## Idea

"An open-source CLI for managing dotfiles across multiple machines."

## Goal type

OSS

## Constraints

Standard

## Setup note

Search for existing dotfile management OSS tools. The space is well-served (chezmoi, dotbot, GNU Stow, etc. — all actively maintained with thousands of stars). The skill should find this and return KILL.

## Expected verdict

**KILL — MEDIUM or HIGH confidence**

Reason: duplicates multiple healthy, actively maintained projects. OSS red flag triggered: "duplicates a healthy actively maintained project."

## Behavioral checks

- [REQUIRED] Verdict is KILL
- [REQUIRED] Adversarial pass names at least 2 specific existing projects with star counts and last commit dates
- [REQUIRED] OSS red flag is explicitly mentioned (duplicates healthy project)
- [REQUIRED] Kill debrief suggests a specific differentiator that could justify a new project (e.g., "a dotfile manager specifically for [niche not served]")
- Competitive gap dimension scores ≤ 1
- Loop-back offer presented
