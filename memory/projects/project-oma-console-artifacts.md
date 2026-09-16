---
name: project-oma-console-artifacts
title: oma Console session Artifacts panel
description: Session detail Inspector Artifacts tab aggregates writes, tool media, uploads, and session outputs from the event log
type: project
category: agents
tags: [project, oma, console, artifacts, agents]
aliases: [oma-artifacts-tab, oma-console-artifacts]
related: ["[[project-open-managed-agents]]", "[[project-oma-output-file-opt-in]]", "[[project-oma-verify-skill]]"]
sources: ["https://github.com/duyet/oma/pull/442", "https://oma.duyet.net", "https://docs.oma.duyet.net"]
created: 2026-09-17
updated: 2026-09-17
timestamp: 2026-09-16T19:05:00Z
---

Console **session detail** Inspector has a sixth tab, **Artifacts** (next to Overview / Usage / Tools / Sandbox / Files). Landed in duyet/oma #442; closes #340 (part of #347 Console UX).

Operators browse agent-produced files without scrolling the event log:

- Grid (default) and list views; source + extension filter chips
- Image thumbnails → lightbox; PDF iframe; text/code via existing `CodeBlock`
- Download for inline writes and `GET /v1/sessions/:id/outputs/:filename`
- Recomputes from the streamed event array — no extra polling or store

| Source | Extraction |
|---|---|
| `write` / `edit` / `output_file` tool_use | Path + `input.content` |
| `agent.tool_result` image/document blocks | `content[].source` (data URLs, file ids, media_type); `is_error` still shown |
| `user.message` attachments | Same I/O set as the chat transcript |
| Session outputs listing | Files tab endpoint; listing-only rows need ≥ 1 KB and a previewable type |

Declared deliverables from opt-in `output_file` (`agent.output_declared`) are covered by [[project-oma-output-file-opt-in]]. Out of scope for #442: shared `ResponsiveRail`, agent-declared contract beyond that opt-in (#341).

verify-oma Feature Map includes `console-session-artifacts` (signed-out gate + login heading; signed-in tab needs a real session cookie).

**Why:** Operators watching a session need a browsable artifact surface without a new storage layer.
**How to apply:** Point QA at signed-in session detail → Inspector **Artifacts**. Do not invent auth cookies for verify. Marketing Building Blocks → Artifacts on https://oma.duyet.net names this panel.

Hub: [[project-open-managed-agents]].
