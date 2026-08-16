---
name: tech-disk-swap-not-extra-ram
title: Disk swap is not extra RAM
description: A huge disk swapfile delays OOM and can hang a headless box; prefer small zram plus kill/evict
type: tech
category: linux
tags: [tech, linux, memory, swap, zram, homelab]
aliases: [zram-over-huge-swap, swap-thrash]
related: ["[[user-duyet-homelab]]", "[[feedback-public-kb-only]]"]
sources:
  - "https://github.com/rfjakob/earlyoom"
  - "https://www.kernel.org/doc/html/latest/admin-guide/sysctl/vm.html"
created: 2026-08-17
updated: 2026-08-17
timestamp: 2026-08-17T00:30:00Z
---

Swap is spill, not capacity. Pages come back 100–1000× slower than RAM. A large **disk** swapfile lets the kernel thrash (SSD busy, allocators stall, NIC/watchdog look dead) instead of killing a fat process.

On a small always-on Linux box (k8s + DB + agents):

- Prefer **2–4 GiB zram** (compressed, memory-speed) for short spikes.
- Do **not** add a swapfile ≥ RAM on the same NVMe as the OS/DB.
- Pair with `earlyoom` / kubelet eviction that fire **while swap still exists**. Huge swap delays that signal.

More swap is useful for hibernate or parking idle desktops. It is a trap when the working set already exceeds RAM and the host must stay reachable.

Related: [[user-duyet-homelab]] (keep topology out of kb — [[feedback-public-kb-only]]).
