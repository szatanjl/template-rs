NAME = project_name
DOCKERNAME = $(NAME)

DOCKER = docker
DOCKER_FLAGS =
DOCKER_RUN_FLAGS = -it --rm --init --name $(DOCKERNAME)
DOCKER_CMD =


all:

-include config.mk


.PHONY: all
.PHONY: docker docker-run
.PHONY: clean distclean

all:

docker:
	$(DOCKER) build $(DOCKER_FLAGS) -t $(DOCKERNAME) .

docker-run:
	$(DOCKER) run $(DOCKER_RUN_FLAGS) $(DOCKERNAME) $(DOCKER_CMD)

clean:

distclean: clean
	rm -f config.mk
