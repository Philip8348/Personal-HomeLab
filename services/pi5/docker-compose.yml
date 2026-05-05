philip@HomeLabPi5-lmrp28:~/docker $ cat docker-compose.yml
services:
  influxdb:
    image: influxdb:2.7
    container_name: influxdb
    restart: unless-stopped
    ports:
      - "8086:8086"
    volumes:
      - /mnt/influxdb:/var/lib/influxdb2
    environment:
      - DOCKER_INFLUXDB_INIT_MODE=setup
      - DOCKER_INFLUXDB_INIT_USERNAME={USERNAME}
      - DOCKER_INFLUXDB_INIT_PASSWORD={PASSWORD}
      - DOCKER_INFLUXDB_INIT_ORG={ORG}
      - DOCKER_INFLUXDB_INIT_BUCKET={BUCKET}

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    restart: unless-stopped
    ports:
      - "3001:3000"
    volumes:
      - grafana-data:/var/lib/grafana
    depends_on:
      - influxdb

  homeassistant:
    image: ghcr.io/home-assistant/home-assistant:stable
    container_name: homeassistant
    network_mode: host
    volumes:
      - /mnt/influxdb/homeassistant/config:/config
    environment:
      - TZ=Europe/Amsterdam
    restart: unless-stopped
    privileged: true



volumes:
  grafana-data:
