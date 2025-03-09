FROM docker.io/library/alpine:3.21

ENV LANG=en_US.utf8

ENV NFS_SERVER_DEBUG="0"

RUN apk add --no-cache nfs-utils btrfs-progs bash

EXPOSE 2049

COPY ./apps/nfs-server/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://git.linux-nfs.org/?p=steved/nfs-utils.git"
