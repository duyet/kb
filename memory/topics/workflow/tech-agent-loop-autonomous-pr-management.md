---
name: tech-agent-loop-autonomous-pr-management
title: Agent-loop autonomous PR management
description: Continuous loop that monitors all open PRs, triages by status, dispatches cheap subagents for fixes/reviews, reduces manual context overhead
type: tech
category: workflow
tags: [tech, automation, agents, PR-management, continuous-integration, efficiency]
related: ["[[project-duyetbot]]", "[[tech-codebase-maintenance-loop]]", "[[feedback-cheap-models-subagents]]"]
created: 2026-06-15
updated: 2026-06-15
timestamp: 2026-06-15T18:51:13Z
---

**Agent-loop** is a continuous, self-paced autonomous system that manages all open PRs without human context overhead.

## Cycle Structure

Runs indefinitely on 15-minute intervals (configurable):

1. **Wait** — sleep for cycle interval (15 min)
2. **Triage** — scan all open PRs across all repos, classify by status
3. **Dispatch** — route work to parallel subagent threads
4. **Monitor** — track thread progress and outcomes
5. **Report** — log cycle summary to `.agent-loop/` state files

## What It Triages

- **Merge-ready**: PR is passing, approved, no conflicts → dispatch merge agent
- **Review-ready**: PR is passing, needs review → dispatch code-review subagent
- **Needs-fix**: PR is failing tests/lint/type-check → dispatch fix subagent
- **Merge-blocked**: conflicts, failing checks, waiting on approval → log and defer
- **Deferred**: previously seen, no change → skip

## Subagent Dispatch Strategy

**Cheap models only** (Sonnet/Haiku) — preserves main context:

- **Haiku** — test failures, lint fixes, simple refactors
- **Sonnet** — code reviews, complex refactors, multi-file changes
- **Main context** — strategic decisions only (scope conflicts, architectural questions)

Max 3 parallel threads per cycle (prevents queue overflow).

## State & Recovery

- **Persisted to** `.agent-loop/state.json` in repo root
- **Recovers** cycle count, items processed, PRs merged, active thread list, thread history
- **Backups** kept in `.agent-loop/backups/` (timestamped) for recovery from corruption
- **Commands**: `/agent-loop:status` (quick), `/agent-loop:inspect` (full), `/agent-loop:stop` (graceful)

## Effectiveness & Cost Savings

**What it eliminates:**
- Manual PR reviews (triaged by subagents in parallel)
- Manual fix cycles (test failures → fix → re-run → merge in one agent call)
- Context-switching cost (loop runs in background, main context for decisions only)
- Duplicate work (state tracking prevents re-triaging)

**Why cheap subagents work:**
- PRs have clear status (passing/failing) → less ambiguity
- Fixes are scoped (fix this test file, not "improve the codebase")
- Reviews use heuristics (no duplicated code, type safety, naming) → Sonnet sufficient
- Merge/CI tasks are deterministic (run test suite, merge, revert if fail)

**Cost vs. value:**
- Haiku @ 80 tokens/request × 20 fixes/cycle = 1.6k tokens
- Sonnet @ 200 tokens/request × 5 reviews/cycle = 1k tokens
- Per 15-min cycle: ~3k tokens (vs. Opus main-loop @ 10x cost)
- 4 cycles/hr × 6 hrs/day = 24 cycles/day = 72k tokens/day (sustainable)

## Setup & Configuration

```bash
# Resume with all-repos scope, 15-min cycle
/agent-loop:resume --scope all --interval 900

# Check status
/agent-loop:status

# Stop gracefully
/agent-loop:stop
```

Configuration persists in state.json; resume re-applies saved interval/scope.

## Integration Points

- **CI systems**: loop watches GitHub Actions status in real-time
- **PR queue**: triages GitHub PR API endpoints (open, draft, status)
- **Git operations**: merge via CLI, uses signed commits (GPG if configured)
- **Logging**: appends to `.agent-loop/cycles/<YYYY-MM-DD>.log` + `state.json` metrics

## Next: Scaling to Org Scope

Currently monitoring single project. Roadmap:
- Fan out to multiple repos (`--scope all --repos org/repo1,org/repo2`)
- Route complex PRs to senior-engineer agents when heuristics are uncertain
- Auto-create follow-up issues for deferred PRs (merge-blockers, architecture questions)
- Dashboard showing cycle health, merge velocity, average review time
