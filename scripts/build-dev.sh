#! /usr/bin/env bash

set -e

declare -r BASEDIR=$(dirname "$(readlink -f -- "$0")")

# Go back to the repo's base
cd "$BASEDIR/.."

echo "Getting reporting-framework for Linux OS"
yseop libs install library/ --os=linux
echo "## Compile library."
yseop clean library/ --all
yseop compile library/

echo "## Compile test project into a pz0.e1 file."
yseop clean test_project/ --all
yseop compile test_project/ --lib-types pz0.e1
