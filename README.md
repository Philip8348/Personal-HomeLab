# Personal HomeLab

Self-hosted infrastructure running on Proxmox VE with a mix of VMs, LXC containers, and a Raspberry Pi 5. Built for learning, automation, and running useful services at home.

## Hardware

| Component | Details |
|-----------|---------|
| CPU | AMD Ryzen 5 2600X |
| RAM | 32 GB DDR4 |
| GPU | NVIDIA RTX 3060 12 GB (passthrough to AI VM) |
| Storage | 500 GB SSD + 1 TB HDD + 4 TB HDD |
| Hypervisor | Proxmox VE 9.1.7 |
| Extra | Raspberry Pi 5 (4 GB) |

## Virtual Machines & Containers

| VM/LXC | Hostname | Role | Resources |
|--------|----------|------|-----------|
| 100 | vaultwarden | Password manager | 1 CPU / 1 GB RAM |
| 101 | game-server | Game server (on-demand) | 4 CPU / 5 GB RAM |
| 102 | dashboard | Homarr dashboard | 2 CPU / 2 GB RAM |
| 103 | portainer | Docker management | 2 CPU / 1 GB RAM |
| 104 | websites | Vogelsite | 2 CPU / 2 GB RAM |
| 106 | reverse-proxy | Nginx reverse proxy (LXC) | 1 CPU / 512 MB RAM |
| 107 | media | Torrent stack (qBittorrent, Prowlarr, Radarr, Jellyfin, Bazarr) | 2 CPU / 6 GB RAM |
| 108 | vogelmonitoring | Bird sex classification project | Low usage |
| 109 | ai-agents | Hermes Agent + ComfyUI + Ollama + n8n | 12 CPU / 16 GB RAM + RTX 3060 |
| — | Raspberry Pi 5 | Pi-hole + InfluxDB + Grafana + Home Assistant (Docker) + WireGuard (bare metal) | 4 GB RAM |

## Services by Category

### Infrastructure
- **Nginx Reverse Proxy** (LXC106) — HTTPS termination for all `.home` domains
- **Pi-hole** (Pi5) — DNS filtering & ad blocking, bare metal
- **WireGuard** (Pi5) — VPN access to home network, bare metal

### Web Services
- **Vaultwarden** (VM100) — Self-hosted Bitwarden password manager
- **Homarr** (VM102) — Dashboard for all homelab services

### Media
- **Jellyfin** (VM107) — Media streaming
- **qBittorrent + Prowlarr + Radarr + Bazarr** (VM107) — Media management stack

### AI & Automation
- **Hermes Agent** (VM109) — AI agent gateway
- **Ollama** (VM109) — Local LLM inference with GPU
- **Open WebUI** (VM109) — Web interface for Ollama
- **ComfyUI** (VM109) — AI image generation
- **n8n** (VM109) — Workflow automation

### Monitoring & Data
- **InfluxDB** (Pi5) — Time-series data collection (energy monitoring)
- **Grafana** (Pi5) — Data visualization dashboards
- **Portainer** (VM103) — Docker management UI

### Other
- **Home Assistant** (Pi5) — Home automation
- **Game Server** (VM101) — On-demand game server
- **Vogelmonitoring** (VM108) — Bird classification project
- **Vogelsite** (VM104) — Bird website
