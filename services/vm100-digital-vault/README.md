# VM100 · Digital Vault

The place for everything the family doesn't want to lose: passwords, documents, photos and family history.

| | |
|---|---|
| OS | Ubuntu 24.04 LTS, Docker |
| Resources | 4 vCPU · 16 GB RAM · 50 GB OS disk |
| Data | ZFS mirror of 2 × 8 TB (disk passthrough) |

## Services

| Service | What it does |
|---------|--------------|
| **Vaultwarden** | Self-hosted Bitwarden password manager for the family |
| **Paperless-ngx** | Scanned documents with OCR, auto-tagging and full-text search |
| **Immich** | Google Photos replacement: phone backup, face recognition, smart search |
| **Immich Swipe** | Small helper to quickly sort out unwanted photos |
| **Gramps Web** | Family tree / genealogy |

All of these run from one Docker Compose project. Every service is reached through the reverse proxy at its own `.home` domain.

## Storage

The OS and databases live on the VM's own disk. The actual data (documents, photos, family tree) lives on a ZFS pool named `vault`: a mirror of two 8 TB drives that Proxmox passes straight through to the VM.

- The mirror uses two different drive models (IronWolf Pro + Exos).
- Regular scrubs; a degraded pool triggers a Discord alert through Prometheus.
- The Proxmox backup only covers the OS disk. An offsite copy of the pool is on the roadmap.

## Paperless-ngx setup

- **Scan straight to Paperless.** Every family member has their own Samba share that the scanner writes to. A workflow assigns each document to the right owner based on the folder.
- **Permissions.** Every family member only sees their own documents plus shared ones. One separate admin account handles administration only.
- **Dutch OCR.** A custom image adds the Dutch Tesseract language pack (`nld+eng`).
- **Local AI.** Paperless uses a small model on [Ollama (VM101)](../vm101-ai-agents/README.md) to suggest titles, tags and dates, with a Dutch prompt. No documents leave the house.

## Immich setup

- Separate accounts per family member.
- Machine learning (CLIP search, face recognition) runs on the CPU.
- Videos are transcoded at high quality with adaptive streaming (720p / 1080p / original).

## Lessons learned

- **A mirror is not a backup.** It protects against a dead drive, not against deletion or ransomware. Offsite backup is next.
- **Uploads through a proxy:** large Immich uploads failed until request buffering was turned off and the body size limit was raised on Nginx.
- **Custom images need maintenance.** The Dutch OCR image and the Paperless AI patch have to be rebuilt after every upstream update.
