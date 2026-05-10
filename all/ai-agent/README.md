# Shadowforce — AI Agent Team

Multi-agent system running across Claude Code and OpenCode Go. Same team, same rules, different runtimes.

## Structure

```
ai-agent/
├── .claude/
│   └── CLAUDE.md                    # Claude Code team definition
└── .config/opencode/
    ├── opencode.json                 # Provider config, MCP servers
    ├── AGENTS.md                     # Overlord — global instructions for main agent
    └── skills/
        ├── stalker/SKILL.md          # Recon
        ├── engineer/SKILL.md         # Implementation
        ├── inquisitor/SKILL.md       # Quality gate
        ├── seeker/SKILL.md           # Incident triage
        ├── architect/SKILL.md        # Strategy
        └── vanguard/SKILL.md         # Security
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

## How It Works

```
You
 └── Overlord (main agent — AGENTS.md defines behavior)
      ├── skill(stalker)      → recon, never modifies
      ├── skill(engineer)     → builds (every action asks you)
      │    ├── skill(inquisitor)  → quality review (parallel)
      │    └── skill(vanguard)    → security review (parallel)
      ├── skill(seeker)       → incidents, asks before bash
      ├── skill(architect)    → strategy, words only
      └── skill(vanguard)     → security, words only
```

Overlord loads each member on demand via `skill({ name: "<member>" })`. All skills run on Overlord's model — no per-skill model config (OpenCode limitation).

## Supervision Model

- Overlord presents plan → you approve → acts
- Stalker skill → reads freely, destructive ops refused
- Engineer skill → asks before every write/edit/bash
- Seeker skill → asks before bash
- Architect, Inquisitor, Vanguard skills → words only, no tools

## Quality + Security Gate

Engineer output → **Inquisitor** skill (quality) + **Vanguard** skill (security) in parallel.
CRITICAL from either → back to Engineer. Both must PASS before reaching you.

## Claude Code

Claude Code uses same team via `CLAUDE.md`. No skill mechanism — Overlord delegates via Agent tool subagents. Same routing rules, same supervision, same chaining. Shadowforce activates automatically on session start.

## Stow

```bash
cd ~/dotfiles/all && stow -t ~ ai-agent
```
