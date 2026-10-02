# Raspberry Pi 5

A small, always-on node for network services and home automation. It's separate from the EPYC server, so DNS and VPN keep working when the big server is down or being worked on.

| | |
|---|---|
| Hardware | Raspberry Pi 5, 4 GB RAM, 500 GB SSD |
| OS | Debian 13 (trixie), arm64 |
| Network | Wired to the rack switch |

## Services

| Service | Runs as | What it does |
|---------|---------|--------------|
| **Pi-hole** | Native | DNS for the whole network: ad blocking plus the local `.home` records |
| **WireGuard (wg-easy)** | Docker | VPN into the home network, with a web UI to manage clients |
| **Home Assistant** | Docker | Home automation and energy monitoring |

## Energy monitoring

Home Assistant pulls everything in through native integrations:

| Source | What |
|--------|------|
| HomeWizard P1 meter | Electricity import/export per phase, and gas |
| HomeWizard energy sockets | Usage of individual devices |
| SolarEdge | Solar production |
| Marstek home battery | Charge, discharge and state of charge (Modbus TCP, **read-only**) |

A custom dashboard shows it all together: grid, solar, battery and home usage.

The battery integration is deliberately read-only. An earlier Modbus integration polled the battery so often that it kept resetting the battery's own power limits, so now all write entities are disabled and the battery is managed only through its own app.

Before this, a set of Python collectors wrote everything to InfluxDB and Grafana. Home Assistant's native integrations replaced all of that.

## Pi-hole

- Pi-hole v6. All local `.home` records live in `pihole.toml`; see [`pihole/pihole.toml.example`](pihole/pihole.toml.example) for the format (23 records, addresses replaced).
- Upstream DNS is Google (8.8.8.8 / 8.8.4.4).
- Pi-hole only does DNS. DHCP stays on the router.

## WireGuard

- wg-easy v15, on nftables (the iptables-legacy variant crashed on the current kernel).
- The web UI sits behind the reverse proxy with HTTPS. wg-easy refuses logins over plain HTTP.
- Family devices use a full tunnel with Pi-hole as DNS. Guests get a split tunnel that only reaches what they need.

## Lessons learned

- **Keep DNS off the big server.** Pi-hole on separate hardware means that rebooting the EPYC host doesn't take down DNS for the whole house.
- **Devices change IP addresses.** When the battery got a new DHCP address, the Home Assistant sensors didn't go "unavailable": they silently froze on their last values. Frozen sensors plus a disconnected Modbus status now means "check the IP first".
- **Escaping in Docker Compose:** a bcrypt hash in a compose file needs every `$` doubled to `$$`.
