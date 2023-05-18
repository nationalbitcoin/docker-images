FROM alpine:3
ARG GITHUB_REF_NAME
ENV RELEASE_URL=https://github.com/nationalbitcoin/${GITHUB_REF_NAME}/releases/download/v1.0.9.1/russianbitcoin-1.0.9.1-amd64-linux-gnu.tar.gz
RUN apk add --no-cache wget tar \
  && wget --quiet -O- "$RELEASE_URL" | tar -xzv \
  && cd usr/local/bin \
  && mv * /usr/local/bin/

FROM ubuntu:latest
ARG GITHUB_REF_NAME
ENV BITCOIND=/usr/local/bin/${GITHUB_REF_NAME}d
COPY --from=0 /usr/local/bin/* /usr/local/bin/
CMD $BITCOIND -printtoconsole

LABEL org.opencontainers.image.source=https://github.com/nationalbitcoin/docker-images
