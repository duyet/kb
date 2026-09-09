---
name: project-oma-home-session
title: oma home session and home runtime
description: Agent has one durable home inbox plus paired long-lived home runtime; ephemeral sandboxes stay separate
type: project
category: agents
tags: [project, oma, sessions, runtime]
aliases: [oma-home, home-session]
related: ["[[project-open-managed-agents]]", "[[project-oma-verify-skill]]", "[[project-oma-console-monitor]]"]
sources: ["https://github.com/duyet/oma", "https://oma.duyet.net"]
created: 2026-09-09
updated: 2026-09-09
timestamp: 2026-09-09T07:01:00Z
---

Product shape shipped in duyet/oma #464 (issues #460–#463): **Agent** is the noun. Each Agent may have one **home session** (metadata `home: true`, title `Home`) — a Bot-like durable inbox. Extra sessions stay ephemeral.

**API:** `POST /v1/sessions/home` get-or-create; `GET /v1/sessions/home?agent_id=`; `POST /v1/sessions` with `metadata.home: true` reuses the same row. Responses include paired **runtime** presence from `/v1/runtimes` heartbeats (`online` | `offline` | `provisioning`; ~90s stale → offline).

**Runtime vs sandbox:** Home runtime = long-lived bridge/herdr (OpenShell optional). Session sandboxes stay ephemeral. CLI relay bootstraps only — not an always-on shared VM.

**Surfaces:** Landing H1 “Your Agent has a computer — and a durable inbox”; Console Overview home strip + open sessions; AgentHealthStrip presence + inbox link; Agent detail **Open home**. Design RFCs live in repo `docs/home-session.md` (not Starlight `apps/docs`).

**Why:** Matches Grok Bot-like pinned inbox without turning every turn into a shared VM.
**How to apply:** Drive landing-home via verify-oma; signed-in Console Overview/home strip needs a real operator session — no invented secrets. Hub: [[project-open-managed-agents]].
