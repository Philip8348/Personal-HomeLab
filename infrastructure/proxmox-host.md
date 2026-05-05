# Proxmox Host

## Hardware

| Component | Details |
|-----------|---------|
| CPU | AMD Ryzen 5 2600X |
| RAM | 32 GB DDR4 |
| GPU | NVIDIA RTX 3060 12 GB (passthrough to VM109) |

## Software

| Component | Details |
|-----------|---------|
| Hypervisor | Proxmox VE 9.1.7 |
| Node name | philip-pve |

## Storage

| Disk | Size | Purpose |
|------|------|---------|
| SSD | 500 GB | Proxmox boot + VM disks |
| HDD | 1 TB | Backups |
| HDD | 4 TB | AI models, media, shared data |

## GPU Passthrough

NVIDIA RTX 3060 is passed through to VM109 (ai-agents) for:
- Ollama LLM inference
- ComfyUI image generation

## VMs & LXCs

See [main README](../../README.md) for full list.
