---
name: project-oma-console-daily-summary
title: oma Console daily summary for scheduled agent runs
description: Agent detail Daily summary tab rolls up schedule firings over 1/7/30 UTC days from agent_schedule_runs
type: project
category: agents
tags: [project, oma, console, schedules, observability]
aliases: [oma-daily-summary, oma-schedule-summary]
related: ["[[project-open-managed-agents]]", "[[project-oma-console-analytics]]", "[[project-oma-console-monitor]]"]
sources: ["https://github.com/duyet/oma/pull/449", "https://docs.oma.duyet.net/build/schedules/"]
created: 2026-09-04
updated: 2026-09-04
timestamp: 2026-09-03T19:35:00Z
---

Console agent detail gains a **Daily summary** tab for schedule firings only (not all-sessions observability). It rolls up `agent_schedule_runs` (`ok` / `error` / `skipped_concurrency`) over chips `1 | 7 | 30` UTC days with counts, tokens, and cost. Per-schedule history stays in its existing modal.

First slice of the daily-summaries issue — deployments rollup is still open.

**Why:** Operators need an agent-level view of what cron firings did without replaying the event log.

**How to apply:** Recert signed-in agent detail → Daily summary with range chips and empty honesty. Do not treat this tab as all-sessions monitoring.

Shipped in duyet/oma #449. Hub: [[project-open-managed-agents]].
