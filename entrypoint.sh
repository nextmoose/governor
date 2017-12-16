#!/bin/sh

docker-compose up -d &&
    sh &&
    docker-compose stop &&
    docker-compose rm -fv
    