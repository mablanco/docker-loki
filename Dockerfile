FROM debian:trixie-20261027-slim@sha256:f6b08b09a05725f9431502d3b5714f5c4576e82c1a84fa1debe0c24a7e0c3ec4 AS base

FROM base AS download
ARG LOKI_VERSION=2.13.1
ARG LOKI_SHA256=ad8ccb7df33ce53b290a7c173b6ea895f6077b39ca7a11bc8ef8b74fe130134a
ADD --checksum=sha256:${LOKI_SHA256} \
    https://github.com/Neo23x0/Loki-RS/releases/download/v${LOKI_VERSION}/loki-linux-x86_64-v${LOKI_VERSION}.tar.gz \
    /tmp/loki.tar.gz
RUN mkdir /app && tar xzf /tmp/loki.tar.gz -C /app --no-same-owner

FROM base
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /app
# ca-certificates lets loki-util download signature updates over HTTPS
RUN set -eux; \
    apt-get update; \
    apt-get -y upgrade; \
    apt-get -y install --no-install-recommends ca-certificates; \
    rm -rf /var/lib/apt/lists/*
COPY --from=download /app /app
ENTRYPOINT ["/app/loki"]
