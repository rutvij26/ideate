# Eval 06 — Learning Goal, Feasible Scope (BUILD)

## Idea

"A small CLI tool written in Rust that parses and pretty-prints JSON, with colored output and path-based filtering."

## Goal type

Learning (builder wants to learn Rust)

## Constraints

Lean (solo, ≤2 weeks)

## Simulated evidence

Not required for this case — the key test is that the Learning goal guard does NOT fire (pain and demand are irrelevant for a learning project, and Build Feasibility + Goal Fit should dominate correctly).

## Expected verdict

**BUILD — MEDIUM confidence**

Reason: Build Feasibility = 5 (clearly achievable in 2 weeks in Rust for someone learning), Goal Fit = 5 (directly achieves the learning objective). Pain and demand may be low — this is expected and correct for Learning goal.

## Behavioral checks

- [REQUIRED] Verdict is BUILD
- [REQUIRED] Score table shows Build Feasibility ≥ 4 and Goal Fit = 5
- [REQUIRED] Learning goal guard does NOT fire (pain is allowed to be low for Learning goal)
- [REQUIRED] Goal Fit anchor used is the Learning-specific one: "shippable demo + named skill gains achievable alone"
- Weighted total ≥ 3.8 (Learning weights applied correctly)
- `ideate/<slug>/validation.md` written
- Note: Willingness to pay/adopt weight for Learning is 0.0 — this dimension should be noted as N/A or 0 with no evidence required
