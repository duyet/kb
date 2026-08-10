---
name: lessons-chmonitor-homelab-deploy
title: Lessons — chmonitor on homelab k3s
description: Homelab chmonitor vs public dash; image ghcr.io/chmonitor/chmonitor; no CH readonly profile; dedicated SELECT user; proxy auth via forwardAuth
type: tech
category: infra
tags: [chmonitor, clickhouse, homelab, k3s, traefik, auth, helm]
aliases: [chmonitor-homelab]
related: ["[[project-clickhouse-monitor]]", "[[project-chmonitor-one-codebase-saas]]", "[[reference-clickhouse-machines]]", "[[tech-traefik-forwardauth-oauth2-proxy]]", "[[project-self-driven-homelab]]"]
sources: ["https://github.com/chmonitor/chmonitor", "https://dash.chmonitor.dev", "https://charts.chmonitor.dev"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T10:11:57Z
---

# Lessons — chmonitor on homelab k3s

## Two different instances (do not conflate)

| Instance | Purpose | Data |
|----------|---------|------|
| **Public Cloud/demo** (`dash.chmonitor.dev`) | SaaS + limited public demo | Limited tables, intentionally constrained |
| **Homelab self-host** (private Traefik + OAuth) | Full cluster ops UI | All DBs/schemas; expected higher metrics volume |

Homelab is supposed to “show more performance” — that is normal, not a bug vs public.

## Image (2026-08)

- **Canonical:** `ghcr.io/chmonitor/chmonitor:latest` (`imagePullPolicy: Always`)
- **Stale:** `ghcr.io/duyet/chmonitor:latest` — no longer receives CI builds; redeploy pulls same old digest forever
- Helm chart repo: `https://charts.chmonitor.dev` (chart `chmonitor`); source repo moved to `chmonitor/chmonitor`

## ClickHouse user for the dashboard

- Use a **dedicated user** with **privilege-based** read-only: `GRANT SELECT, SHOW, dictGet ON *.*` (or narrower), not the server **`readonly` settings profile** (`readonly=1`).
- chmonitor always sets **`max_execution_time`** as a **session setting** on the client. With `readonly=1` ClickHouse returns:

  ```text
  Cannot modify 'max_execution_time' setting in readonly mode
  ```

  → `/api/healthz` fails → readiness 503 → pod never Ready.
- Prefer a normal/`monitoring` profile + grants. Homelab pattern: user `chmonitor` + role with SELECT/SHOW on all DBs.

## Auth (homelab)

- Behind Traefik **forwardAuth** + oauth2-proxy (GitHub via Dex). See [[tech-traefik-forwardauth-oauth2-proxy]].
- chmonitor-scoped middleware stamps a **shared secret** header (`X-Chm-Proxy-Secret`); app trusts identity headers only when secret matches (`CHM_AUTH_PROVIDER=proxy` or `trusted` depending on image).
- Unauthenticated external hit → **302** to the auth portal is expected.

## Ops checklist

1. Confirm image is `ghcr.io/chmonitor/chmonitor:…` and pull/restart after new builds.
2. Confirm CH user can run `SELECT 1 SETTINGS max_execution_time = 60`.
3. Confirm `/api/healthz` reports host `up` and tables/overview APIs return full schema count.
4. Do not use public-demo connection limits as the model for homelab grants.

**Why:** future agents diagnose “chmonitor down” or “empty schemas” without mixing public SaaS and private cluster, and avoid the readonly-profile trap.
**How to apply:** when redeploying or debugging homelab chmonitor, check image org + CH profile first; grant schema via SQL privileges, not `readonly=1`.
