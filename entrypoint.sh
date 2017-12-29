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
    while [ "SISlfyE0" != "$(pass show alpha)" ]
    do
        echo Please enter the correct decryption key to proceed.
    done &&
    export UPSTREAM_ID_RSA=$(pass show ssh-keys.old/github/upstream/private) &&
    export ORIGIN_ID_RSA=$(pass show ssh-keys.old/github/origin/private) &&
    export REPORT_ID_RSA=$(pass show ssh-keys.old/github/report/private) &&
    export AWS_DEFAULT_REGION=$(pass show aws/aws-default-region) &&
    export AWS_ACCESS_KEY_ID=$(pass show aws/aws-access-key-id) &&
    export AWS_SECRET_ACCESS_KEY=$(pass show aws/aws-secret-access-key) &&
    echo SSH_KEYS AWS &&
    export LIEUTENANT_AWS_PRIVATE_KEY=$(pass show aws/ssh-keys.old/lieutenant) &&
    export LIEUTENANT_AWS_PUBLIC_KEY=$(sh /opt/docker/public-key.sh ssh-keys.old/lieutenant/raspberrypi "${LIEUTENANT_AWS_PRIVATE_KEY}") &&
    echo SSH_KEYS HOST &&
    export LIEUTENANT_PUBLIC_KEY=$(pass show ssh-keys.old/lieutenant/ec2/public) &&
    export LIEUTENANT_PRIVATE_KEY=$(pass show ssh-keys.old/lieutenant/ec2/private) &&
    export VOLUMES_BACKUP_PUBLIC_KEY=$(pass show ssh-keys.old/volumes-backup/ec2/public) &&
    export VOLUMES_BACKUP_PRIVATE_KEY=$(pass show ssh-keys.old/volumes-backup/ec2/private) &&
    export HACKER_2_PAVILLION_PRIVATE_KEY=$(pass show ssh-keys.old/hp-pavillion/hacker/private) &&
    export HACKER_2_PAVILLION_PUBLIC_KEY=$(pass show ssh-keys.old/hp-pavillion/hacker/public) &&
    export HACKER_2_LIEUTENANT_PRIVATE_KEY=$(pass show ssh-keys.old/lieutenant/hacker/private) &&
    export HACKER_2_LIEUTENANT_PUBLIC_KEY=$(pass show ssh-keys.old/lieutenant/hacker/public) &&
    export CHINESE_UBUNTU_2_LIEUTENANT_PRIVATE_KEY=$(pass show ssh-keys.old/lieutenant/chinese-ubuntu/private) &&
    export CHINESE_UBUNTU_2_LIEUTENANT_PUBLIC_KEY=$(pass show ssh-keys.old/lieutenant/chinese-ubuntu/public) &&
    export RASPBERRYPI_UBUNTU_2_LIEUTENANT_PRIVATE_KEY=$(pass show ssh-keys.old/lieutenant/raspberrypi/private) &&
    export RASPBERRYPI_UBUNTU_2_LIEUTENANT_PUBLIC_KEY=$(sh /opt/docker/public-key.sh ssh-keys.old/lieutenant/raspberrypi) &&
    export SECRETS_ORIGIN_ORGANIZATION &&
    export SECRETS_ORIGIN_REPOSITORY &&
    docker-compose pull &&
    docker-compose up -d &&
    bash &&
    docker-compose stop &&
    docker-compose rm -fv
    