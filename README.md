Personal Proxmox-based homelab running self-hosted services with reverse proxy, DNS filtering, and more.

## Infrastructure Overview
**Hypervisor:** Proxmox VE 9.1.7 
**Hardware:** AMD Ryzen 5 2600X, 32GB DDR4, 500GB SSD + 1TB HDD + 4TB HDD, RTX 3060 12VRAM


## Virtual Machine's and Linux Containers
| Service | Type | Purpose |
|---------|------|---------|
| Vaultwarden | VM | Self-Hosted password manager |
| Game-server | VM | RL Craft |
| Dashboard | VM | Service dashboard |
| Portainer | VM | Docker management UI |
| Websites | VM | Self-hosted websites |
| Pi-hole | VM | DNS + ad blocking |
| Reverse-Proxy | LXC | HTTPS + self-signed SSL |
| Media | VM | Downloading and streaming movies |
| AI-Agents | VM | AI infrastructure monitoring |
| Home-Assistant | VM | Power data proccessing |




