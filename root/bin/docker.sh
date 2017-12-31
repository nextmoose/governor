#!/bin/sh

sudo \
    /usr/bin/docker \
    container \
    run \
    --interactive \
    --tty \
    --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --label expiry=$(($(date +%s)+60*60*24*7)) \
    docker:17.12.0 "${@}"