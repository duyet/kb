---
name: tech-debian-13-apt-node-20
title: Debian 13 apt ships Node 20
description: Debian 13 (trixie) nodejs is 20.x; Wrangler 4 and many CLIs need Node >=22. Install official 22 LTS to /usr/local and dpkg-divert /usr/bin/node.
type: tech
category: linux
tags: [tech, linux, node, debian, wrangler]
aliases: [debian-trixie-node-20, wrangler-needs-node-22]
related: ["[[tech-npx-scoped-package-bin]]"]
sources:
  - "https://nodejs.org/dist/"
  - "https://packages.debian.org/trixie/nodejs"
created: 2026-08-18
updated: 2026-08-18
timestamp: 2026-08-18T16:00:00Z
---

Debian 13 `apt` `nodejs` is **20.x**. Wrangler 4 refuses to start below **22.0.0**. Do not replace the apt package — other Debian `node-*` packages depend on it.

To make Node 22 the system default:

1. Extract the official `node-v22.*-linux-x64.tar.gz` from nodejs.org into `/usr/local` (`--strip-components=1`). `/usr/local/bin` is already first on the default PATH.
2. `dpkg-divert --local --divert /usr/bin/node.distrib --rename /usr/bin/node` then `ln -sfn /usr/local/bin/node /usr/bin/node`. Cron/systemd `PATH=/usr/bin:/bin` and `#!/usr/bin/node` then get 22. Debian 20 stays at `/usr/bin/node.distrib`.
3. Prefer the `.tar.gz` if `xz-utils` is missing. Verify `SHASUMS256.txt`.

After this, `node -v` and `/usr/bin/node -v` are 22; `npm`/`npx` come from `/usr/local/bin`.
