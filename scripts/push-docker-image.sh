#!/bin/bash

set -e

# Parse arguments.
while getopts 'c:u:p:' arg; do
  case "${arg}" in
    c) CONTAINER_REGISTRY=${OPTARG} ;;
    u) CONTAINER_REGISTRY_USERNAME=${OPTARG} ;;
    p) CONTAINER_REGISTRY_PASSWORD=${OPTARG} ;;
  esac
done

DOCKER_SOCKET=/var/run/docker.sock

echo $CONTAINER_REGISTRY_PASSWORD | docker login ${CONTAINER_REGISTRY} \
  --username $CONTAINER_REGISTRY_USERNAME \
  --password-stdin
docker build -t push-docker-image . --file Dockerfile.push-docker-image
docker run \
  --mount src=$DOCKER_SOCKET,target=$DOCKER_SOCKET,type=bind \
  --env DOCKER_IMAGE_NAME=push-docker-image \
  --env CONTAINER_REGISTRY=$CONTAINER_REGISTRY \
  --env CONTAINER_REGISTRY_USERNAME=$CONTAINER_REGISTRY_USERNAME \
  --env CONTAINER_REGISTRY_PASSWORD=$CONTAINER_REGISTRY_PASSWORD \
  push-docker-image