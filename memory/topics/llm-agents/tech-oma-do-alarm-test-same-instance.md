---
name: tech-oma-do-alarm-test-same-instance
title: oma DO alarm tests must call alarm() in the same runInDurableObject
description: Planting setAlarm spies then firing via runDurableObjectAlarm reincarnates the DO and empties the spy
type: tech
category: agents
tags: [tech, oma, durable-objects, testing, vitest]
aliases: [oma-recovery-do-alarm-rearm, oma-do-alarm-reincarnation]
related: ["[[project-open-managed-agents]]"]
sources: ["https://github.com/duyet/oma/pull/482", "https://github.com/duyet/oma/issues/480"]
created: 2026-10-02
updated: 2026-10-02
timestamp: 2026-10-02T11:55:00Z
---

Cloudflare vitest helpers can reconstruct a Durable Object between `runInDurableObject` and a later `runDurableObjectAlarm`. In-memory spies (`setAlarm`/`deleteAlarm`) and `_activeTurnIds` planted in the first entry point are gone on the second — so `setAlarmInside.length === 0` even when production `_scheduleNextAlarm` is correct (CI symptom on tip after #478/#479).

**How to apply:** Drive `alarm()` **inside** the same `runInDurableObject` callback that plants spies/state (idiom already used by `_finalizeStaleTurns` tests). Prefer asserting the durable slot via `getAlarm()` when reincarnation would invalidate spies. Shipped test-only #482 tip `8146e717` (closes #480); production merge path unchanged. Leave RP alone; no runtime QA.
