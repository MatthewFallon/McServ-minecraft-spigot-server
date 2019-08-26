FROM debian:stretch-slim as fetch-minecraft

ARG MINECRAFT_VERSION=latest

COPY scripts/fetch-minecraft.sh /usr/local/bin/fetch-minecraft

RUN apt-get update && apt-get install -y \
    curl \
    unzip && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/minecraft/ && \
    cd /opt/minecraft && \
    fetch-minecraft "${MINECRAFT_VERSION}"

FROM ubuntu:19.10 as base

LABEL maintainer="Daniel Fallon <daniel@fallon.io>"

RUN apt-get update && apt-get install -y \
    curl \
    openssl \
    libc6 \
    libstdc++6 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=fetch-minecraft /opt/minecraft /opt/minecraft

WORKDIR /opt/minecraft

EXPOSE 19132

COPY scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]