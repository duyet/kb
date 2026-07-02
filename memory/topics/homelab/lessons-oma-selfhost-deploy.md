---
name: lessons-oma-selfhost-deploy
title: Lessons — building, deploying & debugging OMA (Open Managed Agents) self-host
description: Hard-won lessons from taking OMA live on k3s via ArgoCD — self-host feature gaps, the BYOK max-tokens trap, pnpm v11 strictDepBuilds CI break, and GitOps propagation gotchas
type: project
category: homelab
tags: [homelab, k3s, argocd, oma, open-managed-agents, byok, anyrouter, pnpm, docker, ci, lessons]
aliases: [oma-lessons, oma-debug]
related: ["[[tech-oma-k3s-deploy]]", "[[tech-flue-provider-registration]]"]
sources: ["https://github.com/duyet/open-managed-agents", "https://github.com/duyet/infra"]
created: 2026-07-03
updated: 2026-07-03
timestamp: 2026-07-03T00:00:00Z
---

Companion to [[tech-oma-k3s-deploy]] (the how-to). This is the **what-bit-us** list, in the order it bit.

## 1. The self-host binary is a DIFFERENT app than the docs imply
The Cloudflare/full build is `apps/main`; the Node self-host is `apps/main-node`, a *separately assembled* Hono app that mounts routes one-by-one. It runs from **source** via `tsx src/index.ts` (no bundle) — so you can read the exact live routing with `kubectl exec ... grep app.route /app/apps/main-node/src/index.ts`. Several `apps/main` features are only **stubbed** in main-node:
- `GET /v1/model_cards` → hardcoded `{data:[]}`; **no POST/PUT/DELETE, no ModelCardsService, no table**. So BYOK model cards can't be created on self-host at all.
- `GET /v1/integrations/*/credentials` → `{data:[]}` stubs.
Lesson: when a self-host endpoint 404s or returns empty, **read the actually-listening app's source**, don't assume the documented/full-build behavior. A 404 with `{"error":"not found"}` was the app's global `app.notFound`, not a routing-order bug — I initially mis-diagnosed it as the latter.

