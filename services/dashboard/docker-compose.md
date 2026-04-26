services:
  homarr:
    container_name: homarr
    image: ghcr.io/homarr-labs/homarr:latest
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./homarr/appdata:/appdata
    environment:
      - SECRET_ENCRYPTION_KEY= [REDACTED]
    ports:
      - '3000:7575'
