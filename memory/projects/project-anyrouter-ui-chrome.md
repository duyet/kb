---
name: project-anyrouter-ui-chrome
title: AnyRouter public UI chrome
description: Viewport tokens, 44px targets, semantic dark, compact playground row
type: project
category: llm
tags: [project, anyrouter, ui, web]
related: ["[[project-anyrouter]]", "[[tech-flat-design-semantic-tokens]]", "[[tech-shadcn-base]]"]
sources: ["https://anyrouter.dev", "https://docs.anyrouter.dev"]
created: 2026-08-18
updated: 2026-08-18
timestamp: 2026-08-18T17:00:00Z
---

AnyRouter public UI uses one viewport token system: 320 / 375 / 768 / 1024 / 1280. Mobile-first. No `overflow-x` on the page.

- Tap targets: 44px. Marketing CTAs keep visible labels (do not go icon-only). Vietnamese copy is fine.
- Color: semantic tokens only (`background`, `foreground`, `border`, `muted`). No raw hex that breaks dark. Test light and dark. Avoid a white flash.
- Skeletons match the final layout. Do not block first paint on a hung Clerk FAPI.
- Playground compact chrome is one 44px row at 375; extra actions go in More.
- Dashboard sidebar overlays below `lg` and must not crush content. No extra polling. No layout shift from late font/nav.

Hub: [[project-anyrouter]]. Tokens: [[tech-flat-design-semantic-tokens]]. Components: [[tech-shadcn-base]].

**Why:** live QA found icon-only CTAs, stacked playground chrome, and a sidebar that squeezed content on phones.
**How to apply:** design and test at those five widths; keep labels; overflow into More instead of a second toolbar.
