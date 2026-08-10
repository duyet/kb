---
name: tech-kumo-rsc-createcontext
title: createContext breaks RSC importers
description: Libraries that call createContext at module scope force client boundaries
type: tech
category: web
tags: [tech, web, react]
related: ["[[tech-shadcn-base]]", "[[user-duyet-lang-typescript]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

If a UI kit uses `createContext` at import time, every importer may need `"use client"` (RSC).

Prefer kits that stay server-safe or isolate client entrypoints. Related: [[tech-shadcn-base]].
