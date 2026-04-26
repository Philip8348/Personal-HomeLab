# VM109 - AI Agents

## Overview
| Resource | Value |
|----------|-------|
| VM ID | 109 |
| Hostname | ai-agents |
| IP | ai-agents.example.home |
| OS | Ubuntu 24.04.4 LTS |
| CPU/RAM | 12 cores / 16GB |
| GPU | NVIDIA RTX 3060 (12GB VRAM) |
| Auto-boot | Yes (onboot: 1) |

## What's Running

### Docker Containers
| Container | Purpose |
|-----------|---------|
| ollama | Local LLM inference (GPU) |
| open-webui | Web UI for Ollama |
| n8n | Workflow automation |
| openclaw-dashboard | OpenClaw management |
| syncthing | Obsidian vault sync |

### Systemd Services
| Service | Purpose |
|---------|---------|
| comfyui | AI image generation |

## Config Location
- Docker Compose: `/home/<user>/docker/docker-compose.yml`
- OpenClaw data: `/mnt/4tb/ai-agents/openclaw/`
- ComfyUI: `/home/<user>/ComfyUI/`
- Main storage: `/mnt/4tb/ai-agents/`

## Storage Breakdown
| Path | Size | Content |
|------|------|---------|
| `/mnt/4tb/ai-agents/ollama` | 35GB | LLM models |
| `/mnt/4tb/ai-agents/open-webui` | 891MB | WebUI data |
| `/mnt/4tb/ai-agents/openclaw` | 97MB | OpenClaw config |
| `/mnt/4tb/comfyui` | 8.4MB | Generated images |

## GPU Usage
**NVIDIA RTX 3060 (12GB VRAM)**
- ComfyUI: (Stable Diffusion)
- Ollama: Available for LLM inference

## Changes from Default
- GPU passthrough enabled
- Multi-tier AI model fallback (free → paid)
- ComfyUI runs as systemd service (not Docker)

## Access
- **Open WebUI:** `openwebui.example.home`
- **n8n:** `n8n.example.home`
- **ComfyUI:** `comfyui.example.home:8188`
- **OpenClaw Dashboard:** `openclaw.example.home`

## Quick Commands
```bash
# Docker services
cd /home/<user>/docker && docker-compose logs -f

# ComfyUI
systemctl status comfyui
systemctl restart comfyui

# GPU monitoring
nvidia-smi
```

## Related Documentation
- [Docker Compose](docker-compose.md)
- [n8n Workflows](n8n-workflows.md)
- [ComfyUI Workflows](comfyui-workflows.md)

## Notes
- Central AI automation hub
- Atlas (OpenClaw) manages infrastructure
- Free AI models minimize costs
- Critical disk usage - cleanup recommended
