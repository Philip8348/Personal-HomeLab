# Proxmox host (EPYC server)

The single hypervisor in the homelab. Every VM and LXC container runs here.

## Hardware

| Component | Details |
|-----------|---------|
| CPU | AMD EPYC 7402P, 24 cores / 48 threads, 128 MB L3 |
| Motherboard | Supermicro H12SSL-i (SP3, PCIe 4.0, IPMI) |
| RAM | 4 × 16 GB DDR4-2666 ECC RDIMM, quad-channel (4 of 8 slots used) |
| GPU | NVIDIA RTX 3060 12 GB, passed through to VM101 |
| Cooling | Noctua NH-U9 TR4-SP3 |
| PSU | Seasonic Focus GX-850 |
| Chassis | Lanberg 4U rackmount in a 12U closed rack |

### Why EPYC?

The homelab started on a repurposed Ryzen 5 2600X desktop. It worked, but I kept running into its limits: I regularly had to shut down one VM to free up CPU and RAM for another. I also wanted a lot more storage, and rather than buying a separate NAS, I wanted it in the same machine.

In mid-2026 I moved to a single-socket AMD EPYC platform. The refurbished EPYC 7402P itself was surprisingly cheap (under €200). The Supermicro H12SSL-i board was the real investment, at around €900. In return I got 24 cores, 8 memory channels with ECC, plenty of PCIe lanes and SATA ports for data drives, and IPMI to manage the server remotely, including power and console.

I also looked at the newer SP5 platform (far more expensive, DDR5 only) and dual-socket boards (NUMA overhead, large E-ATX boards). For a homelab, neither was worth it.

## Software

| Component | Version |
|-----------|---------|
| Proxmox VE | 9.2 |
| Base OS | Debian 13 (trixie) |
| Boot | UEFI |

## Storage

| Disk | Size | Role |
|------|------|------|
| Samsung 990 PRO NVMe | 1 TB | Proxmox root + LVM-thin pool for VM disks |
| Seagate IronWolf Pro + Exos | 2 × 8 TB | ZFS mirror, passed through to VM100 (Digital Vault) |
| Seagate IronWolf | 4 TB | Media and shared data |
| HDD | 1 TB | Proxmox backups |

The two 8 TB drives are passed through directly to the Digital Vault VM, which runs a ZFS mirror on them. Passwords, documents and photos live there.

## Backups

Proxmox backs up every VM and container twice a week (snapshot mode, zstd) to the dedicated backup drive.

The ZFS drives are excluded from these backups (`backup=0` on the passthrough disks). Otherwise vzdump would read the full 8 TB on every run: the first attempt took 10 hours for what was mostly empty space. Now only the OS disk is backed up and the data is protected by the mirror.

> A mirror is not a backup. An offsite copy of the Digital Vault data is on the roadmap.

## Monitoring

Three Prometheus exporters run directly on the host as systemd services:

- **node_exporter** — CPU, RAM, disk, network, systemd units
- **smartctl_exporter** — SMART health and temperatures for every drive
- **ipmi_exporter** — fan speeds, voltages and board temperatures through IPMI

These feed into the monitoring stack on [LXC106](../services/lxc106-monitoring/README.md).

## Lessons learned

- **Passthrough disks and backups:** `nobackup=1` doesn't work on a passthrough disk; the `backup=0` disk property does.
- **Proxmox tools and sudo:** the `qm`/`pct` binaries live in `/usr/sbin`, which isn't in a regular user's PATH. Automation calls them with the full path.
