make
====


Targets
-------

- `make [all]`

  Build project binaries and libraries

- `make bin`

  Build binaries

- `make lib`

  Build libraries

- `make dist`

  Build distribution tarball

- `make version`

  Generate version information

- `make release`

  Create new release

- `make check`

  Check code formatting, and run linters and tests

- `make test`

  Run tests

- `make lint`

  Lint project

- `make fmt`

  Format code

- `make fmt-check`

  Check code formatting

- `make run`

  Build and run project

- `make dev`

  Run project in development mode, without building

- `make docker`

  Build docker image

- `make docker-run`

  Run built docker image

- `make clean`

  Remove built files

- `make distclean`

  Remove built files and configuration files

- `make cleanall`

  Remove built files, configuration files, and generated version
  information


Configuration
-------------

`make` can be configured by setting following variables
in config.mk file or via CLI:

- `NAME`

  Project name

- `PKGNAME`

  Distribution tarball filename without extension.  Default: `${NAME}`

- `DOCKERNAME`

  Docker image name.  Default: `${NAME}`

- `TAR`

  Archive utility to use.  Default `tar`

- `TARFLAGS`

  Options passed to the archive utility.  Default: `-cf ${PKGNAME}.tar`

- `ZIP`

  Compression utility to use.  Default: `gzip`

- `ZIPFLAGS`

  Options passed to the compression utility.  Default: empty

- `RUN_FLAGS`

  Arguments passed to executed binary.  Default: empty

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
