Personal Proxmox-based homelab running self-hosted services with reverse proxy, DNS filtering, and more.

read me van nginxy aanpassen welke ips allemaal veranderd zijn

## Infrastructure Overview
**Hypervisor:** Proxmox VE 9.1.7 
**Hardware:** AMD Ryzen 5 2600X, 32GB DDR4, 500GB SSD + 1TB HDD + 4TB HDD, RTX 3060 12VRAM


## Virtual Machine's and Linux Containers
| Service | Type | Purpose | Resources |
|---------|------|---------|-----------|
| Vaultwarden | VM | Self-Hosted password manager | 1 CPU core + 1GB RAM |
| Game-server | VM | RL Craft | 4 CPU cores + 5GB RAM |
| Dashboard | VM | Service dashboard | 1 CPU core + 2GB RAM |
| Portainer | VM | Docker management UI | 2 CPU cores + 1GB RAM |
| Websites | VM | Self-hosted websites | 2 CPU cores + 1GB RAM |
| Pi-hole | VM | DNS + ad blocking | 2 CPU cores + 1GB RAM |
| Reverse-Proxy | LXC | HTTPS + self-signed SSL | 1 CPU core + 512MB RAM |
| Media | VM | Downloading and streaming movies | 2 CPU cores + 6GB RAM |
| AI-Agents | VM | AI infrastructure monitoring | 8 CPU cores + 16GB RAM |
| Home-Assistant | VM | Power data proccessing | 2 CPU cores + 4GB RAM |




