# LXC104 · Reverse proxy

A single entry point for every web service in the homelab.

| | |
|---|---|
| Type | LXC container |
| OS | Ubuntu 24.04 LTS |
| Software | Nginx |
| Resources | 1 core · 1 GB RAM · 8 GB disk |

## How it works

```
https://<service>.home → Pi-hole resolves to this container → Nginx → VM:port
```

- **22 sites**, one per service, from Jellyfin to Vaultwarden.
- HTTP always redirects to HTTPS.
- **One certificate** from my own CA (LXC105) covers every `.home` name as an explicit SAN, instead of a wildcard.
- Per-site tuning where a service needs it: WebSocket headers (Home Assistant, Immich, Grafana, n8n), larger or unlimited upload sizes (Immich, Nextcloud, Paperless), and request buffering off for big uploads.

## Conventions

- Every site is a file in `sites-available` with a symlink in `sites-enabled`, never a regular file in `sites-enabled`. A cleanup found 12 sites that broke this rule.
- Removed services also get their site removed. Dead sites for tools I'd stopped using were cleaned up and archived.

## Lessons learned

- **Test before reload.** Every service depends on the proxy, so changes always go through `nginx -t` before a reload.
- **Monitor behind the proxy, not through it.** Uptime Kuma checks services on their own IP and port. Otherwise one proxy outage would show up as 20 red services.
