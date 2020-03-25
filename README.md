# Docker Registry

## Setup

- Native basic auth
  ```bash
  $ ./auth.sh
  ```
- Get a certificate
  ```bash
  $ ./cert.sh [domain]
  ```
- Start the registry
  ```bash
  $ ./start.sh
  ```
## Test

- Login, Tag, Push image
  ```bash
  $ docker login localhost
  $ docker tag memcached:1.5.16 localhost/memcached
  $ docker push memcached:1.5.16 localhost/memcached
  ```
  ```
  https://localhost/v2/_catalog
  https://localhost/v2/memcached/tags/list
  ```
