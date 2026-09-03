---
name: project-oma-console-session-inject
title: OMA Console session Inject overlay
description: Operators inject prompts, MCP, tools, and vault credentials into a live session without mutating the agent
type: project
category: agents
tags: [project, oma, agents, console, sessions, inject, mcp, vault]
aliases: [oma-session-inject, oma-inject-panel]
related: ["[[project-open-managed-agents]]", "[[project-oma-verify-skill]]", "[[project-oma-session-env-secret-persist]]"]
sources: ["https://github.com/duyet/oma", "https://app.oma.duyet.net"]
created: 2026-09-04
updated: 2026-09-04
timestamp: 2026-09-03T19:41:30Z
---

In [[project-open-managed-agents]], operators can intervene in a **running session** via a session-scoped injection overlay (Console Inspector **Inject** tab).

- **Write:** `POST /v1/sessions/:id/injections` (canonical). `PATCH /v1/sessions/:id/tools` is a thin tool-toggle alias.
- **Read:** `GET /v1/sessions/:id/injections` returns the overlay (never tokens).
- **Storage:** `session.metadata._oma_injections` (stripped from public GET metadata). Not copied onto the agent; new sessions do not inherit.
- **Timing:** prompt append + tool overrides apply on the **next turn**; MCP mounts + credential binds on the **next proxy/outbound call**.
- **Credentials:** `credential_id` only, must already be in the session’s `vault_ids` (422 otherwise). Overlay/events/UI never carry tokens.
- **Audit:** `session.config_updated` is non-replayed (prompt body omitted; credential detail is host + id).

First slice of the broader Inject issue; tablet/mobile sheet, env/package injection, and undo stack are out of scope.

**Why:** Live ops without restarting or mutating the agent record.
**How to apply:** Prefer the Inject API/overlay for session-scoped changes; do not put tokens in metadata or expect agent inheritance. Drive verify with `console-inject`.
