---
name: project-clickhouse-monitoring
title: chmonitor
description: Open-source ClickHouse operational advisor — monitoring + AI recommendations
type: project
category: clickhouse
tags: [project, clickhouse, chmonitor, oss]
aliases: [chmonitor, clickhouse-monitoring, project-clickhouse-monitor]
related: ["[[user-duyet-focus-clickhouse]]", "[[tech-one-codebase-oss-saas]]", "[[user-duyet-active-projects]]", "[[user-duyet-data-clickhouse]]"]
sources: ["https://github.com/chmonitor/chmonitor", "https://chmonitor.dev", "https://docs.chmonitor.dev"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T18:00:00Z
---

github.com/chmonitor/chmonitor · https://chmonitor.dev · docs: https://docs.chmonitor.dev

**chmonitor** — operational advisor for ClickHouse (not only a metrics UI). Reads `system.*`, recommends projections/skip indexes/partitions/MVs (**recommend-only**, never auto-applies DDL). Real-time query/cluster/replication monitoring, MCP server, AI agent chat.

| Edition | Notes |
|---------|--------|
| Self-host OSS | Docker/K8s/bare metal/Workers — GPL-3.0 |
| Cloud SaaS | Hosted dashboard (same product family) |

Patterns: [[tech-one-codebase-oss-saas]], [[tech-single-source-env]], [[tech-tanstack-start-ssg]].
Focus: [[user-duyet-focus-clickhouse]]. Portfolio: [[user-duyet-active-projects]].
