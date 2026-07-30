---
name: tech-unit-suffix-vs-scale
title: BI display units never convert — pair suffix with explicit scale
description: A chart unit label ("km") is a display suffix only; conversion needs an explicit per-column multiplier, never inferred from the unit string; plus the impossible-60-minutes formatter diagnostic
type: tech
category: standards
tags: [tech, bi, charts, dashboards, formatting, data-viz]
aliases: []
related: []
sources: []
created: 2026-07-31
updated: 2026-07-31
timestamp: 2026-07-31T01:30:00Z
---

- A unit field on a chart config ("km", "L", "°C") must be a **display suffix only**. The
  frontend cannot know a column's source unit — "km" doesn't say whether the data is metres
  or already km — so conversion must be an **explicit per-column multiplier**
  (`columnScales: {distance: 0.001}`), never inferred from the suffix. Otherwise you render
  `853,020 km` for 853 km and the wrong number wears a correct-looking label.
- Apply the scale everywhere values render (KPI value, comparison values, axis ticks,
  tooltips), and only scale a shared axis when *every* series on it agrees — same rule as
  shared-axis unit labels.
- **Duration formatter diagnostic:** a display like `42:60:58` (60 in the minutes slot) is
  impossible for a correct formatter — it proves the minutes field is computed independently
  and *rounded* (`round(remainder/60)`) instead of floored. Test the hypothesis on a value
  whose remainder rounds *down*: it should match the correct rendering exactly. Sisense
  number masks with `decimals: 0` round to nearest — combined with per-slot MOD formulas
  this produces the bug.
