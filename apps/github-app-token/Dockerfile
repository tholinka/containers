FROM docker.io/library/alpine:3.21

USER root
WORKDIR /app

RUN apk add --no-cache catatonit openssl curl bash jq

COPY . /

USER nobody:nogroup
VOLUME ["/token"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
