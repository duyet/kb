---
name: tech-one-codebase-oss-saas
title: One codebase OSS + SaaS
description: Ship self-host and cloud from one tree behind a fail-closed mode flag
type: tech
category: architecture
tags: [tech, architecture, oss]
related: ["[[project-clickhouse-monitoring]]", "[[tech-single-source-env]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Pattern: single high-level deployment mode (`oss|cloud`) that resolves auth/storage defaults. Unset/junk → OSS so open source never degrades.

Never gate core product features behind cloud-only. Example product: [[project-clickhouse-monitoring]]. Env: [[tech-single-source-env]].
