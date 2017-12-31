#!/bin/sh

dnf update --assumeyes &&
    dnf install --assumeyes dnf-plugins-core &&
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo &&
    dnf install --assumeyes docker-common docker-latest docker-compose &&
    dnf install --assumeyes gnupg gnupg pass findutils bash-completion &&
    adduser user &&
    dnf install --assumeyes sudo &&
    echo "user ALL=(ALL) NOPASSWD: /usr/bin/docker" > /etc/sudoers.d/user &&
    dnf clean all