#!/bin/bash
# Echo output of all command
set -x
# Exit immediately if a command exits with a non-zero status.
# Treat unset variables as an error when substituting.
set -eu

docker run \
    --restart=always \
    --name registry \
    -v "$(pwd)"/mnt/registry:/var/lib/registry \
    -v "$(pwd)"/auth:/auth \
    -e "REGISTRY_AUTH=htpasswd" \
    -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
    -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
    -v "$(pwd)"/certs:/certs \
    -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
    -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
    -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
    -p 443:443 \
    registry:2
