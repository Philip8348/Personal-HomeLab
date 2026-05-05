# Network

## Local DNS

All services use `.home` domains resolved by Pi-hole (Raspberry Pi 5).

Internal addresses use 192.168.x.x/24 subnet.

## Domain Map

| Domain | Service |
|--------|---------|
| vaultwarden.example.home | Vaultwarden (VM100) |
| homarr.example.home | Homarr Dashboard (VM102) |
| portainer.example.home | Portainer (VM103) |
| openwebui.example.home | Open WebUI (VM109) |
| n8n.example.home | n8n (VM109) |
| openclaw.example.home | Hermes Agent (VM109) |
| reverse-proxy.example.home | Nginx (LXC106) |
| pihole.example.home | Pi-hole (Pi5) |
