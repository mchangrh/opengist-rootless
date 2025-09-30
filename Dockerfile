FROM ghcr.io/thomiceli/opengist AS opengist
RUN apk add --no-cache \
  binutils
RUN strip --strip-unneeded /app/opengist/opengist

FROM alpine:3 AS final
COPY --from=opengist /app/opengist/opengist /app/opengist/opengist
RUN apk add --no-cache curl git openssh-server
RUN git config --global --add safe.directory '/opengist' && \
    git config --global receive.advertisePushOptions true
ENV OG_OPENGIST_HOME=/opengist
EXPOSE 6157 2222
VOLUME /opengist
HEALTHCHECK CMD curl -f http://localhost:6157/healthcheck || exit 1
CMD ["/app/opengist/opengist", "--config", "/opengist/config.yml"]