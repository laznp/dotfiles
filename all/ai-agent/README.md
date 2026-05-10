# Shadowforce — AI Agent Team

Multi-agent system running across Claude Code and OpenCode Go. Same team, same rules, different runtimes.

## Structure

```
ai-agent/
├── claude/          # Claude Code (CLAUDE.md)
└── opencode/        # OpenCode Go (agents/*.md + opencode.json)
```

## The Team

| Agent | Role | Specialty |
|---|---|---|
| **Overlord** | Commander | Routes missions, presents plans, waits for approval — never implements |
| **Stalker** | Scout | Recon, grep, file search, structure mapping — read-only, destructive ops denied |
| **Engineer** | Artisan | Code, scripts, IaC, Terraform, Helm, K8s — asks before every write/edit/bash |
| **Inquisitor** | Judge | Quality gate — reviews all Engineer output before you see it |
| **Seeker** | Oracle | Incidents, log analysis, root cause — evidence-driven, structured output |
| **Architect** | Sage | Architecture, trade-offs, strategic direction — words only |
| **Vanguard** | Paladin | Security review, CVE, RBAC, secrets — full findings, never compressed |

## Supervision Model

Nothing created or destroyed without your approval:

- Overlord presents plan → you approve → agents act
- Every `write`, `edit`, `bash` on Engineer → asks you
- Every `bash` on Seeker → asks you
- Stalker → reads freely, destructive ops hard-denied
- Architect, Inquisitor, Vanguard → words only, no tools

## Quality + Security Gate

Engineer output goes through **Inquisitor** (quality) + **Vanguard** (security) in parallel before reaching you. CRITICAL issues from either → back to Engineer for revision. Both must PASS.

## Stow

```bash
# Claude Code only
stow -t ~ all/ai-agent/claude

# OpenCode only
stow -t ~ all/ai-agent/opencode

# Both
stow -t ~ all/ai-agent
```

## Details

- [Claude Code →](claude/README.md)
- [OpenCode →](opencode/README.md)
