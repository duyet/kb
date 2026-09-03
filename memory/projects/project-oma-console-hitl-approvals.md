---
name: project-oma-console-hitl-approvals
title: OMA Console HITL approvals and notice bell
description: Console posts user.tool_confirmation from ApprovalCard; session cards + notice bell for mobile-compact HITL
type: project
category: agents
tags: [project, oma, console, hitl, mobile]
aliases: [oma-hitl, oma-tool-confirmation]
related: ["[[project-open-managed-agents]]", "[[project-oma-console-monitor]]", "[[project-oma-verify-skill]]"]
sources: ["https://github.com/duyet/oma", "https://app.oma.duyet.net"]
created: 2026-09-04
updated: 2026-09-04
timestamp: 2026-09-03T18:33:55Z
---

In [[project-open-managed-agents]] Console, `always_ask` tool calls are approved from an `ApprovalCard` pinned above the session composer. Deny / Approve POST `user.tool_confirmation`. "Don't ask again this session" writes an `oma.hitl.allow:<session>` policy.

Also shipped in the same slice: compact session cards and a notice bell for pending approvals — usable on phone without Web Push.

**Why:** Operators could not approve HITL from mobile; Console never POSTed tool confirmation.
**How to apply:** Recert signed-in session with a pending always_ask tool; expect ApprovalCard + notice. Out of scope: agent `default_tool_policy`, timeout auto-deny, CLI HITL.
