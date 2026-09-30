# LXC106 · Monitoring

Hardware metrics, alerts and service uptime in one place, with notifications to Discord.

| | |
|---|---|
| Type | LXC container, Docker |
| Stack | Prometheus · Grafana · Alertmanager · Uptime Kuma · Homarr |

## Two layers

| Layer | Tool | Watches |
|-------|------|---------|
| **Hardware and hosts** | Prometheus + Grafana + Alertmanager | CPU, RAM, disks, SMART, temperatures, fans, IPMI sensors, ZFS pool health |
| **Services** | Uptime Kuma | 27 HTTP/TCP checks on every service, every 60 seconds |

Both send alerts to Discord: Alertmanager through a small relay container, Uptime Kuma through its native Discord integration.

### Prometheus

- Scrapes `node_exporter`, `smartctl_exporter` and `ipmi_exporter` on the Proxmox host, plus `node_exporter` with the ZFS collector on the Digital Vault VM.
- 15-second scrape interval, 30-day retention.
- Alert rules for host down and a degraded ZFS pool, among others.
- Imported community Grafana dashboards for the exporters.

### Uptime Kuma

- Checks each service **directly on its IP and port**, not through the `.home` domain. If the reverse proxy goes down, that's one red check, not twenty.
- The reverse proxy itself has its own separate check.

### Homarr

The start page for the whole homelab: links to every service, plus widgets for Proxmox and the VPN status.

## History

I tried Netdata, Beszel, Pulse and Checkmk before settling on this stack. Prometheus + Grafana + Alertmanager was the only option that handled per-drive temperatures, fans and GPU properly, with real threshold alerts, fully local. Everything else was removed completely: containers, agents, users and leftover config.

## Lessons learned

- **"Notification configured" ≠ "alerts arrive".** In Uptime Kuma v1, setting a notification as default doesn't attach it to existing monitors. It has to be linked per monitor, and tested with a real down event.
- **A firewall can blind your monitoring.** After a power cut, exporters became unreachable because of firewall rules. That caused false "host down" alerts and hid the ZFS health check until it was fixed.
- **TLS for dashboards.** Homarr kept hanging because its integrations couldn't verify certificates. Adding both the home CA and the Proxmox CA to its trust store fixed it.
