#!/bin/sh

docker build --network host -t mihokookayami/apcupsd-exporter:latest -f Dockerfile .
docker push mihokookayami/apcupsd-exporter:latest
