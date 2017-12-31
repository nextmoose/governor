#!/bin/bash

docker(){
    sudo docker run --interactive --tty --rm --label expiry=$(($(date +%s)+60*60*24*7)) --volume /var/run/docker.sock:/var/run/docker.sock:ro docker:17.12.0 "${@}"
}
    docker image pull nextmoose/governor:scratch_fb54191d-78f2-4889-a85b-e4572dac6885 &&
    docker \
        container \
        run \
        --interactive \
        --tty \
        --rm \
        --publish-all \
        --env USER_NAME="Emory Merryman" \
        --env USER_EMAIL=emory.merryman@gmail.com
        --env SECRETS_HOST_NAME=github.com
        --env SECRETS_HOST_PORT=443
        --env SECRETS_ORIGIN_ORGANIZATION=nextmoose
        --env SECRETS_ORIGIN_REPOSITORY=secrets
        --env GPG_KEY_ID=D65D3F8C
        --env GPG_SECRET_KEY="$(cat private/gpg_secret_key)" \
        --env GPG2_SECRET_KEY="$(cat private/gpg2_secret_key)" \
        --env GPG_OWNER_TRUST="$(cat private/gpg_owner_trust)" \
        --env GPG2_OWNER_TRUST="$(cat private/gpg2_owner_trust)" \
        --env EXPIRY=$(($(date +%s)+60*60*24*7)) \
        --label expiry=$(($(date +%s)+60*60*24*7)) \
        --env DISPLAY \
        --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock,readonly=true \
        nextmoose/governor:scratch_a4b20483-f29c-44b4-a24b-f6d551b5e8e3