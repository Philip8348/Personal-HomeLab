# VM100 - Vaultwarden

## Overview
| Resource | Value |
|----------|-------|
| VM ID | 100 |
| Hostname | vaultwarden |
| IP | vaultwarden.example.home |
| OS | Ubuntu 24.04.4 LTS |
| CPU/RAM | 1 core / 1GB |
| Disk | 40 GB |

## Running Containers
| Container | Image | Port |
|-----------|-------|------|
| vaultwarden | `vaultwarden/server:latest` | 8080→80 |
| portainer_agent | `portainer/agent:latest` | 9001→9001 |

## Config Location
- Docker Compose: `/opt/vaultwarden/docker-compose.yml`
- Data: `/opt/vaultwarden/`

## Changes from Default
- Signups disabled (security)
- Reverse proxy on LXC106 for HTTPS

## Access
- **Web UI:** Via LXC106 reverse proxy (Nginx)
