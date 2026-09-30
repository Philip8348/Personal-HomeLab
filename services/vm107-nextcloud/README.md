# VM107 · Nextcloud

A browser-based workspace for mail, calendar and tasks: "Outlook in the browser", but self-hosted.

| | |
|---|---|
| OS | Ubuntu 24.04 LTS, Docker |
| Resources | 4 vCPU · 4 GB RAM · 60 GB disk |

## Stack

| Container | Role |
|-----------|------|
| `nextcloud:stable` | The app |
| MariaDB 11.4 | Database (READ-COMMITTED, utf8mb4) |
| Redis 7 | Cache and file locking |
| `nextcloud-cron` | Background jobs |

## What it's used for

| App | How |
|-----|-----|
| **Mail** | Reads my existing Gmail over IMAP/SMTP. I don't run a mail server: no public IP, no port 25 and no deliverability headaches. |
| **Calendar** | CalDAV calendar, plus external ICS feeds |
| **Tasks** | Task list that replaced an old Discord task board |
| **Agent access** | Atlas reads and writes the calendar over CalDAV (vdirsyncer). That was the whole point: an open protocol instead of a proprietary API. |

I compared this with separate apps (SnappyMail + Radicale + Vikunja), but that meant three UIs and three logins. One Nextcloud won.

## Security

- Nextcloud is only reachable through the reverse proxy. The firewall only allows the proxy to reach the container port.
- This was the first host with the hardened firewall pattern: a `DOCKER-USER` script that never touches the nat table, run from a systemd unit with `PartOf=docker.service` (see [security](../../infrastructure/security.md)).
- Secrets are generated on the VM itself and stored in a `.env` file with mode 600.
- Uptime Kuma monitors it through the proxy, so the whole chain gets tested, not just the container.
