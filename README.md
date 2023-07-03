# apcupsd_exporter ( Dockerfile )

Un container Docker **AMD64** sous [Alpine Linux](https://www.alpinelinux.org) empaquetant l'application [apcupsd_exporter](https://github.com/mdlayher/apcupsd_exporter) ( mdlayher ).

## Utilisation
docker-compose.yml :

```
  apcupsd-exporter:
    image: mihokookayami/apcupsd-exporter:latest
    container_name: apcupsd-exporter
    network_mode: host
    environment:
      TZ: 'Europe/Paris'
      TELEMETRYADDR: '127.0.0.1:9162'
      TELEMETRYPATH: '/metrics'
      APCUPSDADDR: '127.0.0.1:3551'
      APCUPSDNETWORK: 'tcp'
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: '512M'
```

prometheus.yml :
```
  - job_name: 'ups'
    static_configs:
      - targets: ['127.0.0.1:9116']
```