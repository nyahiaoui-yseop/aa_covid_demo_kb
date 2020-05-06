#! /usr/bin/env bash

set -e

BASEDIR=$(dirname "$(readlink -f -- "$0")")

cd "$BASEDIR"/..

docker pull antora/antora
docker run --rm -u $UID -v "$(pwd)":/antora antora/antora site.yml | grep "asciidoctor: ERROR" && exit 1
