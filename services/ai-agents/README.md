# VM109 - AI Agents

Central hub for AI workloads, agent management, and workflow automation. The heaviest VM in the homelab with GPU passthrough.

## Overview

| Resource | Value |
|----------|-------|
| VM ID | 109 |
| Hostname | ai-agents |
| IP | ai-agents.example.home |
| OS | Ubuntu 24.04.4 LTS |
| CPU/RAM | 8 cores / 16 GB |
| GPU | NVIDIA RTX 3060 (12 GB VRAM, passthrough) |
| Auto-boot | Yes |

## Docker Containers

| Container | Purpose | Port |
|-----------|---------|------|
| ollama | Local LLM inference (GPU) | 11434 |
| open-webui | Web UI for Ollama | 3000 |
| n8n | Workflow automation | 5678 |
| hermes-agent | AI agent gateway | 8642 |
| hermes-dashboard | Agent dashboard & session viewer | 9119 |
| syncthing | Obsidian vault sync | 8384 |

## Systemd Services

| Service | Purpose | Port |
|---------|---------|------|
| comfyui | AI image generation (Stable Diffusion) | 8188 |
| hermes-workspace | SvelteKit UI, chat & operations | 3001 |

## GPU Usage

NVIDIA RTX 3060 (12 GB VRAM) shared between:
- **ComfyUI** — Stable Diffusion image generation
- **Ollama** — LLM inference when needed

## Storage

| Path | Content |
|------|---------|
| `/mnt/4tb/ai-agents/ollama` | LLM models |
| `/mnt/4tb/ai-agents/open-webui` | Open WebUI data |
| `/mnt/4tb/hermes` | Hermes Agent configuration & profiles |
| `/mnt/4tb/obsidian-vault` | Obsidian vault (Syncthing source) |
| `/mnt/4tb/comfyui/output` | ComfyUI generated images |
| `/mnt/4tb/comfyui/scripts` | ComfyUI automation scripts |
| `/mnt/4tb/n8n` | n8n workflow data |

## Access

| Service | URL |
|---------|-----|
| Open WebUI | openwebui.example.home |
| n8n | n8n.example.home |
| ComfyUI | ai-agents.example.home:8188 |
| Hermes Workspace | ai-agents.example.home:3001 |

## Quick Commands

```bash
# Docker services
cd /home/<user>/docker && docker compose logs -f

# ComfyUI
systemctl status comfyui
systemctl restart comfyui

# Hermes Workspace
systemctl status hermes-workspace

# GPU monitoring
nvidia-smi
```

## Related

- [Docker Compose](docker-compose.yml)
