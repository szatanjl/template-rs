make
====


Targets
-------

- `make [all]`

  Build project

- `make docker`

  Build docker image

- `make docker-run`

  Run built docker image


Configuration
-------------

`make` can be configured by setting following variables via CLI:

- `NAME`

  Project name

- `DOCKERNAME`

  Docker image name.  Default: `${NAME}`

- `DOCKER`

  Container management utility to use: `docker` or `podman`.
  Default: `docker`

- `DOCKER_FLAGS`

  Options passed to `${DOCKER} build`.  Default: empty

- `DOCKER_RUN_FLAGS`

  Options passed to `${DOCKER} run`.
  Default: `-it --rm --init --name ${DOCKERNAME}`

- `DOCKER_CMD`

  Command executed by `${DOCKER} run`.  Default: empty
