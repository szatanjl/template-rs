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

DESTDIR =
prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
sbindir = $(exec_prefix)/sbin
libexecdir = $(exec_prefix)/libexec
libdir = $(exec_prefix)/lib
includedir = $(prefix)/include
datarootdir = $(prefix)/share
datadir = $(datarootdir)
sysconfdir = $(prefix)/etc
localstatedir = $(prefix)/var
runstatedir = $(localstatedir)/run
mandir = $(datarootdir)/man
man1dir = $(mandir)/man1
man3dir = $(mandir)/man3


all:

-include version.mk
-include config.mk


.PHONY: all bin lib
.PHONY: dist version release
.PHONY: install install-bin install-lib install-man-bin install-man-lib
.PHONY: check test lint fmt fmt-check
.PHONY: run dev
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

install: install-bin install-lib install-man-bin install-man-lib

install-bin: hello
	mkdir -p $(DESTDIR)$(bindir)
	cp -f hello $(DESTDIR)$(bindir)
	chmod +x $(DESTDIR)$(bindir)/hello

install-lib:
	mkdir -p $(DESTDIR)$(libdir)

install-man-bin: man/hello.1
	mkdir -p $(DESTDIR)$(man1dir)
	cp -f man/hello.1 $(DESTDIR)$(man1dir)

install-man-lib:
	mkdir -p $(DESTDIR)$(man3dir)

check: fmt-check lint test

test: tests/example.sh
	$(SHELL) $<

lint: make/lint.sh
	./$<

fmt: make/fmt.sh
	./$<

fmt-check: make/fmt-check.sh
	./$<

run: hello
	./$< $(RUN_FLAGS)

dev: src/main.sh
	$(SHELL) $< $(RUN_FLAGS)

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
