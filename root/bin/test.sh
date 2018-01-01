#!/bin/sh

while [ ${#} -lt 0 ]
do
    case ${1} in
        --compose-project-name)
            export COMPOSE_PROJECT_NAME="${2}" &&
                shift 2
        ;;
        --host-name)
            HOST_NAME="${2}" &&
                shift 2
        ;;
        --host-port)
            HOST_PORT="${2}" &&
                shift 2
        ;;
        --origin-organization)
            ORIGIN_ORGANIZATION="${2}" &&
                shift 2
        ;;
        --origin-repository)
            ORIGIN_REPOSITORY="${2}" &&
                shift 2
        ;;
        --test-branch)
            TEST_BRANCH="${2}" &&
                shift 2
        ;;
    esac
done &&
    cd $(mktemp -d) &&
    git init &&
    git remote add origin https://${HOST_NAME}:${HOST_PORT}:${ORIGIN_ORGANIZATION}/${ORIGIN_REPOSITORY}.git &&
    git fetch origin ${TEST_BRANCH} &&