---
name: project-oma-output-file-opt-in
title: OMA output_file is opt-in declared deliverables
description: output_file is gated like browser tools; marks keep-this files as agent.output_declared for Console Artifacts
type: project
category: agents
tags: [project, oma, agents, console, artifacts]
aliases: [oma-output-file, oma-declared-outputs]
related: ["[[project-open-managed-agents]]", "[[project-oma-verify-skill]]"]
sources: ["https://github.com/duyet/oma", "https://oma.duyet.net"]
created: 2026-09-04
updated: 2026-09-04
timestamp: 2026-09-03T18:38:01Z
---

In [[project-open-managed-agents]], `output_file` is **not** a default-on write to `/mnt/session/outputs/`. It is an **opt-in** tool (same `configs` gate as `browser` / `run_dynamic_worker`) that marks a file as a session deliverable.

Enable via agent toolset config, e.g. `agent_toolset_20260401` with `{ "name": "output_file", "enabled": true }`. Declared files emit `agent.output_declared` into the session event log and surface in the Console Artifacts tab.

Marketing copy on https://oma.duyet.net names this under Building Blocks → Artifacts.

**Why:** Operators want intentional keep-this artifacts, not every sandbox write.
**How to apply:** Do not assume `output_file` is always present; check agent configs. Full Artifacts panel listing is a separate slice.
