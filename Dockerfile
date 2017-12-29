FROM nextmoose/cloud9:scratch_65de0557-be0d-44ed-bb84-a7dfa908a89a
FROM docker/compose:1.17.1
COPY docker-compose.yml entrypoint.sh pre-commit.sh public-key.sh /opt/docker/
RUN \
    apk update && \
        apk upgrade && \
        apk add --no-cache bash make git gnupg findutils tree openssh-client && \
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