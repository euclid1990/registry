#!/bin/bash
# Echo output of all command
set -x
# Exit immediately if a command exits with a non-zero status.
# Treat unset variables as an error when substituting.
set -eu

domain=${1:-localhost}

case "$domain" in
    "localhost")
        echo "Generate self-signed certificate for localhost"
        openssl req -x509 -out certs/domain.crt -keyout certs/domain.key \
            -newkey rsa:2048 -nodes -sha256 \
            -subj '/CN=localhost' -extensions EXT -config <( \
            printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
        ;;
    *)
    echo "Generate letsencrypt certificate for $domain"
    # Run Nginx to prove control to Let’s Encrypt via HTTP wellknown
    docker rm -f certnginx
    docker run --name certnginx \
        -p 80:80 \
        -v "$(pwd)"/certs/www:/usr/share/nginx/html \
        -d \
        nginx:1.17.9
    # Requesting a certificate for domain
    docker run -it --rm --name certbot \
        -v "$(pwd)"/certs/etc:/etc/letsencrypt \
        -v "$(pwd)"/certs/var:/var/lib/letsencrypt \
        -v "$(pwd)"/certs/www:/var/www/certbot \
        certbot/certbot:v1.3.0 certonly \
        --agree-tos --eff-email --register-unsafely-without-email \
        --webroot -w /var/www/certbot \
        --preferred-challenges http \
        --rsa-key-size 2048 \
        -d $domain
    # Remove nginx container
    docker rm -f certnginx
    # Move certificates to parent folder
    mv "$(pwd)"/certs/etc/letsencrypt/live/$domain.crt "$(pwd)"/certs/domain.crt
    mv "$(pwd)"/certs/etc/letsencrypt/live/$domain.key "$(pwd)"/certs/domain.key
esac
