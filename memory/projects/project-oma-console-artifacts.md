---
name: project-oma-console-artifacts
title: OMA Console Artifacts Inspector tab
description: Session detail Inspector Artifacts tab aggregates writes, tool-result media, uploads, and session outputs from the event log
type: project
category: agents
tags: [project, oma, console, artifacts, inspector]
aliases: [oma-console-artifacts, oma-artifacts-tab]
related: ["[[project-open-managed-agents]]", "[[project-oma-output-file-opt-in]]", "[[project-oma-verify-skill]]"]
sources: ["https://github.com/duyet/oma/pull/442", "https://oma.duyet.net"]
created: 2026-09-17
updated: 2026-09-17
timestamp: 2026-09-16T19:05:00Z
---

In [[project-open-managed-agents]], Console session detail has an **Artifacts** Inspector tab (alongside Overview / Usage / Tools / Sandbox / Files). Shipped in duyet/oma #442.

Derivation is client-side from the streamed event array plus the session outputs listing — no extra store or polling:

| Source | What surfaces |
|---|---|
| `write` / `edit` / `output_file` tool_use | Path + content |
| `agent.tool_result` image/document blocks | data URLs / file ids / media_type |
| `user.message` attachments | Same set as the chat transcript |
| Session outputs listing | Listing-only rows need ≥ 1 KB and a previewable type |

Grid/list views, source + extension filters, image lightbox, PDF iframe, text via `CodeBlock`, download for inline writes and `GET /v1/sessions/:id/outputs/:filename`. Declared deliverables via opt-in `output_file` are covered in [[project-oma-output-file-opt-in]] (#341 contract still separate).

**Why:** Operators need to browse agent-produced files without scrolling the event log.
**How to apply:** QA on a signed-in session detail → Artifacts tab. Do not invent auth secrets for verify; gate checks can assert redirect to `/login`.
