# `topics/linux/`

## Concepts

- [Debian 13 apt ships Node 20](tech-debian-13-apt-node-20.md) — Debian 13 (trixie) nodejs is 20.x; Wrangler 4 and many CLIs need Node >=22. Install official 22 LTS to /usr/local and dpkg-divert /usr/bin/node.
- [Disk swap is not extra RAM](tech-disk-swap-not-extra-ram.md) — A huge disk swapfile delays OOM and can hang a headless box; prefer small zram plus kill/evict
