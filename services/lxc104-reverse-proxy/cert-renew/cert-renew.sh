#!/bin/bash
# DISABLED: the timer is off and the certificate is renewed by hand before it expires.
# Check the provisioner claims (maxTLSCertDuration) before re-enabling it.
# Renew step-ca certificate for nginx if needed
set -e

CERT=/etc/ssl/local/step.crt
KEY=/etc/ssl/local/step.key
FULLCHAIN=/etc/ssl/local/step-fullchain.crt
CA_URL=https://<lan-ip>:8443

# Check if cert exists
if [ ! -f "$CERT" ]; then
  echo "ERROR: No certificate found at $CERT"
  exit 1
fi

# Try to renew
echo "[$(date)] Attempting certificate renewal..."
if step ca renew --force "$CERT" "$KEY" --ca-url "$CA_URL" 2>&1; then
  echo "[$(date)] Certificate renewed successfully"
  # Rebuild fullchain
  cat "$CERT" /etc/ssl/local/intermediate.crt > "$FULLCHAIN"
  # Reload nginx
  systemctl reload nginx
  echo "[$(date)] Nginx reloaded with renewed certificate"
else
  echo "[$(date)] Renewal not needed or failed - will retry next cycle"
fi
