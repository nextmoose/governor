#!/bin/sh

cleanup() {
    docker-compose stop &&
        docker-compose rm -fv
} &&
    trap cleanup EXIT &&
    TEMP=$(mktemp -d) &&
    echo "${GPG_SECRET_KEY}" > ${TEMP}/gpg_secret_key &&
    gpg --batch --import ${TEMP}/gpg_secret_key &&
    echo "${GPG_OWNER_TRUST}" > ${TEMP}/gpg_owner_trust &&
    gpg --batch --import-ownertrust ${TEMP}/gpg_owner_trust &&
    rm -rf ${TEMP} &&
    pass init ${GPG_KEY_ID} &&
    pass git init &&
    pass git config user.name "${USER_NAME}" &&
    pass git config user.email "${USER_EMAIL}" &&
    pass git remote add origin https://${SECRETS_HOST_NAME}:${SECRETS_HOST_PORT}/${SECRETS_ORIGIN_ORGANIZATION}/${SECRETS_ORIGIN_REPOSITORY}.git &&
    pass git fetch origin master &&
    pass git checkout origin/master &&
    cp /opt/docker/pre-commit.sh ${HOME}/.password-store/.git/hooks/pre-commit &&
    chmod 0500 ${HOME}/.password-store/.git/hooks/pre-commit &&
    docker-compose pull &&
    export ALPHA=$(pass show alpha) &&
    export REPORT_ID_RSA=$(pass show ssh-keys/github/report/private) &&
    export AWS_DEFAULT_REGION=$(pass show aws/aws-default-region) &&
    export AWS_ACCESS_KEY_ID=$(pass show aws/aws-access-key-id) &&
    export AWS_SECRET_ACCESS_KEY=$(pass show aws/aws-secret-access-key) &&
    export SECRETS_ORIGIN_ORGANIZATION &&
    export SECRETS_ORIGIN_REPOSITORY &&
    docker-compose up -d &&
    bash &&
    docker-compose stop &&
    docker-compose rm -fv
    