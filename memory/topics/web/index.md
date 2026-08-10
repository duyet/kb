# `topics/web/`

## Concepts

- [Build-time OG images](tech-og-images-build-time.md) — Generate OG cards at build from one registry shared by generator and route head
- [createContext breaks RSC importers](tech-kumo-rsc-createcontext.md) — Libraries that call createContext at module scope force client boundaries
- [OG meta must be prerendered](tech-og-meta-in-prerender.md) — Social crawlers need Open Graph tags in static HTML, not only client head
- [Semantic design tokens](tech-flat-design-semantic-tokens.md) — Use semantic tokens (bg-card, foreground) not ad-hoc color utilities
- [shadcn/ui base components](tech-shadcn-base.md) — shadcn + CVA + slot pattern as default React component base
- [Stale route chunks after deploy](tech-tanstack-stale-chunks.md) — Missing lazy chunks throw reading 'component'; add reload guard + prerender shells
- [TanStack Start SSG](tech-tanstack-start-ssg.md) — Prerender Vite/TanStack apps to static HTML for crawlers and edge hosts
- [tech-flat-design-hairline](tech-flat-design-hairline.md)
- [tech-rust-wasm-when](tech-rust-wasm-when.md)
- [WASM prerender CI trap](tech-wasm-prerender-ci.md) — Missing wasm build step makes prerender succeed empty or fail late
