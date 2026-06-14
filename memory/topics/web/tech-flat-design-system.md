---
name: tech-flat-design-system
title: Flat editorial design system
description: duyet.net design rules — hairline borders not shadows, lucide icons, shadcn + semantic tokens, minimal token layer, dark mode
type: tech
category: design
tags: [tech, design, css, tokens, shadcn]
related: ["[[project-duyet-net]]", "[[project-llm-timeline]]", "[[tech-tanstack-start-ssg]]"]
sources: ["https://kb.duyet.net/llms.txt"]
created: 2026-06-04
updated: 2026-06-04
timestamp: 2026-06-04T00:00:00Z
---

Flat editorial visual language across [[project-duyet-net]] (xAI-style reference,
set 2026-05-25). [[project-llm-timeline]] PR #1003 is the reference implementation.

**Flat rules:** hairline 1px border (`var(--hairline)`) is the only elevation cue.
No `shadow-*`, no glow, no `rounded-2xl` (use `rounded-none`/`rounded-md`). Hover
= background tint (`var(--faint)`), not shadow. Divider grid: `gap-px
bg-[var(--hairline)]` container with `bg-[var(--background)]` cells.

**Tokens (3 additive CSS layers in `packages/components/styles.css`):** base
(Tailwind v4 `@theme`) → warm (`#fbf7f0 / #1f1f1f`) → minimal (`--minimal-*` +
utilities `.pill-outline`, `.eyebrow-mono`, `.display-tight`). shadcn primitives
(badge/button/input/card, CVA + radix slot) use semantic tokens (`bg-card`,
`text-foreground`, `border-border`) — zero hardcoded `neutral-*`/`dark:`.

**Icons:** `lucide-react` everywhere (drop `weight` prop); migrate
`@phosphor-icons/react` when touching a file. **Dark mode:** card tints
`dark:bg-{color}/20`; badges invert shade pair; blog uses white `#ffffff` bg
(distinct editorial identity) over the warm cream others use.
