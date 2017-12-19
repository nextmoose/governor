#!/bin/sh

apk update &&
    apk upgrade &&
    apk add --no-cache tree &&
    mkdir ${HOME}/opt &&
    cd ${HOME}/opt &&
    git clone https://git.zx2c4.com/password-store &&
    cd ${HOME}/opt/password-store &&
    make install &&
    pass init ${GPG_KEY_ID} &&
    pass git init &&
    pass git config user.name "${USER_NAME}" &&
    pass git config user.email "${USER_EMAIL}" &&
    pass git remote add origin https://${SECRETS_HOST_NAME}:${SECRETS_HOST_PORT}/${SECRETS_ORIGIN_ORGANIZATION}/${SECRETS_ORIGIN_REPOSITORY}.git &&
    pass git fetch origin master &&
    pass git checkout origin/master &&
    cp /opt/docker/pre-commit.sh ${HOME}/.password-store/.git/hooks/pre-commit &&
    chmod 0500 ${HOME}/.password-store/.git/hooks/pre-commit &&
    bash