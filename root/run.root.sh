#!/bin/sh

dnf update --assumeyes &&
    # dnf install --assumeyes dnf-plugins-core &&
    # dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo &&
    # dnf install --assumeyes docker-common docker-latest &&
    dnf install --assumeyes python2-pip &&
    curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose &&
    dnf install --assumeyes gnupg gnupg pass findutils bash-completion &&
    dnf clean all