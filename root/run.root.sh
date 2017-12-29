#!/bin/sh

dnf update --assumeyes &&
    dnf install --assumeyes install dnf-plugins-core &&
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo &&
    dnf install --assumeyes docker-common docker-latest &&
    dnf clean all