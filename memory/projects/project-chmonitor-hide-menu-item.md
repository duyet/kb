---
name: project-chmonitor-hide-menu-item
title: chmonitor hide sidebar pages in place
description: Hover Hide next to pin hides a sidebar leaf; restore in Settings → Workspace → Navigation
type: project
category: clickhouse
tags: [project, chmonitor, clickhouse, ui]
related: ["[[project-clickhouse-monitoring]]", "[[project-chmonitor-menu-engine-filter]]", "[[project-chmonitor-tools-sidebar]]"]
sources: ["https://github.com/chmonitor/chmonitor", "https://docs.chmonitor.dev"]
created: 2026-08-19
updated: 2026-08-19
timestamp: 2026-08-19T12:10:00+07:00
---

Sidebar leaf items (with an href) can be hidden **in the menu**, without opening Settings first.

- Hover reveals **Hide** (EyeOff) next to **Pin**. Click does not navigate.
- Persist via `hiddenMenuHrefs` / Custom workspace (`hideMenuHref` / `showMenuHref`).
- Toast: `{title} hidden from the menu` / `Bring it back in Settings → Workspace → Navigation.` Actions: **Undo** and **Open Navigation**.
- Settings gear / ⌘, still open General; the toast opens the **navigation** tab.
- Footer About is not hideable. Engine filter still applies ([[project-chmonitor-menu-engine-filter]]).

Hub: [[project-clickhouse-monitoring]].

**Why:** hide/show used to live only in Settings → Workspace → Navigation.
**How to apply:** add hide only on leaves with href; restore path is always Settings → Workspace → Navigation; do not invent a second hide store.
