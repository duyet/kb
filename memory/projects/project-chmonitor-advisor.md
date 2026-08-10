---
name: project-chmonitor-advisor
title: chmonitor recommends, never auto-DDL
description: AI/ops advisor suggests CH changes but does not apply DDL automatically
type: project
category: clickhouse
tags: [project, chmonitor, clickhouse, security]
related: ["[[project-clickhouse-monitoring]]", "[[feedback-fail-loud]]", "[[user-duyet-focus-clickhouse]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T18:00:00Z
---

chmonitor advisor mode is **recommend-only** — projections, skip indexes, partitions, MVs — never silent schema mutations.

Hub: [[project-clickhouse-monitoring]]. Safety culture: [[feedback-fail-loud]].
