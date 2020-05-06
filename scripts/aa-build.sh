#! /usr/bin/env bash

set -e

echo "## Compile library."
yseop compile ../library

echo "## Compile test project into a pz0.e1 file."
yseop compile
