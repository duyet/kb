---
name: project-chmonitor-licenses
title: chmonitor paid licenses are self-hosted host-count
description: Paid chmonitor is honor-system host-count licenses (yearly/lifetime), not hosted SaaS seats
type: project
category: clickhouse
tags: [project, chmonitor, clickhouse]
related: ["[[project-clickhouse-monitoring]]", "[[tech-one-codebase-oss-saas]]", "[[user-duyet-active-projects]]"]
sources: ["https://chmonitor.dev"]
created: 2026-08-18
updated: 2026-08-21
timestamp: 2026-08-21T12:00:00Z
---

Public paid path for [[project-clickhouse-monitoring]] is **self-hosted host-count licenses** (yearly or lifetime), honor system — not hosted SaaS seats. Replicas in the same shard are **not counted**.

Cloud demo remains `dash.chmonitor.dev`. OSS self-host stays the default for enterprises (IP allowlists, no metadata leaving the VPC).

**Why:** agents should not design “SaaS seats” as the paid SKU.
**How to apply:** talk about host-count licenses + trust model; replicas are free.
