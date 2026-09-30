# LXC105 · Certificate authority

My own private PKI, so every internal service runs on HTTPS without browser warnings.

| | |
|---|---|
| Type | LXC container |
| OS | Ubuntu 24.04 LTS |
| Software | [step-ca](https://smallstep.com/docs/step-ca/) (Smallstep) |
| Resources | 2 cores · 1 GB RAM · 8 GB disk |

## Design

| Level | Key | Notes |
|-------|-----|-------|
| Root CA | ECC P-256 | Valid for 10 years. Only used to sign the intermediate. |
| Intermediate CA | ECC P-256 | Signs the server certificates |
| Server certificate | ECC P-256 | Used by Nginx, with all `.home` names as SANs |

- Provisioners: a JWK admin provisioner for manual requests, and ACME.
- The root certificate can be downloaded at a fixed URL, so family members can install it on their own devices once.
- The root key is backed up outside the container.

## Why a private CA?

- **Self-signed per service:** every device would have to trust every single service.
- **Let's Encrypt:** needs a public domain and DNS or HTTP validation. The `.home` names only exist inside the network.
- **Own CA:** devices trust one root certificate, and every current and future service is covered.

## Renewal

The server certificate is valid for about two years and is renewed by hand, with a reminder set ahead of the expiry date.

## Lessons learned

- **Proxmox has its own CA.** The Proxmox web UI uses its built-in cluster CA, not step-ca. Tools that talk to the Proxmox API (like Homarr) need that root as well.
- **Moving from a wildcard to explicit SANs** means reissuing the certificate for every new service. In return it's always clear exactly which names are valid.
