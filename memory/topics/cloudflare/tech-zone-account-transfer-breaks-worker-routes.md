---
name: tech-zone-account-transfer-breaks-worker-routes
title: Moving a CF zone between accounts copies DNS but not Worker routes — Error 1000
description: Cloudflare inter-account zone/registrar transfer carries DNS records but drops Worker routes and Custom Domains, so every proxied hostname 403s with Error 1000 until routes are recreated
type: reference
category: cloudflare
tags: [reference, cloudflare, workers, dns, migration, zone-transfer]
aliases: ["Error 1000 after account move", "cloudflare zone move worker routes"]
related: ["[[tech-workers-cache-enabled]]"]
sources: ["https://developers.cloudflare.com/fundamentals/manage-domains/move-domain/"]
created: 2026-08-16
updated: 2026-08-16
timestamp: 2026-08-16T00:00:00Z
---

Moving a zone to another Cloudflare account (including a Registrar inter-account
transfer) copies **DNS records** but **not** Worker routes or Workers Custom Domains.

**Failure mode:** every proxied hostname returns `403` / **Error 1000 "DNS points to
prohibited IP."** The copied proxied A records point at Cloudflare anycast IPs. On the
old zone those were never used as an origin because Worker routes intercepted first;
on the new zone, with no routes, Cloudflare tries to reach that "origin", sees its own
IP, and refuses. **Routes are what make those placeholder A records harmless.**

Checklist when moving a Workers-backed zone:

| Item | Carries over? |
|---|---|
| DNS records (A/CNAME/MX/TXT) | yes |
| Worker routes | **no — recreate** |
| Workers Custom Domains | **no** |
| Custom rulesets (transform/cache rules) | **no** |
| Email Routing rules | **no** — and destination addresses must be re-verified first, else `2054` |
| Zone id | **changes** — re-point every hardcoded reference and re-issue zone-scoped API tokens |

Gotchas:

- An **apex** declared `custom_domain: true` is not matched by a `*.example.com/*`
  route. Creating the Custom Domain fails while leftover apex A records exist
  (`already has externally managed DNS records`); delete them first.
- Records that are **CNAMEs to a third party** (e.g. an auth provider's satellite
  domain) can silently disappear into a `*` wildcard A record — every name still
  resolves, so nothing looks broken while the integration is down. Diff the old and
  new zone by querying **each nameserver set directly** with `dig @<ns>`, not by
  checking whether a name resolves.
- Registrar transfers lock the registration for **30 days** — no rollback in that
  window at any price.
- A tunnel is **not** transferable: create a new one on the destination account and
  repoint the connector. Its ingress is readable from the API when the tunnel is
  remotely managed, so it can be replicated exactly without any node access.
- Verify resource ids (D1/KV/secrets-store) against the **live destination account**
  before substituting them; a recorded config file is a record of intent, not proof.
