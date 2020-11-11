#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

IMAGE_NAME=stakater/nexus3
IMAGE_VERSION=3.28.1-keycloak_plugin0.4.1

docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} \
             -f "${DIR}/Dockerfile" "${DIR}"
