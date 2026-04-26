# VM103 - Portainer

## Overview
| Resource | Value |
|----------|-------|
| VM ID | 103 |
| Hostname | portainer |
| IP | portainer.example.home |
| OS | Ubuntu 24.04.4 LTS |
| CPU/RAM | 2 cores / 512MB |
| Disk | 10 GB (68% full) |
| Auto-boot | Yes (onboot: 1) |

## Running Services
| Container | Image |
|-----------|-------|
| portainer | `portainer/portainer-ce:latest` |
| portainer_agent | `portainer/agent:latest` |

## Config Location
- Docker Compose: `/home/<user>/portainer/docker-compose.yml`
- Data: `/var/lib/docker/volumes/portainer_portainer_data/`

## Managed Environments
Portainer manages Docker on:
- VM100 (vaultwarden) - via agent on port 9001
- [Add other VMs with agents]

## Changes from Default
- Local agent running for self-management

## Access
- **Portainer UI:** `portainer.example.home`

## Quick Commands
```bash
docker logs portainer -f
docker restart portainer
```
