# Vaultwarden Backup & Restore

## Backup Strategie

### Proxmox VM Backup (Primary)
**Automatisch via Proxmox UI:**
- **Frequentie:** Dagelijks
- **Backup locatie:** HDD 1TB (`/mnt/backup-hdd` - 200GB allocated)
- **Type:** Proxmox VZDump (volledige VM snapshot)
- **Retentie:** 2

**Backup bevat:**
- Volledige VM state
- Alle Docker containers + volumes
- Vaultwarden database + attachments

**Restore procedure (Proxmox):**
1. Proxmox UI → VM100 → Backup → Select backup
2. Click "Restore"
3. Start VM na restore
4. Verify Vaultwarden: `docker ps` + check web UI

## Backup Locaties
- **Primair:** Proxmox backup → `/mnt/backup-hdd` (1TB HDD, 200GB allocated)

## Recovery Scenarios

### Volledige VM crash
→ Restore via Proxmox backup (volledige VM)
