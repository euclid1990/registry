#!/bin/bash
# Echo output of all command
set -x
# Exit immediately if a command exits with a non-zero status.
# Treat unset variables as an error when substituting.
set -eu

user=${1:-testuser}
password=${1:-testpassword}
docker run \
    --entrypoint htpasswd \
    registry:2 -Bbn $user $password > "$(pwd)"/auth/htpasswd
