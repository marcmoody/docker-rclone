FROM alpine:3.4

MAINTAINER Philipp Schmitt <philipp@schmitt.co>

RUN apk -U add ca-certificates \
    && rm -rf /var/cache/apk/* \
    && cd /tmp \
    && wget -q http://downloads.rclone.org/rclone-current-linux-amd64.zip \
    && unzip /tmp/rclone-current-linux-amd64.zip \
    && mv /tmp/rclone-*-linux-amd64/rclone /usr/bin \
    && rm -r /tmp/rclone* \
    && addgroup rclone \
    && adduser -h /config -s /bin/ash -G rclone -D rclone

USER rclone

VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/rclone"]

CMD ["--version"]
