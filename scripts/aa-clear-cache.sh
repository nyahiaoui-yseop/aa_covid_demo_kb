#! /usr/bin/env bash

set -e

echo "## Clear cache."
../library/gradlew installYmlLibLinux --refresh-dependencies
