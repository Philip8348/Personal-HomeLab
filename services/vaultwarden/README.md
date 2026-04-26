# VM100 - Vaultwarden

## Overzicht
| Resource | Waarde |
|----------|--------|
| VM ID | 100 |
| Hostname | vaultwarden |
| Rol | Password Manager |
| IP | `$VAULTWARDEN_IP` |
| Status | ✅ Actief |

## Hardware (Proxmox)
- **CPU:** 1 core (x86-64-v2-AES)
- **RAM:** 1024 MB
- **Disk:** 40 GB
- **OS:** Ubuntu 24.04.4 LTS

## Docker Containers
| Container | Image | Poort |
|-----------|-------|-------|
| `vaultwarden` | `vaultwarden/server:latest` | 8080 → 80 |
| `portainer_agent` | `portainer/agent:latest` | 9001 → 9001 |

## Gerelateerde Documentatie
- [Setup Details](setup.md)
- [Backup Procedure](backup.md)
- Reverse Proxy: Zie LXC106 docs

## Notities
- Reverse proxy op LXC106 (Nginx) handelt HTTPS-terminatie af
- Bitwarden-compatibele clients werken out-of-the-box

---
*Laatst geupdate: 2026-04-26*
