# VM103 & VM108 · Game servers

Dedicated game servers for playing with friends. Both are currently **stopped** and don't start at boot, so they don't use CPU and RAM when nobody is playing.

| VM | Game | Resources | Status |
|----|------|-----------|--------|
| VM103 | Minecraft, *All the Mods 10* modpack | 8 vCPU · 16 GB RAM | ⚪ Stopped |
| VM108 | 7 Days to Die | 4 vCPU · 8 GB RAM | ⚪ Stopped |

## Minecraft (VM103)

- Runs in Docker with the `itzg/minecraft-server` image (Java 21, NeoForge).
- About 450 mods; the server has a fixed 8 GB heap with Aikar's G1GC flags.
- **Lesson:** big modpacks build up entities over time. Cleaning them up is done by editing the region files offline, with the server stopped.

## 7 Days to Die (VM108)

A custom Docker image: Debian slim + SteamCMD from Valve's tarball, because SteamCMD isn't available as an apt package on Debian bookworm.

Getting it playable meant solving three problems in a row:

1. **World generation deadlock.** A popular server-fixes mod was only built for the previous game version and froze saving. Removing it fixed the hang.
2. **"Server is still initializing" kick.** Steam's `steamclient.so` wasn't where the game expected it. A symlink in the image fixed Steam authentication.
3. **Lost build files after a reboot.** The build directory lived in `/tmp`. Moving it to a persistent path made rebuilds work offline in under a second.

Other details:

- Friends connect over WireGuard with a profile that only reaches this VM, not the rest of the network.
- The web panel and telnet only listen on `127.0.0.1`. Only the game ports are published.
- There's no pause-when-empty mod for the current version, so the plan is an auto-shutdown script: when there have been no players for 30 minutes, stop the container.

## Lessons learned

- **Check mod compatibility per game version.** A mod that is one version behind can freeze the server without an error in the log.
- **Per-client VPN rules.** In wg-easy, the global default for allowed IPs covers the whole LAN, so every guest profile needs an explicit, narrow `AllowedIPs`.
