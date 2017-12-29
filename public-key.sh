#!/bin/sh

TEMP=$(mktemp) &&
    echo "${@}" > ${TEMP} &&
    ssh-keygen -y -f ${TEMP} &&
    rm -rf ${TEMP}