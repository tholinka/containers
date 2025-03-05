FROM docker.io/library/ubuntu:24.04 AS builder

ARG VERSION

RUN apt-get update && apt-get -y --no-install-recommends install build-essential git ca-certificates && \
    git clone https://github.com/Zygo/bees.git /bees && \
    cd /bees && \
    git checkout v${VERSION} && \
    make -j$(nproc)

# copy from builder
FROM docker.io/library/ubuntu:24.04

ENV BEESHOME="/mnt/.beeshome"
# 1024 * 1024 * 1024 = 1GiB
# see https://github.com/Zygo/bees/blob/master/docs/config.md#hash-table-sizing for what size to use
ENV DB_SIZE=1073741824

ADD ./apps/bees/entrypoint.sh /

COPY --from=builder /bees/bin/bees /usr/local/bin/bees

RUN apt-get update && apt-get -y --no-install-recommends install btrfs-progs bash && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/Zygo/bees"
