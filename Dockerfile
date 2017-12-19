FROM docker/compose:1.17.1
COPY docker-compose.yml entrypoint.sh secret-viewer.sh /opt/docker/
RUN \
    apk update && \
        apk upgrade && \
        apk add --no-cache bash make git gnupg findutils && \
        rm -rf /var/cache/apk/*
WORKDIR /opt/docker
ENTRYPOINT ["sh", "/opt/docker/entrypoint.sh"]
CMD []