#!/bin/sh

mkdir ${HOME}/opt &&
    cd ${HOME}/opt &&
    git clone https://git.zx2c4.com/password-store &&
    export PATH=${HOME}/opt:${PATH} &&
    echo "PATH=\${HOME}/opt:\${PATH}" >> ${HOME}/.bashrc &&
    pass init ${GPG_KEY_ID} &&
    pass git init &&
    pass git config user.name "${USER_NAME}" &&
    pass git config user.email "${USER_EMAIL}" &&
    pass git remote add origin https://${HOST_NAME}:${HOST_PORT}/${ORIGIN_ORGANIZATION}/${ORIGIN_REPOSITORY}.git &&
    pass git fetch origin master &&
    pass git checkout origin/master &&
    cp /opt/docker/extension/pre-commit.sh /home/user/.password-store/.git/hooks/pre-commit &&
    chmod 0500 /home/user/.password-store/.git/hooks/pre-commit &&
    bash