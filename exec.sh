#!/bin/bash

docker image pull nextmoose/governor:scratch_58a9c972-9286-4de0-93ca-5edf2b9980b5 &&
    docker \
        container \
        run \
        --interactive \
        --tty \
        --rm \
        --env-file public.env \
        --env UPSTREAM_ID_RSA="${UPSTREAM_ID_RSA}" \
        --env ORIGIN_ID_RSA="${ORIGIN_ID_RSA}" \
        --env REPORT_ID_RSA="${REPORT_ID_RSA}" \
        --env EXPIRY=$(($(date +%s)+60*60*24*7)) \
        --label expiry=$(($(date +%s)+60*60*24*7)) \
        --env DISPLAY \
        --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock,readonly=true \
        nextmoose/governor:scratch_58a9c972-9286-4de0-93ca-5edf2b9980b5