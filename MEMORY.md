# Memory Index

Master table of contents. One line per note — read this first, then open only
the notes relevant to your task. See `AGENTS.md` for the protocol.

## User
- [Duyet Le profile](memory/user-duyet-profile.md) — senior data engineer (VN), owner of this brain
- [Tech stack](memory/user-duyet-stack.md) — Rust/Python/TS/SQL, ClickHouse, K8s, data + LLM agents
- [AI & coding-agent stance](memory/user-duyet-ai-stance.md) — vibe-codes prod, Claude Code daily driver, agent SDKs

## Feedback
- [Working style](memory/feedback-working-style.md) — concise English, simple code, semantic commits
- [Docs-Driven Development](memory/feedback-docs-driven-development.md) — tiny router + kb brain, auto read-in/write-out
- [Cheap models for sub-agents](memory/feedback-cheap-models-subagents.md) — default fan-out agents to Sonnet/Haiku, not Opus, to control cost

## Reference
- [Web presence](memory/user-duyet-web-presence.md) — blog/CV/GitHub/socials + llms.txt sources
- [Blog content & themes](memory/reference-duyet-blog.md) — digital garden: ClickHouse, Rust, AI agents, data eng
- [GitHub projects](memory/reference-duyet-github.md) — ClickHouse tooling, Rust data tools, AI-agent repos, infra

## Project
- [duyet.net monorepo](memory/project-duyet-net.md) — Bun + Turborepo, ~9 apps, TanStack Start SSG on Cloudflare Pages
- [duyetbot](memory/project-duyetbot.md) — autonomous agent maintaining the monorepo: scope, loop, memory hierarchy
- [LLM Timeline app](memory/project-llm-timeline.md) — 3700+ SSG pages, shadcn UI, dual data sources (1950–2026)
- [kb.duyet.net](memory/project-kb-duyet-net.md) — public KB site migrating from monorepo app to this shared-brain repo
- [Infra optimization baseline](memory/project-infra-optimization.md) — k3s resource tuning, security hardening, host cleanup (2026-06-13)
- [Self-driving homelab](memory/project-self-driven-homelab.md) — AI agent (Minh/Hermes) manages its own k3s cluster via Telegram

## Tech
- [AI agent stack](memory/tech-ai-agent-stack.md) — LangGraph/AI SDK/Agents SDK/MCP + what Duyet uses
- [TanStack Start SSG](memory/tech-tanstack-start-ssg.md) — prerender Vite app to survive CF Rocket Loader; migration recipe
- [Rust→WASM strategy](memory/tech-rust-wasm-prerender.md) — WASM only beats TS >1ms; the silent-prerender CI trap
- [Flat design system](memory/tech-flat-design-system.md) — hairline borders, lucide, shadcn + semantic tokens, dark mode
- [Cloudflare Pages deploy](memory/tech-cloudflare-pages-deploy.md) — commit→push→background-deploy; parallel-deploy hazard
- [Codebase maintenance loop](memory/tech-codebase-maintenance-loop.md) — improvement cycles, safe dead-code removal, tests
- [Cloudflare AI Gateway proxy](memory/tech-cloudflare-ai-gateway-proxy.md) — AIG doesn't validate model ids; "invalid model ID" is the upstream rejecting, not CF
- [Traefik forwardAuth + OAuth2 Proxy](memory/tech-traefik-forwardauth-oauth2-proxy.md) — ErrorPages keeps original status, need nginx redirector for 302
- [Hermes agent custom provider](memory/tech-hermes-agent-custom-provider.md) — custom_providers registration, provider:custom, steer mode
