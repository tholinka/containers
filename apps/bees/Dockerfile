FROM docker.io/library/ubuntu:24.04 as builder

ARG VERSION

RUN apt-get update && apt-get install build-essential git && \
    git clone https://github.com/Zygo/bees.git /bees && \
    git checkout v${VERSION} \
    cd /bees && \
    make -j$(nproc)

# copy from builder
FROM docker.io/library/ubuntu:24.04

ENV BEESHOME="/mnt/.beeshome"
ADD entrypoint.sh /

COPY --from=builder /bees/bin/bees /usr/local/bin/bees

# add btrfs-progs for debugging
RUN apt-get update && apt-get install btrfs-progs && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/bees", "--no-timestamps", "/mnt"]
