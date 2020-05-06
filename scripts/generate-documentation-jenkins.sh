#! /usr/bin/env bash

set -e

BASEDIR=$(dirname "$(readlink -f -- "$0")")

cd "$BASEDIR"/..

IMAGE=antora-doc

docker build --pull -t "$IMAGE" -f scripts/Dockerfile-antora . | grep 'asciidoctor: ERROR' && exit 1

# While there is no way to expose the nginx container to the world,
# let's just extract the generated html site and archive it with Jenkins

mkdir -p ./build/site
CONTAINER_ID=$(docker container create "$IMAGE")
docker container cp "${CONTAINER_ID}:/usr/share/nginx/html/." ./build/site
docker container rm -f "$CONTAINER_ID"
docker rmi "$IMAGE"
