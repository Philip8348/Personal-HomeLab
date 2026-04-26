# VM101 - Game Server

## Overview
| Resource | Value |
|----------|-------|
| VM ID | 101 |
| Hostname | game-server |
| OS | Ubuntu 24.04.4 LTS |
| CPU/RAM | 4 cores / 4GB |
| Disk | 15 GB (74% full) |
| Auto-boot | No (onboot: 0) |

## Running Services
- **RLCraft Server** (Minecraft modpack) - systemd service (disabled on boot)

## Config Location
- Server files: `/home/<user>/rlcraft/`
- Backups: `/home/<user>/minecraft-backups/`
- Backup script: `/home/<user>/backup-rlcraft.sh`
- Service file: `/etc/systemd/system/minecraft.service`

## Automation
- **Backup:** Every 3 hours via cron (`0 */3 * * *`)
- **Autostart:** Disabled (manual start required after VM boot)

## Changes from Default
- Disk 74% full - monitor backup growth
- VM does not auto-boot with Proxmox
- Minecraft service does not auto-start with VM

## Quick Commands
```bash
systemctl status minecraft
systemctl start minecraft
systemctl stop minecraft
```
