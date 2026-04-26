# VM100 - Vaultwarden

## Overzicht
| Resource | Waarde |
|----------|--------|
| VM ID | 100 |
| Hostname | vaultwarden |
| IP | vaultwarden.example.home |
| OS | Ubuntu 24.04.4 LTS |
| CPU/RAM | 1 core / 1GB |
| Disk | 40 GB |

## Wat draait er
| Container | Image | Poort |
|-----------|-------|-------|
| vaultwarden | `vaultwarden/server:latest` | 8080→80 |
| portainer_agent | `portainer/agent:latest` | 9001→9001 |

## Config Locatie
- Docker Compose: `/opt/vaultwarden/docker-compose.yml`
- Data: `/opt/vaultwarden/`

## Afwijkingen van Default
- Signups uitgeschakeld (veiligheid)
- Reverse proxy op LXC106 voor HTTPS

## Toegang
- **Web UI:** Via LXC106 reverse proxy (Nginx)
