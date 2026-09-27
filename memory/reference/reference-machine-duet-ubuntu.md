---
name: reference-machine-duet-ubuntu
title: Dev machine duet-ubuntu and local repos
description: "Primary Linux workstation (duet-ubuntu) — OS, Herdr workspaces, local repo checkout paths, and which credentials are stale"
type: reference
category: reference
tags: [reference, machine, homelab, herdr, ubuntu]
related: ["[[project-news]]", "[[reference-duyet-github]]", "[[projects/homelab/index]]"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T01:40:00Z
---

# Dev machine: `duet-ubuntu`

Primary Linux workstation. Confirmed 2026-09-27.

## Machine

- hostname `duet-ubuntu` (FQDN same), user `duyet`
- Ubuntu 24.04.4 LTS, kernel 6.8.0-138, x86_64
- uptime at capture: 3 weeks

## Herdr

Terminal multiplexer; agents run in panes. Every control command requires
`HERDR_ENV=1` or it must be refused. `herdr` v0.9.0.

- Workspaces are labelled per repo; the repo path is the workspace
  `worktree.checkout_path`, so a repo can be found by path rather than label.
- `herdr plugin action invoke <plugin>.<action>` resolves the **focused**
  workspace, not the caller's cwd. A `status`-style action invoked from repo A
  can therefore report repo B.

## Local repos

| Repo | Path |
|---|---|
| aidr | `/home/duyet/project/aidr` |
| herdr-desk | `/home/duyet/project/herdr-desk` |
| chmonitor | `/home/duyet/project/chmonitor` |
| monorepo | `/home/duyet/project/monorepo` |
| anyrouter | `/home/duyet/project/anyrouter-dev/anyrouter` |

Herdr worktrees live under `/home/duyet/.herdr/worktrees/<repo>/<branch>`.

## Stale credentials (as of 2026-09-27)

Every one of these was valid once and now fails; do not trust them without
re-probing:

- `CLOUDFLARE_API_TOKEN` — Cloudflare `1000 Invalid API Token`. Blocks local
  `pnpm sync-env --workers` and `wrangler deploy`. **GitHub Actions still
  deploys fine**, so the copy in repo secrets is good — only the local one is
  dead. Symptom: `wrangler whoami` → `9109 Invalid access token`.
- `CLERK_SECRET_KEY` (in `aidr/.env.local`) — was `401` from `api.clerk.com`
  after being rotated.
- `NEWS_ADMIN_TOKEN` (in `aidr/.env.local`) — no longer matches the Worker's
  copy, so `POST /api/admin/clerk-sync` returns `{"error":"unauthorized"}`.
- `TELEGRAM_BOT_TOKEN` (in `aidr/.env.local`) — well-formed but revoked;
  `getMe` returns `401`.

Lesson: on this box, verify a credential against its provider before assuming a
command failed for another reason. See `aidr`'s `.cursor/skills/aidr-ops`
(`preflight`) which automates exactly these checks.

## Secrets tooling

- `scripts/sync-env.ts` spawns wrangler with `env: process.env`, so a token that
  lives only in `.env.local` never reaches it. Unfixed upstream.
- `herdr-desk` gained a host-level `notify.json`
  (`~/.config/herdr/plugins/herdr-desk/`) for Telegram, deliberately outside
  any repo so tokens are never committed.
