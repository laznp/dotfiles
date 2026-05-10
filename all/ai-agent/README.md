# Shadowforce — AI Agent Team

Multi-agent system running across Claude Code and OpenCode Go. Same team, same rules, different runtimes.

## Structure

```
ai-agent/
├── .claude/
│   └── CLAUDE.md                    # Claude Code team definition
└── .config/opencode/
    ├── opencode.json                 # Provider config, default_agent, MCP servers
    └── agents/
        ├── overlord.md               # Primary agent (default)
        ├── stalker.md                # Recon
        ├── engineer.md               # Implementation
        ├── inquisitor.md             # Quality gate
        ├── seeker.md                 # Incident triage
        ├── architect.md              # Strategy
        └── vanguard.md               # Security
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
 └── Overlord (presents plan, waits approval)
      ├── @stalker      → recon, never modifies
      ├── @engineer     → builds (every action asks you)
      │    ├── @inquisitor  → quality review (parallel)
      │    └── @vanguard    → security review (parallel)
      ├── @seeker       → incidents, asks before bash
      ├── @architect    → strategy, words only
      └── @vanguard     → security, words only
```

## Supervision Model

- Overlord presents plan → you approve → agents act
- Every `write`, `edit`, `bash` on Engineer → asks you
- Every `bash` on Seeker → asks you
- Stalker → reads freely, destructive ops hard-denied
- Architect, Inquisitor, Vanguard → words only, no tools

## Quality + Security Gate

Engineer output → **Inquisitor** (quality) + **Vanguard** (security) in parallel.
CRITICAL from either → back to Engineer. Both must PASS before reaching you.

## OpenCode Models

| Agent | Model | Why |
|---|---|---|
| Overlord | `deepseek-v4-flash` | Fast routing, no depth needed |
| Stalker | `qwen3.5-plus` | Highest TPS — recon is high-volume |
| Engineer | `glm-5.1` | SWE-Bench Pro #1 (58.4%), best agentic coder |
| Inquisitor | `deepseek-v4-pro` | Strongest reasoning for judgment |
| Seeker | `mimo-v2.5-pro` | Purpose-built for systematic long-horizon reasoning |
| Architect | `deepseek-v4-pro` | Strongest pure reasoning, Codeforces 3206 |
| Vanguard | `glm-5.1` | Leads CyberGym security benchmark |

> Kimi K2.5/K2.6 excluded — Moonshot MFJS incompatibility on opencode-go.
> Track fix: https://github.com/anomalyco/opencode/pull/25011

## Claude Code

Claude Code uses the same team via `CLAUDE.md`. No model switching (single model), but same routing rules, same supervision, same chaining. Shadowforce activates automatically on session start.

## Stow

```bash
cd ~/dotfiles/all && stow -t ~ ai-agent
```
