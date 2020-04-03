# Docker Registry

## Setup

- Grant execute permission
  ```bash
  $ sudo chmod a+x ./*.sh
  ```
- Native basic auth
  ```bash
  $ ./auth.sh testuser testpassword
  ```
- Get a certificate
  ```bash
  $ ./cert.sh [domain]
  ```
- Start the registry
  ```bash
  $ ./start.sh
  ```
  Or
  ```bash
  $ docker-compose up
  ```
  Or (http)
  ```bash
  $ docker-compose -f docker-compose.http.yml up
  ```

## Test

- Login, Tag, Push image
  ```bash
  $ docker login localhost:5000    # username: testuser | password: testpassword
  $ docker pull hello-world
  $ docker tag hello-world:latest localhost:5000/hello-world:1.0
  $ docker push localhost:5000/hello-world:1.0
  ```
- Registry API
  ```
  https://localhost/v2/_catalog
  https://localhost/v2/memcached/tags/list
  ```
- Registry Frontend
  ```bash
  https://localhost:5001    # username: testuser | password: testpassword
  ```
  ![image](https://user-images.githubusercontent.com/5584709/77814769-cf3ea680-70e6-11ea-85c5-3cda1bd5db59.png)
