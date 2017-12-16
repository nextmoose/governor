#!/bin/sh

docker \
    container \
    run \
    --interactive \
    --rm \
    --label expiry=$(($(date +%s)+60*60*24*7)) \
    --env DISPLAY \
    nextmoose/governor:scratch/58a9c972-9286-4de0-93ca-5edf2b9980b5