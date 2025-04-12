FROM docker.io/library/alpine:3.21

USER root
WORKDIR /app

RUN apk add --no-cache openssl curl bash jq

COPY . /

USER nobody:nogroup
WORKDIR /out
VOLUME ["/out"]

ENTRYPOINT ["/usr/bin/bash", "entrypoint.sh"]
