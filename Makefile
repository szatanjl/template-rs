NAME = project_name
DOCKERNAME = $(NAME)

DOCKER = docker
DOCKER_FLAGS =
DOCKER_RUN_FLAGS = -it --rm --init --name $(DOCKERNAME)
DOCKER_CMD =


all:

.PHONY: all
.PHONY: docker docker-run

all:

docker:
	$(DOCKER) build $(DOCKER_FLAGS) -t $(DOCKERNAME) .

docker-run:
	$(DOCKER) run $(DOCKER_RUN_FLAGS) $(DOCKERNAME) $(DOCKER_CMD)
