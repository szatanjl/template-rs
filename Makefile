NAME = project_name
PKGNAME = $(NAME)
DOCKERNAME = $(NAME)

TAR = tar
TARFLAGS = -cf $(PKGNAME).tar
ZIP = gzip
ZIPFLAGS =

DOCKER = docker
DOCKER_FLAGS =
DOCKER_RUN_FLAGS = -it --rm --init --name $(DOCKERNAME)
DOCKER_CMD =


all:

-include config.mk


.PHONY: all bin lib
.PHONY: dist
.PHONY: docker docker-run
.PHONY: clean distclean

all: bin lib

bin: hello

lib:

dist:
	mkdir $(PKGNAME)
	find . ! -name . -prune ! -name .git ! -name $(PKGNAME) \
		-exec cp -RPf {} $(PKGNAME) \;
	cd $(PKGNAME) && $(MAKE) distclean
	$(TAR) $(TARFLAGS) $(PKGNAME)
	$(ZIP) $(ZIPFLAGS) $(PKGNAME).tar
	rm -Rf $(PKGNAME).tar $(PKGNAME)

docker:
	$(DOCKER) build $(DOCKER_FLAGS) -t $(DOCKERNAME) .

docker-run:
	$(DOCKER) run $(DOCKER_RUN_FLAGS) $(DOCKERNAME) $(DOCKER_CMD)

clean:
	rm -Rf $(PKGNAME).* $(PKGNAME)
	rm -f hello

distclean: clean
	rm -f config.mk


hello: src/main.sh
	cp -f $< $@
	chmod +x $@
