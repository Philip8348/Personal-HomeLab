# VM101 · AI & Automation

Home of Atlas, my self-hosted AI agent, and the tools it uses.

| | |
|---|---|
| OS | Ubuntu 24.04 LTS, Docker + systemd |
| Resources | 8 vCPU · 16 GB RAM · 150 GB disk |
| GPU | NVIDIA RTX 3060 12 GB (PCIe passthrough) |

## Services

| Service | What it does |
|---------|--------------|
| **Hermes Agent ("Atlas")** | AI agent that manages the homelab over SSH, runs research and keeps the documentation up to date |
| **Ollama** | Local LLM inference on the RTX 3060, used for example by Paperless-ngx |
| **SearXNG** | Private meta search engine, used by the agent for web research |
| **Crawl4AI** | Turns web pages into clean text for the agent |
| **n8n** | Workflow automation |
| **Syncthing** | Keeps the Obsidian documentation vault in sync between the server and my PC |

## How Atlas works

Atlas is a Hermes agent with several profiles, each with its own role:

| Profile | Role |
|---------|------|
| Main | Talks to me, runs tasks on the servers |
| Curator | Turns raw notes into structured documentation |
| Reviewer | Critically reviews plans before anything changes |
| Researcher | Deep research with a read-only toolset |

**The documentation is the agent's memory.** Everything lives in an Obsidian vault (synced with Syncthing), not in the agent's internal memory. Atlas drops findings in a `raw/` folder. A file watcher then triggers the curator, which files them in the right place.

**Plans are checked before they're run.** For server changes, Atlas first inventories read-only and proposes exact commands, a test plan and a rollback. The change only goes ahead after review.

**Its own identity.** Atlas has a dedicated `atlas` user with SSH keys on every host, so its actions are separate from mine. Its Proxmox API token is read-only (audit roles only).

## Lessons learned

- **Clean up regularly.** Experiments pile up quickly. One cleanup round freed about 14 GB of unused Docker images and build cache.
- **Firewall and published ports.** Uptime Kuma couldn't reach SearXNG until I allowed the container port (8080) instead of the published port (8081). See [security](../../infrastructure/security.md).
