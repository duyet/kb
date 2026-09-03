---
name: project-oma-console-analytics
title: oma Console Analytics dashboard
description: Console /analytics charts cross-agent estimated spend, token mix by kind, and declared multiagent delegation from existing usage APIs
type: project
category: agents
tags: [project, oma, console, analytics, usage]
aliases: [oma-analytics, oma-console-analytics, oma-spend-dashboard]
related: ["[[project-open-managed-agents]]", "[[project-oma-verify-skill]]", "[[project-oma-console-monitor]]"]
sources: ["https://github.com/duyet/oma/pull/446", "https://oma.duyet.net/features/", "https://docs.oma.duyet.net/concepts/"]
created: 2026-09-04
updated: 2026-09-04
timestamp: 2026-09-03T19:09:31Z
---

Console **Analytics** (`/analytics`, chord `g y`) is a dedicated spend and delegation page for a workspace. First slice of the analytics issue — no new backend.

It reads `GET /v1/usage?group_by=agent&days=N` (range chips `1d | 7d | 30d`, default `7d`) and `GET /v1/agents` multiagent rosters. KPI strip covers estimated spend, tokens, sessions, and agents with usage. Token mix is **by kind** (input, output, cache, reasoning), not by model. Cost-by-agent uses the same Sonnet-class rates as agent stats (top 10 + Others). Daily trend charts sandbox-active seconds. Declared delegation shows a ranked roster plus a compact SVG node-link on desktop.

Marketing copy on https://oma.duyet.net/features/ names Console Analytics under multi-agent delegation. Docs concepts page documents the same surface. Signed-out `/analytics` stays behind the Console login gate.

**Why:** Operators with many agents need one screen for “who spends?” and “who can call whom?” without a new analytics API.

**How to apply:** Recert signed-in `/analytics` with range chips and empty-tenant honesty. Do not invent by-model charts or a dedicated `/v1/analytics` until usage events carry model ids. Full issue remains open for later slices.

Hub: [[project-open-managed-agents]].