## 2. BYOK + uncapped max_tokens = every turn 502s
Symptom: agent runs fail `finish_reason:"error", "Failed after 3 attempts. Last error: Bad Gateway"`. Root cause chain:
- OMA's default harness calls `streamText()` with **no `maxOutputTokens`** → AI SDK defaults to provider max (4096 for Anthropic).
- AnyRouter routed the model to an **openrouter-byok** upstream (bills the user's *OpenRouter* account, NOT AnyRouter's own credit balance).
- BYOK upstreams reject when the **requested** max exceeds the affordable balance — regardless of how tiny the real output is.
Proof: same in-pod key + model at `max_tokens:16` → HTTP 200; at 4096 → 502. And a fat AnyRouter `monthly_balance` (e.g. $162) does **not** help — BYOK bills elsewhere.
Fixes (any one): (a) add `maxOutputTokens` cap to the harness — shipped as opt-in env `OMA_MAX_OUTPUT_TOKENS` (duet PR #4); (b) top up the BYOK upstream account; (c) disable BYOK so requests bill AnyRouter credit.
Lesson: "upstream 502 after retries" from a gateway usually means the *upstream* rejected the request params (here: unaffordable max_tokens), not a transient network blip. Check the `anyrouter_metadata.upstream.provider` field — `*-byok` changes who pays.

## 3. pnpm v11 `strictDepBuilds` hard-fails the Docker build
The ghcr image workflow failed at `pnpm install --frozen-lockfile` with `[ERR_PNPM_IGNORED_BUILDS]` on `@google/genai`, `@mongodb-js/zstd`, `node-liblzma`. pnpm v11 refuses to *silently* skip a dependency's postinstall script — every script-bearing dep must be **explicitly listed** in `allowBuilds` (the v11 map that replaced the `onlyBuiltDependencies` array; v11 reads it from `pnpm-workspace.yaml`, and **ignores** the `pnpm` block in package.json). `true`=run the build (needs a toolchain in the image), `false`=explicitly skip. A local build with an older, lenient pnpm hid this — CI on a fresh runner (corepack pinned `pnpm@11.0.8`) surfaced it. Fix: add the three as `false` (they ship prebuilt binaries; the live image runs fine without their gyp rebuilds), avoiding pulling build-essential into the image.
Lesson: pin `packageManager` AND keep `allowBuilds` complete, or the image build breaks the moment a new script-bearing transitive dep appears. `.pnpm-approve-builds.json` in this repo is legacy/unused by v11 — the yaml `allowBuilds` is authoritative.

## 4. GitOps / k8s propagation gotchas
- **ConfigMap changes don't reach a running pod** — env is injected at container start. After Argo syncs a ConfigMap edit, you still need `kubectl -n oma rollout restart deploy/oma`.
- Initial deploy used **locally-built images imported to containerd** (`k3s ctr images import`) with `imagePullPolicy: Never`. Fast to bootstrap, but every code change then needs a rebuild+reimport. Migrating to `ghcr.io` pull (CI-published) removes that, at the cost of an image-source + pullPolicy change in the deployment.
- Building images on the Mac (OrbStack buildx) then `docker save | ssh | ctr import` **filled the node disk** once and restarted OrbStack mid-cleanup. Build only the image you need, prune aggressively, prefer CI→registry over local→ctr for anything repeated.

## 4b. LIVE WIN — Phase-E tool-use demonstrated
Achieved a green agentic completion on k3s: an OMA agent on `google/gemini-2.5-flash` routed through **AnyRouter `/chat/completions`**, executed a **bash tool** (`echo … && uname -sm` → `hello-from-OMA / Linux x86_64`), and returned a final message — trajectory `is_error:false`, `finish_reason:tool-calls` then `stop`, billed to AnyRouter credit (used +$0.45). What unblocked it:
- **BYOK is a dead end for Anthropic here.** All `anthropic/*` route to `openrouter-byok` (exhausted → 502); AnyRouter's $160 credit does NOT cover BYOK. Only non-Anthropic models (gemini/deepseek) work, via `/chat/completions`, on credit.
- **Node self-host was hardwired to Anthropic `/messages`** (`buildModel` in `apps/main-node/src/index.ts` passed `compat=undefined`). Added env `OMA_API_COMPAT=oai` (duet PR #6) so it uses the OpenAI-compatible wire format; also had to keep the FULL `provider/model` id (not strip the prefix) for the oai branch, else AnyRouter 404s `model_unavailable`.

## 4c. Building the image ourselves (no CI) — gotchas
Built `openma/main-node:dev` locally and imported to k3s (docker on the node is **masked** deliberately; OrbStack on the Mac was down — `orb start`).
- **Cross-arch (ARM Mac → amd64 node) via qemu emulation is flaky:** the console `vite build` fails `MODULE_NOT_FOUND` under emulation → use `--build-arg SKIP_CONSOLE=1` for an API-only bridge image (CI on native amd64 doesn't hit this). apt-get in the runtime stage also intermittently fails — just retry.
- **`--load` into the docker daemon can OOM/crash OrbStack** on a big emulated image → export straight to a tar: `--output type=docker,dest=img.tar`, and pass `-t name:tag` or the tar's `RepoTags` is null and `ctr import` lands it unnamed.
- Import: `scp` the tar, then `k3s ctr -n k8s.io images import img.tar` (k8s.io namespace, needs sudo).
- **THE BIG TRAP — `imagePullPolicy: Never` + a mutable tag caches the OLD image.** After re-importing `:dev`, `ctr images ls` shows the new digest but **`crictl images` (what kubelet uses) still maps the tag to the old config digest**, so `rollout restart` keeps launching the old code. `scale 0` + `crictl rmi` + re-import didn't fully clear it either. **What worked:** import under a NEW unique tag (`:v5`) and `kubectl set image deploy/oma main-node=…:v5` — a fresh tag has no stale kubelet cache. (For real, use CI→ghcr with immutable/digest tags and `pullPolicy: IfNotPresent`.)

## 5. Process / guardrail lessons
- The auto-mode classifier blocks: materializing secrets into tool output (print response bodies, never key bytes — use `node -e` with the key kept in `process.env`), self-merging your own fresh PRs with `--admin`, and shared-cluster mutations. Don't launder around these — surface and hand off.
- Verify credentials/plumbing with the **smallest** possible direct call (`max_tokens:16`) before blaming credit/quota — it isolates "key works" from "request too big for budget".
