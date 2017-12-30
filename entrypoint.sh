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
    if [ ${#} == 0 ]
    then
        pass git fetch origin master &&
            pass git checkout origin/master
    else
        pass git fetch origin ${0} &&
            pass git checkout origin/${0}
    fi &&
    cp /opt/docker/pre-commit.sh ${HOME}/.password-store/.git/hooks/pre-commit &&
    chmod 0500 ${HOME}/.password-store/.git/hooks/pre-commit &&
    if [ "5XKuWcyq" != "$(pass show alpha)" ]
    then
        echo Please enter the correct decryption key to proceed. &&
            exit 64
    fi &&
    export UPSTREAM_ID_RSA=$(pass show ssh-keys.old/github/upstream/private) &&
    export ORIGIN_ID_RSA=$(pass show ssh-keys.old/github/origin/private) &&
    export REPORT_ID_RSA=$(pass show ssh-keys.old/github/report/private) &&
    export AWS_DEFAULT_REGION=$(pass show aws/aws-default-region) &&
    export AWS_ACCESS_KEY_ID=$(pass show aws/aws-access-key-id) &&
    export AWS_SECRET_ACCESS_KEY=$(pass show aws/aws-secret-access-key) &&
    echo AWS SSH KEYS &&
    export LIEUTENANT_AWS_PRIVATE_KEY=$(pass show aws/ssh-keys/lieutenant) &&
    export LIEUTENANT_AWS_PUBLIC_KEY=$(sh /opt/docker/public-key.sh "${LIEUTENANT_AWS_PRIVATE_KEY}") &&
    echo HOST SSH KEYS &&
    export PAVILLION_2_LIEUTENANT_PRIVATE_KEY=$(pass show hosts/pavillion/lieutenant) &&
    export PAVILLION_2_LIEUTENANT_PUBLIC_KEY=$(sh /opt/docker/public-key "${PAVILLION_2_LIEUTENANT_PRIVATE_KEY}") &&
    echo HACKER SSH KEYS &&
    export HACKER_2_LIEUTENANT_PRIVATE_KEY=$(pass show hacker/ssh-keys/lieutenant) &&
    export HACKER_2_LIEUTENANT_PUBLIC_KEY=$(sh /opt/docker/public-key "${HACKER_2_LIEUTENANT_PRIVATE_KEY}")  &&
    export HACKER_2_PAVILLION_PRIVATE_KEY=$(pass show hacker/ssh-keys/pavillion) &&
    export HACKER_2_PAVILLION_PUBLIC_KEY=$(sh /opt/docker/public-key "${HACKER_2_PAVILLION_PRIVATE_KEY}")&&
    export SECRETS_ORIGIN_ORGANIZATION &&
    export SECRETS_ORIGIN_REPOSITORY &&
    docker-compose pull &&
    docker-compose up -d &&
    bash &&
    docker-compose stop &&
    docker-compose rm -fv
    