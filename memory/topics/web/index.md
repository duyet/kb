# `topics/web/`

## Concepts

- [Cloudflare Kumo UI + Next.js integration gotchas](tech-kumo-ui-nextjs-integration.md) — Kumo (base-ui) + Phosphor crash RSC pre-render via createContext — every importer must be "use client"; plus Button/Tabs/Chart/Sidebar API differences
- [Flat editorial design system](tech-flat-design-system.md) — duyet.net design rules — hairline borders not shadows, lucide icons, shadcn + semantic tokens, minimal token layer, dark mode
- [Per-page OG images in a static-prerendered app](tech-og-images-static-prerender.md) — Build-time Open Graph cards from one registry feeding both the generator and the route head; meta must be in prerendered HTML for crawlers
- [Rust→WASM strategy + prerender CI trap](tech-rust-wasm-prerender.md) — When WASM beats TS (>1ms compute only), and the silent-prerender CI trap when the gitignored WASM binary is missing
- [TanStack Router stale lazy route chunks](tech-tanstack-stale-route-chunks.md) — After Vite hash rotation, missing lazy chunks surface as reading 'component' — reload guard + prerender marketing shells
- [TanStack Start SSG (Cloudflare)](tech-tanstack-start-ssg.md) — Why + how to prerender a Vite app with TanStack Start SSG to survive Cloudflare Rocket Loader
