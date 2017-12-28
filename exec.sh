#!/bin/bash

docker() {
    sudo docker run --interactive --tty --rm --label expiry=$(($(date +%s)+60*60*24*7)) docker:17.12.0 "${@}"
} &&
    sudo docker image pull nextmoose/governor:scratch_58a9c972-9286-4de0-93ca-5edf2b9980b5 &&
    sudo docker \
        container \
        run \
        --interactive \
        --tty \
        --rm \
        --env-file public.env \
        --env GPG_SECRET_KEY="$(cat private/gpg_secret_key)" \
        --env GPG2_SECRET_KEY="$(cat private/gpg2_secret_key)" \
        --env GPG_OWNER_TRUST="$(cat private/gpg_owner_trust)" \
        --env GPG2_OWNER_TRUST="$(cat private/gpg2_owner_trust)" \
        --env EXPIRY=$(($(date +%s)+60*60*24*7)) \
        --label expiry=$(($(date +%s)+60*60*24*7)) \
        --env DISPLAY \
        --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock,readonly=true \
        nextmoose/governor:scratch_58a9c972-9286-4de0-93ca-5edf2b9980b5