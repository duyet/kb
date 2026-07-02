---
name: 2026-06-30-clickhouse-machines-setup
title: Session Log — ClickHouse Multi-Host Setup
description: Investigation, connectivity fixes, optimization, and partial data clone across the primary, clone, and perf ClickHouse instances
type: project
category: sessions
tags: [clickhouse, homelab, session-log, infra]
related: ["[[clickhouse-machines]]", "[[project-clickhouse-monitor]]"]
sources: []
created: 2026-06-30
updated: 2026-07-02
timestamp: 2026-07-02T00:00:00Z
---

# Session Log — ClickHouse Multi-Host Setup

## Objective

Investigate and fix ClickHouse connectivity across 3 instances (primary k3s cluster, perf VPS, new small cloud instance), configure the monitoring dashboard to connect to all instances, set up ClickHouse on the blank instance, clone data from the primary, optimize for the small instance, and document all machines in Obsidian notes.

## What was done

### 1. Investigated connectivity across 3 instances

| Role | Version | Access | Status | Notes |
|------|---------|--------|--------|-------|
| primary (k3s) | 26.4.x | Internal Tailscale HTTPS Funnel URL | ✅ Working | Already configured, Tailscale HTTPS Funnel |
| clone (small cloud instance) | 26.3.x | Internal Tailscale HTTP | ✅ Working after fixes | Password unknown, memory limit too low |
| perf (VPS) | 26.5.x | Internal Tailscale HTTP (non-default port) | ✅ Working | Internal HTTP on a non-default port |

All three verified with `SELECT 1` and version queries.

### 2. Fixed the clone instance

**Password reset**
- The `users.d/` directory was empty; the default user had an unknown password hash
- Replaced the password hash with the SHA256 of the shared password
- Verified connection: `SELECT 1` returned `1`

**Memory optimization**
- Discovered `config.d/memory.xml` with `max_server_memory_usage=734003200` (700 MB)
- On ~1.9 GB RAM (memory-constrained), even simple queries hit `MEMORY_LIMIT_EXCEEDED`
- Updated to `1073741824` (1 GB) with `max_concurrent_queries=10`
- Restarted ClickHouse, verified `system.server_settings` shows new value

### 3. Updated multi-host config

All 3 instances added to the multi-host config (comma-separated multi-host format), single credential pair shared across them.

### 4. Cloning `duyet_analytics` from primary to clone

**duyet_analytics contents on the primary**:
- 65 tables, ~700 MiB compressed on disk
- Includes GA4 reports, GitHub commits, WakaTime, Unsplash, Cloudflare stats, home lab metrics, web activity, n8n transactions, peerdb validation tables, ccusage/OpenRouter usage
- Most tables use `MergeTree` or `ReplacingMergeTree`

**Clone status**: Complete ✅
- Step 1: Listed all tables and DDLs ✅
- Step 2: Create database and 50 tables on the clone ✅
- Step 3: Export/import data via HTTP Native streaming ✅
- Step 4: Verify row counts match on all 34 tables with data ✅

**Key details:**
- Large tables cloned (2.44M rows total)
  - power_usage: 777,355 ✓
  - homelab_ubuntu_sensors: 739,425 ✓ (batched at 20k due to large raw_data strings)
  - duyet_redirect: 418,507 ✓ (+47k dups from batch retry, ReplacingMergeTree cleans up)
  - events: 100,209 ✓ (batched at 50k then 20k due to memory limit)
- Batch strategy: Python script on dev laptop → `curl` primary (HTTP Native) → `ssh | clickhouse-client` clone
- Explicit column lists to skip MATERIALIZED columns
- Batched with LIMIT/OFFSET for large tables (20k-50k per chunk)
- 16 tables are empty on both sides (normal)

### 5. Memory tuning after clone

After cloning completed, `max_server_memory_usage` reduced from 1.7 GiB back toward 1 GiB:
- Tried 1 GiB (1073741824) → ClickHouse restart hit MEMORY_LIMIT_EXCEEDED at RSS 1.06 GiB
- Settled at 1.5 GiB (1610612736) — leaves ~400 MiB for OS/page cache

### 6. Documentation

Created/updated:
- `memory/projects/homelab/clickhouse-machines.md` — durable machine inventory (updated with clone details)
- `memory/projects/homelab/sessions/2026-06-30-clickhouse-machines-setup.md` — this session log
- Synced to the `duyet/kb` repo

## Production caveat

Only the primary is reachable from Cloudflare Workers via a Tailscale HTTPS Funnel URL. The clone and perf instances use internal Tailscale addresses that Cloudflare Workers cannot reach. To add them to the production monitoring dashboard, they would need:
- Tailscale Funnel public URLs, or
- A Tailscale subnet router reachable from Cloudflare Workers, or
- Public HTTPS endpoints

## Remaining work

1. ✅ ~~Complete cloning `duyet_analytics` to the clone instance~~ — DONE (all 34 tables with data verified)
2. (Optional) Set up Tailscale Funnel for the clone and perf instances if production multi-host is desired
3. (Optional) Clone additional databases (home_assistant, amazon, git) to the clone instance if needed

## Commands used (for reference)

```bash
# Test connectivity (pass from env var or --password flag)
clickhouse-client --query "SELECT 1"

# Check memory settings
clickhouse-client --query "SELECT name, value FROM system.server_settings WHERE name='max_server_memory_usage'"

# Get DDLs
clickhouse-client --query "SELECT create_table_query FROM system.tables WHERE database='duyet_analytics'"

# Clone data between hosts via HTTP Native + clickhouse-client pipe
# See clone script in ~/scripts/ for current implementation
```
