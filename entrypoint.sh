#!/bin/sh

docker-compose pull &&
    docker-compose up -d &&
    sh &&
    docker-compose stop &&
    docker-compose rm -fv
    