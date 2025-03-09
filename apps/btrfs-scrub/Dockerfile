FROM docker.io/library/alpine:3.21

ADD ./apps/btrfs-scrub/entrypoint.sh /

RUN apk --no-cache add btrfs-progs bash

ENTRYPOINT ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://btrfs.readthedocs.io"
