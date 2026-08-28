---
name: project-monorepo
title: duyet/monorepo
description: Public Bun+Turborepo for personal duyet.net web apps including news and the kb site
type: project
category: web
tags: [project, duyet, web]
related: ["[[project-llm-timeline]]", "[[project-duyetbot]]", "[[project-kb-site]]", "[[project-news]]", "[[tech-tanstack-start-ssg]]"]
sources: ["https://github.com/duyet/monorepo"]
created: 2026-08-10
updated: 2026-08-28
timestamp: 2026-08-28T08:42:29Z
---

github.com/duyet/monorepo — public web monorepo (blog, CV, timeline apps, kb site, news, shared packages).

Stack: Bun, Turborepo, TanStack Start SSG, Cloudflare Pages / Workers.
`apps/kb` is the renderer for [[project-kb]] / [[project-kb-site]].
`apps/news` is [[project-news]] (news.duyet.net).
`apps/news-tab` is the unpacked Chrome new-tab client for that feed (Load unpacked; not on Pages/Workers). Separate release-please component (#1406): own changelog, 0.1.x, `news-tab-v*` tags — not folded into the root `duyet` release. Leave its release-please PR unmerged ([[feedback-never-auto-merge-release-please]]).
Related: [[project-llm-timeline]], [[project-duyetbot]], [[tech-tanstack-start-ssg]], [[tech-flat-design-hairline]].
