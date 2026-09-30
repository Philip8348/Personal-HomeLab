# VM102 · Media

A self-hosted streaming service with automated library management, all download traffic routed through a VPN.

| | |
|---|---|
| OS | Ubuntu 24.04 LTS, Docker |
| Resources | 4 vCPU · 8 GB RAM · 70 GB disk |
| Media | 4 TB drive on the Proxmox host, shared over NFS |

## Services

| Service | What it does |
|---------|--------------|
| **Jellyfin** | Media server: streaming to TVs, phones and browsers |
| **Seerr** | Request portal: family members ask for a film or series |
| **Radarr / Sonarr** | Manage the film and series libraries |
| **Prowlarr** | Manages indexers for Radarr and Sonarr |
| **Bazarr** | Fetches subtitles |
| **qBittorrent** | Download client |
| **Gluetun** | VPN container (WireGuard) with port forwarding |

## VPN isolation

qBittorrent has no network of its own: it runs inside Gluetun's network namespace (`network_mode: service:gluetun`). If the VPN drops, qBittorrent has no route to the internet, so there's no traffic leak outside the tunnel.

Gluetun's control API is locked down with a read-only API key. The Homarr dashboard uses it to show the VPN status and public IP.

## Access

- Everything is reached through the reverse proxy at its own `.home` domain.
- Only the proxy can reach the management UIs. Jellyfin itself is open on the LAN so TVs can find it.
- Friends outside the house watch through a split-tunnel WireGuard profile that only reaches the reverse proxy and DNS.

## Lessons learned

- **Gluetun config format:** a wrong TOML structure for the auth roles crashes the container on startup. The roles have to be `[[roles]]` arrays.
- **Transcoding** is CPU-only on this VM, so "original quality" playback works best for remote viewers.
