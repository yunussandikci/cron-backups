FROM alpine

RUN apk update \
    && apk add zip \
    && apk add curl

COPY        entrypoint.sh /entrypoint.sh
COPY        backup.sh /backup.sh
RUN         chmod +x /entrypoint.sh
RUN         chmod +x /backup.sh
ENTRYPOINT  ["/entrypoint.sh"]