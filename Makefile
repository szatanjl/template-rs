NAME = project_name
PKGNAME = $(NAME)
DOCKERNAME = $(NAME)

TAR = tar
TARFLAGS = -cf $(PKGNAME).tar
ZIP = gzip
ZIPFLAGS =

RUN_FLAGS =

DOCKER = docker
DOCKER_FLAGS =
DOCKER_RUN_FLAGS = -it --rm --init --name $(DOCKERNAME)
DOCKER_CMD =


all:

-include version.mk
-include config.mk


.PHONY: all bin lib
.PHONY: dist version release
.PHONY: run
.PHONY: docker docker-run
.PHONY: clean distclean cleanall

all: bin lib

bin: hello

lib:

dist:
	mkdir $(PKGNAME)
	find . ! -name . -prune ! -name .git \
		! -name $(PKGNAME) ! -name '$(NAME)-*' \
		-exec cp -RPf {} $(PKGNAME) \;
	cd $(PKGNAME) && $(MAKE) distclean
	$(TAR) $(TARFLAGS) $(PKGNAME)
	$(ZIP) $(ZIPFLAGS) $(PKGNAME).tar
	rm -Rf $(PKGNAME).tar $(PKGNAME)

version: make/version.sh
	{ \
	./$< && printf '%s\n' '' \
		'PKGNAME = $$(NAME)-$$(VERSION)' \
		'DOCKERNAME = $$(NAME):$$(VERSION)'; \
	} >| version.mk

release: make/release.sh
	./$<

run: hello
	./$< $(RUN_FLAGS)

docker:
	$(DOCKER) build $(DOCKER_FLAGS) -t $(DOCKERNAME) .

docker-run:
	$(DOCKER) run $(DOCKER_RUN_FLAGS) $(DOCKERNAME) $(DOCKER_CMD)

clean:
	rm -Rf $(PKGNAME).* $(PKGNAME) $(NAME)-*
	rm -f hello

distclean: clean
	rm -f config.mk

cleanall: distclean
	rm -f version.mk


hello: src/main.sh
	cp -f $< $@
	chmod +x $@
