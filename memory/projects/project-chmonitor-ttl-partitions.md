---
name: project-chmonitor-ttl-partitions
title: chmonitor TTL & Partitions inventory
description: System TTL page lists table inventory plus part-health charts; never select system.tables.ttl
type: project
category: clickhouse
tags: [project, chmonitor, clickhouse, ui]
related: ["[[project-clickhouse-monitoring]]", "[[project-chmonitor-tools-sidebar]]"]
sources: ["https://github.com/chmonitor/chmonitor", "https://docs.chmonitor.dev"]
created: 2026-08-19
updated: 2026-08-19
timestamp: 2026-08-19T10:18:00+07:00
---

System view **TTL & Partitions** (`/ttl-partition-health`) shows:

- Inventory table: full_table, engine, partition_key, ttl_expression, partitions, active_parts, parts_per_partition, bytes_on_disk
- Charts: part health and parts per table

This is a System monitor, not a Tools utility ([[project-chmonitor-tools-sidebar]]).

`system.tables` has no `ttl` column. Inventory SQL must never select `system.tables.ttl` — that 500s and the UI shows a silent Retry.

Hub: [[project-clickhouse-monitoring]].

**Why:** inventory failed live when the query invented a column; charts still worked.
**How to apply:** keep inventory and charts as separate queries; fail loud on inventory errors; do not select `system.tables.ttl`.
