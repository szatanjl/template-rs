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

- `make clean`

  Remove built files

- `make distclean`

  Remove built files and configuration files


Configuration
-------------

`make` can be configured by setting following variables
in config.mk file or via CLI:

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
