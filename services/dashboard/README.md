# VM102 - Dashboard

## Overview
| Resource | Value |
|----------|-------|
| VM ID | 102 |
| Hostname | dashboard |
| IP | homarr.example.home |
| OS | Ubuntu 24.04.4 LTS |
| CPU/RAM | 2 cores / 2GB |
| Disk | 20 GB (86% full - monitor!) |
| Auto-boot | Yes (onboot: 1) |

## Running Services
- **Homarr** - Homelab dashboard

## Config Location
- Docker Compose: `/home/<user>/homarr/docker-compose.yml`
- Data/Config: `/home/<user>/homarr/homarr/appdata/`

## Dashboard Content
Coming 

## Access
- **Dashboard UI:** `http://homarr.example.home`

## Quick Commands
```bash
docker ps
docker logs homarr -f
docker restart homarr
```
