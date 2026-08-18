---
name: tech-digest-local-date
title: Daily digest keys must use the audience timezone
description: A UTC-dated snapshot can miss the local calendar day so the daily digest looks up null and never sends
type: tech
category: workflow
tags: [tech, workflow, timezone, notifications]
related: ["[[project-news]]", "[[tech-workflows-binding-schedules]]"]
created: 2026-08-18
updated: 2026-08-18
timestamp: 2026-08-18T16:00:00Z
---

Key a once-per-local-day digest by the audience timezone date, not UTC. If the snapshot row uses UTC and the sender looks up local date, the lookup is null around midnight and the channel never posts.

If the LLM step that writes the snapshot fails, persist a non-invented fallback (e.g. existing titles) so the send path still has a row. Related: [[project-news]].
