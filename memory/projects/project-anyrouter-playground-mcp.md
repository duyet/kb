---
name: project-anyrouter-playground-mcp
title: AnyRouter playground MCP
description: Playground new chats enable AnyRouter MCP at the documented HTTP endpoint
type: project
category: llm
tags: [project, anyrouter, mcp, playground]
aliases: [anyrouter-playground-mcp]
related: ["[[project-anyrouter]]", "[[project-anyrouter-ui-chrome]]"]
sources: ["https://docs.anyrouter.dev/mcp", "https://anyrouter.dev/playground"]
created: 2026-08-26
updated: 2026-08-27
timestamp: 2026-08-26T17:30:00Z
---

AnyRouter playground (`https://anyrouter.dev/playground`) attaches remote HTTP MCP servers. A new conversation already has **AnyRouter MCP enabled**.

- Default endpoint (from live docs, do not invent): `https://anyrouter.dev/api/v1/mcp`
- Transport: remote HTTP / Streamable HTTP. No stdio.
- Users can disable the default (row stays listed) and add more HTTPS MCP servers.
- Intended auth: a signed-in Clerk session is enough (`POST /api/v1/mcp` kind `session`). Pasted `sk-ar-v1-*` / `ak_*` is an optional override. Signed-out 401 still asks to sign in or add a key. Live 2026-08-27 still showed the red key line + empty tools while signed in (leftover of #2751). Do not invent tools, auth, or prices.

Hub: [[project-anyrouter]]. Chrome: [[project-anyrouter-ui-chrome]].

**Why:** playground chat needs catalog/keys/credits tools without leaving the conversation.
**How to apply:** default-on the documented URL; never invent a second MCP endpoint or tool list.
