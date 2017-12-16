#!/bin/bash

docker \
    container \
    run \
    --interactive \
    --tty \
    --rm \
    --env-file private.env \
    --env UPSTREAM_ID_RSA="${UPSTREAM_ID_RSA}" \
    --env ORIGIN_ID_RSA="${ORIGIN_ID_RSA}" \
    --env REPORT_ID_RSA="${REPORT_ID_RSA}" \
    --label expiry=$(($(date +%s)+60*60*24*7)) \
    --env DISPLAY \
    nextmoose/governor:scratch/58a9c972-9286-4de0-93ca-5edf2b9980b5