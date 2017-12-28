#!/bin/sh

docker() {
    sudo docker run --interactive --tty --rm --volume /var/run/docker.sock:/var/run/docker.sock:ro --label expiry=$(($(date +%s)+60*60*24*7)) docker:17.12.0 "${@}"
} &&
    # source ./dockerhub.env &&
    # docker login --username ${DOCKERHUB_USERNAME} --password ${DOCKERHUB_PASSWORD} &&
    # docker image pull nextmoose/governor:scratch_58a9c972-9286-4de0-93ca-5edf2b9980b5 &&
    docker \
        container \
        run \
        --interactive \
        --tty \
        --rm \
        --env USER_NAME=Emory Merryman \
        --env USER_EMAIL=emory.merryman@gmail.com \
        --env SECRETS_HOST_NAME=github.com \
        --env SECRETS_HOST_PORT=443 \
        --env SECRETS_ORIGIN_ORGANIZATION=nextmoose \
        --env SECRETS_ORIGIN_REPOSITORY=secrets \
        --env GPG_KEY_ID=D65D3F8C \
        --env GPG_SECRET_KEY="$(cat private/gpg_secret_key)" \
        --env GPG2_SECRET_KEY="$(cat private/gpg2_secret_key)" \
        --env GPG_OWNER_TRUST="$(cat private/gpg_owner_trust)" \
        --env GPG2_OWNER_TRUST="$(cat private/gpg2_owner_trust)" \
        --env EXPIRY=$(($(date +%s)+60*60*24*7)) \
        --label expiry=$(($(date +%s)+60*60*24*7)) \
        --env DISPLAY \
        --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock,readonly=true \
        nextmoose/governor:scratch_58a9c972-9286-4de0-93ca-5edf2b9980b5