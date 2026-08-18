---
name: project-chmonitor-tools-sidebar
title: chmonitor Tools sidebar group
description: Dashboard Tools group holds SQL Console, Data Explorer, Explain, Advisor, Chart Builder, Schema Compare, Settings Diff
type: project
category: clickhouse
tags: [project, chmonitor, clickhouse, ui]
related: ["[[project-clickhouse-monitoring]]", "[[project-chmonitor-advisor]]", "[[project-chmonitor-menu-engine-filter]]"]
sources: ["https://github.com/chmonitor/chmonitor", "https://docs.chmonitor.dev"]
created: 2026-08-19
updated: 2026-08-19
timestamp: 2026-08-19T02:50:00+07:00
---

Dashboard sidebar **Tools** (after Overview / Postgres, before AI Agent) is the interactive-utility group:

- SQL Console (`/sql`)
- Data Explorer (`/explorer`)
- Explain (`/explain`)
- Advisor (`/advisor`) — recommend-only ([[project-chmonitor-advisor]])
- Chart Builder (`/dashboard`)
- Schema Compare (`/schema-diff`)
- Settings Diff (`/settings-diff`)

AI Agent stays its own top-level group. Queries, Cluster, and other monitors stay put. DBA / Engineer / SRE workspace presets include Tools.

Tools is ClickHouse-family only — a Postgres host must not see it ([[project-chmonitor-menu-engine-filter]]).

Hub: [[project-clickhouse-monitoring]].

**Why:** tool pages were scattered under Tables, Queries, Operations, and System.
**How to apply:** put new interactive utilities in Tools; do not move monitoring views there.
