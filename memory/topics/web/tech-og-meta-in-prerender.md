---
name: tech-og-meta-in-prerender
title: OG meta must be prerendered
description: Social crawlers need Open Graph tags in static HTML, not only client head
type: tech
category: web
tags: [tech, web, seo, ssg]
related: ["[[tech-og-images-build-time]]", "[[tech-tanstack-start-ssg]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Put OG/Twitter meta into prerendered HTML. Client-only `useEffect` head injection is invisible to most crawlers.

Related: [[tech-og-images-build-time]], [[tech-tanstack-start-ssg]].
