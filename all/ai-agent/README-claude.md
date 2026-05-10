# Shadowforce — Claude Code Team

Same team structure as OpenCode, adapted for Claude Code. One commander, five specialists. Same supervision model, same chaining rules.

## The Team

| Agent | Role | Specialty |
|---|---|---|
| **Overlord** | Commander | Routes tasks, presents plans, waits for approval |
| **Stalker** | Scout | Recon, grep, file search, structure mapping — read-only |
| **Engineer** | Artisan | Code, scripts, IaC, Terraform, Helm, K8s — asks before every action |
| **Inquisitor** | Judge | Reviews all Engineer output — PASS/FAIL verdict before you see it |
| **Seeker** | Oracle | Incidents, log analysis, root cause — SYMPTOMS → ROOT CAUSE → REMEDIATION |
| **Architect** | Sage | Architecture, trade-offs, strategic direction — words only |
| **Vanguard** | Paladin | Security review, CVE, RBAC, secrets — full findings, never compressed |

## How It Works

```
You
 └── Overlord (presents plan, waits approval)
      ├── Stalker     → recon, never modifies
      ├── Engineer    → builds (every action asks you)
      │    ├── Inquisitor  → quality review (parallel)
      │    └── Vanguard    → security review (parallel)
      ├── Seeker      → incidents, asks before bash
      ├── Architect   → strategy, words only
      └── Vanguard    → security, words only
```

## Chaining Rules

1. **Recon first** — Stalker before Engineer acts, never modify blindly
2. **Design before build** — Architect for complex tasks, then Engineer to implement
3. **Diagnose before fix** — Seeker for prod issues, then Engineer to patch
4. **Quality + Security gate** — Engineer output goes through Inquisitor + Vanguard in parallel. CRITICAL from either sends back to Engineer. Both must PASS before reaching you.

## Difference vs OpenCode

| | OpenCode | Claude Code |
|---|---|---|
| Model per agent | Yes — specialized per role | No — same Claude model for all |
| Agent switching | Native, `@agent` syntax | Spawned as subagents via Agent tool |
| Persistence | Agent `.md` files | `CLAUDE.md` system prompt |
| Supervision | Permission flags + ask | Prompt-enforced + ask confirmation |

## Structure

```
.claude/
└── CLAUDE.md    # Full team definition, routing rules, behaviors
```

## Usage

Shadowforce activates automatically on session start via `CLAUDE.md`. No setup needed.

Claude acts as Overlord by default — routes to the right specialist, presents plan, waits for your go-ahead before acting.
