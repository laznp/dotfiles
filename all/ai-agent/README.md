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
    └── agents/
        ├── stalker.md                # Recon
        ├── engineer.md               # Implementation
        ├── inquisitor.md             # Quality gate
        ├── seeker.md                 # Incident triage
        ├── architect.md              # Strategy
        └── vanguard.md              # Security
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
      ├── @stalker      → recon, never modifies
      ├── @engineer     → builds (every action asks you)
      │    ├── @inquisitor  → quality review
      │    └── @vanguard    → security review
      ├── @seeker       → incidents, asks before bash
      ├── @architect    → strategy, words only
      └── @vanguard     → security, words only
```

Overlord delegates via `@agentname`. Each agent runs on its own model with scoped tool permissions.

## Supervision Model

- Overlord presents plan → you approve → acts
- Stalker → reads freely, destructive ops refused
- Engineer → asks before every write/edit/bash
- Seeker → asks before bash
- Architect, Inquisitor, Vanguard → words only, no tools

## Quality + Security Gate

Engineer output → **@inquisitor** (quality) + **@vanguard** (security) sequentially.
CRITICAL from either → back to Engineer. Both must PASS before reaching you.

## Models

| Agent | Model | Reason |
|---|---|---|
| Overlord | `opencode-go/qwen3.6-plus` | Orchestration + reasoning |
| Stalker | `opencode-go/deepseek-v4-flash` | Fast, cheap recon |
| Engineer | `opencode-go/deepseek-v4-pro` | Quality implementation |
| Inquisitor | `opencode-go/qwen3.6-plus` | Strong review |
| Vanguard | `opencode-go/qwen3.6-plus` | Strong security review |
| Architect | `opencode-go/kimi-k2.5` | Deep reasoning |
| Seeker | `opencode-go/deepseek-v4-pro` | Evidence-driven investigation |

## Claude Code

Claude Code uses same team via `CLAUDE.md`. No `@agent` syntax — Overlord delegates via Agent tool subagents. Same routing rules, same supervision, same chaining. Shadowforce activates automatically on session start.

## Stow

```bash
cd ~/dotfiles/all && stow -t ~ ai-agent
```
