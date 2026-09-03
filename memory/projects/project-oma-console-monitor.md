---
name: project-oma-console-monitor
title: oma Console Agent Monitor tab
description: Console AgentDetail health strip plus Monitor tab is the live agent.status heartbeat feed
type: project
category: agents
tags: [project, oma, console, agents]
aliases: [oma-monitor-tab, oma-agent-health-strip]
related: ["[[project-open-managed-agents]]", "[[project-oma-verify-skill]]"]
sources: ["https://github.com/duyet/oma/pull/444", "https://oma.duyet.net/features/coding-agents/"]
created: 2026-09-04
updated: 2026-09-04
timestamp: 2026-09-03T18:12:37Z
---

Console AgentDetail shows a derived **health strip** (status, last/next run, uptime, success rate, avg duration, cost/run) from existing schedules, sessions, stats, and analytics. No dedicated `/v1/agents/:id/health` route yet.

**Monitor** (`/agents/:id/monitor`) sits between Schedules and Observability. It is the live `agent.status` progress feed: current or last session, step bar, amber `blocked_on`, heartbeat log, lag at 2× the 5-minute default. Eyes-only — Interrupt is out of this slice. Upgrade log is an honest empty placeholder.

Dashboard **Active sessions** deep-links to that agent's Monitor when exactly one running session has an agent id.

Landed in #444 as the first slice of the monitoring UX (#345 still open). Signed-out `/monitor` stays behind the Console login gate.

**Why:** Operators of scheduled or long-running agents need a glanceable alive/progress surface without new control-plane endpoints.

**How to apply:** Point operators and recert at AgentDetail header + Monitor tab, not Observability. Do not invent heartbeat_missed / self_upgrade notify until a dispatcher exists.

Hub: [[project-open-managed-agents]].
