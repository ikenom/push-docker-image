#!/bin/bash

set -e

echo $CONTAINER_REGISTRY_PASSWORD | docker login ${CONTAINER_REGISTRY} \
  --username $CONTAINER_REGISTRY_USERNAME \
  --password-stdin

FULL_NAME=$CONTAINER_REGISTRY/$DOCKER_IMAGE_NAME
docker build -t $FULL_NAME .
docker push $FULL_NAME
