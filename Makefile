NAME = project_name
PKGNAME = $(NAME)
DOCKERNAME = $(NAME)

TAR = tar
TARFLAGS = -cf $(PKGNAME).tar
ZIP = gzip
ZIPFLAGS =

CARGO = cargo
CARGO_BUILD_FLAGS =
CARGO_FETCH_FLAGS =
CARGO_PKG_FLAGS =
CARGO_TEST_FLAGS =
CARGO_RUN_FLAGS =
CARGO_CLEAN_FLAGS =

RUN_FLAGS =

DOCKER = docker
DOCKER_FLAGS = \
	--build-arg CARGO='$(CARGO)' \
	--build-arg CARGO_BUILD_FLAGS='$(CARGO_BUILD_FLAGS)' \
	--build-arg CARGO_FETCH_FLAGS='$(CARGO_FETCH_FLAGS)'
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


.PHONY: all bin lib deps
.PHONY: dist crate version release
.PHONY: install install-bin install-lib install-man-bin install-man-lib
.PHONY: uninstall uninstall-bin uninstall-lib
.PHONY: uninstall-man-bin uninstall-man-lib
.PHONY: check test lint fmt fmt-check
.PHONY: run dev
.PHONY: docker docker-run
.PHONY: clean distclean cleanall

all:
	$(CARGO) build $(CARGO_BUILD_FLAGS)

bin:
	$(CARGO) build --bins $(CARGO_BUILD_FLAGS)

lib:
	$(CARGO) build --lib $(CARGO_BUILD_FLAGS)

deps:
	$(CARGO) fetch $(CARGO_FETCH_FLAGS)

dist:
	mkdir $(PKGNAME)
	find . ! -name . -prune ! -name .git ! -name target \
		! -name $(PKGNAME) ! -name '$(NAME)-*' \
		-exec cp -RPf {} $(PKGNAME) \;
	cd $(PKGNAME) && $(MAKE) distclean
	$(TAR) $(TARFLAGS) $(PKGNAME)
	$(ZIP) $(ZIPFLAGS) $(PKGNAME).tar
	rm -Rf $(PKGNAME).tar $(PKGNAME)

crate:
	$(CARGO) package $(CARGO_PKG_FLAGS)

version: make/version.sh
	{ \
	./$< && printf '%s\n' '' \
		'PKGNAME = $$(NAME)-$$(VERSION)' \
		'DOCKERNAME = $$(NAME):$$(VERSION)'; \
	} >| version.mk

release: make/release.sh
	./$<

install: install-bin install-lib install-man-bin install-man-lib

install-bin: target/release/hello
	mkdir -p $(DESTDIR)$(bindir)
	cp -f target/release/hello $(DESTDIR)$(bindir)
	chmod +x $(DESTDIR)$(bindir)/hello

install-lib:
	mkdir -p $(DESTDIR)$(libdir)

install-man-bin: man/hello.1
	mkdir -p $(DESTDIR)$(man1dir)
	cp -f man/hello.1 $(DESTDIR)$(man1dir)

install-man-lib:
	mkdir -p $(DESTDIR)$(man3dir)

uninstall: uninstall-man-lib uninstall-man-bin
uninstall: uninstall-lib uninstall-bin

uninstall-bin:
	rm -f $(DESTDIR)$(bindir)/hello
	-cd $(DESTDIR)/ && rmdir -p .$(bindir)

uninstall-lib:
	-cd $(DESTDIR)/ && rmdir -p .$(libdir)

uninstall-man-bin:
	rm -f $(DESTDIR)$(man1dir)/hello.1
	-cd $(DESTDIR)/ && rmdir -p .$(man1dir)

uninstall-man-lib:
	-cd $(DESTDIR)/ && rmdir -p .$(man3dir)

check: fmt-check lint test

test:
	$(CARGO) test $(CARGO_TEST_FLAGS)

lint: make/lint.sh
	./$<

fmt: make/fmt.sh
	./$<

fmt-check: make/fmt-check.sh
	./$<

run:
	$(CARGO) run $(CARGO_RUN_FLAGS) -- $(RUN_FLAGS)

dev:
	$(CARGO) watch -x run $(CARGO_RUN_FLAGS)-- $(RUN_FLAGS)

docker:
	$(DOCKER) build $(DOCKER_FLAGS) -t $(DOCKERNAME) .

docker-run:
	$(DOCKER) run $(DOCKER_RUN_FLAGS) $(DOCKERNAME) $(DOCKER_CMD)

clean:
	rm -Rf $(PKGNAME).* $(PKGNAME) $(NAME)-*
	$(CARGO) clean $(CARGO_CLEAN_FLAGS)

distclean: clean
	rm -f Cargo.lock config.mk

cleanall: distclean
	rm -f version.mk


target/release/hello:
	$(CARGO) build --bins -r $(CARGO_BUILD_FLAGS)
