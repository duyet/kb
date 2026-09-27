---
name: project-anyrouter-uniform-reasoning
title: AnyRouter should unify reasoning effort across upstreams and models
description: Ticket — /api/v1/models advertises reasoning params on 12 of 206 listings, never the accepted effort values, so clients cannot discover a uniform reasoning surface
type: project
category: llm
tags: [project, anyrouter, llm, gateway, api, reasoning]
aliases: [anyrouter-uniform-reasoning, anyrouter-reasoning-ticket]
related: ["[[project-anyrouter]]", "[[project-anyrouter-openai-compat]]", "[[project-anyrouter-catalog-one-id]]"]
sources: ["https://anyrouter.dev/api/v1/models?all=1", "https://docs.anyrouter.dev/features/models-catalog"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T09:30:00Z
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

## Measured: AnyRouter does not validate the field at all

Live test 2026-09-27, `POST /api/v1/chat/completions`, reading
`error.metadata.upstream_message`. The gateway forwards `reasoning_effort`
verbatim and the **serving upstream's** 400 decides:

| upstream | its own allowlist |
| --- | --- |
| `openrouter-pool` | `max`, `xhigh`, `high`, `medium`, `low`, `minimal`, `none` |
| `huggingface-pool` | `low`, `medium`, `high` — rejects `xhigh` |
| `nvidia-byok` | rejects `medium` |
| `z-ai-coding-byok` | no validation, accepts any value |
| `hermes-agent` | `low`, `medium`, `high`, `xhigh` |

So there is no uniform ladder the gateway enforces. `low` and `high` are the
only rungs accepted on all 12 routes reachable from a plain key. A published
`low`/`medium`/`high` contract returns a hard 400 on `deepseek-v4.1-flash`
(`nvidia-byok`). The field *is* honoured — `reasoning_tokens` track the value
(`gpt-oss-20b` 21/53/98 across low/medium/high).

The accepted set is **per model id, not per backend**: `nvidia-byok` serves
both `deepseek-v4.1-flash` (rejects `minimal`/`medium`) and
`muse-glimmer-30b` (accepts both). No toggle field exists — `reasoning: true`
and `reasoning: false` both 400 on every reachable route.

Honored effect, same prompt, `max_tokens=700`, two runs per value, mean
`reasoning_tokens` (2026-09-27):

| route | `none` | `low` | `medium` | `high` |
| --- | --- | --- | --- | --- |
| `minimax/m3` | 349 (one run 0) | 611 | 551 | 846 |
| `nvidia/nemotron-3-super-120b-a12b` | 0 | 483 | 592 | 558 |
| `openai/gpt-oss-20b` | rejected | 273 | 629 | 698 |
| `deepseek-v4.1-flash` | 0 | 537 | rejected | 700 |
| `anyrouter/free` | 0 | 566 | 667 | 697 |

Depth rises with the value where the rung is accepted, and `none` drives
`reasoning_tokens` to 0, so it is a real off position. `nemotron-3-ultra`
returned no usage for the depth probe.

**Why:** without this, every client maintains its own per-model reasoning
table and guesses, and a uniform contract silently breaks on the routes whose
upstream is narrower.
**How to apply:** no public tracker exists for AnyRouter (closed service, no
GitHub repo, issues disabled here), so this note is the ticket of record. Until
the API normalizes, publish only a route's measured set and cite the
measurement — do not encode per-lab ladders, do not publish a rung a route
rejects, and never publish a `toggle`, which this API does not have. Ask #2 is
the one that unblocks full-fidelity per-model data. See
[[project-anyrouter-openai-compat]].
