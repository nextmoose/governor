#!/bin/sh

dnf update --assumeyes &&
    dnf install --assumeyes python2-pip psproc kill &&
    curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/sbin/docker-compose &&
    chmod 0500 /usr/local/sbin/docker-compose &&
    dnf install --assumeyes gnupg gnupg pass findutils bash-completion &&
    dnf clean all