#!/bin/bash
set -o errexit
set -o nounset

IMG="$REGISTRY/$REPOSITORY:$TAG"

echo "Check we can build from ${IMG}"

DIR="$(mktemp -d)"
DOCKERFILE="${DIR}/Dockerfile"
touch "$DOCKERFILE"
echo "FROM ${IMG}" >> "$DOCKERFILE"
echo "RUN true" >> "$DOCKERFILE"

docker build "$DIR"
