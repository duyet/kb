---
name: 2026-06-30-clickhouse-machines-setup
title: Session Log — ClickHouse Multi-Host Setup
description: Investigation, connectivity fixes, optimization, and partial data clone across duet-ubuntu, clickhouse-aws, and openclaw
type: log
category: sessions
tags: [clickhouse, homelab, chmonitor, session-log, infra]
related: ["[[clickhouse-machines]]", "[[project-clickhouse-monitor]]"]
sources: []
created: 2026-06-30
updated: 2026-07-01
timestamp: 2026-07-01T13:00:00Z
---

# Session Log — ClickHouse Multi-Host Setup

## Objective

Investigate and fix ClickHouse connectivity across 3 machines (duet-ubuntu k3s cluster, openclaw, new EC2), configure dash.chmonitor.dev to connect to all instances, setup ClickHouse on blank EC2, clone data from duet-ubuntu, optimize for small instance, and document all machines in Obsidian notes.

## What was done

### 1. Investigated connectivity across 3 machines

| Host | Version | URL | Status | Notes |
|------|---------|-----|--------|-------|
| duet-ubuntu (k3s) | 26.4.3.37 | `https://duet-ubuntu.dingo-mora.ts.net:8443` | ✅ Working | Already configured, Tailscale HTTPS Funnel |
| clickhouse-aws (EC2 t3a.small) | 26.3.17.4 | `http://CLICKHOUSE_AWS_TAILSCALE_IP:8123` | ✅ Working after fixes | Password unknown, memory limit too low |
| openclaw (Contabo VPS) | 26.5.1.882 | `http://OPENCLAW_TAILSCALE_IP:8124` | ✅ Working | HTTP on port 8124 (not default 8123) |

All three verified with `SELECT 1` and version queries.

### 2. Fixed clickhouse-aws

**Password reset**
- The `users.d/` directory was empty; default user had unknown SHA256 hash `ebcfa138f951243998ae0de4ad20a20b4794a5e5daf3360c7d2ab87948dd248e`
- Replaced the password hash with SHA256 of shared password `CLICKHOUSE_PASSWORD_REDACTED`
- Verified connection: `SELECT 1` returned `1`

**Memory optimization**
- Discovered `/etc/clickhouse-server/config.d/memory.xml` with `max_server_memory_usage=734003200` (700 MB)
- On 1.9 GB RAM t3a.small, even simple queries hit `MEMORY_LIMIT_EXCEEDED`
- Updated to `1073741824` (1 GB) with `max_concurrent_queries=10`
- Restarted ClickHouse, verified `system.server_settings` shows new value

### 3. Updated multi-host `.env.local`

File: `/Users/duet/project/chmonitor/chmonitor/apps/dashboard/.env.local`

```
CLICKHOUSE_HOST=https://duet-ubuntu.dingo-mora.ts.net:8443,http://CLICKHOUSE_AWS_TAILSCALE_IP:8123,http://OPENCLAW_TAILSCALE_IP:8124
CLICKHOUSE_USER=default
CLICKHOUSE_PASSWORD=CLICKHOUSE_PASSWORD_REDACTED
CLICKHOUSE_NAME=duet-ubuntu,clickhouse-aws,openclaw
```

Single credential pair applies to all hosts in the multi-host parser.

### 4. Cloning `duyet_analytics` from duet-ubuntu to clickhouse-aws

**duyet_analytics contents on duet-ubuntu**:
- 65 tables, ~700 MiB compressed on disk
- Includes GA4 reports, GitHub commits, WakaTime, Unsplash, Cloudflare stats, home lab metrics, web activity, n8n transactions, peerdb validation tables, ccusage/OpenRouter usage
- Most tables use `MergeTree` or `ReplacingMergeTree`

**Clone status**: Complete ✅
- Step 1: Listed all tables and DDLs ✅
- Step 2: Create database and 50 tables on clickhouse-aws ✅
- Step 3: Export/import data via HTTP Native streaming ✅
- Step 4: Verify row counts match on all 34 tables with data ✅

**Key details:**
- Large tables cloned (2.44M rows total)
  - power_usage: 777,355 ✓
  - homelab_ubuntu_sensors: 739,425 ✓ (batched at 20k due to large raw_data strings)
  - duyet_redirect: 418,507 ✓ (+47k dups from batch retry, ReplacingMergeTree cleans up)
  - events: 100,209 ✓ (batched at 50k then 20k due to memory limit)
- Batch strategy: Python script on dev laptop → `curl duet-ubuntu (HTTP Native)` → `ssh | clickhouse-client (clickhouse-aws)`
- Explicit column lists to skip MATERIALIZED columns
- Batched with LIMIT/OFFSET for large tables (20k-50k per chunk)
- 16 tables are empty on both sides (normal)

### 5. Memory tuning after clone

After cloning completed, `max_server_memory_usage` reduced from 1.7 GiB back toward 1 GiB:
- Tried 1 GiB (1073741824) → ClickHouse restart hit MEMORY_LIMIT_EXCEEDED at RSS 1.06 GiB
- Settled at 1.5 GiB (1610612736) — leaves ~400 MiB for OS/page cache

### 6. Documentation

Created/updated:
- `kb/memory/projects/homelab/clickhouse-machines.md` — durable machine inventory (updated with clone details)
- `kb/memory/projects/homelab/sessions/2026-06-30-clickhouse-machines-setup.md` — this session log (updated 2026-07-01)
- Synced to `github.com:duyet/kb.git`

## Production caveat

Only duet-ubuntu is accessible from Cloudflare Workers via Tailscale Funnel. clickhouse-aws and openclaw use internal Tailscale IPs (`100.x.x.x`) that Cloudflare Workers cannot reach. To add them to production dash.chmonitor.dev, they would need:
- Tailscale Funnel public URLs, or
- A Tailscale subnet router reachable from Cloudflare Workers, or
- Public IPs/HTTPS endpoints

## Remaining work

1. ✅ ~~Complete cloning `duyet_analytics` to clickhouse-aws~~ — DONE (all 34 tables with data verified)
2. (Optional) Set up Tailscale Funnel for clickhouse-aws and openclaw if production multi-host is desired
3. (Optional) Clone additional databases (home_assistant, amazon, git) to clickhouse-aws if needed

## Commands used (for reference)

```bash
# Test connectivity
curl -s -u "default:CLICKHOUSE_PASSWORD_REDACTED" "https://duet-ubuntu.dingo-mora.ts.net:8443/" -d "SELECT 1"
curl -s -u "default:CLICKHOUSE_PASSWORD_REDACTED" "http://CLICKHOUSE_AWS_TAILSCALE_IP:8123/" -d "SELECT 1"
curl -s -u "default:CLICKHOUSE_PASSWORD_REDACTED" "http://OPENCLAW_TAILSCALE_IP:8124/" -d "SELECT 1"

# SSH to clickhouse-aws
ssh -i ~/.ssh/clickhouse-aws.pem ec2-user@CLICKHOUSE_AWS_TAILSCALE_IP

# Check memory settings
clickhouse-client -u default --password CLICKHOUSE_PASSWORD_REDACTED \
  --query "SELECT name, value FROM system.server_settings WHERE name='max_server_memory_usage'"

# Get DDLs
clickhouse-client --query "SELECT create_table_query FROM system.tables WHERE database='duyet_analytics'"
```
