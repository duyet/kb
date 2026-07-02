---
name: tech-oma-k3s-deploy
title: Open Managed Agents (OMA) on k3s via ArgoCD
description: Deploy + use OMA (self-hosted Claude Managed Agents) on a k3s cluster via ArgoCD; BYOK model card → AnyRouter; spawn an agent over /v1
type: project
category: homelab
tags: [homelab, k3s, argocd, oma, open-managed-agents, agents, anyrouter, kubernetes]
aliases: [openma, open-managed-agents]
related: ["[[tech-hermes-agent-custom-provider]]", "[[chmonitor-one-codebase-saas]]"]
sources: ["https://openma.dev", "https://docs.openma.dev", "https://github.com/openma-ai/open-managed-agents"]
created: 2026-07-02
updated: 2026-07-02
timestamp: 2026-07-02T00:00:00Z
---

**What OMA is:** self-hosted Claude Managed Agents API (Anthropic-compatible `/v1/agents` + `/v1/sessions`) with sessions, sandboxes, tools, memory, integrations, crash recovery. Node self-host (sqlite/postgres + FS) or Cloudflare (D1/KV/R2). **For k8s use the Node self-host path.**

## Deploy on k3s via ArgoCD (Node self-host)
- If the cluster already runs ArgoCD with an app-of-apps, add OMA as a new `Application` matching that repo layout; commit+push manifests so Argo syncs. Namespace-isolate as `oma`.
- Workloads: `main-node` (API + Console) + `oma-vault`, plus postgres (or sqlite on a PVC). Images `openma/main-node` / `openma/oma-vault` — confirm they're published; if dev-only, build from the compose `build:` Dockerfiles and push to a registry the cluster can pull (or `k3s ctr images import` on-node).
- Reuse the cluster's existing cert-manager + ingress convention to expose it rather than inventing one.

## Required secrets (k8s Secret — never commit to git)
- `ANTHROPIC_API_KEY` — any Anthropic-compatible key (an AnyRouter key works).
- `ANTHROPIC_BASE_URL` — optional proxy base, e.g. `https://anyrouter.dev/api/v1` (SDK appends `/messages`).
- `BETTER_AUTH_SECRET` = `openssl rand -hex 32` (signs Console sessions).
- `PLATFORM_ROOT_SECRET` = `openssl rand -base64 32` (at-rest encryption). **Back it up** — lose it and every encrypted row (credentials, model-card keys) is unreadable.

## Use it — spawn an agent (AnyRouter as the model plane)
Anthropic-compatible; auth via `x-api-key`. Route models through AnyRouter with a BYOK **model card** (no code change):
1. `POST /v1/model_cards` with `provider:"oai-compatible"`, `base_url:"https://anyrouter.dev/api/v1"`, `model:"stepfun-ai/step-3.7-flash"`, and the AnyRouter key as the card credential — the card's `base_url` overrides upstream and custom headers propagate.
2. `POST /v1/agents` — create the agent (OMA-specific fields like `harness`/`runtime_binding` nest under `_oma:` so stock Anthropic SDKs ignore them).
3. `POST /v1/sessions`, then post a message → SSE stream of the turn. That spawns the agent run.

## Verified run flow + gotchas (node self-host)
Order that actually works against a live node self-host:
1. **Bootstrap a user** — no default admin; email/password signup requires verification but self-host has no SMTP (`sendEmail` no-ops when `SEND_EMAIL` unset — the code isn't even logged). Seed one: POST `/auth/sign-up/email`, then set `emailVerified=1` in `/app/data/auth.db` (`node:sqlite`, table `user`). Then sign-in works.
2. **Mint an API key** — POST `/v1/api_keys` with the better-auth session cookie → returns an `oma_…` key once. Use it as `x-api-key` for `/v1/*`.
3. **Create agent** — POST `/v1/agents` `{name,model,system,tools}`; OMA-only fields nest under `_oma:` (e.g. `runtime_binding`).
4. **Create session** — body field is **`agent`** (not `agent_id`, despite older self-host.md), and a non-local-runtime agent needs **`environment_id`** — main-node accepts ANY id (returns a synthetic local-runtime env), e.g. `"env-local-runtime"`.
5. **Drive** — POST `/v1/sessions/:id/events` `{events:[{type:"user.message",content:[{type:"text",text:"…"}]}]}`; read `/v1/sessions/:id/trajectory` or `/events/stream`.

Bugs / friction found — root-caused live (the running pod serves **`apps/main-node`** from source via `tsx`, NOT the full `apps/main` Hono app):
- **Model cards write-path is UNIMPLEMENTED in the Node self-host.** `main-node/src/index.ts` only registers a read stub `v1.get("/model_cards", c => c.json({data:[]}))` — no POST/PUT/DELETE, no `ModelCardsService`, likely no `model_cards` table. So `POST /v1/model_cards` matches nothing and falls through to that app's global `app.notFound → {"error":"not found"}` (404). (Earlier theory that a routing-order/integrations bug swallowed it was WRONG — it's just an unported feature. Integrations are stubbed the same way: `v1.get("/integrations/*/credentials")` only.) Registering BYOK oai-compatible / free models therefore needs the feature built, not a route reorder.
- **Uncapped output tokens → BYOK 502.** Harness `streamText` (default-loop.ts:408) sets no `maxOutputTokens` → SDK default **4096**. When AnyRouter routes to an **openrouter-byok** upstream (bills the user's OpenRouter account, NOT AnyRouter's own credit balance), it rejects when the *requested* max exceeds the affordable budget — surfaces in OMA as `finish_reason:"error", "Failed after 3 attempts. Last error: Bad Gateway"` after 3 retries. **Confirmed:** same in-pod key + model at `max_tokens:16` → HTTP 200; at 4096 (OMA default) → 502. Note AnyRouter `monthly_balance` (e.g. $162) does NOT cover BYOK upstreams — BYOK bills elsewhere. **Fix shipped:** PR #4 `duyet/open-managed-agents` adds opt-in `OMA_MAX_OUTPUT_TOKENS` env cap; set it (e.g. `1024`) in the OMA ConfigMap for BYOK/low-budget self-hosts. Alternative: turn off BYOK so requests bill AnyRouter credit.
- Default provider uses AnyRouter's Anthropic-native `/messages` → only `anthropic/*` model ids route cleanly; non-anthropic ids get their `provider/` prefix mangled. Reaching free `/chat/completions` models needs the (unimplemented) model-cards write-path above.

## Flue / sandbox interop
- The real harness contract is a class `implements HarnessInterface` (`apps/agent/src/harness/interface.ts`), NOT the README's unimplemented `defineHarness`. Register with `registerHarness("name", …)`; mirror the `AcpProxyHarness` meta-harness pattern to embed another framework's loop.
- Sandbox port `SandboxExecutor.exec` returns a **string** with an `[exit N]` suffix (not structured) — parse it when adapting to a framework that wants `{stdout,stderr,exitCode}`. Adapters live in `packages/sandbox/src/adapters/`.
- k8s agent code-exec sandboxes: the kubernetes-sigs **agent-sandbox** CRD (Sandbox/SandboxWarmPool/SandboxClaim) is the standard building block; pair with gVisor/Kata for untrusted-code isolation.
