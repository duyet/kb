---
name: tech-improvement-loop
title: Autonomous improvement loop
description: One issue per cycle with full verify before next
type: tech
category: workflow
tags: [tech, workflow, agents]
related: ["[[project-duyetbot]]", "[[tech-cloudflare-pages-deploy]]", "[[tech-codebase-maintenance-loop]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Loop: pick highest priority → implement → lint/test/build → commit → deploy → log.

Persona: [[project-duyetbot]]. Deploy: [[tech-cloudflare-pages-deploy]]. Cheap fan-out: [[feedback-cheap-models-subagents]].
