NAME = project_name
DOCKERNAME = $(NAME)

DOCKER = docker
DOCKER_FLAGS =
DOCKER_RUN_FLAGS = -it --rm --init --name $(DOCKERNAME)
DOCKER_CMD =


all:

-include config.mk


.PHONY: all bin lib
.PHONY: docker docker-run
.PHONY: clean distclean

all: bin lib

bin: hello

lib:

docker:
	$(DOCKER) build $(DOCKER_FLAGS) -t $(DOCKERNAME) .

docker-run:
	$(DOCKER) run $(DOCKER_RUN_FLAGS) $(DOCKERNAME) $(DOCKER_CMD)

clean:
	rm -f hello

distclean: clean
	rm -f config.mk


hello: src/main.sh
	cp -f $< $@
	chmod +x $@
