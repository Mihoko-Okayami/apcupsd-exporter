FROM golang:alpine AS build

LABEL maintainer="Mihoko-Okayami (https://hub.docker.com/r/mihokookayami/apcupsd-exporter/)"

RUN set -eux; \
	apk add --no-cache git; \
	git clone https://github.com/mdlayher/apcupsd_exporter.git /tmp/apcupsd_exporter; \
	cd /tmp/apcupsd_exporter; \
	go build cmd/apcupsd_exporter/main.go

FROM alpine:latest

ARG TELEMETRYADDR="127.0.0.1:9162"
ARG TELEMETRYPATH="/metrics"
ARG APCUPSDADDR="127.0.0.1:3551"
ARG APCUPSDNETWORK="tcp" 

ENV TELEMETRYADDR "$TELEMETRYADDR"
ENV TELEMETRYPATH="$TELEMETRYPATH"
ENV APCUPSDADDR "$APCUPSDADDR"
ENV APCUPSDNETWORK="$APCUPSDNETWORK" 

COPY --from=build /tmp/apcupsd_exporter/main /usr/local/bin/apcupsd_exporter

CMD /usr/local/bin/apcupsd_exporter -telemetry.addr $TELEMETRYADDR -telemetry.path $TELEMETRYPATH -apcupsd.addr $APCUPSDADDR -apcupsd.network $APCUPSDNETWORK