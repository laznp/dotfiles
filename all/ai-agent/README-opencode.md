# Shadowforce — OpenCode Agent Team

A structured multi-agent system for OpenCode Go. One commander, five specialists. Nothing gets built or destroyed without your approval.

## The Team

| Agent | Role | Model | Tools |
|---|---|---|---|
| **Overlord** | Commander — routes missions, presents plans, waits for approval | `deepseek-v4-flash` | none |
| **Stalker** | Scout — recon, grep, file search, structure mapping | `qwen3.5-plus` | bash (read-only) |
| **Engineer** | Artisan — code, scripts, IaC, Terraform, Helm, K8s | `glm-5.1` | write + edit + bash |
| **Inquisitor** | Judge — reviews all Engineer output before it reaches you | `deepseek-v4-pro` | none |
| **Seeker** | Oracle — incidents, log analysis, root cause, Grafana/K8s | `mimo-v2.5-pro` | bash |
| **Architect** | Sage — architecture, trade-offs, strategic direction | `deepseek-v4-pro` | none |
| **Vanguard** | Paladin — security review, CVE, RBAC, secrets | `glm-5.1` | none |

## How It Works

```
You
 └── Overlord (presents plan, waits approval)
      ├── @stalker    → recon first, never modifies
      ├── @engineer   → builds (every action asks you)
      │    ├── @inquisitor  → quality review (parallel)
      │    └── @vanguard    → security review (parallel)
      ├── @seeker     → incidents (every bash asks you)
      ├── @architect  → strategy, words only
      └── @vanguard   → security, words only
```

### Flow for implementation tasks

1. **Stalker** recons — exact paths, line numbers, no modification
2. **Architect** designs (if complex) — trade-offs, costs named
3. **Engineer** builds — asks permission before every write/edit/bash
4. **Inquisitor + Vanguard** review in parallel — CRITICAL issues send back to Engineer
5. **Overlord** presents verdict + output to you

### Flow for incidents

1. **Seeker** triages — SYMPTOMS → TIMELINE → SIGNALS → HYPOTHESES → ROOT CAUSE → REMEDIATION
2. **Engineer** patches — asks permission before every action

## Supervision Model

- Overlord presents plan before any action
- Every `write`, `edit`, `bash` on Engineer requires your approval
- Every `bash` on Seeker requires your approval
- Stalker: destructive ops hard-denied, reads flow freely
- Architect, Inquisitor, Vanguard: words only — can never touch files

## Model Selection

Models chosen per role based on benchmark performance:

| Model | Why |
|---|---|
| `glm-5.1` | SWE-Bench Pro #1 (58.4%) — best agentic coder; leads CyberGym security benchmark |
| `deepseek-v4-pro` | Strongest pure reasoning — Codeforces 3206; best for judgment/analysis |
| `deepseek-v4-flash` | Fastest — routing and recon don't need depth |
| `mimo-v2.5-pro` | Purpose-built for systematic long-horizon reasoning — incident triage |
| `qwen3.5-plus` | Highest TPS — recon is high-volume, speed > intelligence |

> Note: Kimi K2.5/K2.6 excluded — buggy on opencode-go provider (Moonshot MFJS message format incompatibility). Track fix: https://github.com/anomalyco/opencode/pull/25011

## Provider

All models via `opencode-go` provider on [OpenCode Go](https://opencode.ai/docs/go) subscription ($10/month, $60/month cap).

## Structure

```
.config/opencode/
├── opencode.json          # Provider config, default_agent, MCP servers
└── agents/
    ├── overlord.md        # Primary agent (default)
    ├── stalker.md         # Recon subagent
    ├── engineer.md        # Implementation subagent
    ├── inquisitor.md      # Quality gate subagent
    ├── seeker.md          # Incident triage subagent
    ├── architect.md       # Strategy subagent
    └── vanguard.md        # Security subagent
```

## Usage

Overlord is default. Just start OpenCode — it routes automatically.

Invoke specialists directly when needed:
```
@stalker find all Terraform files defining IAM roles
@architect should we use Helm or Kustomize?
@seeker pod is crashlooping in prod
@vanguard review this Terraform for security issues
```
