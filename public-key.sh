#!/bin/sh

TEMP=$(mktemp) &&
    pass show ${1} > ${TEMP}/private &&
    ssh-keygen -y -f ${TEMP} &&
    rm -rf ${TEMP}