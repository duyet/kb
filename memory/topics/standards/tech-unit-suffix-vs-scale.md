---
name: tech-unit-suffix-vs-scale
title: Chart unit suffix ≠ scale
description: Display unit labels must not silently convert values; pair with explicit multiplier
type: tech
category: standards
tags: [tech, standards, charts, ui]
related: ["[[tech-flat-design-semantic-tokens]]", "[[feedback-fail-loud]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

If a formatter shows `min`/`h`/`ms`, it must not convert magnitudes unless the multiplier is explicit.

Smell: values that can never reach "60 minutes" if unit is wrong. Related: [[tech-flat-design-semantic-tokens]].
