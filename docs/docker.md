docker
======


Common Commands
---------------

- `docker build -t <IMAGE> .`

  Build docker image

- `docker run -it --rm --name <CONTAINER> <IMAGE> [CMD] [ARGS...]`

  Run docker container

- `docker exec -it <CONTAINER> /bin/sh`

  Attach to container shell

- `docker logs -t <CONTAINER>`

  Print container logs

- `docker rm -fv <CONTAINER>`

  Kill and remove running container

- `docker rmi -f <IMAGE>`

  Remove docker image

- `docker save -o <FILENAME> <IMAGE>`

  Export docker image to a file

- `docker load -i <FILENAME>`

  Import docker image from a file


Configuration
-------------

`docker build` can be configured by setting following variables
via CLI `--build-arg` flag:

- `BASEIMG`

  Default base image used for docker build stages.
  Default: `alpine:latest`

- `BUILDIMG`

  Image used for building the project.  Default: `${BASEIMG}`
