---
name: project-chmonitor-menu-engine-filter
title: chmonitor menu engine filter
description: Absent engines on a menu item means ClickHouse family; Postgres hosts must not see those items
type: project
category: clickhouse
tags: [project, chmonitor, clickhouse, postgres, ui]
related: ["[[project-clickhouse-monitoring]]", "[[project-chmonitor-tools-sidebar]]"]
sources: ["https://github.com/chmonitor/chmonitor"]
created: 2026-08-19
updated: 2026-08-19
timestamp: 2026-08-19T02:50:00+07:00
---

Dashboard nav (sidebar, command palette, Settings > Navigation) filters by the **active host engine**.

- No `engines` tag → ClickHouse family (`clickhouse` + `clickhouse-cloud`). Hidden on Postgres.
- `engines: ['postgres']` → Postgres-only.

Settings > Navigation uses the same filter as the live sidebar (`useActiveHostEngine`). Do not hardcode ClickHouse when building the customize tree. Do not add `engines: ['postgres']` to ClickHouse tools just to show a heading.

Hub: [[project-clickhouse-monitoring]]. Tools group: [[project-chmonitor-tools-sidebar]].

**Why:** a Postgres host must not customize or see ClickHouse-only pages (Queries, Cluster, Tools).
**How to apply:** leave CH-only items untagged; thread the active host engine into every nav surface.
