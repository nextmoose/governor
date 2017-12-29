#!/bin/sh

TEMP=$(mktemp) &&
    pass show ${1}/private > ${TEMP} &&
    ssh-keygen -y -f ${TEMP} &&
    rm -rf ${TEMP}