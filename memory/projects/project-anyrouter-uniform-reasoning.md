---
name: project-anyrouter-uniform-reasoning
title: AnyRouter should unify reasoning effort across upstreams and models
description: Ticket — /api/v1/models advertises reasoning params on 12 of 206 listings, never the accepted effort values, so clients cannot discover a uniform reasoning surface; chat is effort-only by the host's own docs
type: project
category: llm
tags: [project, anyrouter, llm, gateway, api, reasoning]
aliases: [anyrouter-uniform-reasoning, anyrouter-reasoning-ticket]
related: ["[[project-anyrouter]]", "[[project-anyrouter-openai-compat]]", "[[project-anyrouter-catalog-one-id]]"]
sources: ["https://anyrouter.dev/api/v1/models?all=1", "https://docs.anyrouter.dev/api-reference/models", "https://docs.anyrouter.dev/api-reference/chat-completions", "https://docs.anyrouter.dev/api-reference/presets", "https://docs.anyrouter.dev/features/models-catalog"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T13:10:00Z
---

Open ticket for [[project-anyrouter]], measured on the full catalog
(`GET /api/v1/models?all=1`, 206 listings, 2026-09-27). AnyRouter is one
gateway over many upstreams, so it should expose **one** reasoning contract
instead of whatever each upstream happens to accept.

Evidence:

- 123 listings carry `reasoning` in `capabilities`, but only **12** list any
  reasoning request field in `supported_parameters`.
- Those 12 disagree with each other: `inclusionai/ling-3.0-flash-fin` and
  `nex-agi/nex-n2.5-*` list only `reasoning`; `z-ai/glm-4.5` and
  `z-ai/glm-5.2` list only `reasoning_effort`; only `z-ai/glm-5.3-flash` and
  `stealth/space-bunny-alpha` list all three.
- **No listing ever publishes the accepted effort values.** A client cannot
  tell whether `xhigh` is legal on a given route.
- All 9 `anyrouter/*` presets advertise only
  `[max_tokens, temperature, top_p, stop, stream]` — no reasoning and no
  `tools` — even though `auto`/`hermes`/`cowork` route to reasoning models
  and the preset descriptions tell callers to pass `tools`.
- 101 of 206 listings have `top_provider.max_completion_tokens: null`, so the
  documented clamp ("A max_tokens set higher is clamped down silently") is
  undiscoverable. `anyrouter/decision` is one of them.

Asks:

1. One reasoning surface for the whole API: the same request field
   (`reasoning` + `reasoning_effort`) accepted on every model, forwarded to
   whichever route serves the request.
2. Publish the accepted effort values per model, or adopt a single ladder
   (`low`/`medium`/`high`) and document it once.
3. Include reasoning and `tools` in the presets' `supported_parameters`.
4. Fill `top_provider.max_completion_tokens` (or add an explicit
   `max_output_tokens`) so the clamp is discoverable.

## The contract is already documented — chat is effort-only

`/api-reference/models` states it outright, and it settles the toggle question
that no amount of probing could:

> "AnyRouter does not infer universal toggle, token-budget, or
> interleaved-thinking support from a model name or description. Toggle and
> budget controls remain endpoint-specific (`reasoning.enabled` /
> `reasoning.max_tokens` on Responses, `thinking` on Messages)."

The architecture doc in the gateway repo
(`docs/kb/architecture/reasoning-metadata-and-preset-contract.md`) adds: for
`anyrouter/*` presets, "Chat uses flat `reasoning_effort`; Responses uses nested
`reasoning.effort` plus endpoint-specific `reasoning.enabled`; Messages uses
`thinking`; `none` remains a disable sentinel on the flat Chat/converted-Messages
path." So on chat there is **one** control plus an off sentinel, and a
`toggle`/`budget_tokens` entry in any catalog for this API is wrong.

Probes agree (2026-09-27, `POST /api/v1/chat/completions`, `reasoning` object
forms `effort` / `enabled` / `max_tokens` / `exclude`):

| route | `reasoning: {…}` | `reasoning_effort: none` |
| --- | --- | --- |
| `deepseek/deepseek-v4.1-flash` | 400 `Validation: Unsupported parameter(s): 'reasoning'` | 200, `reasoning_tokens: 0` |
| `openai/gpt-oss-20b` | 400 `property 'reasoning' is unsupported` | 400 (upstream allowlist is low/medium/high only) |
| `nvidia/nemotron-3-ultra-550b-a55b` | 200; `enabled:false` → 0, `exclude:true` ignored | 200, 0 |
| `anyrouter/free` | 200; `enabled:false` → 0 | 200, 0 |

The nemotron routes accept the object form only because they are served by an
OpenRouter-compatible pool that passes it through — exactly the
"provider support remains route-specific" caveat in the host's own doc. It is
not a gateway contract, so catalogs must not publish a toggle on it.

## Measured: the gateway forwards the field and never validates it

Reading `error.metadata.upstream_message`, the **serving upstream's** 400
decides which rungs are legal:

| upstream | its own allowlist |
| --- | --- |
| `openrouter-pool` | `max`, `xhigh`, `high`, `medium`, `low`, `minimal`, `none` |
| `huggingface-pool` | `low`, `medium`, `high` — rejects `xhigh` |
| `nvidia-byok` (`deepseek-v4.1-flash`) | rejects `minimal` and `medium` |
| `z-ai-coding-byok` | no validation, accepts any value |
| `hermes-agent` | `low`, `medium`, `high`, `xhigh` |

The accepted set is **per model id, not per backend**: `nvidia-byok` serves
both `deepseek-v4.1-flash` (rejects `minimal`/`medium`) and
`muse-glimmer-30b` (accepts both). A published `low`/`medium`/`high` contract
returns a hard 400 on `deepseek-v4.1-flash`.

Honored effect, same multi-step prompt, mean `reasoning_tokens` (2026-09-27):

| route | `none` | `low` | `medium` | `high` | `max` |
| --- | --- | --- | --- | --- | --- |
| `openai/gpt-oss-20b` (700) | rejected | 273 | 629 | 698 | rejected |
| `deepseek-v4.1-flash` (1500, n=3) | 0 | 718 | rejected | 1182 | 1410 |
| `nemotron-3-super-120b-a12b` (1500, n=3) | 0 | 663 | — | 916 | 722 |
| `nemotron-3-ultra-550b-a55b` (1500, n=3) | 0 | 615 | — | 471 | 287 |
| `anyrouter/free` (700) | 0 | 535 | 580 | 626 | — |
| `minimax/m3` (700) | 0 / 349 | 611 | 551 | 846 | — |

`none` is a real off position everywhere it is accepted. `nemotron-3-ultra`
is the counter-example to "deeper value = more tokens": its ladder came out
inverted, so accept-without-honored-effect is the honest reading for that
route — publish the peer's rungs, not a wider set.

Presets resolve the member per request, so their ladder is not separable:
`cowork`/`hermes` served `poolside/laguna-s-2.1` (`none` = 0, every graded
value pinned at the whole budget), `auto` served `nvidia/nemotron-3-ultra-550b-a55b`
(`low` = 3000), `latest` served `meta/muse-glimmer-30b` (no reasoning tokens
reported at all), `free` served `dots-studio/dots-3-note-preview`.

Account-dependent gotchas when re-probing: `minimax/m3` ran out of upstream
credit partway through the day (402 → 502, not a rejected rung), and
`z-ai/glm-4.7-flash` is intermittent (502 from `z-ai-coding-byok`). Eight ids
are BYOK-only and cannot be exercised with a plain key at all: 404
`Model … is a Bring Your Own Key (BYOK) only model` or `No upstream available
for model …` on every value, including a nonsense one.

**`none` is not uniformly an off switch.** Two routes show why one measurement
is not enough:

- `minimax/m3`, five runs of `none` at max_tokens=1200: the two the route
  served returned **0 and 787** reasoning tokens. Same value, same route, so
  the sentinel can be ignored there and no catalog should promise it.
- `anyrouter/hermes` answers `none` with 400 `Reasoning is mandatory for this
  endpoint and cannot be disabled.` while `low`/`medium`/`high` each return 0
  tokens on the member it does serve — publishing the off switch on that preset
  would advertise a 400.
- By contrast `anyrouter/auto`, `cowork` and `free` return 0 on every served run
  of `none` (5/5, 3/3, 4/4) and spend the whole budget on any graded value,
  because the router picks the member per request: a preset can promise the off
  and nothing deeper.

**Why:** without this, every client maintains its own per-model reasoning
table and guesses, and a uniform contract silently breaks on the routes whose
upstream is narrower.
**How to apply:** no public tracker exists for AnyRouter (closed service, no
GitHub repo, issues disabled here), so this note is the ticket of record. Ask
#2 (publish the accepted values per listing) is the one that unblocks
full-fidelity per-model data; until then publish the route's measured set,
cite the measurement in the entry, drop every `toggle` and `budget_tokens`,
and use `none` as the off position, and only where it reproduces. Shipped that way
in the models.dev catalog (PR anomalyco/models.dev#8023, merged after the
automated review came back clean): per-model ladders, no toggles, no cost tiers
(this API publishes flat rates), no per-token price for the `anyrouter/*`
presets because they bill the route they resolve, and `[]` for the five entries
where nothing could be verified — `m3`, `kimi-k2.6`, `grok-build-0.1`,
`hermes`, `latest`. See
[[project-anyrouter-openai-compat]].
