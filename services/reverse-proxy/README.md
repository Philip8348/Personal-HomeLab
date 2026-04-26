# LXC106 - Reverse Proxy

## Overview
| Resource | Value |
|----------|-------|
| Container ID | 106 |
| Type | LXC Container |
| Hostname | reverse-proxy |
| IP | reverse-proxy.example.home |
| OS | Ubuntu 25.04 |
| CPU/RAM | 1 core / 512MB |
| Disk | 8 GB |

## What's Running
- **Nginx** (systemd service, no Docker)
- Acts as reverse proxy for all web services
- Handles HTTPS termination

## Config Location
- Nginx config: `/etc/nginx/sites-available/`
- Enabled sites: `/etc/nginx/sites-enabled/`
- SSL certificates: `/etc/letsencrypt/` or `/etc/ssl/`

## Proxied Services
| Service | Backend | Port |
|---------|---------|------|
| Vaultwarden | vaultwarden.example.home | 8080 |
| [Add others as needed] | | |

## Changes from Default
- Custom Nginx configs per service
- HTTPS termination enabled

## Access
- Entry point for all web traffic
- Routes based on domain/path to backend VMs

## Quick Commands
```bash
systemctl status nginx
systemctl restart nginx
