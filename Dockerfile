FROM docker/compose:1.17.1
COPY docker-compose.yml entrypoint.sh secret-viewer.sh pre-commit.sh /opt/docker/
RUN \
    apk update && \
        apk upgrade && \
        apk add --no-cache bash make git gnupg findutils tree && \
        TEMP=$(mktemp -d) && \
        cd ${TEMP} && \
        git init && \
        git remote add origin https://git.zx2c4.com/password-store && \
        git fetch origin master && \
        git checkout origin/master && \
        make install && \
        cd / && \
        rm -rf ${TEMP} && \
        rm -rf /var/cache/apk/*
WORKDIR /opt/docker
ENTRYPOINT ["sh", "/opt/docker/entrypoint.sh"]
CMD []