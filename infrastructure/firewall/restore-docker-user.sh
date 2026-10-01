#!/bin/bash
# Rebuild ONLY the DOCKER-USER chain (example: Nextcloud host).
# Never touch the nat table: restoring a full iptables snapshot after a reboot
# pointed Docker's DNAT rules at old container IPs and broke every service.
set -e

if ! iptables -L DOCKER-USER -n >/dev/null 2>&1; then
    echo "DOCKER-USER chain missing (Docker not started yet?) - systemd will retry" >&2
    exit 1
fi

iptables -F DOCKER-USER

# established connections
iptables -A DOCKER-USER -m conntrack --ctstate RELATED,ESTABLISHED -j RETURN
# container <-> container on the Docker bridge (nextcloud, db, redis, cron)
iptables -A DOCKER-USER -s 172.16.0.0/12 -d 172.16.0.0/12 -j RETURN
# reverse proxy -> Nextcloud. Match the post-DNAT port: published 8080 -> container 80
iptables -A DOCKER-USER -s <lan-ip>/32 -p tcp --dport 80 -j RETURN
# containers -> internet via the uplink NIC (IMAP/SMTP, calendar feeds, updates)
iptables -A DOCKER-USER -o ens18 -j RETURN
# everything else: drop
iptables -A DOCKER-USER -j DROP
