FROM docker.io/library/alpine:3.21

ADD ./apps/btrfs-scrub/entrypoint.sh /

RUN apk --no-cache add btrfs-progs

ENTRYPOINT ["/entrypoint.sh"]
