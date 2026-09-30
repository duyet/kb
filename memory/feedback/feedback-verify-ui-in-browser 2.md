---
name: feedback-verify-ui-in-browser
title: Verify UI work in a real browser, not by reading the diff
description: Markup/CSS/JS bugs stay invisible in review — measure the rendered page before claiming done
type: feedback
category: style
tags: [feedback, ui, testing, verification]
related: ["[[feedback-fail-loud]]", "[[feedback-logic-change-update-tests]]", "[[feedback-simple-code]]"]
created: 2026-09-29
updated: 2026-09-29
timestamp: 2026-09-29T00:00:00Z
---

Render the page in a real browser and measure computed styles/geometry before
calling UI work done. Assert the *why* in tests, not the markup.

**Why:** on a UI audit, three defects passed code review, a green test suite,
and a clean read of the diff — all only visible in the rendered page:
- a container reused two classes (`.wrap .topbar-in`), silently inheriting
  72px padding and inflating a nav bar from 52px to 113px
- a `<button>` missing its class fell back to the UA default grey, so the
  primary CTA was unstyled
- a control built in JS with one class instead of two got 18px instead of a
  40px hit area
Also: a slow/mocked `fetch` in the test harness is what proved a double click
fired two mutating POSTs. `color-mix`, `overflow-x`, and focus rings look right
in source and fail silently.

**How to apply:** open the page, then read back `getBoundingClientRect()` and
`getComputedStyle()` for hit areas, background, and contrast; compute WCAG ratios
in-page rather than eyeballing greys; test at ~360px for overflow; mock `fetch`
and count *requests*, not UI states. Fix the defect's cause in CSS, not its
symptom in one call site, so every instance is covered.
