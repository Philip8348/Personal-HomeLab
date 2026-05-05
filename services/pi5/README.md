# Raspberry Pi 5

## Overview

| Resource | Value |
|----------|-------|
| Type | Bare metal (Raspberry Pi 5) |
| RAM | 4 GB |
| OS | Raspberry Pi OS (Bookworm) |
| Storage | MicroSD |

## Bare Metal Services

| Service | Purpose |
|---------|---------|
| Pi-hole | DNS filtering & ad blocking |
| WireGuard | VPN access to home network |

## Docker Services

| Container | Purpose | Port |
|-----------|---------|------|
| InfluxDB | Time-series data collection (energy monitoring) | 8086 |
| Grafana | Data visualization dashboards | 3000 |
| Home Assistant | Home automation | 8123 |

## Pi-hole

- Running bare metal (not Docker) to avoid port 53 conflicts
- Upstream DNS: Cloudflare with DNSSEC
- Handles `.home` domain resolution for all local services

## WireGuard

- Interface: wg0
- Subnet: 10.0.0.0/24
- Port: 51820/UDP
- Used for remote access to home network

## Quick Commands

```bash
# Pi-hole status
pihole status

# WireGuard status
sudo wg show

# Docker services
docker compose logs -f
```

## Related

- [Docker Compose](docker-compose.yml)
