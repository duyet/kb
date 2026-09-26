---
name: project-chmonitor-desk-jobs
title: chmonitor scheduled desk jobs
description: Four herdr-desk jobs (triage, babysit, prod watch, improve) with staggered minutes and one agent name each
type: project
category: automation
tags: [project, chmonitor, herdr, automation, cron]
related: ["[[project-clickhouse-monitoring]]", "[[tech-silent-scheduler-failure]]", "[[feedback-issue-research-pr]]"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T00:00:00Z
---

chmonitor's unattended maintenance is the **herdr-desk** Herdr plugin, config
only in `.herdr-desk.json` plus repo-owned playbooks in `docs/herdr-desk/`.

| Job | Cron | Owns |
|---|---|---|
| `desk:github-issues` | `0,30 * * * *` | triage, research, dispatch children |
| `local:babysit` | `10,40 * * * *` | red required CI, review, auto-merge, worktrees |
| `local:prod` | `20,50 * * * *` | live deploy verification, agent probe, usage, revert |
| `local:improve` | `17 2 * * *` | desk health, doc/skill drift, dead code, slowdowns |

**Why:** one job doing all four duties made every duty compete for the same five
child slots, so a busy issue queue silently starved PR maintenance. Separate
jobs give each duty its own budget and its own manager.

**How to apply:**

- **Stagger the minutes** so two jobs never contend for one slot, and give each
  job its own `agentName` — the agent name *is* the session identity, so a
  shared name means two prompts racing for one pane.
- **`name` in the desk config must equal the repo folder name.** A stale
  `"name": "chmonitor"` in the herdr-desk repo registered a second chmonitor job
  on a different cron; the loser recorded a prompt failure.
- Required CI is `unit-tests` + `dashboard`. `e2e-test`, `e2e-test-tsr`,
  `component-test`, `codecov/patch`, `promptfoo` and `Claude Issues` are
  informational. Release-please PRs are human-only, never auto-merge.
- Production deploys itself on push to `main`; `local:prod` is the second pair of
  eyes and may only verify or restore service, never ship.
- Proof a branch landed before deleting its worktree: `git diff <branch>
  origin/main -- <touched files>`, **not** `git branch --merged` — squash merges
  change the sha, so a fully merged branch still reads "ahead N".

Lessons: [[tech-silent-scheduler-failure]], [[feedback-issue-research-pr]].
